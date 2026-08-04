VARYING vec2 vUV;
VARYING vec3 vWorldPos;
VARYING vec3 vWorldNormal;

vec3 floorSkyReflection(vec3 rayDir)
{
    vec3 r = vec3(rayDir.x, -rayDir.y, rayDir.z);
    vec2 uv = vec2(atan(r.z, r.x) * 0.15915494, asin(clamp(r.y, -1.0, 1.0)) * 0.31830989) + 0.5;
    vec3 sky = pow(textureLod(skyTexture, uv, skyReflectionBlur).rgb, vec3(2.2));
    float ndotv = clamp(-rayDir.y, 0.0, 1.0);
    float fresnel = 0.04 + 0.96 * pow(1.0 - ndotv, 5.0);
    return sky * fresnel * skyReflectionStrength;
}

vec3 floorColor(vec3 cameraPos, vec3 rayDir)
{
    if (rayDir.y >= -0.000001)
        return floorOuterColor.rgb;
    float rayLength = (groundPlaneY - cameraPos.y) / rayDir.y;
    if (rayLength <= 0.0)
        return floorOuterColor.rgb;
    float distanceFromOrigin = length(cameraPos.xz + rayDir.xz * rayLength);
    float gradient = smoothstep(floorHighlightInnerRadius, floorHighlightOuterRadius,
                                distanceFromOrigin);
    return mix(floorHighlightColor.rgb * floorHighlightStrength,
               floorOuterColor.rgb, gradient)
           + floorSkyReflection(rayDir);
}

void MAIN()
{
    NORMAL = normalize(vWorldNormal);
    BASE_COLOR = vec4(0.0, 0.0, 0.0, 1.0);
    METALNESS = 0.0;
    ROUGHNESS = 1.0;
    SPECULAR_AMOUNT = 0.0;
    EMISSIVE_COLOR = vec3(0.0);
}

void POST_PROCESS()
{

    COLOR_SUM.rgb = floorColor(CAMERA_POSITION, normalize(vWorldPos - CAMERA_POSITION));
    COLOR_SUM.a = 1.0;
}
