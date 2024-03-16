//Copyright © 2024 David Draper Jr

#version 120

varying vec2 texcoord;

uniform vec3 sunPosition;

uniform float viewWidth;
uniform float viewHeight;
uniform float sunAngle;

uniform vec3 fogColor;
uniform vec3 skyColor;

uniform ivec2 eyeBrightness;

uniform sampler2D colortex0;
uniform sampler2D colortex1;
uniform sampler2D colortex2;

uniform sampler2D depthtex0;

void main()
{
    float lowResX = round(texcoord.x * 320.0)/320.0;
    float lowResY = round(texcoord.y * 240.0)/240.0;
    //fix pixel blur offset
    lowResX = round(lowResX * viewWidth)/viewWidth + 0.5/viewWidth;
    lowResY = round(lowResY * viewHeight)/viewHeight + 0.5/viewHeight;
    
    vec3 albedo = texture2D(colortex0, texcoord).rgb;
    float depth = texture2D(depthtex0, texcoord).r;

    if(depth == 1.0f){
        gl_FragData[0] = vec4(albedo, 1.0f);
        return;
    }
    

    vec3 lightmap = texture2D(colortex2, texcoord).rgb;
    
    float dither = mod(lowResY*120.0,1.0)*2.0-mod(lowResX*160.0,1.0);

    vec3 skylight = round(lightmap.y * 10.0 + (dither-0.5)*0.25)*0.1 * skyColor * 1.5 + vec3(0.4);
    vec3 torchlight = round(lightmap.x * 10.0 + (dither-0.5)*0.25)*0.1 * vec3(0.95,0.6,0.45) * mix(3,1,skyColor.b+0.2);

    

    /* DRAWBUFFERS:0 */
    // Finally write the diffuse color
    gl_FragData[0] = vec4(albedo * (skylight + torchlight), 1.0);
}