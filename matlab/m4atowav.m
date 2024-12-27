clear all;
close all;

% 读取 .m4a 文件
[inputAudio, fs] = audioread('../resources/20241227-2307_SSTV-color-test.m4a'); % input.m4a 是文件名
disp(fs);

% 将音频保存为 .wav 文件
audiowrite('../resources/20241227-2307_SSTV-color-test.wav', inputAudio, fs); % output.wav 是目标文件名

%%
% disp('Conversion from m4a to wav completed.');

% 生成时间轴
numSamples = 480000;          % 样本数量
time = (0:numSamples-1) / fs;            % 时间轴，单位为秒

% 绘制波形
figure(1);
plot(time, inputAudio(1:numSamples));
xlabel('Time (s)');                      % 横轴：时间（秒）
ylabel('Amplitude');                     % 纵轴：振幅
title('Waveform of the Audio File');     % 标题
grid on;

% 设计低通滤波器（2500 Hz 通带）
fc = 2600;                 % 截止频率（Hz）
order = 10;                 % 滤波器阶数
% [b, a] = besself(order, 2 * pi * fc);     % 连续时间 Bessel 滤波器
% [bz, az] = bilinear(b, a, fs); 
[b, a] = butter(order, fc / (fs / 2), 'low'); % 归一化截止频率

% 计算并绘制幅频特性
figure(2);
[h, w] = freqz(b, a, 1024, fs); % 频率响应
plot(w(1:200), 20*log10(abs(h(1:200))));      % 绘制幅度响应（单位：dB）
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Frequency Response of the Low-pass Filter');
grid on;

% 应用低通滤波器
filteredAudio = filter(b, a, inputAudio);
audiowrite('efilter.wav', inputAudio, fs);
% 
% % 生成时间轴
% numSamplesFilter = 480000;          % 样本数量
% timeFilter = (0:numSamplesFilter-1) / fs;            % 时间轴，单位为秒
% 
% % 绘制波形
% figure(3);
% plot(timeFilter, filteredAudio(1:numSamplesFilter));
% xlabel('Time (s)');                      % 横轴：时间（秒）
% ylabel('Amplitude');                     % 纵轴：振幅
% title('Waveform of the Audio File');     % 标题
% grid on;