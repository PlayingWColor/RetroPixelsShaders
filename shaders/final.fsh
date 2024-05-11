//Copyright © 2024 David Draper Jr

#version 120

varying vec2 texcoord;

uniform sampler2D colortex0;
uniform sampler2D colortex1;
uniform sampler2D gnormal;

uniform float viewWidth;
uniform float viewHeight;

void main()
{
    float lowResX = texcoord.x;//round(texcoord.x * 320.0)/320.0;
    float lowResY = texcoord.y;//round(texcoord.y * 240.0)/240.0;
    //fix pixel blur offset
    //lowResX = round(lowResX * viewWidth)/viewWidth + 0.5/viewWidth;
    //lowResY = round(lowResY * viewHeight)/viewHeight + 0.5/viewHeight;

    float xPixelCoord = texcoord.x * 320;
    xPixelCoord = xPixelCoord - floor(xPixelCoord);

    float yPixelCoord = texcoord.y * 240;
    yPixelCoord = yPixelCoord - floor(yPixelCoord);

    vec3 pixelBleed = (1.0-xPixelCoord) * 2 * vec3(1.0,0.0,0.0) + (xPixelCoord) * 2 * vec3(0.0,1.0,0.0) + (1-2*abs(xPixelCoord-0.5)) * 2 * vec3(0.0,0.0,1.0);
    pixelBleed *= vec3(1.5-2*abs(yPixelCoord-0.5));

    float vignette = 1.0-length(texcoord-0.5);

    vec3 color = texture2D(colortex0, vec2(lowResX,lowResY)).rgb;

    gl_FragColor = vec4(color*vignette*pixelBleed,1.0);
}