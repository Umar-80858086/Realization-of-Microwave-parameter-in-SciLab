// Parameters for the circular waveguide
clear;
clc;

a = 1; // Radius of the waveguide
m = 1; // Mode number (TM_mn)
n = 10; // Number of zeros to find

// Function to find zeros of the derivative of the Bessel function
function y = besselj_prime_func(x, m)
    y = besselj(m, x, 1); // Derivative of Bessel function of the first kind
endfunction

// Find the nth zero of the derivative of the Bessel function
function zero = find_besselj_prime_zero(m, n)
    // Initial guess for the nth zero
    initial_guess = n * %pi + (m - 1) * %pi / 2;
    zero = fsolve(initial_guess, list(besselj_prime_func, m));
endfunction

// Compute the zeros of the derivative of the Bessel function
zeros = [];
for i = 1:n
    zero = find_besselj_prime_zero(m, i);
    zeros = [zeros, zero];
end

// Display the zeros in the console
disp("Zeros of the derivative of the Bessel function J" + string(m));
disp(zeros);

// Plot the derivative of the Bessel function and its zeros
x = linspace(0, 20, 1000); // Range for plotting
Jm_prime = besselj(m, x); // Derivative of Bessel function values

// Create a plot
figure();
plot(x, Jm_prime, 'b-', 'LineWidth', 2);
title("Derivative of Bessel Function J" + string(m) + " and Its Zeros");
xlabel("x");
ylabel("J" + string(m) + "(x)");


// Mark the zeros on the plot

for i = 1:length(zeros)
    plot(zeros(i), 0, 'ro', 'MarkerSize', 8, 'LineWidth', 2);
    text(zeros(i), 0.1, string(zeros(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left');
end

// Add legend
legend('J''(' + string(m) + ', x)', 'Zeros');
