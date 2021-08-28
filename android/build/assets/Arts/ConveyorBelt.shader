shader_type canvas_item;


uniform float speed = 0.1;
uniform float x_scale = 1;

void fragment(){
    vec2 newuv = UV;
	newuv.x *= x_scale;
    newuv.x += TIME * speed;
    vec4 c = texture(TEXTURE, newuv);
    COLOR = c;
}