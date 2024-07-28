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

    vec3 color = texture2D(colortex0, vec2(lowResX,lowResY)).rgb;

    vec3 pixelBleed = (1.0-abs(xPixelCoord*5.0-1.0)) * color.r*vec3(1.0,0.0,0.0) + (1.0-abs(xPixelCoord*5.0-2.5)) * color.g * vec3(0.0,1.0,0.0) + (1.0-abs(5.0*xPixelCoord-4)) * color.b * vec3(0.0,0.0,1.0);
    pixelBleed *= vec3(1.5-2*abs(yPixelCoord-0.5));
    //pixelBleed *= 3;

    vec2 texCoordCenterSquare = vec2(pow(1.0-2.0*texcoord.x,2),pow(1.0-2.0*texcoord.y,2));

    float vignette = clamp(3.0*(1.0-texCoordCenterSquare.x)*(1.0-texCoordCenterSquare.y),0.0,1.0);

    
    /* DRAWBUFFERS:0 */
    // Finally write the diffuse color
    gl_FragData[0] = vec4(vignette*pixelBleed,1.0);
}