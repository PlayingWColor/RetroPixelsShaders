//Copyright © 2024 David Draper Jr

#version 120
#include "ps_vertex_transform.glsl"

noperspective varying vec2 texcoord;
noperspective varying vec2 lightcoord;

varying vec4 vertexColor;

void main()
{
    gl_Position = psTransform();

    lightcoord = mat2(gl_TextureMatrix[1]) * gl_MultiTexCoord1.st;
    lightcoord = (lightcoord * 33.05f / 32.0f) - (1.05f / 32.0f);

    texcoord = gl_MultiTexCoord0.st;

    vertexColor = gl_Color;

}