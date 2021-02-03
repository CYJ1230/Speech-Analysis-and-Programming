function f0=F0_extraction_cep(sig,fs)
% ˵����
% ����ͨ��audioread������ȡ�������źźͻ�Ƶ�� 
% ���õ��׷������ظ����������Ļ�Ƶ��

% [sig fs]=audioread('shehui.wav');
original_signal_len=length(sig);%���ʱ��
frame_len=512;%֡��Ϊ20ms
frame_step=round((fs/1000)*5);%����Ϊ5ms

frame_num=floor((original_signal_len-frame_len)/frame_step);%��Ż�Ƶ���ݵĹ�ģ��ԭʼ�źų��ȼ�ȥһ��֡���ٳ��Բ���


%�ӿ�ʼ�����Ļ�Ƶ�����㣬ִ��ѭ��
%��enframe��֡
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