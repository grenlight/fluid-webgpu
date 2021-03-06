layout(set = 0, binding = 0) uniform NSEFluidUniform {
  // lattice 在正规化坐标空间的大小
  vec2 lattice_size;
  // 正规化坐标空间里，一个像素对应的距离值'
  vec2 pixel_distance;

  uvec2 lattice_num;
  // 画布像素尺寸
  uvec2 canvas_size;
};
layout(set = 0, binding = 1) buffer NSEVector0 { vec2 pre_velocity[]; };
layout(set = 0, binding = 2) buffer NSEVector1 { vec2 velocity[]; };

// Divergence field of advected velocity
layout(set = 0, binding = 3) buffer NSEScalar0 { float divergence[]; };
// Pressure field from previous iteration, p^(k-1)
layout(set = 0, binding = 4) buffer NSEScalar1 { float pressure[]; };

uint latticeIndex(uvec2 uv) {
  return min(uv.x, lattice_num.x - 1) +
         min(uv.y, lattice_num.y - 1) * lattice_num.x;
}

uint latticeIndex(int u, int v) {
  uint uu = clamp(u, 0, lattice_num.x - 1);
  uint uv = clamp(v, 0, lattice_num.y - 1);
  return uu + uv * lattice_num.x;
}