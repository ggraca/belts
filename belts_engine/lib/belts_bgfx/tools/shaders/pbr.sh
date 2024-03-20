/*
 * From: https://github.com/Nadrin/PBR/blob/master/data/shaders/glsl/pbr_fs.glsl
 */

#define PI 3.1415926538
#define Epsilon 0.00001

// Shlick's approximation of the Fresnel factor.
vec3 fresnelSchlick(vec3 F0, float cosTheta) {
	return F0 + (vec3(1.0) - F0) * pow(1.0 - cosTheta, 5.0);
}

// GGX/Towbridge-Reitz normal distribution function.
// Uses Disney's reparametrization of alpha = roughness^2.
float ndfGGX(float cosLh, float roughness) {
	float alpha   = roughness * roughness;
	float alphaSq = alpha * alpha;

	float denom = (cosLh * cosLh) * (alphaSq - 1.0) + 1.0;
	return alphaSq / (PI * denom * denom);
}

// Single term for separable Schlick-GGX below.
float gaSchlickG1(float cosTheta, float k) {
	return cosTheta / (cosTheta * (1.0 - k) + k);
}

// Schlick-GGX approximation of geometric attenuation function using Smith's method.
float gaSchlickGGX(float cosLi, float cosLo, float roughness) {
	float r = roughness + 1.0;
	float k = (r * r) / 8.0; // Epic suggests using this roughness remapping for analytic lights.
	return gaSchlickG1(cosLi, k) * gaSchlickG1(cosLo, k);
}

vec3 PBR(vec3 N, vec3 Li, vec3 Lo, vec3 F0, float roughness, float metalness, vec3 albedo) {
  vec3 Lh = normalize(Li + Lo);

  float cosLi = max(0.0, dot(N, Li));
  float cosLo = max(0.0, dot(N, Lo));
  float cosLh = max(0.0, dot(N, Lh));

  vec3 F  = fresnelSchlick(F0, max(0.0, dot(Lh, Lo)));
  float D = ndfGGX(cosLh, roughness);
  float G = gaSchlickGGX(cosLi, cosLo, roughness);

  vec3 kd = mix(vec3(1.0) - F, vec3(0.0), metalness);
  vec3 diffuseBRDF = kd * albedo;

  vec3 specularBRDF = (F * D * G) / max(Epsilon, 4.0 * cosLi * cosLo);

  return (diffuseBRDF + specularBRDF) * cosLi;
}
