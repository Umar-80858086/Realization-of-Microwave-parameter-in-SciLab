// Define constants
c = 3e8; // Speed of light in vacuum (m/s)

// Define the range of lengths (a)
a = linspace(0.01, 0.1, 100); // Lengths from 0.01m to 0.1m

// Calculate cutoff frequencies for different modes
Fc_TE11 = c ./ (2 * %pi * a) * 1.841;
Fc_TM01 = c ./ (2 * %pi * a) * 2.405;
Fc_TE01 = c ./ (2 * %pi * a) * 3.832;

// Plot the results
plot(a, Fc_TE11, 'b-', a, Fc_TM01, 'r-', a, Fc_TE01, 'g-');
xlabel('Length (a) in meters');
ylabel('Cutoff Frequency (Fc) in Hz');
title('Cutoff Frequency vs Length for Circular Waveguide Modes');
legend(['TE11 mode'; 'TM01 mode'; 'TE01 mode']);
