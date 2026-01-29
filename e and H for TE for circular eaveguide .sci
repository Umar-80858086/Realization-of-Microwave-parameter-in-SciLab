// Define waveguide parameters
a = 0.02; // Radius of the circular waveguide (meters)
f = 10e9; // Frequency in Hz (10 GHz)
c = 3e8;  // Speed of light in m/s
lambda = c / f; // Free-space wavelength
k0 = 2 * %pi / lambda; // Free-space wave number

// TE11 Mode Parameters
m = 2;
n = 1;
x_mn = 5.1356; // First root of J1(x) = 0 for TE11 mode

// Compute Cutoff Frequency and Wave Number
fc = (c / (2 * 3.14)) * (x_mn / a); // Cutoff frequency
kc = x_mn / a; // Cutoff wave number
beta = sqrt(k0^2 - kc^2); // Propagation constant

// Define the grid for visualization
nr = 50; nt = 100; // Grid resolution (Radial and Angular points)
r = linspace(0, a, nr);
theta = linspace(0, 6.28, nt);
[R, Theta] = ndgrid(r, theta);

// Convert to Cartesian Coordinates
X = R .* cos(Theta);
Y = R .* sin(Theta);

// Compute the fields using Bessel functions
Jm = besselj(m, kc * R); // Bessel function of first kind

// Electric Field Components
E_theta = Jm .* sin(m * Theta); // Azimuthal component
Er = Jm .* cos(m * Theta);
// Magnetic Field Components
H_r = -Jm .* cos(m * Theta); // Radial component
H_z = Jm .* sin(m * Theta); // Longitudinal Magnetic Field

// Plot the Electric Field Magnitude
figure(1);
clf();
surf(R, Theta, sqrt(E_theta.^2));
title("Electric Field Magnitude (TE11 Mode)");
xlabel("x (m)");
ylabel("y (m)");
zlabel("|E| Field Intensity");
colorbar();

// Plot the Magnetic Field Magnitude
figure(2);
clf();
surf(R, Theta, sqrt(H_r.^2 + H_z.^2));//
title("Magnetic Field Magnitude (TE11 Mode)");
xlabel("x (m)");
ylabel("y (m)");
zlabel("|H| Field Intensity");
colorbar();

figure(3);
clf();
surf(X, Y, sqrt(E_theta.^2));
title("Electric Field Magnitude (TE11 Mode)");
xlabel("x (m)");
ylabel("y (m)");
zlabel("|E| Field Intensity");
colorbar();

// Plot the Magnetic Field Magnitude
figure(4);
clf();
surf(X, Y, sqrt(H_r.^2 + H_z.^2));//
title("Magnetic Field Magnitude (TE11 Mode)");
xlabel("x (m)");
ylabel("y (m)");
zlabel("|H| Field Intensity");
colorbar();
