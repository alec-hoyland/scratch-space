function [H M P] = transfer(F,nfreqs)
%
% Name: transfer - v2
%
% Inputs:
%    F - a struct, representing an IIR digital filter
%    nfreqs - a scalar representing the number of frequencies to evaluate
% Outputs:
%    H - a nfreqs-by-1 vector, representing the filter frequency response
%    M - a nfreqs-by-1 vector, representing the filter magnitude response
%    P - a nfreqs-by-1 vector, representing the filter phase response
%
% Created by: Adam C. Lammert (2022)
% Author: ??? (you)
%
% Description: Compute the frequency response of a IIR filter at the
%              nfreqs frequencies equally spaced between 0 and pi.
%              Note: this is a version of Matlab's 'freqz'.
%

% Determine additional parameters
j = sqrt(-1);

% Fill a vector of test frequencies
w = linspace(0, pi, nfreqs)';

% Create a vectors NUM and DEN that will eventually contain 
% the numerator and denominator of the transfer function.
NUM = zeros(nfreqs,1);
DEN = zeros(nfreqs,1);

% Compute NUM and DEN by summing the terms of two polynomials in z.
% One polynomial relates to prior filter inputs and the b coefficients,
% and should have its value stored in NUM. The second polynomial relates 
% to prior filter outputs and the a coefficients, and should have its 
% value stored in DEN.

NUM = F.b(1);
for ii = 2:F.order
    NUM = F.b(ii) * (nfreqs .^ (ii - 1));
end

DEN = F.a(1);
for ii = 2:F.order
    DEN = F.a(ii) * (nfreqs .^ (ii - 1));
end

% Compute H as the ratio of NUM and DEN

H = NUM ./ DEN;

% Calculate magnitude (M) and phase (P) outputs

M = abs(H);
P = angle(H);

return
%eof