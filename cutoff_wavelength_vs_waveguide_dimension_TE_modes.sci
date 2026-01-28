c = 3e8; // Speed of light in vacuum (m/s)
epsilon_r = 1; // Relative permittivity
mu_r = 1; // Relative permeability

a_range_mm = 5:1:30; // 'a' from 5 mm to 30 mm
a_range = a_range_mm * 1e-3; // Convert to meters
n_points = length(a_range);

function fc = calculate_fc(m, n, a, b, c, epsilon_r, mu_r)
    fc = c / (2 * sqrt(epsilon_r * mu_r)) * sqrt((m/a)^2 + (n/b)^2);
endfunction

lambda_TE10 = zeros(1, n_points); // TE10 mode
lambda_TE11 = zeros(1, n_points); // TE11 mode
lambda_TE01 = zeros(1, n_points); // TE01 mode
lambda_TE20 = zeros(1, n_points); // TE20 mode

// Calculate cutoff frequencies for each mode over the range of 'a'
for i = 1:n_points
    a = a_range(i); // Larger dimension in meters
    b = a / 2; // Smaller dimension (b = a / 2)

    // Calculate cutoff frequencies for each mode
    fc_TE10(i) = calculate_fc(1, 0, a, b, c, epsilon_r, mu_r); // TE10: m=1, n=0
    fc_TE11(i) = calculate_fc(1, 1, a, b, c, epsilon_r, mu_r); // TE11: m=1, n=1
    fc_TE01(i) = calculate_fc(0, 1, a, b, c, epsilon_r, mu_r); // TE01: m=0, n=1
    fc_TE20(i) = calculate_fc(2, 0, a, b, c, epsilon_r, mu_r); // TE20: m=2, n=0
end
// Convert frequencies to GHz for easier interpretation
fc_TE10 = fc_TE10 / 1e9;
fc_TE11 = fc_TE11 / 1e9;
fc_TE01 = fc_TE01 / 1e9;
fc_TE20 = fc_TE20 / 1e9;
// Calculate cutoff wavelengths for each mode over the range of 'a'
for i = 1:n_points
   
   lambda_TE10(i) = c / (fc_TE10(i) * 1e9); // Convert f_c back to Hz
   lambda_TE11(i) = c / (fc_TE11(i) * 1e9); 
   lambda_TE01(i) = c / (fc_TE01(i) * 1e9);
   lambda_TE20(i) = c / (fc_TE20(i) * 1e9);
end

// Plot cutoff wavelengths for all modes
figure(); // Open a new figure for wavelength
plot(a_range_mm, lambda_TE10 * 1e3, "r-", "LineWidth", 2); // TE10 in red, converted to mm
plot(a_range_mm, lambda_TE11 * 1e3, "g--", "LineWidth", 2); // TE11 in green, converted to mm
plot(a_range_mm, lambda_TE01 * 1e3, "b-.", "LineWidth", 2); // TE01 in blue, converted to mm
plot(a_range_mm, lambda_TE20 * 1e3, "m:", "LineWidth", 2); // TE20 in magenta, converted to mm

// Add labels, title, and legend for wavelength plot
xlabel("Waveguide Larger Dimension  a (mm)");
ylabel("Cutoff Wavelength λ_c (mm)");
title("Cutoff Wavelength vs a for Rectangular Waveguide Modes");
legend(["TE10", "TE11", "TE01", "TE20"], "Location", "northwest");

// Add grid for better visualization
xgrid();
