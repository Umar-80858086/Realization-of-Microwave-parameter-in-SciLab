// Input parameters
fc = 90e9; // Cutoff frequency in Hz
epsilon_r = 1.0; // Relative permittivity (initial guess)
mu_r = 1.0; // Relative permeability (initial guess)
c = 3e8; // Speed of light in vacuum (m/s)

// Target dimensions (a and b)
a_target = 1e-2; // Target value for 'a' in meters
b_target = 0.5e-2; // Target value for 'b' in meters

// Function to calculate the cutoff frequency
function fc_calc = calculate_fc(a, b, epsilon_r, mu_r)
    fc_calc = c / (2 * sqrt(epsilon_r * mu_r) * a);
endfunction

// Mutation loop for permittivity and permeability
epsilon_range = 0.1:0.1:5; // Range for epsilon_r
mu_range = 0.01:0.01:5; // Range for mu_r
best_epsilon = 0;
best_mu = 0;
best_error = %inf;

for epsilon = epsilon_range
    for mu = mu_range
        a_calc = c / (2 * sqrt(epsilon * mu) * fc); // Calculate 'a'
        b_calc = a_calc / 2; // Assume b = a / 2
        error = abs(a_calc - a_target) + abs(b_calc - b_target); // abs is | | this measure how far waveguide dimension and target value 

        if error < best_error  // If the current error is smaller than the best error, updates best_epsilon best_mu, and best_error.
            best_error = error;
            best_epsilon = epsilon;
            best_mu = mu;
        end
    end
end

// Display the results
disp("Optimal Relative Permittivity (epsilon_r): " + string(best_epsilon));
disp("Optimal Relative Permeability (mu_r): " + string(best_mu));

a_final = c / (2 * sqrt(best_epsilon * best_mu) * fc);
b_final = a_final / 2;

disp("Calculated a (width): " + string(a_final) + " meters");
disp("Calculated b (height): " + string(b_final) + " meters");
