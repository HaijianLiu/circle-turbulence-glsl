
#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

float smoothDist(in float left, in float right, in float x){
  return smoothstep(left,left+left*0.01,x)
  -smoothstep(right-0.01*right,right,x);
}

float smoothNormal(in float left, in float right, in float x){
  x = clamp((x-left)/(right-left),-1.0,1.0);
  return 1.0-x*x*(3.0-2.0*abs(x));
}

mat2 rotate2d(float angle){
    return mat2(cos(angle),-sin(angle),
                sin(angle),cos(angle));
}

float ring(
  in vec2 pos, in float delay, in float a, in float r){
  r += +0.01
  *smoothNormal(0.0,0.3*PI,a)
  *cos(12.0*(a+delay+1.0*iGlobalTime));
  return smoothDist(0.21,0.225,r);
}

void main(){
	vec2 st = gl_FragCoord.xy/iResolution.xy;
  st.y *= iResolution.y/iResolution.x;
  vec2 pos = vec2(0.5)-st;

  pos = rotate2d(iGlobalTime*PI*0.3)*pos;

  float a = atan(pos.y/pos.x);
  float r = length(pos);

	vec3 color = vec3(
    ring(pos,0.0,a,r),
    ring(pos,0.33,a,r),
    ring(pos,0.66,a,r)
    );

	gl_FragColor = vec4( color, 1.0 );
}
