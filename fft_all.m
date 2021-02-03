function [scale spec_log]=fft_single(sig,fs,a,b);
% 说明：
% 给定通过audioread函数提取的语音信号和基频，以及时间轴上横坐标取值范围
% 返回该语音样本指定时间段内的功率谱。


signal_temp=sig(round(a*fs):round(b*fs)-1,1); 

signal_len=length(signal_temp);
han_win=blackman(signal_len);
amp_win=signal_temp.*han_win;
    
f_amp=fft(amp_win,signal_len);
spec=abs(f_amp(1:round(signal_len/2)));
spec_log=10*log10(spec);

max_value=max(spec_log);
min_value=min(spec_log);
scale=[1:(fs/2)/(signal_len/2):fs/2]';
    
% figure;
% plot(scale_temp,spec_log,'b');
% axis([1 fs/2 min_value max_value*1.4]);
% xlabel('Frequency(Hz)');
% ylabel('Amplitude(dB)');

% signal_temp=handles.Speech(round(handles.LeftPoint*handles.FS):round(handles.LeftPoint*handles.FS)+handles.FftPoint-1,1); 
% han_win=blackman(handles.FftPoint);% han_win=hanning(frame_length);    % han_win=hamming(frame_length);
% amp_win=signal_temp.*han_win;
%     
% f_amp=fft(amp_win);
% spec=abs(f_amp(1:handles.FftPoint/2));
% spec_log=20*log10(spec);%对数谱
%     
% max_value=max(spec_log);
% min_value=min(spec_log);
% scale_temp=[1:(handles.FS/2)/(handles.FftPoint/2):handles.FS/2]';
%     
% figure;
% plot(scale_temp,spec_log,'b');
% axis([1 handles.FS/2 min_value max_value*1.4]);
% title(['Spectrum of ',handles.Filename]);
% xlabel('Frequency(Hz)');
% ylabel('Amplitude(dB)');