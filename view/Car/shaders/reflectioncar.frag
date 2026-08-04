VARYING vec2 vUV;
VARYING vec3 vWorldPos;
VARYING vec3 vWorldNormal;

// 1 at the mirror plane, 0 at reflectionFadeEndY.
float heightFade(float worldY)
{
    float fadeEndY = min(reflectionFadeEndY, groundPlaneY - 0.0001);
    return smoothstep(fadeEndY, groundPlaneY, worldY);
}

// The height fade scaled by ground transmission.
float reflectionAmount(float worldY)
{
    return heightFade(worldY) * (1.0 - clamp(reflectionGroundTransmission, 0.0, 1.0));
}

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
    float fade = reflectionAmount(vWorldPos.y);
    NORMAL = normalize(vWorldNormal);

    // Fully faded fragments get replaced by the floor color in POST_PROCESS.
    if (fade <= 0.0) {
        BASE_COLOR = vec4(0.0, 0.0, 0.0, 1.0);
        METALNESS = 0.0;
        ROUGHNESS = 1.0;
        SPECULAR_AMOUNT = 0.0;
        EMISSIVE_COLOR = vec3(0.0);
        return;
    }

    vec3 baseColorResult = baseColor.rgb;
    if (useBaseColorMap)
        baseColorResult *= texture(baseColorMap, vUV).rgb;

    BASE_COLOR = vec4(baseColorResult, 1.0);
    METALNESS = clamp(metalness, 0.0, 1.0) * fade;
    ROUGHNESS = mix(1.0, clamp(roughness, 0.0, 1.0), fade);
    SPECULAR_AMOUNT = fade;
    EMISSIVE_COLOR = vec3(0.0);
}

void POST_PROCESS()
{
    float amount = reflectionAmount(vWorldPos.y);

    // Emitters reach emissiveFalloff x deeper than the body fade, with a
    // gentler curve: bright lamps reflect much deeper on a glossy floor.
    float fadeEndY = min(reflectionFadeEndY, groundPlaneY - 0.0001);
    float emissiveEndY = groundPlaneY + (fadeEndY - groundPlaneY) * max(emissiveFalloff, 0.01);
    float deepFade = pow(smoothstep(emissiveEndY, groundPlaneY, vWorldPos.y), 0.5);

    // Blended glass-cover variant (coverAlpha >= 0): a see-through lamp
    // cover so the emitters behind it stay visible in the reflection.
    if (coverAlpha >= 0.0) {
        COLOR_SUM.a = coverAlpha * amount;
        return;
    }

    // Multiplicative tint-cover variant (coverTint >= 0, DstColor/Zero
    // blending): colors the emitter behind it without hiding it, fading to
    // no tint at the same depth the emitter glow fades.
    if (coverTint >= 0.0) {
        COLOR_SUM.rgb = mix(vec3(1.0), baseColor.rgb, coverTint * deepFade);
        COLOR_SUM.a = 1.0;
        return;
    }

    // Opaque dissolve into the analytic floor - no blended reflection pass.
    if (amount < 1.0) {
        vec3 rayDir = normalize(vWorldPos - CAMERA_POSITION);
        COLOR_SUM.rgb = mix(floorColor(CAMERA_POSITION, rayDir), COLOR_SUM.rgb, amount);
    }

    // Emissive is added after the dissolve so the dissolve mix does not
    // scale it away.
    float emissiveFade = deepFade * (1.0 - clamp(reflectionGroundTransmission, 0.0, 1.0));
    COLOR_SUM.rgb += emissiveColor.rgb * emissiveStrength * emissiveFade;
    COLOR_SUM.a = 1.0;
}
