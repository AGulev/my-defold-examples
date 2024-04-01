varying highp vec4 var_position;
varying mediump vec3 var_normal;
varying mediump vec2 var_texcoord0;
varying mediump vec4 var_light;

uniform lowp sampler2D tex0;
uniform lowp vec4 tint;

void main() {
    // Get the original color of the image
    vec4 tint_pm = vec4(tint.xyz * tint.w, tint.w);
    vec4 color = texture2D(tex0, var_texcoord0.xy) * tint_pm;
    vec3 originalColor = color.rgb;

    vec3 ambient_light = vec3(0.5);
    vec3 diff_light = vec3(normalize(var_light.xyz - var_position.xyz));
    diff_light = max(dot(var_normal,diff_light), 0.0) + ambient_light;
    diff_light = clamp(diff_light, 0.0, 1.0);
    
    // Convert the original color to grayscale
    float grayscale = dot(originalColor, vec3(0.3, 0.59, 0.11));

    // Applying contrast enhancement
    float contrast = 1.3; // Adjust contrast level
    grayscale = 0.5 + contrast * (grayscale - 0.5);

    // Simulating infrared color mapping
    // Vegetation in infrared is bright, so we boost mid to high grayscales
    float irLuminance = smoothstep(0.0, 0.4, grayscale);
    vec3 irColor = vec3(irLuminance);

    // Output the infrared-like image
    gl_FragColor = vec4(irColor*diff_light , 10.0);
}