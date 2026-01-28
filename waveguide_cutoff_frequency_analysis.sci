// Define constants
c = 3e8; // Speed of light in vacuum (m/s)
epsilon_r = 1; // Relative permittivity
mu_r = 1; // Relative permeability

// Range for 'a' in mm (converted to meters in calculations)
a_range_mm = 5:1:30; // 'a' from 5 mm to 30 mm
a_range = a_range_mm * 1e-3; // Convert to meters
n_points = length(a_range);

// Function to calculate cutoff frequency for a given mode
function fc = calculate_fc(m, n, a, b, c, epsilon_r, mu_r)
    fc = c / (2 * sqrt(epsilon_r * mu_r)) * sqrt((m/a)^2 + (n/b)^2);
endfunction

// Initialize arrays for cutoff frequencies
fc_TE10 = zeros(1, n_points); // TE10 mode
fc_TE11 = zeros(1, n_points); // TE11 mode
fc_TE01 = zeros(1, n_points); // TE01 mode
fc_TE20 = zeros(1, n_points); // TE20 mode

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


plot(a_range_mm, fc_TE10, "r-", "LineWidth", 2); // TE10 in red
plot(a_range_mm, fc_TE11, "g--", "LineWidth", 2); // TE11 in green
plot(a_range_mm, fc_TE01, "b-.", "LineWidth", 2); // TE01 in blue
plot(a_range_mm, fc_TE20, "m:", "LineWidth", 3); // TE20 in magenta


xlabel("Waveguide Larger Dimension a (mm)");
ylabel("Cutoff Frequency f_c (GHz)");
title("Cutoff Frequency vs a for Rectangular Waveguide Modes");
legend(["TE10", "TE11", "TE01", "TE20"], "Location", "northwest");


xgrid();
