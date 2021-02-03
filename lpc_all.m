function lpc_all_result = lpc_all(sig,fs,a,b)
% 说明：
% 给定通过audioread函数提取的语音信号和基频，以及时间轴横坐标取值范围
% 返回该语音样本在该时间段内的LPC分析结果。

% [sp fs]=audioread('aaa.wav');
sig=sig(round(a*fs):round(b*fs)-1,1); 
fftpnt=512;
lpc_order=10;


% for i=1:fftpnt/2
%     axis_scaler(i)=i*((fs/2)/(fftpnt/2));
% end
% 
% plot(axis_scaler,spectrum_p);
% axis([1 fs/2 min_p max_p*1.2]);
% xlabel('Frequency (Hz)');
% ylabel('Megnitude (dB)');


original_signal_len=length(sig);
frame_len=fftpnt;%帧长为512
frame_step=round((fs/1000)*0.05);
frame_num=floor((original_signal_len-frame_len)/frame_step);
frame_signal=enframe(sig,frame_len,frame_step);
for i=1:frame_num
    single_frame_signal=frame_signal(i,:)';
    lpc_coe=lpc(single_frame_signal,lpc_order)';
    fft_coe=fft(lpc_coe,fftpnt);
    spectrum_p=10*log10(abs(fft_coe))*-1;
    spectrum_p=spectrum_p(1:fftpnt/2,1);
    lpc_all_result(i,:)=spectrum_p;
end
