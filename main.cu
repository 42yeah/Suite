#include "ui_modules/visualizer/App.cuh"
#include "modules/texture/Texture.cuh"
#include "modules/model/Vertex.cuh"
#include "modules/softras/SoftwareRasterizer.cuh"


int main() {
    // start_app();

    SoftwareRasterizer rasterizer(glm::ivec2(1024, 1024));
    Scene scene("models/cow.dae");

//    std::shared_ptr<Model> tri_model = std::make_shared<Model>(std::vector<Vertex>({
//        Vertex{glm::vec3(0.0f, 0.0f, 0.0f), glm::vec3(0.0f, 0.0f, 1.0f), glm::vec2(0.0f, 0.0f)},
//        Vertex{glm::vec3(0.5f, 0.0f, 0.0f), glm::vec3(0.0f, 0.0f, 1.0f), glm::vec2(1.0f, 0.0f)},
//        Vertex{glm::vec3(0.0f, 0.5f, 0.0f), glm::vec3(0.0f, 0.0f, 1.0f), glm::vec2(0.5f, 1.0f)} }));
//    Object object(tri_model, glm::mat4(1.0f));

    Camera camera(scene.center(), glm::radians(45.0f), 1.0f, 0.1f, 100.0f);
    camera.eye = glm::vec3(3.0f, 0.5f, 2.0f);
    camera.center = glm::vec3(scene.center());
    camera.update_camera_no_pyr();
    const Texture &tex = rasterizer.render(scene, camera);
    tex.export_as_jpg("result.jpg");

    return 0;
}
