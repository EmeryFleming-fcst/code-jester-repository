shader_type canvas_item;

uniform float distortion_strength: hint_range(0.0, 1.0) = 0.1;
uniform vec2 offset1 = vec2(0.1);
uniform vec2 offset2 = vec2(0.2);
uniform sampler2D screen_texture: hint_screen_texture, filter_nearest;
uniform sampler2D noise_tex1: repeat_enable;
uniform sampler2D noise_tex2: repeat_enable;

void fragment() {
	vec4 noise_color1 = texture(noise_tex1, UV + offset1 * TIME);
	vec4 noise_color2 = texture(noise_tex1, UV + offset2 * TIME);
	
	float final_noise = (noise_color1.r * noise_color2.r) * distortion_strength;
	vec4 final_color = texture(screen_texture, SCREEN_UV + final_noise);
	
	COLOR = final_color;
}
