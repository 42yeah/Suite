#version 330 core

in vec3 normal;

out vec4 color;

void main() {
    vec3 objColor = vec3(1.0, 1.0, 1.0);

    vec3 ambient = 0.2 * objColor;
    vec3 diffuse = clamp(dot(normal, normalize(vec3(1.0, 1.0, 0.0))), 0.0, 1.0) * objColor;

    color = vec4(ambient + diffuse, 1.0);
}
