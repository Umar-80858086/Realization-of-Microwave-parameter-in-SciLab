# Waveguide \& Electromagnetic Mode Analysis Toolkit (Scilab)

##  Executive Summary



This repository is a production-grade Scilab simulation suite for electromagnetic waveguide analysis, covering rectangular and circular waveguides, TE/TM mode field distributions, cutoff characteristics, attenuation (insertion loss), and material parameter optimization.



The codebase is designed for Electronics \& Communication engineers, RF/microwave researchers, and postgraduate students who want physics-accurate, modular, and extensible simulations aligned with textbook theory and industry practice.



##  🎯 Key Capabilities



TE \& TM mode field visualization



Cutoff frequency \& wavelength analysis



Insertion loss modeling



Circular and rectangular waveguide support



Material optimization (εᵣ, μᵣ)



Ferrite hysteresis simulation



Bessel function zero analysis



Clean, parameterized Scilab implementations



This repository prioritizes clarity, correctness, and scalability.



##  📁 Repository Structure \& File Description

###  📘 Documentation



README.md

Central documentation and usage guide



## Circular wave guide.docx

Theoretical background and derivations for circular waveguides



##  🔌 Rectangular Waveguide Analysis



waveguide\_cutoff\_frequency\_analysis.sci

Computes cutoff frequencies for rectangular waveguides



TE\_mode\_electric\_magnetic\_field\_distribution.sci

Spatial distribution of E and H fields for TE modes



TE\_mode\_insertion\_loss\_rectangular\_waveguide.sci

Frequency-dependent attenuation / insertion loss modeling



cutoff\_wavelength\_vs\_waveguide\_dimension\_TE.sci

Relationship between cutoff wavelength and waveguide dimensions



###  🟠 Circular Waveguide Analysis



circular\_waveguide\_mode\_field\_visualization.sci

General field visualization framework for circular waveguides



circular\_waveguide\_TE21\_mode\_field\_distribution.sci

TE₂₁ mode electric \& magnetic field patterns



cutoff\_frequency\_vs\_radius\_circular\_waveguide.sci

Cutoff frequency dependency on waveguide radius



e\_and\_H\_for\_TE\_for\_circular\_waveguide.sci

Complete E-field and H-field formulation for TE modes



TM11\_mode\_field\_patterns.sci

TM₁₁ mode field visualization



 ##  📐 Mathematical \& Physical Modeling



zeros\_of\_bessel\_derivative\_TM\_modes.sci

Calculates roots of Bessel function derivatives for TM modes



Phase Velocity and Guided Wavelength Analysis.sci

Phase velocity and guided wavelength behavior vs frequency



##   🧲 Material \& Ferrite Analysis



Hysteresis Loop Simulation for Ferrite Material.sci

Ferrite magnetic hysteresis modeling



waveguide\_material\_parameter\_optimization.sci

Brute-force optimization of εᵣ and μᵣ to meet target cutoff and dimensions



##   ⚙️ Requirements



Scilab 6.x or higher



Basic understanding of:



Electromagnetic Theory



Waveguide Modes (TE/TM)



Bessel Functions



Maxwell’s Equations



No external libraries required.

