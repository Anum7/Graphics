// Fragment shader

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_LIGHT_SHADER

// These values come from the vertex shader
varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;
varying vec4 vertTexCoord;

void main() {
  int numCir = 8;
  float center = 0.5;
  float formRadius = 0.3;
  float Cdistance;
  float newRadius = 0.1;

  float deg = 0.0;
  float rad = radians(deg);

  
  gl_FragColor = vec4(1.0,0,0,0.0);

  for(int i = 1; i <= numCir; i++) {
  	vec2 angleV  = vec2(cos(rad), sin(rad)); 
  	vec2 newCenter = (angleV * formRadius) + center;
  	Cdistance = distance(vertTexCoord.xy, newCenter);    
  	if (Cdistance < newRadius) {
  		gl_FragColor = vec4(0, 1.0, 1.0, (float(i) / (numCir + 1)));  
  		
  	} 
  	deg = deg + 45.0;
  	rad = radians(deg);	
  }

}


