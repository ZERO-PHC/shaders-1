varying vec2 vUv;
varying vec3 vPosition;
uniform vec3 pulsePosition;
uniform float pulseTimer;

void main() {
  float coord = vPosition.z * 2.0; // Changed from y to z for a vertical effect
  float line = abs(fract(coord - 0.5) - 0.5) / fwidth(coord);
  float lineFill = 1.0 - min(line, 1.0);
  lineFill = pow(lineFill, 1.0 / 2.2); // Keep the visual effect consistent

  float circleGrowTimer = min(pulseTimer * 2.0, 1.0); // Keep the original growth speed
  float colorFadeTimer = 1.0 - pulseTimer; // Keep the original fade effect

  float circle = 1.0 - smoothstep(0.9 * circleGrowTimer, 1.0 * circleGrowTimer, length(pulsePosition.xy - vPosition.xy) * 0.05); // Adjusted to xy plane for consistency

  // Set to a different color, let's go with a cool cyan tone
  vec3 color = vec3(0.0, 1.0, 1.0) * colorFadeTimer; // Cyan with adjusted intensity
  vec3 coloredLines = color * lineFill; // Apply line fill effect

  vec3 finalColor = mix(coloredLines, vec3(lineFill * 0.15), 1.0 - circle * colorFadeTimer); // Adjusted mix ratio for a slightly different visual effect

  gl_FragColor = vec4(finalColor, 1.0);
}
