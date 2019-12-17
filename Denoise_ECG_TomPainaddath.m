clear all;
close all;
data = load('ecg_data.txt');        %load the ECG signal file
t = data(:,1);                      %time vector
x = data(:,2);                      %ECG signal 
fs = 1000;                          %sampling frequency
fc = 10;                            %cutoff frequency
N = 3;                              %order of filter

%%
%Coruppted signal
subplot(2, 3, 1);                   %place the plot in first row first column
plot(t,x);                          %plot the courrpted signal
xlabel('Coruppted');                %label x-axis
subplot(2, 3, 2);                   %place the plot in first row 2 column
myFFT(x,fs);                        %plot fast fourier of the signal
xlabel('myFFT Coruppted');          %label x-axis
%%
%Butterworth filter
[num,den] = butter(N,2*pi*fc,'s');  %set the numerator and denominator of the Butterworth filter transfer function
H_butter = tf(num,den);             %create the transfer function  
y = lsim(H_butter,x,t);             %apply the filter on the signal
disp('butter poles');               %display text
disp(roots(den));                   %display roots of the denominator
subplot(2, 3, 3);                   %place the plot in row 1 column 3
plot(t,y);                          %plot Butterworth filtered signal
xlabel('Denoised');                 %label x-axis
subplot(2, 3, 4);                   %place the plot in row 2 column 1
myFFT(y,fs);                        %plot fast fourier of the denoised signal
xlabel('myFFT Denoised');           %label x-axis

%%
%Butterworth and Chebyshev  filters combined
[num,den] = cheby1(N,3,2*pi*fc,'s');
H_cheb = tf(num,den);
z = lsim(H_cheb, y,t);
subplot(2, 3, 5);
plot(t,z);
xlabel('Combined Denoised');
subplot(2, 3, 6);
myFFT(z, fs);
xlabel('myFFT Combined Denoised');




