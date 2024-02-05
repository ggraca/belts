vec3 phong(vec3 N, vec3 Li, vec3 Lo, vec3 albedo) {
  float cosLi = max(0.0, dot(N, Li));

  float cosLoPow = 0.0;
  if (cosLi > 0.0) {
    vec3 R = reflect(-Li, N);
    float cosLo = max(0.0, dot(R, Lo));
    cosLoPow = pow(cosLo, 80.0);
  }

  return albedo + albedo * cosLi + albedo * cosLoPow;
}
