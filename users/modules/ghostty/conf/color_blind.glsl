mat3 normal;
normal[1] = vec3(1.0, 0.0, 0.0);
normal[2] = vec3(0.0, 1.0, 0.0);
normal[3] = vec3(0.0, 0.0, 1.0);
// Red-Blind
mat3 protanopia; 
protanopia[1] = vec3(0.567,0.433,0.000);
protanopia[2] = vec3(0.558,0.442,0.000);
protanopia[3] = vec3(0.000,0.242,0.758);
// Red-Weak
mat3 protanomaly;
protanomaly[1] = vec3(0.817,0.183,0.000);
protanomaly[2] = vec3(0.333,0.667,0.000);
protanomaly[3] = vec3(0.000,0.125,0.875);
// Green-Blind
mat3 deuteranopia;
deuteranopia[1] = vec3(0.625,0.375,0.000);
deuteranopia[2] = vec3(0.700,0.300,0.000);
deuteranopia[3] = vec3(0.000,0.300,0.700);
// Green-Weak
mat3 deuteranomaly;
deuteranomaly[1] = vec3(0.800,0.200,0.000);
deuteranomaly[2] = vec3(0.258,0.742,0.000);
deuteranomaly[3] = vec3(0.000,0.142,0.858);
// Blue-Blind
mat3 tritanopia;
tritanopia[1] = vec3(0.950,0.050,0.000);
tritanopia[2] = vec3(0.000,0.433,0.567);
tritanopia[3] = vec3(0.000,0.475,0.525);
// Blue-Weak
mat3 tritanomaly;
tritanomaly[1] = vec3(0.967,0.033,0.00);
tritanomaly[2] = vec3(0.00,0.733,0.267);
tritanomaly[3] = vec3(0.00,0.183,0.817);
// Monochromacy
mat3 achromatopsia;
achromatopsia[1] = vec3(0.299,0.587,0.114);
achromatopsia[2] = vec3(0.299,0.587,0.114);
achromatopsia[3] = vec3(0.299,0.587,0.114);
// Blue Cone Monochromacy
mat3 achromatomaly;
achromatomaly[1] = vec3(0.618,0.320,0.062);
achromatomaly[2] = vec3(0.163,0.775,0.062);
achromatomaly[3] = vec3(0.163,0.320,0.516);
