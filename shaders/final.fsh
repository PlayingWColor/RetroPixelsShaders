//Copyright © 2024 David Draper Jr

#version 120

#define CRT 0 //[0 1]

varying vec2 texcoord;

uniform sampler2D colortex0;
uniform sampler2D colortex1;
uniform sampler2D gnormal;

uniform float viewWidth;
uniform float viewHeight;

#include "/utility/gaussian.glsl"

void main()
{
#if CRT == 1
    gl_FragColor = FastGaussianBlur(colortex0, texcoord, 0.002, 4)*3 + FastGaussianBlur(colortex0, texcoord, 0.01, 8)*2;
#else
    gl_FragColor = texture2D(colortex0, texcoord);
#endif
}