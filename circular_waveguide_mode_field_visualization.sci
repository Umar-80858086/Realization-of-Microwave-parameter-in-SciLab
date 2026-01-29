// Define parameters
clc;
clear;
clf;

a = 1;  // Cylinder radius
l = 2;  // Cylinder length

// Create a grid in cylindrical coordinates
theta = linspace(0, 2*%pi, 50);
r = linspace(0, a, 50);
[R, THETA] = ndgrid(r, theta);
X = R .* cos(THETA);
Y = R .* sin(THETA);

// Define Bessel function orders for each mode
modes = [3.4, 2.61, 1.64]; // Normalized Bessel function roots
labels = ["TE_11", "TM_01", "TE_01"];

// Create figure
for i = 1:3
    Jm = besselj(1, modes(i) * R / a); // Bessel function for mode shape
    Z = cos(THETA) .* Jm; // Simulate the field distribution

    subplot(3, 3, 3*i - 2)
    contour(r, theta, Z, 20);
    title(labels(i) + " Cross-section");
    xlabel("X");
    ylabel("Y");
   
xlong = linspace(-l/2, l/2, 50);
zlong = linspace(-a, a, 50);
    // Longitudinal field distribution
    [Zlong, Xlong] = ndgrid(xlong, zlong);
    Field = cos(%pi * Zlong / l) .* cos(%pi * Xlong / a); // Approximation

    subplot(3, 3, 3*i-1)
    contourf(xlong, zlong, Field, 20);
    title(labels(i) + " Longitudinal View");
    xlabel("Length");
    ylabel("Radial");
    
        subplot(3, 3, 3*i)
   
    for t = 1:5:length(theta)
        plot(r .* cos(theta(t)), r .* sin(theta(t)), 'b'); // Radial lines
    end
    for rr = linspace(0, a, 5)
        plot(rr * cos(theta), rr * sin(theta), 'r'); // Circular field lines
    end
   
    title(labels(i) + " Field Lines");
    xlabel("X");
    ylabel("Y");
    
end

// Display plot
show_window();
    
