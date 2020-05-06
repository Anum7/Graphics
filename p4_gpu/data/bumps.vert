// Vertex shader

// Our shader uses both processing's texture and light variables
#define PROCESSING_TEXLIGHT_SHADER

// Set automatically by Processing
uniform mat4 transform;
uniform mat3 normalMatrix;
uniform vec3 lightNormal;
uniform mat4 texMatrix;
uniform sampler2D texture;

// Come from the geometry/material of the object
attribute vec4 vertex;
attribute vec4 color;
attribute vec3 normal;
attribute vec2 texCoord;

// These values will be sent to the fragment shader
varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;
varying vec4 vertTexCoord;
varying vec4 vertTexCoordR;
varying vec4 vertTexCoordL;

void main() {

	vertColor = color;
	vertTexCoord = texMatrix * vec4(texCoord, 1.0, 1.0);

	vec4 normalb = vec4(normal.x, normal.y, normal.z, 0.0);
	vec4 bColor = texture2D(texture, vertTexCoord.st);
	
	float colorR = (0.3 * bColor.r);
	float colorG = (0.6 * bColor.g);
	float colorB = (0.1 * bColor.b);	
	float intensity = colorR + colorG + colorB;
	vec4 offset = normalb * (1 - intensity) * 100.0;

	vec4 pos = vertex + vec4(offset.x, offset.y, offset.z, 0.0);
	gl_Position = transform * pos;	
}
