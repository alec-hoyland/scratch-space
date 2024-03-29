function F = makefiltlp(fc,Fs)
%
% Name: makefiltlp
%
% Inputs:
%    fc - Cutoff frequency (Hz)
%    Fs - Sampling frequency (Hz)
% Outputs:
%    F - a struct, representing a 2nd-order low-pass digital sinc filter
%
% Created by: Adam C. Lammert (2022)
% Author: ??? (you)
%
% Description: Create a 2nd-order low-pass digital sinc filter
%              and populate its coefficients in accordance with the
%              specified cutoff frequency fc at sampling rate Fs
%

% Make a 2nd-order digital filter
F = makefilt(2);

% Determine filter cutoff frequency, as a fraction of the Nyquist frequency
theta = 2 * fc / Fs;

% Calculate filter coefficients (b)
% Store them in the filter struct
A = 0.08 * theta * sinc(theta);
F.b(1) = A / (2 * A + theta);
F.b(2) = theta / (2 * A + theta);
F.b(3) = F.b(1);

% Set the normalization term (a)
% Store them in the filter struct
F.a(1) = 1;

return
%eof