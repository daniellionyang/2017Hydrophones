%Construct a bandpass filter
filtertype = 'FIR';  %FIR filter
sampleRate = 1e5;
Fstop1 = 23e3;       %1st stopband
Fpass1 = 27e3;       %start of passband
Fpass2 = 33e3;       %end of passband
Fstop2 = 37e3;       %2nd stopband
Rp = .1;             %Passband ripple
Astop = 80;          %Stopband Attenuation

d = fdesign.bandpass(Fstop1,Fpass1,Fpass2,Fstop2,Astop,Rp,Astop,sampleRate);
%Use below for highpass filter
%d = fdesign.highpass(Fstop1,Fpass1,Astop,Rp,sampleRate);

%FIRL=design(d,'SystemObject',true);
FIR = design(d, 'equiripple', 'systemobject', true, 'minphase', true);

%fvtool(FIRL,FIR);

%get the coefficients of the filter
coefficients = coeffs(FIR);
coefficients = coefficients.Numerator;