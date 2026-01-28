// Hysteresis Loop Simulation for Ferrite Material
// Simplified Jiles-Atherton Model

clear;
clf;
scf(0); // Ensure clean figure

// Material Parameters
a = 50;        // Shape parameter (A/m) - controls anhysteretic curve slope
alpha = 5e-4;    // Interdomain coupling coefficient
k = 500;          // Coercivity/pinning coefficient (A/m)
Ms = 1.5e5;      // Saturation magnetization (A/m)

// Simulation Parameters
H_max = 1000;    // Maximum applied field (A/m) - Increased for better saturation
N_points = 1000; // Number of calculation points per branch
mu0 = 4*%pi*1e-7; // Permeability of free space (H/m)

// Initialize arrays
H = zeros(2*N_points, 1);
M = zeros(2*N_points, 1);

// Generate field sequence: one full cycle (-Hmax -> +Hmax -> -Hmax)
H(1:N_points) = linspace(-H_max, H_max, N_points);
H(N_points+1:2*N_points) = linspace(H_max, -H_max, N_points);

// Initialize magnetization at negative saturation (for proper closed loop)
// Approximate using Langevin function at H = -H_max
H_init = -H_max + alpha*(-Ms);
if abs(H_init/a) > 1e-3 then
    M(1) = Ms*(coth(H_init/a) - a/H_init);
else
    M(1) = -Ms; // Approximate saturation
end

// Calculate magnetization
for n = 2:(2*N_points)
    dH = H(n) - H(n-1);
    
    // Effective field (using previous M for numerical stability)
    He_prev = H(n-1) + alpha*M(n-1);
    He_curr = H(n) + alpha*M(n-1);
    
    // Langevin function: Man(H) = Ms*(coth(He/a) - a/He)
    // with protection against He ≈ 0 singularity
    function y = langevin(He)
        x = He / a;
        if abs(x) < 1e-6 then
            // Taylor expansion: coth(x) - 1/x ≈ x/3 for x→0
            y = Ms * (x / 3);
        else
            y = Ms * (coth(x) - 1/x);
        end
    endfunction
    
    Man_curr = langevin(He_curr);
    Man_prev = langevin(He_prev);
    
    // Exponential relaxation toward anhysteretic curve
    // Different sign for ascending vs descending to ensure decay factor < 1
    if dH > 0 then
        // Ascending branch (dH positive, -k*dH negative, exp < 1)
        M(n) = Man_curr + (M(n-1) - Man_prev)*exp(-k*dH/Ms);
    else
        // Descending branch (dH negative, k*dH negative, exp < 1)
        M(n) = Man_curr + (M(n-1) - Man_prev)*exp(k*dH/Ms);
    end
end

// Convert to flux density B = μ0(H + M)
B = mu0*(H + M);

// Plotting
plot(H, B, 'b-', 'LineWidth', 2);
xlabel("Magnetic Field Strength, H (A/m)", "fontsize", 3);
ylabel("Magnetic Flux Density, B (T)", "fontsize", 3);
title("Ferrite Hysteresis Loop (Jiles-Atherton Model)", "fontsize", 4);
xgrid(color('gray'), 1, 7); // Modern grid style

// Auto-scale axes based on actual calculated values with margin
B_max = max(B);
H_margin = H_max * 1.1;
B_margin = B_max * 1.2;
gca().data_bounds = [-H_margin, -B_margin; H_margin, B_margin];

// Add saturation line reference
plot(H, mu0*H, 'r--', 'LineWidth', 1); // Air line (B = μ0*H)
legend(["Hysteresis Loop"; "Air core (μ0H)"], opt=1);
