varying highp vec4 var_position;
varying mediump vec3 var_normal;
varying mediump vec2 var_texcoord0;

uniform lowp sampler2D tex0;
uniform lowp vec4 tint;

void main()
{
    // Sample the texture color
    vec4 color = texture2D(tex0, var_texcoord0.xy);

    // Convert to grayscale to manipulate brightness and contrast
    float grayscale = dot(color.rgb, vec3(0.299, 0.587, 0.114));

    // Simulate infrared characteristics:
    // In real infrared, light green vegetation reflects more, so we enhance green channel
    // Skies and water, often darker, can be simulated by inversing some of the brightness logic
    float infrared = grayscale + color.g - (color.b * 0.1); // Boost green, reduce some of blue

    // Apply contrast to the infrared signal
    infrared = pow(infrared, 1.1); // Adjust for more contrast if needed

    // Clamp the result to ensure it's within the valid range
    infrared = clamp(infrared, 0.0, 1.0);

    gl_FragColor = vec4(vec3(infrared), 1.0); // Greyscale intensity with full opacity
}
