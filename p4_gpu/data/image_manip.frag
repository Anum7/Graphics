// Fragment shader

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXLIGHT_SHADER

// set by host code
uniform float time;

// Set in Processing
uniform sampler2D texture;

// These values come from the vertex shader
varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;
varying vec4 vertTexCoord;


void main() { 
  
  vec4 diffuse_color = texture2D(texture, vertTexCoord.xy); 
  float diffuse = clamp(dot (vertNormal, vertLightDir),0.0,1.0);
  gl_FragColor = vec4(diffuse * diffuse_color.rgb, 1.0);

  if (vertTexCoord.x < time) {
    float dx = 1.0 / 250.0;
    float dy = 1.0 / 250.0; 

    vec4 temp1 = vec4(vertTexCoord.x, vertTexCoord.y + dy, 1, 1);
    vec4 temp2 = vec4(vertTexCoord.x + dx, vertTexCoord.y, 1, 1);
    vec4 temp3 = vec4(vertTexCoord.x, vertTexCoord.y - dy, 1, 1);
    vec4 temp4 = vec4(vertTexCoord.x - dx, vertTexCoord.y, 1, 1);

    vec4 addedTemp = temp1 + temp2 +temp3 + temp4;

    vec4 color_ind1 = texture2D(texture, temp1.xy);
    vec4 color_ind2 = texture2D(texture, temp2.xy);
    vec4 color_ind3 = texture2D(texture, temp3.xy);
    vec4 color_ind4 = texture2D(texture, temp4.xy);

    vec4 addedColor = color_ind1 + color_ind2 + color_ind3 + color_ind4;

    float N = ((addedColor.x + addedColor.y + addedColor.z) / 3.0);
    
    N -= 4 * ((diffuse_color.x + diffuse_color.y + diffuse_color.z) / 3.0);

    N *= 1.9;

    N += 0.5;

    gl_FragColor = vec4(N,N,N,1.0);
  }

}

