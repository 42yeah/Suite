//
// Created by 42yea on 2022/6/22.
//

#ifndef SUITE_CAMERA_CUH
#define SUITE_CAMERA_CUH

#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>


struct Camera {
    inline Camera() : eye(0.0f), center(0.0f), front(0.0f), pitch(0.0f), yaw(0.0f),
        view(1.0f), perspective(1.0f), fovy(glm::radians(45.0f)), aspect(1.0f), near(0.1f),
        far(100.0f), speed(1.0f) {

        update_camera();
    }

    inline Camera(glm::vec3 eye, float fovy, float aspect, float near, float far) : eye(eye), center(0.0f),
        front(0.0f), pitch(0.0f), yaw(0.0f), view(1.0f), perspective(1.0f), fovy(fovy), aspect(aspect),
        near(near), far(far), speed(1.0f) {

        update_camera();
    }

    /// update camera according to current pitch and yaw.
    inline void update_camera() {
        pitch = glm::clamp(pitch, -glm::pi<float>() / 2.0f + 0.01f,
                           glm::pi<float>() / 2.0f - 0.01f);

        front = glm::normalize(glm::vec3(cosf(pitch) * sinf(yaw), sinf(pitch), -cosf(pitch) * cosf(yaw)));
        center = eye + front;

        view = glm::lookAt(eye, center, glm::vec3(0.0f, 1.0f, 0.0f));
        perspective = glm::perspective(fovy, aspect, near, far);
    }

    glm::vec3 eye, center, front;
    glm::mat4 view, perspective;

    float fovy, aspect, near, far;

    float pitch, yaw;
    float speed;
};


#endif //SUITE_CAMERA_CUH
