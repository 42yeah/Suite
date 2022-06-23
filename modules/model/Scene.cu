//
// Created by 42yea on 21/06/2022.
//

#include "Scene.cuh"
#include <queue>
#include <assimp/Importer.hpp>
#include <assimp/scene.h>
#include <assimp/postprocess.h>



Scene::Scene(const std::string &path) {
    Assimp::Importer importer;

    const aiScene *scene = importer.ReadFile(path.c_str(),
                                             aiProcess_Triangulate |
                                             aiProcess_GenNormals);
    if (!scene) {
        std::cerr << "ERR! Failed to load scene: " << path << "." << std::endl;
    }

    for (int i = 0; i < scene->mNumMeshes; i++) {
        const aiMesh *mesh = scene->mMeshes[i];
        std::vector<Vertex> vertices;
        for (int f = 0; f < mesh->mNumFaces; f++) {
            const aiFace face = mesh->mFaces[f];
            // should be triangulated
            for (int v = 0; v < face.mNumIndices; v++) {
                unsigned int index = face.mIndices[v];
                const aiVector3D &pos = mesh->mVertices[index];
                const aiVector3D &normal = mesh->mNormals[index];
                aiVector3D tex_coord(0.0f, 0.0f, 0.0f);
                if (mesh->HasTextureCoords(0)) {
                    tex_coord = mesh->mTextureCoords[0][index];
                }

                Vertex vertex = {
                    glm::vec3(pos.x, pos.y, pos.z),
                    glm::vec3(normal.x, normal.y, normal.z),
                    glm::vec2(tex_coord.x, tex_coord.y)
                };
                vertices.push_back(vertex);
            }
        }

        std::shared_ptr<Model> model = std::make_shared<Model>(std::move(vertices));
        models.push_back(model);
    }

    // construct objects from scene hierarchy
    std::queue<std::pair<aiNode *, aiMatrix4x4> > queue;
    queue.push({ scene->mRootNode, scene->mRootNode->mTransformation });

    while (!queue.empty()) {
        aiNode *node = queue.front().first;
        const aiMatrix4x4 &trans = queue.front().second;

        glm::mat4 transposed;
        std::memcpy(&transposed, &trans, sizeof(glm::mat4));
        transposed = glm::transpose(transposed);

        queue.pop();

        // mMesh should be consistent with models
        for (int i = 0; i < node->mNumMeshes; i++) {
            Object object(models[node->mMeshes[i]], transposed);
            objects.push_back(std::move(object));
        }

        // for each child, apply the transformation
        for (int i = 0; i < node->mNumChildren; i++) {
            aiNode *child = node->mChildren[i];
            aiMatrix4x4 child_transform = trans * child->mTransformation;
            queue.push({ child, child_transform });
        }
    }
}

const std::vector<std::shared_ptr<Model> > &Scene::get_models() const {
    return models;
}

std::vector<Object> Scene::get_objects() const {
    return objects;
}

glm::vec3 Scene::center() const {
    glm::vec3 center(0.0f);
    // 1. sum transformed center
    for (const auto &obj : objects) {
        center += glm::vec3(obj.transform * glm::vec4(obj.model->get_center(), 1.0f));
    }
    // 2. calculate average
    if (objects.size() > 0.0f) {
        center /= objects.size();
    }
    return center;
}

BBox Scene::bbox() const {
    BBox bbox;
    for (const auto &obj : objects) {
        bbox = bbox + obj.bbox();
    }
    return bbox;
}
