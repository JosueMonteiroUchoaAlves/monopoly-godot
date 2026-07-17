shader_type canvas_item;

// Cores
uniform vec4 color_bg = vec4(0.02, 0.10, 0.04, 1.0); 
uniform vec4 color_base_gold = vec4(0.70, 0.55, 0.15, 1.0); 
uniform vec4 color_pearl_gold = vec4(0.92, 0.82, 0.38, 1.0); 

// Comportamento
uniform float speed : hint_range(0.0, 1.0) = 0.15;
uniform float liquid_scale : hint_range(1.0, 15.0) = 6.0; // Zoom do líquido

// Efeito Perolado
uniform float pearl_intensity : hint_range(0.0, 1.0) = 0.5; // Opacidade do brilho
uniform float flake_intensity : hint_range(0.0, 2.0) = 0.4; // Força dos diamantes
uniform float flake_scale : hint_range(50.0, 300.0) = 180.0; // Tamanho dos pontinhos
uniform float flake_density : hint_range(0.5, 0.99) = 0.92; // Quantidade de pontinhos (maior = menos pontos)

// Pós-Processamento
uniform float scanline_density : hint_range(100.0, 1500.0) = 900.0; // Quantidade de linhas CRT
uniform float scanline_opacity : hint_range(0.0, 0.1) = 0.035; // Visibilidade das linhas
uniform float vignette_size : hint_range(0.0, 2.0) = 1.2; // Tamanho da sombra nas bordas
uniform float vignette_smoothness : hint_range(0.0, 1.0) = 0.2; // Suavidade da sombra

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
    vec2 p = UV * liquid_scale; 
    float t = TIME * speed;
    
    // 1. FLUXO DAS PARTÍCULAS
    vec2 flake_flow = p;
    flake_flow.x += 0.2 * sin(1.5 * p.y + t);
    flake_flow.y += 0.2 * cos(1.5 * p.x + t);
    
    vec2 flake_grid = flake_flow * flake_scale;
    vec2 flake_id = floor(flake_grid);
    vec2 flake_fract = fract(flake_grid) - 0.5;
    
    float flake_noise = hash(flake_id);
    float flake = step(flake_density, flake_noise);
    flake *= step(length(flake_fract), 0.3);
    
    // 2. FLUXO DO LÍQUIDO
    for(float i = 1.0; i < 9.0; i++) {
        vec2 new_p = p;
        new_p.x += 0.7 / i * sin(i * 1.5 * p.y + t) + 1.0;
        new_p.y += 0.7 / i * cos(i * 1.5 * p.x + t) - 1.0;
        p = new_p;
    }
    
    float pattern = cos(p.x + p.y) * 0.5 + 0.5;
    
    // Composição
    vec3 final_color = mix(color_bg.rgb, color_base_gold.rgb, smoothstep(0.05, 0.35, pattern));
    float pearl_mask = smoothstep(0.45, 0.9, pattern);
    
    vec3 pearl_color = color_pearl_gold.rgb + (flake * flake_intensity); 
    final_color = mix(final_color, pearl_color, pearl_mask * pearl_intensity);
    
    // Sombreamento de profundidade
    final_color -= (sin(p.x * 2.0) * 0.05);
    
    // Textura estrutural (Scanlines)
    //float scanline = sin(UV.y * scanline_density) * scanline_opacity;
    //final_color -= scanline;
    
    // Vinheta de foco central
    float dist = distance(UV, vec2(0.5));
    final_color *= smoothstep(vignette_size, vignette_smoothness, dist);
    
    COLOR = vec4(final_color, 1.0) * COLOR;
}