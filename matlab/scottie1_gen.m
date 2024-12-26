clc;
clear;
sampleRate = 44100;%sampling rate
signal = [];
image = imread('bupt_scottie.png');

R = image(:,:,1);
G = image(:,:,2);
B = image(:,:,3);

% compare
% for i = 1:256
%     for j = 1:320
%         if mod(j, 80)>40
%             R(i, j) = 200;
%             G(i, j) = 200;
%             B(i, j) = 200;
%         else
%             R(i, j) = 33;
%             G(i, j) = 33;
%             B(i, j) = 33;
%         end
%     end
% end
% image(:,:,1) = R;
% image(:,:,2) = G;
% image(:,:,3) = B;
% imshow(image);

% leader tone 1900Hz 300ms
signal = genSignal(1900, 300, signal);

% break 1200Hz 10ms
signal = genSignal(1200, 10, signal);

% leader tone 1900Hz 300ms
signal = genSignal(1900, 300, signal);

% VIS code
% start bit 1200Hz 30ms
signal = genSignal(1200, 30, signal);

visScottie1 = 60;

bits = dec2bin(visScottie1);
bits = bits - 48;
len = 7 - length(bits);
temp = zeros(1, len);
bits = [temp bits];
num = length(find(bits == 1));
if mod(num, 2) == 0
    parity = 0;
else
    parity = 1;
end
bits = [parity bits];
for i = 8:-1:1
    if bits(i)      % 1
        signal = genSignal(1100, 30, signal);
    else           % 0
        signal = genSignal(1300, 30, signal);
    end
end
signal = genSignal(1200, 30, signal);

% “Starting” sync pulse (first line only!)
signal = genSignal(1200, 9, signal);

% Scan circle
for i = 1:256
    signal = sendOneline(R(i, :), G(i, :), B(i, :), signal);
end
% plot(signal(200000:201000));
audiowrite('buptScottie.wav',signal,44100);


function signal = genSignal(frequency, duration_ms, signal)
    % 使相位连续，否则有严重的频谱泄露
    persistent phi;
    if isempty(phi)
        phi = 0;
    end
    sampleRate = 44100;
    numSamples = sampleRate*duration_ms/1000;

    time = linspace(0,duration_ms/1000,numSamples);
    signal = [signal sin(2*pi*frequency*time + phi)];
    delta = pi/10;
    phi = mod(2*pi*frequency*duration_ms/1000 + phi + delta, 2*pi);
end

function signal = sendOneline(R, G, B, signal)
    pixel_time = 0.4385;
    % seperator pulse 1.5ms 1500hz
    signal = genSignal(1500, 1.495, signal);

%     disp('---------line---------');
%     disp(R);
%     disp(G);
%     disp(B);
    % Green scan
    for i = 1:320
        frq = double(G(i))*3.1372549+1500;
%         disp(frq);
        signal = genSignal(frq, pixel_time, signal);
    end
    % seperator pulse 1.5ms 1500hz
    signal = genSignal(1500, 1.495, signal);
    % Blue scan
    for i = 1:320
        frq = double(B(i))*3.1372549+1500;
%         disp(frq);
        signal = genSignal(frq, pixel_time, signal);
    end
    % Sync pulse 9.0ms 1200hz
    signal = genSignal(1200, 8.985, signal);
    % Sync porch 1.5ms 1500hz
    signal = genSignal(1500, 1.495, signal);
    % Red scan
    for i = 1:320
        frq = double(R(i))*3.1372549+1500;
%         disp(frq);
        signal = genSignal(frq, pixel_time, signal);
    end
end
