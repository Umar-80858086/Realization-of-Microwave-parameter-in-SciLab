
clc;
clear;
close;

// -------------------- Constants --------------------
a = 10e-3;        // Broad dimension of waveguide (meters)
c = 3e8;          // Speed of light in vacuum (m/s)

// -------------------- Frequency Range --------------------
f_start = 20e9;   // Start frequency (20 GHz) > cutoff
f_end   = 40e9;   // End frequency (40 GHz)
num_points = 200;

f = linspace(f_start, f_end, num_points);

// -------------------- Cutoff Frequency (TE10) --------------------
f_c = c / (2 * a);

// -------------------- Phase Velocity --------------------
v_p = c ./ sqrt(1 - (f_c ./ f).^2);

// -------------------- Guided Wavelength --------------------
lambda_g = v_p ./ f;

// -------------------- Plotting --------------------
scf(0);

// Phase Velocity vs Frequency
subplot(2,1,1);
plot(f/1e9, v_p/1e8, 'b', 'LineWidth', 2);
xlabel('Frequency (GHz)');
ylabel('Phase Velocity (×10^8 m/s)');
title('Phase Velocity vs Frequency (TE_{10} Mode)');
xgrid();

// Guided Wavelength vs Frequency
subplot(2,1,2);
plot(f/1e9, lambda_g*1e3, 'g', 'LineWidth', 2);
xlabel('Frequency (GHz)');
ylabel('Guided Wavelength (mm)');
title('Guided Wavelength vs Frequency (TE_{10} Mode)');
xgrid();
