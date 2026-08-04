VARYING vec2 vUV;
VARYING vec3 vWorldPos;
VARYING vec3 vWorldNormal;

void MAIN()
{
    vec4 worldPosition = MODEL_MATRIX * vec4(VERTEX, 1.0);

    vUV = UV0;
    vWorldPos = worldPosition.xyz;
    vWorldNormal = normalize(NORMAL_MATRIX * NORMAL);
    POSITION = MODELVIEWPROJECTION_MATRIX * vec4(VERTEX, 1.0);
}
