function cep_env_result=cep_nev(pos,sp,fs)
% ˵����
% ����ͨ��audioread������ȡ�������źźͻ�Ƶ���Լ���ͼ�ν�����ѡ����ʱ��������꣬ 
% ���ظ�����������Ӧʱ�����װ��硣

if pos<length(sp)-256 && pos>255 
    sp=sp(pos-255:pos+256,1);
elseif pos>=length(sp)-256
    sp=sp(pos-511:pos,1);
elseif pos<=255
    sp=sp(pos:pos+511,1);
end
%�������ѡ�������߽磬�Ͳ��ܴ����߸�ȡ256�ˣ�����һ���жϡ�

win_p=blackman(512);
sp_win=sp.*win_p;
pow_spec=abs(fft(sp_win,512));
pow_spec=10*log(pow_spec(1:256));
% plot(pow_spec);
cep_p=dct(pow_spec);%����
cep_z=cep_p;
cep_z(25:512/2)=0;
% plot(cep_p);
cep_env_result=idct(cep_z);%���˷��任����ʣ�µ�ֻ�еĹ�����Ϣ�������
% plot(cep_env_result);
% scale_p=[1:(fs/2)/(512/2):fs/2]';%������fftpoint/2 ��1��fs/2
% plot(scale_p,cep_env);
% max_p=max(cep_env);
% min_p=min(cep_env);
% axis([1 fs/2 min_p max_p*1.4]);
% xlabel('Frequency(Hz)');

% ����Ҫ��һ���װ���͹����׵�����һ����� ������-����-�װ��� ����һ����� ѡȡһ���㣬plot������
% ����һ���õ��׷����Ƶ�ĺ���