//
// Created by 42yea on 2022/6/22.
//

#include "BVH.cuh"
#include <glm/glm.hpp>


BVH::BVH(const Scene &scene) {
    BBox bbox;
    for (const auto &obj : scene.get_objects()) {
        const glm::mat4 &trans = obj.transform;
        const std::vector<Vertex> &verts = obj.model->get_vertices();

        for (int i = 0; i < verts.size() / 3; i++) {
            glm::vec3 a = glm::vec3(trans * glm::vec4(verts[i * 3 + 0].position, 1.0f));
            glm::vec3 b = glm::vec3(trans * glm::vec4(verts[i * 3 + 1].position, 1.0f));
            glm::vec3 c = glm::vec3(trans * glm::vec4(verts[i * 3 + 2].position, 1.0f));
            Triangle tri(a, b, c);
            primitives.push_back(tri);
            bbox = bbox + tri.bbox;
        }
    }
    // the whole scene bbox
    nodes.emplace_back(0, (int) primitives.size(), -1, -1, bbox);

    // TODO: bounding volume hierarchy implementation

}

BVH::Node::Node() : start(0), size(0), l(0), r(0) {

}

BVH::Node::Node(int start, int size, int l, int r, BBox bbox) : start(start), size(size), l(l), r(r), bbox(bbox) {

}
