function [scale cep_env_result]=cep_env_all(sp,fs,a,b)
% ˵����
% ����ͨ��audioread������ȡ�������źźͻ�Ƶ���Լ���ͼ�ν�����ѡ����ʱ��������귶Χ�� 
% ���ظ�����������Ӧʱ�䷶Χ���װ��硣

sp=sp(round(a*fs):round(b*fs)-1,1); 
signal_len=length(sp);
win_p=blackman(length(sp));
sp_win=sp.*win_p;
pow_spec=abs(fft(sp_win,length(sp)));
pow_spec=10*log(pow_spec(1:0.5*length(sp)));
% plot(pow_spec);
cep_p=dct(pow_spec);%����
cep_z=cep_p;
cep_z(25:length(sp))=0;
% plot(cep_p);
cep_env_result=idct(cep_z);%���˷��任����ʣ�µ�ֻ�еĹ�����Ϣ�������

scale=[1:(fs/2)/length(cep_env_result):fs/2]';
% 
% figure;
% plot(scale_temp,cep_env_result,'b');
% axis([1 fs/2 min_value max_value*1.4]);
% xlabel('Frequency(Hz)');
% ylabel('Amplitude(dB)');

% plot(cep_env_result);
% scale_p=[1:(fs/2)/(512/2):fs/2]';%������fftpoint/2 ��1��fs/2
% plot(scale_p,cep_env);
% max_p=max(cep_env);
% min_p=min(cep_env);
% axis([1 fs/2 min_p max_p*1.4]);
% xlabel('Frequency(Hz)');

% ����Ҫ��һ���װ���͹����׵�����һ����� ������-����-�װ��� ����һ����� ѡȡһ���㣬plot������
% ����һ���õ��׷����Ƶ�ĺ���