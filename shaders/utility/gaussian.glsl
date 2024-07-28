vec4 FastGaussianBlur(sampler2D textureSampler, vec2 sourceUV, float radius, float iRadius)
{
    vec4 result = vec4(0.0,0.0,0.0,0.0);
    
    vec2 uv = sourceUV;

    float interval = radius / iRadius;
    float iRadiusSquared = iRadius * iRadius;
    float weight = 0;
    float weightBase = 0.3780/pow(iRadius, 1.975);
    float xSquared, ySquared;
    float x,y;
    
    
    
    for(x = -iRadius; x < iRadius; x++)
    {
    	xSquared = x * x;
    	for(y = -iRadius; y < iRadius; y++)
    	{
    		ySquared = y * y;
    		
    		weight = weightBase * exp((-xSquared-ySquared)/(2.0*iRadiusSquared));
    		
    		uv = sourceUV + vec2(x*interval,y*interval);
    		
    		result += texture(textureSampler, uv) * weight;
    	}
    }

    return result;
}