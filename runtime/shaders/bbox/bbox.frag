#version 330 core

uniform bool highlight;
out vec4 color;

void main() {
    if (highlight) {
        color = vec4(1.0, 0.0, 0.0, 1.0);
    } else {
        color = vec4(1.0, 1.0, 1.0, 1.0);
    }

}
