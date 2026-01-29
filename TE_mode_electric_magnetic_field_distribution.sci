// Define waveguide dimensions
a = 0.02; // Width of the waveguide (x-direction) in meters
b = 0.01; // Height of the waveguide (y-direction) in meters

// Define frequency and mode parameters
f = 10e9; // Frequency in Hz (10 GHz)
c = 3e8; // Speed of light in m/s
lambda = c / f; // Wavelength in meters
k0 = 2 * %pi / lambda; // Wave number in free space

// TE11 mode numbers
m = 2;
n = 0;

// Compute cutoff frequency and wave number
fc = (c / 2) * sqrt((m / a)^2 + (n / b)^2); // Cutoff frequency
kc = sqrt((m * %pi / a)^2 + (n * %pi / b)^2); // Cutoff wave number
beta = sqrt(k0^2 - kc^2); // Propagation constant

// Define the grid for visualization
nx = 20; ny = 20; // Grid resolution
x = linspace(0, a, nx);
y = linspace(0, b, ny);
[X, Y] = ndgrid(x, y); // Create 2D meshgrid (corrected)


// Compute Electric Field (E) components for TE11 mode
Ex = - (n * %pi / b) * cos(m * %pi * X / a) .* sin(n * %pi * Y / b);
Ey = (m * %pi / a) * sin(m * %pi * X / a) .* cos(n * %pi * Y / b);

// Compute Magnetic Field (H) components for TE11 mode
Hx =  (m * %pi / a) * sin(m * %pi * X / a) .* cos(n * %pi * Y / b);
Hy = - (n * %pi / b) * cos(m * %pi * X / a) .* sin(n * %pi * Y / b);

// Plot the Electric Field
figure(1);
clf();
champ(x, y, Ex, Ey); // Corrected input for champ()
title('Electric Field (E) in TE11 Mode');
xlabel('x (m)');
ylabel('y (m)');
xgrid();

// Plot the Magnetic Field
figure(2);
clf();
champ(x, y, Hx, Hy); // Corrected input for champ()
title('Magnetic Field (H) in TE11 Mode');
xlabel('x (m)');
ylabel('y (m)');
xgrid();
