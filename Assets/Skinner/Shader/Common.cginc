#include "UnityCG.cginc"

// Seed for PRNG
float _RandomSeed;

// PRNG function
float UVRandom(float2 uv, float salt)
{
    uv += float2(salt, _RandomSeed);
    return frac(sin(dot(uv, float2(12.9898, 78.233))) * 43758.5453);
}

// Stereographic projection and inverse projection
float2 StereoProjection(float3 n)
{
    return n.xy / (1 - n.z);
}

float3 StereoInverseProjection(float2 p)
{
    float d = 2 / (dot(p.xy, p.xy) + 1);
    return float3(p.xy * d, 1 - d);
}

// Hue to RGB convertion
half3 HueToRGB(half h)
{
    h = frac(h);
    half r = abs(h * 6 - 3) - 1;
    half g = 2 - abs(h * 6 - 2);
    half b = 2 - abs(h * 6 - 4);
    half3 rgb = saturate(half3(r, g, b));
#if UNITY_COLORSPACE_GAMMA
    return rgb;
#else
    return GammaToLinearSpace(rgb);
#endif
}