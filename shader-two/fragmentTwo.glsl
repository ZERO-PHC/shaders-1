varying vec2 vUv;
varying vec3 vPosition;
uniform vec3 pulsePosition;
uniform float pulseTimer;

void main() {
  float coord = vPosition.x * 2.0; // Changed from y to x for horizontal lines
  float line = abs(fract(coord - 0.5) - 0.5) / fwidth(coord);
  float lineFill = 1.0 - min(line, 1.0);
  lineFill = pow(lineFill, 1.0 / 2.2); // Adjusted for a slightly different visual effect

  float circleGrowTimer = min(pulseTimer * 2.5, 1.0); // Increased growth speed
  float colorFadeTimer = 1.0 - sqrt(pulseTimer); // Changed for a different fade effect

  float circle = 1.0 - smoothstep(0.8 * circleGrowTimer, 1.1 * circleGrowTimer, length(pulsePosition.xy - vPosition.xy) * 0.05); // Changed to xy plane and adjusted step values

  // Set to a light blue color, adjust the multiplication factor for intensity if needed
  vec3 color = vec3(1.0, 1.0, 0.0) * colorFadeTimer; // Set to electric yellow with adjusted intensity
  vec3 coloredLines = color * lineFill; // Apply line fill effect

  vec3 finalColor = mix(coloredLines, vec3(lineFill * 0.2), 1.0 - circle * colorFadeTimer); // Adjusted mix ratio for a different visual effect

  gl_FragColor = vec4(finalColor, 1.0);
}