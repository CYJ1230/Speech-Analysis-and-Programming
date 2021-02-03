function f0=F0_extraction_cep(sig,fs)
% 说明：
% 给定通过audioread函数提取的语音信号和基频， 
% 利用倒谱法，返回该语音样本的基频。

% [sig fs]=audioread('shehui.wav');
original_signal_len=length(sig);%存放时长
frame_len=512;%帧长为20ms
frame_step=round((fs/1000)*5);%步长为5ms

frame_num=floor((original_signal_len-frame_len)/frame_step);%存放基频数据的规模，原始信号长度减去一个帧长再除以步长


%从开始到最后的基频测量点，执行循环
%用enframe分帧
frame_signal=enframe(sig,frame_len,frame_step);
for i=1:frame_num
    single_frame_signal=frame_signal(i,:)';
    win_p=blackman(frame_len);
    single_frame_signal_win=single_frame_signal.*win_p;
    pow_spec=abs(fft(single_frame_signal_win,frame_len));
    pow_spec=20*log(pow_spec(1:0.5*frame_len));
    cep_p=dct(pow_spec);
    [f0_max f0_max_p]=max(cep_p(30:200,1));
    f0(i,1)=round(fs/(29+f0_max_p));
end