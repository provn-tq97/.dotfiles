/*
 * Grayscale
 */
#version 300 es
precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

void main() {
    vec4 pixColor = texture2D(tex, v_texcoord);

    fragColor = vec4(
        pixColor[0] * 0.299 + pixColor[1] * 0.587 + pixColor[2] * 0.114,
        pixColor[0] * 0.299 + pixColor[1] * 0.587 + pixColor[2] * 0.114,
        pixColor[0] * 0.299 + pixColor[1] * 0.587 + pixColor[2] * 0.114,
        pixColor[3]
    );
}
