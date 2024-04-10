/*
 * From: https://github.com/Nadrin/PBR/blob/master/data/shaders/glsl/pbr_fs.glsl
 */

#define PI 3.1415926538
#define Epsilon 0.0000001

// Shlick's approximation of the Fresnel factor.
vec3 fresnelSchlick(vec3 F0, float cosTheta) {
	return F0 + (vec3(1.0) - F0) * pow(1.0 - cosTheta, 5.0);
}

// GGX/Towbridge-Reitz normal distribution function.
// Uses Disney's reparametrization of alpha = roughness^2.
float ndfGGX(float NdotH, float roughness) {
	float alpha   = roughness * roughness;
	float alphaSq = alpha * alpha;

	float denom = (NdotH * NdotH) * (alphaSq - 1.0) + 1.0;
	return alphaSq / (PI * denom * denom);
}

// Single term for separable Schlick-GGX below.
float gaSchlickG1(float cosTheta, float k) {
	return cosTheta / (cosTheta * (1.0 - k) + k);
}

// Schlick-GGX approximation of geometric attenuation function using Smith's method.
float gaSchlickGGX(float NdotL, float NdotV, float roughness) {
	float r = roughness + 1.0;
	float k = (r * r) / 8.0; // Epic suggests using this roughness remapping for analytic lights.
	return gaSchlickG1(NdotL, k) * gaSchlickG1(NdotV, k);
}

vec3 PBR(vec3 N, vec3 L, vec3 V, float roughness, float metalness, vec3 albedo) {
  vec3 H = normalize(V + L); // Halfway vector

  float NdotL = max(0.0, dot(N, L));
  float NdotV = max(0.0, dot(N, V));
  float NdotH = max(0.0, dot(N, H));
  float HdotV = max(0.0, dot(H, V));

  vec3 F0 = mix(vec3(0.04), albedo, metalness);
  vec3 F  = fresnelSchlick(F0, HdotV);
  float D = ndfGGX(NdotH, roughness);
  float G = gaSchlickGGX(NdotL, NdotV, roughness);
  vec3 specularBRDF = (F * D * G) / max(Epsilon, 4.0 * NdotL * NdotV);

  vec3 kS = F;
  vec3 kD = vec3(1.0) - kS; // Diffuse component is just 1 - specular
  kD *= 1.0 - metalness; // Reduce the diffuse component if metal
  vec3 diffuseBRDF = kD * (albedo / PI);

  return (diffuseBRDF + specularBRDF) * NdotL;
}
