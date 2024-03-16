//Copyright © 2024 David Draper Jr

vec4 psTransform()
{
    vec4 position = gl_ProjectionMatrix * gl_ModelViewMatrix * gl_Vertex;
    
    float positionX = round(position.x*80.0)/80.0;
    float positionY = round(position.y*60.0)/60.0;

    return vec4(positionX,positionY,position.zw);
}