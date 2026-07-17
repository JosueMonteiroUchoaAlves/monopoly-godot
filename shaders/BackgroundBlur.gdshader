shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
uniform float blur_amount : hint_range(0.0, 10.0) = 2.0;

void fragment() {
    // Lê a tela por trás deste nó e aplica o nível de MIP map (blur)
    COLOR = textureLod(screen_texture, SCREEN_UV, blur_amount);
}
