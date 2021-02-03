function formant_display_output = formant_display(sig,fs)
% 说明：
% 给定通过audioread函数提取的语音信号和基频，
% 返回该语音样本的共振峰。

%FORMANT_DISPLAY 此处显示有关此函数的摘要
%   此处显示详细说明

% [sig fs]=audioread('a_ibm.wav');
fftpnt=512;
lpc_order=10;

original_signal_len=length(sig);
frame_len=fftpnt;%帧长为512
frame_step=round(length(sig)/200);%200个点 %round((fs/1000)*1);
frame_num=floor((original_signal_len-frame_len)/frame_step);
frame_signal=enframe(sig,frame_len,frame_step);

for i=1:frame_num
    single_frame_signal=frame_signal(i,:)';
    lpc_coe=lpc(single_frame_signal,lpc_order);
    pole=roots(lpc_coe(1,:));
    
    formant=(angle(pole)*fs)/(2*pi);
    
    pole_i=sqrt(power(real(pole),2)+power(imag(pole),2));
    w_i=angle(pole);
    bandwidth=(-log10(pole_i)*fs)/pi;

    
    fmt_p(:,1)=formant(:,1);
    fmt_p(:,2)=bandwidth(:,1);
    fmt_p=round(sortrows(fmt_p));
    formant_p(1:5,1)=fmt_p(6:10,1);
    formant_p(1:5,2)=fmt_p(6:10,2);
    
        
    for j=1:length(formant_p)
        if formant_p(j,2)>700
            formant_p(j,1)=nan;
        end
    end
    
    for k=1:length(formant_p)
        if formant_p(k,1)<150
            formant_p(k,1)=nan;
        elseif formant_p(k,1)>fs*0.5
            formant_p(k,1)=nan;
        end
    end

    formant_display_output(i,:)=formant_p(:,1);
    
end
% plot(formant_display_output,'.');
