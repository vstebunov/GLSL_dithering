uniform sampler2D texture;

varying vec4 vertColor;
varying vec4 vertTexCoord;

const int indexMatrix8x8[64] = int[](0,  32, 8,  40, 2,  34, 10, 42,
                                     48, 16, 56, 24, 50, 18, 58, 26,
                                     12, 44, 4,  36, 14, 46, 6,  38,
                                     60, 28, 52, 20, 62, 30, 54, 22,
                                     3,  35, 11, 43, 1,  33, 9,  41,
                                     51, 19, 59, 27, 49, 17, 57, 25,
                                     15, 47, 7,  39, 13, 45, 5,  37,
                                     63, 31, 55, 23, 61, 29, 53, 21);

float indexValue() {
    int x = int(mod(gl_FragCoord.x, 8));
    int y = int(mod(gl_FragCoord.y, 8));
    return indexMatrix8x8[(x + y * 8)] / 64.0;
}

vec3 dither(vec4 color) {
    float d = indexValue();
    float r = color.r + d;
    float g = color.g + d;
    float b = color.b + d;

    float m = max(r,g);
    m = max (m,b);

    if (m < 0.49) {
        r = 0.0;
        g = 0.0;
        b = 0.0;
    } else {
        r = r >= 0.49 ? 0.49 : 0.0;
        g = g >= 0.49 ? 0.49 : 0.0;
        b = b >= 0.49 ? 0.49 : 0.0;
    }

    return vec3(r,g,b);
}

void main() {
  vec4 col = texture2D(texture, vertTexCoord.st);
  gl_FragColor = vec4(dither(col),1);
}
