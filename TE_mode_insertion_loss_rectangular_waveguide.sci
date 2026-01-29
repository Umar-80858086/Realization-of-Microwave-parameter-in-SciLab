// Input Parameters
a = 2e-2;         // Waveguide width (m) 
b = 1e-2;         // Waveguide height (m) 
m = 1;                // TE mode index m
n = 1;                // TE mode index n (n=0 for TE modes)
sigma = 1e-7;        // Conductivity (S/m)
epsilon_r = 1;        // Relative permittivity (air-filled)
mu_r = 1;             // Relative permeability
f_start = 5e9;        // Start frequency (Hz)
f_stop = 30e9;        // Stop frequency (Hz)
N = 100;              // Number of frequency points

// Constants
mu0 = 4*%pi*1e-7;     // Permeability of free space
epsilon0 = 8.854e-12; // Permittivity of free space
c = 3e8;              // Speed of light

// Derived Parameters
mu = mu_r * mu0;
epsilon = epsilon_r * epsilon0;
eta = sqrt(mu/epsilon);
f = linspace(f_start, f_stop, N);
omega = 2*%pi*f;
k = omega .* sqrt(mu .* epsilon); // Element-wise multiplication

// Pre-calculate cutoff frequency for TE mode
fc_TE = c / (2 * sqrt(mu_r * epsilon_r)) * sqrt((m/a)^2 + (n/b)^2);

// Calculate beta for TE mode
kc_TE = %pi/a * sqrt((m/a)^2 + (n/b)^2);
beta_TE = sqrt(k.^2 - kc_TE.^2); // Element-wise subtraction

// Calculate characteristic impedance for TE mode
Zte = eta .* beta_TE ./ k; // Element-wise division

alpha_TE = zeros(1, N);

// Check for valid TE mode
if (m == 0 & n == 0) then
    error("TE00 mode does not exist!");
end

for k = 1:N
    // Surface resistance
    Rs = sqrt(%pi * f(k) * mu / sigma);
    
    // TE Mode Calculation using the alternative formula
    if (f(k) > fc_TE) then
        alpha_TE(k) = (sigma * omega(k)) / (2 * mu) * (1 + c^2 / (2 * a^2 * omega(k)^2));
    else
        alpha_TE(k) = %inf; // Below cutoff
    end
end

// Convert to dB/m (1 Np = 8.686 dB)
alpha_TE_dB = log10(alpha_TE);

// Plot Results
plot(f/1e9, alpha_TE_dB, 'r-', linewidth=2);
xgrid();
xlabel("Frequency (GHz)");
ylabel("Attenuation (dB/m)");
title("Insertion Loss for TE" + string(m) + string(n) + " Mode in Rectangular Waveguide");
legend("TE" + string(m) + string(n));
