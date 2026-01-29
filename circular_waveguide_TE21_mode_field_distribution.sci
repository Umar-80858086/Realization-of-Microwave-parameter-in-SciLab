// Define waveguide dimensions
a = 0.05; // Radius of the circular waveguide (m)

// Define frequency and mode parameters
f = 10e9; // Frequency in Hz (10 GHz)
c = 3e8; // Speed of light in m/s
lambda = c / f; // Wavelength in meters
k0 = 2 * %pi / lambda; // Wave number in free space


m = 2;
n = 1;

// Compute cutoff frequency and wave number
kc = 3.0542 / a; // Cutoff wave number for TE11 mode
beta = sqrt(k0^2 - kc^2); // Propagation constant

// Define the grid for visualization
nr = 50; nphi = 50; // Grid resolution
r = linspace(0, a, nr);
phi = linspace(0, 2*%pi, nphi);
[R, Phi] = ndgrid(r, phi); // Create 2D meshgrid

// Compute Bessel function and its derivative
Jm = besselj(m, kc * R);
Jm_prime = besselj(m-1, kc * R) - (m ./ (kc * R)) .* besselj(m, kc * R);

// Compute Electric Field (E) components for TE11 mode
E_theta = Jm .* sin(m * Phi); // Azimuthal component

// Compute Magnetic Field (H) components for TE11 mode
H_r = -(1i * beta) ./ (kc^2 * R) .* m .* Jm .* sin(m * Phi); // Radial component
H_theta = (1i * beta) ./ kc .* Jm_prime .* cos(m * Phi); // Azimuthal component
H_z = Jm .* cos(m * Phi); // Longitudinal component

// Convert to Cartesian coordinates for plotting
X = R .* cos(Phi);
Y = R .* sin(Phi);

// Plot the Electric Field Magnitude
figure(1);
clf();
surf(X, Y, abs(E_theta));
title(['Electric Field Magnitude (TE' + string(m) + string(n) + ' Mode)']);
xlabel('x (m)');
ylabel('y (m)');
zlabel('|E_theta|');

// Plot the Magnetic Field Magnitude
figure(2);
clf();
H_magnitude = sqrt(abs(H_r).^2 + abs(H_theta).^2 + abs(H_z).^2);
surf(X, Y, H_magnitude);
title(['Electric Field Magnitude (TE' + string(m) + string(n) + ' Mode)']);
xlabel('x (m)');
ylabel('y (m)');
zlabel('|H|');
