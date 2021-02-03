function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 06-Jan-2021 20:10:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @main_OpeningFcn, ...
    'gui_OutputFcn',  @main_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

% End initialization code - DO NOT EDIT


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --------------------------------------------------------------------
function file_Callback(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function edit_Callback(hObject, eventdata, handles)
% hObject    handle to edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function pitch_Callback(hObject, eventdata, handles)
% hObject    handle to pitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function f0a_Callback(hObject, eventdata, handles)
% hObject    handle to f0a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function normalization_Callback(hObject, eventdata, handles)
% hObject    handle to normalization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：语音信号数值归一化
handles = guidata(gcbo);

handles.num_time=handles.num_time+1;

handles.sig=handles.sig/max(abs(handles.sig))*0.9;

handles.sigresult{handles.num_time}=handles.sig;
handles.leftresult{handles.num_time}=handles.PreLeft;
handles.rightesult{handles.num_time}=handles.PreRight;

guidata(hObject, handles);
refresh_Callback(hObject, handles);
% --------------------------------------------------------------------
function invert_Callback(hObject, eventdata, handles)
% hObject    handle to invert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：将语音波形上下翻转
handles = guidata(gcbo);

handles.num_time=handles.num_time+1;


handles.sig=handles.sig*-1;%上下翻转

handles.sigresult{handles.num_time}=handles.sig;
handles.leftresult{handles.num_time}=handles.PreLeft;
handles.rightesult{handles.num_time}=handles.PreRight;

guidata(hObject, handles);
refresh_Callback(hObject, handles);
% --------------------------------------------------------------------
function inverse_Callback(hObject, eventdata, handles)
% hObject    handle to inverse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：将语音波形前后翻转
handles = guidata(gcbo);

handles.num_time=handles.num_time+1;

handles.sig=flipud(handles.sig);%前后翻转


handles.sigresult{handles.num_time}=handles.sig;
handles.leftresult{handles.num_time}=handles.PreLeft;
handles.rightesult{handles.num_time}=handles.PreRight;

guidata(hObject, handles);
refresh_Callback(hObject, handles);
% --------------------------------------------------------------------
function open_Callback(hObject, eventdata, handles)
% hObject    handle to open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% 菜单功能：打开一个语音文件
handles = guidata(gcbo);
[handles.file,handles.path]=uigetfile('*.wav');

if handles.file==0
    return;
end

[handles.sig,handles.fs]=audioread([handles.path,handles.file]);
handles.sig_len=length(handles.sig);

handles.time_len=handles.sig_len/handles.fs;
handles.PreLeft=0;
handles.PreRight=handles.time_len;
handles.LeftPoint=0;
handles.RightPoint=handles.time_len;
handles.FileOpened=true;
handles.bandswitch=1;
handles.colormap=1;
handles.amplitudeswitch=0;
handles.powerswitch=0;
handles.f0switch=0;
handles.f0cepswitch=0;
handles.f0kawaharaswitch=0;
handles.formantswitch=0;
handles.time_len_selected=0;
handles.LpcOrder=12;
handles.num_time=1;

handles.sigresult{handles.num_time}=handles.sig;
handles.leftresult{handles.num_time}=handles.PreLeft;
handles.rightesult{handles.num_time}=handles.PreRight;

% handles.LeftPoint = 0;
% handles.RightPoint = length(handles.sig)/(handles.fs*0.001)-0.001;

% duration=length(handles.sig)/(handles.fs*0.001);
% duration_str=int2str(duration);
% sig_scale=[0:(length(handles.sig)/(handles.fs*0.001))/length(handles.sig):length(handles.sig)/(handles.fs*0.001)-0.001]';
% plot(handles.axes1,sig_scale,handles.sig);
% axis(handles.axes1, [0 inf -inf inf]);
% title(handles.axes1, ['时长:',duration_str,'(ms)']);
% xlabel(handles.axes1,'时间(ms)');


% [b,f,t]=specgram(handles.sig,512,handles.fs,50,49);
% imagesc(handles.axes2, t*1000,f,20*log10(abs(b)));
% colormap(handles.axes2,flipud(gray));
% axis(handles.axes2, 'xy');
% axis(handles.axes2, [0 inf 0 inf]);
% xlabel(handles.axes2,'时间(ms)');
% ylabel(handles.axes2,'频率(Hz)');

%刷新数据，一定要加
guidata(hObject, handles);
refresh_Callback(hObject, handles);
% --------------------------------------------------------------------
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% 菜单功能：保存语音文件
handles = guidata(gcbo);
audiowrite(['sounds\',handles.file],handles.sig,handles.fs);

guidata(hObject, handles);
refresh_Callback(hObject, handles);
% --------------------------------------------------------------------
function saveas_Callback(hObject, eventdata, handles)
% hObject    handle to saveas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% 菜单功能：把语音文件另存为
handles = guidata(gcbo);
[newfile,newpath]=uiputfile('*.wav');
if newfile==0
    return;
end
audiowrite([newpath,newfile],handles.sig,handles.fs);

guidata(hObject, handles);
refresh_Callback(hObject, handles);
% --------------------------------------------------------------------
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% 菜单功能：退出程序
clear all;
close all;
% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sound(handles.sig(round(handles.LeftPoint*handles.fs):round(handles.RightPoint*handles.fs),1),handles.fs);


% --------------------------------------------------------------------
function fft_Callback(hObject, eventdata, handles)
% hObject    handle to fft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function power_spec_Callback(hObject, eventdata, handles)
% hObject    handle to power_spec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 打印单点的功率谱到figure
handles = guidata(gcbo);
figure;
scale_fft=[1:(handles.fs/2)/(512/2):handles.fs/2]';
fft_result=fft_single(round(handles.LeftPoint/(length(handles.sig)/(handles.fs*0.001))*length(handles.sig)),handles.sig,handles.fs);
plot(scale_fft,fft_result);
axis([1 handles.fs/2 min(fft_result) max(fft_result)*1.4]);
% --------------------------------------------------------------------
function spec_envelope_Callback(hObject, eventdata, handles)
% hObject    handle to spec_envelope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 打印单点的谱包络到figure
handles = guidata(gcbo);
figure(1);
scale_spec_env=[1:(handles.fs/2)/(512/2):handles.fs/2]';
spec_env_result=cep_env(round(handles.LeftPoint/(length(handles.sig)/(handles.fs*0.001))*length(handles.sig)),handles.sig,handles.fs);
plot(scale_spec_env,spec_env_result);
axis([1 handles.fs/2 inf inf*1.4]);

% --------------------------------------------------------------------
function f0b_Callback(hObject, eventdata, handles)
% hObject    handle to f0b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(gcbo);
LeftPoint = get(handles.axes1, 'CurrentPoint');%有六个数字 我们只要第一个
if LeftPoint(1, 1) < 0 || LeftPoint(1, 1) > length(handles.sig),
    return;
end
handles.LeftPoint = LeftPoint(1, 1);

guidata(hObject, handles);
refresh_Callback(hObject, handles);

% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonUpFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(gcbo);
RightPoint = get(handles.axes1, 'CurrentPoint');
handles.RightPoint = RightPoint(1, 1);


% change left and right
    if handles.RightPoint < handles.LeftPoint
        temp = handles.RightPoint;
        handles.RightPoint = handles.LeftPoint;
        handles.LeftPoint = temp;
    end

guidata(hObject, handles);
refresh_Callback(hObject, handles);

% --------------------------------------------------------------------
function power_spec_envelope_Callback(hObject, eventdata, handles)
% hObject    handle to power_spec_envelope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：打印单点的功率谱和谱包络到figure
figure(2);
hold on;
scale=[1:(handles.fs/2)/(512/2):handles.fs/2]';
plot(scale,fft_single(round(handles.LeftPoint/(length(handles.sig)/(handles.fs*0.001))*length(handles.sig)),handles.sig,handles.fs));
plot(scale,cep_env(round(handles.LeftPoint/(length(handles.sig)/(handles.fs*0.001))*length(handles.sig)),handles.sig,handles.fs));
axis([1 handles.fs/2 inf inf]);

% --------------------------------------------------------------------
function cepstrum_Callback(hObject, eventdata, handles)
% hObject    handle to cepstrum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：查看指定坐标点的倒谱
figure(1);
sig_temp=round(handles.LeftPoint/(length(handles.sig)/(handles.fs))*length(handles.sig));
[result f0_max f0_max_p f0_temp]=cepstrum(sig_temp,handles.sig,handles.fs);

duration=['Cepstrum:',' ', num2str(f0_temp) ,' ','(Hz)'];

plot(result,'b');
hold on;
plot(49+f0_max_p,f0_max,'or');
hold off;
title(duration);



% --------------------------------------------------------------------
function LPC_menu_Callback(hObject, eventdata, handles)
% hObject    handle to LPC_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Formant_menu_Callback(hObject, eventdata, handles)
% hObject    handle to Formant_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function formant_display_Callback(hObject, eventdata, handles)
% hObject    handle to formant_display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：在语图上显示共振峰
handles = guidata(gcbo);

if handles.formantswitch==0
    handles.formantswitch=1;
elseif handles.formantswitch==1
    handles.formantswitch=0;
end

handles.formant_output=formant_display(handles.sig,handles.fs);

guidata(hObject, handles);
refresh_Callback(hObject, handles);
% --------------------------------------------------------------------
function lpc_single_Callback(hObject, eventdata, handles)
% hObject    handle to lpc_single (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：单点的LPC
figure(1);
[axis_scaler spectrum_p]=lpc_single(round(handles.LeftPoint/(length(handles.sig)/(handles.fs*0.001))*length(handles.sig)),handles.sig,handles.fs);
plot(axis_scaler,spectrum_p);
axis([1 handles.fs/2 ceil(min(spectrum_p)) 1.2*max(spectrum_p)]);
xlabel('Frequency (Hz)');
ylabel('Megnitude (dB)');

% --------------------------------------------------------------------
function lpc_all_Callback(hObject, eventdata, handles)
% hObject    handle to lpc_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：选定范围的LPC
figure(1);
lpc_selected=lpc_all(handles.sig,handles.fs,handles.LeftPoint,handles.RightPoint);
mesh(lpc_selected);
colormap(flipud(gray));


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function view_all_Callback(hObject, eventdata, handles)
% hObject    handle to view_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% 菜单功能：在窗口展示全部语音波形图
handles.num_time=handles.num_time+1;

handles.PreLeft=0;
handles.PreRight=handles.time_len;
handles.LeftPoint=0;
handles.RightPoint=handles.time_len;


handles.sigresult{handles.num_time}=handles.sig;
handles.leftresult{handles.num_time}=handles.PreLeft;
handles.rightesult{handles.num_time}=handles.PreRight;

guidata(hObject, handles);
refresh_Callback(hObject, handles);

% --------------------------------------------------------------------
function view_selected_Callback(hObject, eventdata, handles)
% hObject    handle to view_selected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% 菜单功能：在窗口展示选中的语音波形图
handles.num_time=handles.num_time+1;

handles.PreLeft = handles.LeftPoint;
handles.PreRight = handles.RightPoint;


handles.sigresult{handles.num_time}=handles.sig;
handles.leftresult{handles.num_time}=handles.PreLeft;
handles.rightesult{handles.num_time}=handles.PreRight;

guidata(hObject, handles);
refresh_Callback(hObject, handles);

% --------------------------------------------------------------------
function switch_band_Callback(hObject, eventdata, handles)
% hObject    handle to switch_band (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% 菜单功能：切换宽窄带语图
handles = guidata(gcbo);
if handles.bandswitch==1
    handles.bandswitch=2;
else handles.bandswitch=1;
end
guidata(hObject, handles);
refresh_Callback(hObject, handles);

% --------------------------------------------------------------------


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.PreLeft = handles.LeftPoint;
handles.PreRight = handles.RightPoint;

guidata(hObject, handles);
refresh_Callback(hObject, handles);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.PreLeft=0;
handles.PreRight=handles.time_len;
handles.LeftPoint=0;
handles.RightPoint=handles.time_len;

guidata(hObject, handles);
refresh_Callback(hObject, handles);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton1.
function pushbutton1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function plot_wave_Callback(hObject, eventdata, handles)
% hObject    handle to plot_wave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：把波形图输出到figure
handles = guidata(gcbo);

figure;
sig_len=length(handles.sig);
time_len=sig_len/handles.fs;
scale=[0:time_len/sig_len:time_len]';

sig_disp=zeros(sig_len,2);
sig_disp(1:sig_len,1)=handles.sig(1:sig_len,1);
sig_disp(1:sig_len,2)=scale(1:sig_len,1);

plot(sig_disp(:,2),sig_disp(:,1),'b');
xlabel('Time (Secend)');
ylabel('Magnitude');

LeftTime = handles.PreLeft;
RightTime = handles.PreRight;
axis([LeftTime, RightTime, -1, 1]);

% --------------------------------------------------------------------
function plot_spec_Callback(hObject, eventdata, handles)
% hObject    handle to plot_spec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：把语图输出到figure
handles = guidata(gcbo);
figure;

% to set spectrugram
switch handles.bandswitch
    case 1
        specgram(handles.sig, 512, handles.fs, 50, 49);
    case 2
        specgram(handles.sig, 512, handles.fs, 200,199);
end

switch handles.colormap
    case 1
        colormap(flipud(gray));
    case 2
        colormap(hsv);
    case 3
        colormap(jet);
end

LeftTime = handles.PreLeft;
RightTime = handles.PreRight;
axis([LeftTime, RightTime, 0, handles.fs/2]);
xlabel('Time (Secend)');
ylabel('Frequency（Hz）');



% --------------------------------------------------------------------
function effect_Callback(hObject, eventdata, handles)
% hObject    handle to effect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function time_domain_Callback(hObject, eventdata, handles)
% hObject    handle to time_domain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function cut_Callback(hObject, eventdata, handles)
% hObject    handle to cut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：删除选中的语音片段
handles.num_time=handles.num_time+1;


sig1=handles.sig(1:round(handles.LeftPoint*handles.fs),1);
sig2=handles.sig(round(handles.RightPoint*handles.fs:end),1);
handles.sig=[sig1;sig2];

handles.PreLeft = 0;
handles.PreRight = length(handles.sig)/handles.fs;
handles.LeftPoint = 0;
handles.RightPoint = length(handles.sig)/handles.fs;
handles.FileOpened = true;

handles.sigresult{handles.num_time}=handles.sig;
handles.leftresult{handles.num_time}=handles.PreLeft;
handles.rightesult{handles.num_time}=handles.PreRight;

guidata(hObject, handles);
refresh_Callback(hObject, handles);

% --------------------------------------------------------------------
function trim_Callback(hObject, eventdata, handles)
% hObject    handle to trim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：删除未选中的语音片段
handles.num_time=handles.num_time+1;


handles.sig=handles.sig(round(handles.LeftPoint*handles.fs):round(handles.RightPoint*handles.fs),1);

handles.PreLeft = 0;
handles.PreRight = length(handles.sig)/handles.fs;
handles.LeftPoint = 0;
handles.RightPoint = length(handles.sig)/handles.fs;
handles.FileOpened = true;

handles.sigresult{handles.num_time}=handles.sig;
handles.leftresult{handles.num_time}=handles.PreLeft;
handles.rightesult{handles.num_time}=handles.PreRight;

guidata(hObject, handles);
refresh_Callback(hObject, handles);

% --------------------------------------------------------------------
function play_all_Callback(hObject, eventdata, handles)
% hObject    handle to play_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：播放全部语音
sound(handles.sig,handles.fs);

% --------------------------------------------------------------------
function play_selected_Callback(hObject, eventdata, handles)
% hObject    handle to play_selected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：播放选中部分的语音
sound(handles.sig(round(handles.LeftPoint*handles.fs):round(handles.RightPoint*handles.fs),1),handles.fs);

% --------------------------------------------------------------------
function play_unselected_Callback(hObject, eventdata, handles)
% hObject    handle to play_unselected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：播放未选中部分的语音
sp_temp1=handles.sig(1:round(handles.LeftPoint*handles.fs),1);
sp_temp2=handles.sig(round(handles.RightPoint*handles.fs:end),1);
sp_temp=[sp_temp1;sp_temp2];
sound(sp_temp,handles.fs);

% --------------------------------------------------------------------
function duration_menu_Callback(hObject, eventdata, handles)
% hObject    handle to duration_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function amplitude_Callback(hObject, eventdata, handles)
% hObject    handle to amplitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：在语图上显示振幅
handles=guidata(gcbo);
handles.amplitude_para=amplitude(handles.sig,handles.fs);
handles.amplitude_len=length(handles.amplitude_para);

if handles.amplitudeswitch==0
    handles.amplitudeswitch=1;
elseif handles.amplitudeswitch==1
    handles.amplitudeswitch=0;
end


guidata(hObject, handles);
refresh_Callback(hObject, handles);

% --------------------------------------------------------------------
function duration_all_Callback(hObject, eventdata, handles)
% hObject    handle to duration_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：查看整个语音样本的时长
handles = guidata(gcbo);

figure;
sig_len=length(handles.sig);
time_len=sig_len/handles.fs;
scale=[0:time_len/sig_len:time_len]';

sig_disp=zeros(sig_len,2);
sig_disp(1:sig_len,1)=handles.sig(1:sig_len,1);
sig_disp(1:sig_len,2)=scale(1:sig_len,1);

plot(sig_disp(:,2),sig_disp(:,1),'b');
xlabel('时间 (秒)');
ylabel('振幅');


duration_all=['时长: ',int2str(time_len*1000),' (ms)'];
title(duration_all);


LeftTime = handles.PreLeft;
RightTime = handles.PreRight;
axis([LeftTime, RightTime, -1, 1]);


% --------------------------------------------------------------------
function duration_selected_Callback(hObject, eventdata, handles)
% hObject    handle to duration_selected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：查看选中语音片段的时长
handles = guidata(gcbo);

figure;
sig_len=length(handles.sig);
time_len=sig_len/handles.fs;
scale=[0:time_len/sig_len:time_len]';

sig_disp=zeros(sig_len,2);
sig_disp(1:sig_len,1)=handles.sig(1:sig_len,1);
sig_disp(1:sig_len,2)=scale(1:sig_len,1);

plot(sig_disp(:,2),sig_disp(:,1),'b');
line([handles.LeftPoint, handles.LeftPoint], [-1, 1], 'color', 'r');
line([handles.RightPoint, handles.RightPoint], [-1, 1], 'color', 'k');
xlabel('时间 (秒)');
ylabel('振幅');

time_len_selected=handles.RightPoint-handles.LeftPoint;
duration_selected=['时长: ',int2str(time_len_selected*1000),' (ms)'];
title(duration_selected);


LeftTime = handles.PreLeft;
RightTime = handles.PreRight;
axis([LeftTime, RightTime, -1, 1]);

% --------------------------------------------------------------------
function wave_plus_Callback(hObject, eventdata, handles)
% hObject    handle to wave_plus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：波形放大
handles = guidata(gcbo);

handles.num_time=handles.num_time+1;

handles.sig=handles.sig*1.2;

handles.sigresult{handles.num_time}=handles.sig;
handles.leftresult{handles.num_time}=handles.PreLeft;
handles.rightesult{handles.num_time}=handles.PreRight;

guidata(hObject, handles);
refresh_Callback(hObject, handles);

% --------------------------------------------------------------------
function wave_minus_Callback(hObject, eventdata, handles)
% hObject    handle to wave_minus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：波形减小
handles = guidata(gcbo);
handles.num_time=handles.num_time+1;

handles.sig=handles.sig*0.8;

handles.sigresult{handles.num_time}=handles.sig;
handles.leftresult{handles.num_time}=handles.PreLeft;
handles.rightesult{handles.num_time}=handles.PreRight;

guidata(hObject, handles);
refresh_Callback(hObject, handles);

% --------------------------------------------------------------------
function colormap_Callback(hObject, eventdata, handles)
% hObject    handle to colormap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function colormap1_Callback(hObject, eventdata, handles)
% hObject    handle to colormap1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：切换语图颜色
handles.colormap = 1;
guidata(hObject, handles);
refresh_Callback(hObject, handles);

% --------------------------------------------------------------------
function colormap2_Callback(hObject, eventdata, handles)
% hObject    handle to colormap2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.colormap = 2;
guidata(hObject, handles);
refresh_Callback(hObject, handles);

% --------------------------------------------------------------------
function colormap3_Callback(hObject, eventdata, handles)
% hObject    handle to colormap3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.colormap = 3;
guidata(hObject, handles);
refresh_Callback(hObject, handles);

% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function power_Callback(hObject, eventdata, handles)
% hObject    handle to power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：在语图上显示能量
handles=guidata(gcbo);
handles.power_para=power_amp(handles.sig,handles.fs);
handles.power_len=length(handles.power_para);

if handles.powerswitch==0
    handles.powerswitch=1;
elseif handles.powerswitch==1
    handles.powerswitch=0;
end


guidata(hObject, handles);
refresh_Callback(hObject, handles);


% --------------------------------------------------------------------
function power_output_Callback(hObject, eventdata, handles)
% hObject    handle to power_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：打印能量曲线图到figure
handles=guidata(gcbo);
figure;
sig_len=length(handles.sig);
time_len=sig_len/handles.fs;
scale=[0:time_len/sig_len:time_len]';
handles.power_para=power_amp(handles.sig,handles.fs);
handles.power_len=length(handles.power_para);

power_display_scale=[0.001:time_len/handles.power_len:time_len-0.001]';
power_para_display=handles.power_para-min(handles.power_para);
max_para=max(power_para_display);
% power_para_display=(power_para_display/max(power_para_display));
plot(power_display_scale,power_para_display,'b.-');

LeftTime = handles.PreLeft;
RightTime = handles.PreRight;
axis([LeftTime, RightTime, 0, max_para*1.2]);


guidata(hObject, handles);
refresh_Callback(hObject, handles);
% --------------------------------------------------------------------
function amplitude_output_Callback(hObject, eventdata, handles)
% hObject    handle to amplitude_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：打印振幅曲线图到figure
figure;
sig_len=length(handles.sig);
time_len=sig_len/handles.fs;
scale=[0:time_len/sig_len:time_len]';
handles.amplitude_para=amplitude(handles.sig,handles.fs);
handles.amplitude_len=length(handles.amplitude_para);

amplitude_display_scale=[0.001:time_len/handles.amplitude_len:time_len-0.001]';
amplitude_para_display=handles.amplitude_para-min(handles.amplitude_para);
max_para=max(amplitude_para_display);
% amplitude_para_display=(amplitude_para_display/max(amplitude_para_display));
plot(amplitude_display_scale,amplitude_para_display,'g.-');

LeftTime = handles.PreLeft;
RightTime = handles.PreRight;
axis([LeftTime, RightTime, 0, max_para*1.2]);

guidata(hObject, handles);
refresh_Callback(hObject, handles);
% --------------------------------------------------------------------
function foc_Callback(hObject, eventdata, handles)
% hObject    handle to foc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function low_pass_Callback(hObject, eventdata, handles)
% hObject    handle to low_pass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：对语音信号执行低通滤波处理
handles = guidata(gcbo);

handles.num_time=handles.num_time+1;

[h]=remez(600,[0 150/(11025/2) 300/(11025/2) 1],[1 1 0 0],[1,1]);
low_pass_signal_temp=conv(h,filter([1 -0.9375],1,handles.sig));
handles.sig=(low_pass_signal_temp(300:length(handles.sig)+300,1)/max(abs(low_pass_signal_temp)))*0.7;

handles.sigresult{handles.num_time}=handles.sig;
handles.leftresult{handles.num_time}=handles.PreLeft;
handles.rightesult{handles.num_time}=handles.PreRight;

guidata(hObject, handles);
refresh_Callback(hObject, handles);

% --------------------------------------------------------------------
function high_pass_Callback(hObject, eventdata, handles)
% hObject    handle to high_pass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：对语音信号执行高通滤波处理
handles = guidata(gcbo);

handles.num_time=handles.num_time+1;

[h]=remez(400,[0 3000/(11025/2) 3200/(11025/2) 1],[0 0 1 1],[1,1]);
low_pass_signal=conv(h,filter([1 -0.9375],1,handles.sig));
handles.sig=(low_pass_signal(200:length(handles.sig)+200,1)/max(abs(low_pass_signal)))*0.7;

handles.sigresult{handles.num_time}=handles.sig;
handles.leftresult{handles.num_time}=handles.PreLeft;
handles.rightesult{handles.num_time}=handles.PreRight;

guidata(hObject, handles);
refresh_Callback(hObject, handles);

% --------------------------------------------------------------------
function band_pass_Callback(hObject, eventdata, handles)
% hObject    handle to band_pass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：对语音信号执行带通滤波处理
handles = guidata(gcbo);

handles.num_time=handles.num_time+1;

[h]=remez(400,[0 2000/(11025/2) 3000/(11025/2) 1],[0 1 1 0],[1,1]);
band_pass_signal=conv(h,filter([1 -0.9375],1,handles.sig));
handles.sig=(band_pass_signal(200:length(handles.sig)+200,1)/max(abs(band_pass_signal)))*0.7;

handles.sigresult{handles.num_time}=handles.sig;
handles.leftresult{handles.num_time}=handles.PreLeft;
handles.rightesult{handles.num_time}=handles.PreRight;

guidata(hObject, handles);
refresh_Callback(hObject, handles);


% --------------------------------------------------------------------
function power_output_txt_Callback(hObject, eventdata, handles)
% hObject    handle to power_output_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：打印能量数据到txt文件
handles=guidata(gcbo);
sig_len=length(handles.sig);
time_len=sig_len/handles.fs;
scale=[0:time_len/sig_len:time_len]';
handles.power_para=power_amp(handles.sig,handles.fs);
handles.power_len=length(handles.power_para);
handles.power_display_scale=[0.001:time_len/handles.power_len:time_len-0.001]';
outputfilename=[handles.file,'_power.txt'];
T = table(handles.power_display_scale,handles.power_para','VariableNames',{'Time','Power'});
writetable(T,outputfilename);

% --------------------------------------------------------------------
function amplitude_output_txt_Callback(hObject, eventdata, handles)
% hObject    handle to amplitude_output_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：打印振幅数据到txt文件
handles=guidata(gcbo);
sig_len=length(handles.sig);
time_len=sig_len/handles.fs;
scale=[0:time_len/sig_len:time_len]';
handles.amplitude_para=amplitude(handles.sig,handles.fs);
handles.amplitude_len=length(handles.amplitude_para);
handles.amplitude_display_scale=[0.001:time_len/handles.amplitude_len:time_len-0.001]';
outputfilename=[handles.file,'_amplitude.txt'];
T = table(handles.amplitude_display_scale,handles.amplitude_para','VariableNames',{'Time','Amplitude'});
writetable(T,outputfilename);


% --------------------------------------------------------------------
function undo_Callback(hObject, eventdata, handles)
% hObject    handle to undo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：撤销上一步操作
handles=guidata(gcbo);

handles.num_time=handles.num_time-1;
if handles.num_time<1
    handles.num_time=1;
end
% handles.sigresult{handles.num_time}=handles.sig;

guidata(hObject, handles);
refresh_Callback(hObject, handles);

% --------------------------------------------------------------------
function redo_Callback(hObject, eventdata, handles)
% hObject    handle to redo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：恢复上一步操作
handles=guidata(gcbo);

handles.num_time=handles.num_time+1;
if handles.num_time>length(handles.sigresult)
    handles.num_time=length(handles.sigresult);
end

guidata(hObject, handles);
refresh_Callback(hObject, handles);


% --------------------------------------------------------------------
function formant_output_Callback(hObject, eventdata, handles)
% hObject    handle to formant_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：打印共振峰图到figure
handles=guidata(gcbo);
figure;
sig_len=length(handles.sig);
time_len=sig_len/handles.fs;
handles.formant_output=formant_display(handles.sig,handles.fs);
formant_display_scale=[0.001:time_len/length(handles.formant_output):time_len-0.001]';
plot(formant_display_scale,handles.formant_output,'.');

% --------------------------------------------------------------------
function formant_output_txt_Callback(hObject, eventdata, handles)
% hObject    handle to formant_output_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：打印共振峰数据到txt
handles=guidata(gcbo);
sig_len=length(handles.sig);
time_len=sig_len/handles.fs;
handles.formant_output=formant_display(handles.sig,handles.fs);
handles.formant_display_scale=[0.001:time_len/length(handles.formant_output):time_len-0.001]';
outputfilename=[handles.file,'_formant.txt'];
T = table(handles.formant_output','VariableNames',{'Formant'});
writetable(T,outputfilename);


% --------------------------------------------------------------------
function lpc_inversefilter_Callback(hObject, eventdata, handles)
% hObject    handle to lpc_inversefilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：逆滤波
handles = guidata(gcbo);
handles.num_time=handles.num_time+1;
handles.sig(:,1)=lpc_inversefilter(handles.sig,handles.LpcOrder,256);
handles.sigresult{handles.num_time}=handles.sig;
handles.leftresult{handles.num_time}=handles.PreLeft;
handles.rightesult{handles.num_time}=handles.PreRight;


guidata(hObject, handles);
refresh_Callback(hObject, handles);

% --------------------------------------------------------------------
function lpc_preinversefilter_Callback(hObject, eventdata, handles)
% hObject    handle to lpc_preinversefilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：高频提升逆滤波
handles = guidata(gcbo);
handles.num_time=handles.num_time+1;
handles.sig(:,1)=lpc_pre_inversefilter(handles.sig,handles.LpcOrder,256);
handles.sigresult{handles.num_time}=handles.sig;
handles.leftresult{handles.num_time}=handles.PreLeft;
handles.rightesult{handles.num_time}=handles.PreRight;


guidata(hObject, handles);
refresh_Callback(hObject, handles);

% --------------------------------------------------------------------
function power_spec_selected_Callback(hObject, eventdata, handles)
% hObject    handle to power_spec_selected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 打印选中区域的功率谱到figure
[scale spec_log]=fft_all(handles.sig,handles.fs,handles.LeftPoint,handles.RightPoint);
figure;
plot(scale,spec_log,'b');
xlabel('Frequency(Hz)');
ylabel('Amplitude(dB)');
axis([1 handles.fs/2 min(spec_log) max(spec_log)*1.4]);

% --------------------------------------------------------------------
function f0_view_c_Callback(hObject, eventdata, handles)
% hObject    handle to f0_view_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：用Kawahara法在figure查看选中语音片段的基频
handles = guidata(gcbo);
sig_len=length(handles.sig);
time_len=sig_len/handles.fs;
handles.f0_step=time_len/length(handles.f0_kawahara);

f0_mark1=ceil(handles.LeftPoint/handles.f0_step);
f0_mark2=round(handles.RightPoint/handles.f0_step);

f0_temp=handles.f0_kawahara(f0_mark1:f0_mark2,1);
f0_temp_len=length(f0_temp);
f0_temp_time=handles.RightPoint-handles.LeftPoint;
f0_temp_step=f0_temp_time/f0_temp_len;
temp_scale=[0:f0_temp_step:f0_temp_time]';

figure;
plot(temp_scale,f0_temp,'b.');
axis([0.001 f0_temp_time 30 300]);
xlabel('时间 (s)');
ylabel('基频 (Hz)');

% --------------------------------------------------------------------
function f0_delete_selected_c_Callback(hObject, eventdata, handles)
% hObject    handle to f0_delete_selected_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：删除语图上选中的用Kawahara法提取的基频
handles = guidata(gcbo);
sig_len=length(handles.sig);
time_len=sig_len/handles.fs;

handles.f0_step=time_len/length(handles.f0_kawahara);

f0_mark1=ceil(handles.LeftPoint/handles.f0_step);
f0_mark2=round(handles.RightPoint/handles.f0_step);

handles.f0_kawahara(f0_mark1:f0_mark2,1)=NaN;


guidata(hObject, handles);
refresh_Callback(hObject, handles);


% --------------------------------------------------------------------
function f0_delete_unselected_c_Callback(hObject, eventdata, handles)
% hObject    handle to f0_delete_unselected_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：删除语图上未选中的用Kawahara法提取的基频
handles = guidata(gcbo);
sig_len=length(handles.sig);
time_len=sig_len/handles.fs;

handles.f0_step=time_len/length(handles.f0_kawahara);

f0_mark1=ceil(handles.LeftPoint/handles.f0_step);
f0_mark2=round(handles.RightPoint/handles.f0_step);

handles.f0_kawahara(1:f0_mark1,1)=NaN;
handles.f0_kawahara(f0_mark2:length(handles.f0_kawahara),1)=NaN;


guidata(hObject, handles);
refresh_Callback(hObject, handles);

% --------------------------------------------------------------------
function f0_output_original_c_Callback(hObject, eventdata, handles)
% hObject    handle to f0_output_original_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 打印用Kawahara法提取的基频到txt文件
handles = guidata(gcbo);
outputfilename=[handles.file,'_f0_kawahara.txt'];
T = table(handles.f0_kawahara);
writetable(T,outputfilename);

% --------------------------------------------------------------------
function f0_output_normalized_c_Callback(hObject, eventdata, handles)
% hObject    handle to f0_output_normalized_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function f0_view_b_Callback(hObject, eventdata, handles)
% hObject    handle to f0_view_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：用倒谱法在figure查看选中语音片段的基频
handles = guidata(gcbo);
sig_len=length(handles.sig);
time_len=sig_len/handles.fs;
handles.f0_step=time_len/length(handles.f0_cep);

f0_mark1=ceil(handles.LeftPoint/handles.f0_step);
f0_mark2=round(handles.RightPoint/handles.f0_step);

f0_temp=handles.f0_cep(f0_mark1:f0_mark2,1);
f0_temp_len=length(f0_temp);
f0_temp_time=handles.RightPoint-handles.LeftPoint;
f0_temp_step=f0_temp_time/f0_temp_len;
temp_scale=[0.001:f0_temp_step:f0_temp_time]';

figure;
plot(temp_scale,f0_temp,'b.');
axis([0.001 f0_temp_time 30 300]);
xlabel('时间 (s)');
ylabel('基频 (Hz)');


% --------------------------------------------------------------------
function f0_delete_selected_b_Callback(hObject, eventdata, handles)
% hObject    handle to f0_delete_selected_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：删除语图上选中的用倒谱法提取的基频
handles = guidata(gcbo);
sig_len=length(handles.sig);
time_len=sig_len/handles.fs;

handles.f0_step=time_len/length(handles.f0_cep);

f0_mark1=ceil(handles.LeftPoint/handles.f0_step);
f0_mark2=round(handles.RightPoint/handles.f0_step);

handles.f0_cep(f0_mark1:f0_mark2,1)=NaN;


guidata(hObject, handles);
refresh_Callback(hObject, handles);

% --------------------------------------------------------------------
function f0_delete_unselected_b_Callback(hObject, eventdata, handles)
% hObject    handle to f0_delete_unselected_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：删除语图上未选中的用倒谱法提取的基频
handles = guidata(gcbo);
sig_len=length(handles.sig);
time_len=sig_len/handles.fs;

handles.f0_step=time_len/length(handles.f0_cep);

f0_mark1=ceil(handles.LeftPoint/handles.f0_step);
f0_mark2=round(handles.RightPoint/handles.f0_step);

handles.f0_cep(1:f0_mark1,1)=NaN;
handles.f0_cep(f0_mark2:length(handles.f0_cep),1)=NaN;


guidata(hObject, handles);
refresh_Callback(hObject, handles);


% --------------------------------------------------------------------
function f0_output_original_b_Callback(hObject, eventdata, handles)
% hObject    handle to f0_output_original_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 打印用倒谱法提取的基频到txt文件
handles = guidata(gcbo);
outputfilename=[handles.file,'_f0_cep.txt'];
T = table(handles.f0_cep);
writetable(T,outputfilename);

% --------------------------------------------------------------------
function f0_output_normalized_b_Callback(hObject, eventdata, handles)
% hObject    handle to f0_output_normalized_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function f0_view_a_Callback(hObject, eventdata, handles)
% hObject    handle to f0_view_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：用自相关法在figure查看选中语音片段的基频
handles = guidata(gcbo);
sig_len=length(handles.sig);
time_len=sig_len/handles.fs;
handles.f0_step=time_len/length(handles.f0);

f0_mark1=ceil(handles.LeftPoint/handles.f0_step);
f0_mark2=round(handles.RightPoint/handles.f0_step);

f0_temp=handles.f0(f0_mark1:f0_mark2,1);
f0_temp_len=length(f0_temp);
f0_temp_time=handles.RightPoint-handles.LeftPoint;
f0_temp_step=f0_temp_time/f0_temp_len;
temp_scale=[0.001:f0_temp_step:f0_temp_time]';

figure;
plot(temp_scale,f0_temp,'b.');
axis([0.001 f0_temp_time 30 300]);
xlabel('时间 (s)');
ylabel('基频 (Hz)');

% --------------------------------------------------------------------
function f0_delete_selected_a_Callback(hObject, eventdata, handles)
% hObject    handle to f0_delete_selected_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：删除语图上选中的用自相关法提取的基频
handles = guidata(gcbo);
sig_len=length(handles.sig);
time_len=sig_len/handles.fs;

handles.f0_step=time_len/length(handles.f0);

f0_mark1=ceil(handles.LeftPoint/handles.f0_step);
f0_mark2=round(handles.RightPoint/handles.f0_step);

handles.f0(f0_mark1:f0_mark2,1)=NaN;


guidata(hObject, handles);
refresh_Callback(hObject, handles);


% --------------------------------------------------------------------
function f0_delete_unselected_a_Callback(hObject, eventdata, handles)
% hObject    handle to f0_delete_unselected_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：删除语图上未选中的用自相关法提取的基频
handles = guidata(gcbo);
sig_len=length(handles.sig);
time_len=sig_len/handles.fs;

handles.f0_step=time_len/length(handles.f0);

f0_mark1=ceil(handles.LeftPoint/handles.f0_step);
f0_mark2=round(handles.RightPoint/handles.f0_step);

handles.f0(1:f0_mark1,1)=NaN;
handles.f0(f0_mark2:length(handles.f0),1)=NaN;


guidata(hObject, handles);
refresh_Callback(hObject, handles);


% --------------------------------------------------------------------
function f0_output_original_a_Callback(hObject, eventdata, handles)
% hObject    handle to f0_output_original_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 打印用自相关法提取的基频到txt文件
handles = guidata(gcbo);
outputfilename=[handles.file,'_f0.txt'];
T = table(handles.f0);
writetable(T,outputfilename);


% --------------------------------------------------------------------
function f0_output_normalized_a_Callback(hObject, eventdata, handles)
% hObject    handle to f0_output_normalized_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function f0extraction_Callback(hObject, eventdata, handles)
% hObject    handle to f0extraction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：在语图上用自相关法显示基频
handles = guidata(gcbo);

if handles.f0switch==0
    handles.f0switch=1;
elseif handles.f0switch==1
    handles.f0switch=0;
end

handles.f0=F0_extraction(handles.sig,handles.fs);

guidata(hObject, handles);
refresh_Callback(hObject, handles);

% --------------------------------------------------------------------
function f0extraction_cep_Callback(hObject, eventdata, handles)
% hObject    handle to f0extraction_cep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：在语图上用倒谱法显示基频
handles = guidata(gcbo);

if handles.f0cepswitch==0
    handles.f0cepswitch=1;
elseif handles.f0cepswitch==1
    handles.f0cepswitch=0;
end

handles.f0_cep=F0_extraction_cep(handles.sig,handles.fs);


guidata(hObject, handles);
refresh_Callback(hObject, handles);

% --------------------------------------------------------------------
function f0extraction_kawahara_Callback(hObject, eventdata, handles)
% hObject    handle to f0extraction_kawahara (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：在语图上用Kawahara法显示基频
handles = guidata(gcbo);


if handles.f0kawaharaswitch==0
    handles.f0kawaharaswitch=1;
elseif handles.f0kawaharaswitch==1
    handles.f0kawaharaswitch=0;
end

handles.f0_kawahara=MulticueF0v14(handles.sig,handles.fs,50,500);


guidata(hObject, handles);
refresh_Callback(hObject, handles);


% --------------------------------------------------------------------
function f0_view_all_c_Callback(hObject, eventdata, handles)
% hObject    handle to f0_view_all_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：用Kawahara法在figure查看整个语音基频
handles = guidata(gcbo);

sig_len=length(handles.sig);
time_len=sig_len/handles.fs;
F0_display_scale=[0:time_len/length(handles.f0_kawahara):time_len-0.001]';

figure;
plot(F0_display_scale,handles.f0_kawahara,'b.');
xlabel('时间 (s)');
ylabel('基频 (Hz)');

LeftTime = handles.PreLeft;
RightTime = handles.PreRight;
axis([LeftTime, RightTime, 30, 300]);

% --------------------------------------------------------------------
function f0_view_all_b_Callback(hObject, eventdata, handles)
% hObject    handle to f0_view_all_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：用倒谱法在figure查看整个语音基频
handles = guidata(gcbo);

sig_len=length(handles.sig);
time_len=sig_len/handles.fs;
F0_display_scale=[0.001:time_len/length(handles.f0_cep):time_len-0.001]';

figure;
plot(F0_display_scale,handles.f0_cep,'b.');
xlabel('时间 (s)');
ylabel('基频 (Hz)');

LeftTime = handles.PreLeft;
RightTime = handles.PreRight;
axis([LeftTime, RightTime, 30, 300]);

% --------------------------------------------------------------------
function f0_view_all_a_Callback(hObject, eventdata, handles)
% hObject    handle to f0_view_all_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 菜单功能：用自相关法在figure查看整个语音基频
handles = guidata(gcbo);

sig_len=length(handles.sig);
time_len=sig_len/handles.fs;
F0_display_scale=[0.001:time_len/length(handles.f0):time_len-0.001]';

figure;
plot(F0_display_scale,handles.f0,'b.');
xlabel('时间 (s)');
ylabel('基频 (Hz)');

LeftTime = handles.PreLeft;
RightTime = handles.PreRight;
axis([LeftTime, RightTime, 30, 300]);

% --------------------------------------------------------------------
function tb_save_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to tb_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%工具栏按钮：用于保存文件
handles = guidata(gcbo);
audiowrite(['sounds\',handles.file],handles.sig,handles.fs);

guidata(hObject, handles);
refresh_Callback(hObject, handles);

% --------------------------------------------------------------------
function tb_open_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to tb_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%工具栏按钮：用于打开文件
handles = guidata(gcbo);
[handles.file,handles.path]=uigetfile('*.wav');

if handles.file==0
    return;
end

[handles.sig,handles.fs]=audioread([handles.path,handles.file]);
handles.sig_len=length(handles.sig);

handles.time_len=handles.sig_len/handles.fs;
handles.PreLeft=0;
handles.PreRight=handles.time_len;
handles.LeftPoint=0;
handles.RightPoint=handles.time_len;
handles.FileOpened=true;
handles.bandswitch=1;
handles.colormap=1;
handles.amplitudeswitch=0;
handles.powerswitch=0;
handles.f0switch=0;
handles.f0cepswitch=0;
handles.f0kawaharaswitch=0;
handles.formantswitch=0;
handles.time_len_selected=0;
handles.LpcOrder=12;
handles.num_time=1;

handles.sigresult{handles.num_time}=handles.sig;
handles.leftresult{handles.num_time}=handles.PreLeft;
handles.rightesult{handles.num_time}=handles.PreRight;

% handles.LeftPoint = 0;
% handles.RightPoint = length(handles.sig)/(handles.fs*0.001)-0.001;

% duration=length(handles.sig)/(handles.fs*0.001);
% duration_str=int2str(duration);
% sig_scale=[0:(length(handles.sig)/(handles.fs*0.001))/length(handles.sig):length(handles.sig)/(handles.fs*0.001)-0.001]';
% plot(handles.axes1,sig_scale,handles.sig);
% axis(handles.axes1, [0 inf -inf inf]);
% title(handles.axes1, ['时长:',duration_str,'(ms)']);
% xlabel(handles.axes1,'时间(ms)');


% [b,f,t]=specgram(handles.sig,512,handles.fs,50,49);
% imagesc(handles.axes2, t*1000,f,20*log10(abs(b)));
% colormap(handles.axes2,flipud(gray));
% axis(handles.axes2, 'xy');
% axis(handles.axes2, [0 inf 0 inf]);
% xlabel(handles.axes2,'时间(ms)');
% ylabel(handles.axes2,'频率(Hz)');

%刷新数据，一定要加
guidata(hObject, handles);
refresh_Callback(hObject, handles);


% --------------------------------------------------------------------
function tb_undo_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to tb_undo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%工具栏按钮：撤销
handles=guidata(gcbo);

handles.num_time=handles.num_time-1;
if handles.num_time<1
    handles.num_time=1;
end
% handles.sigresult{handles.num_time}=handles.sig;

guidata(hObject, handles);
refresh_Callback(hObject, handles);

% --------------------------------------------------------------------
function tb_redo_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to tb_redo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%工具栏按钮：恢复
handles=guidata(gcbo);

handles.num_time=handles.num_time+1;
if handles.num_time>length(handles.sigresult)
    handles.num_time=length(handles.sigresult);
end

guidata(hObject, handles);
refresh_Callback(hObject, handles);


% --------------------------------------------------------------------
function tb_play_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to tb_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%工具栏按钮：用于播放选中的语音
sound(handles.sig(round(handles.LeftPoint*handles.fs):round(handles.RightPoint*handles.fs),1),handles.fs);


% --------------------------------------------------------------------
function tb_select_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to tb_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%工具栏按钮：用于在窗口最大化展示选中的波形

handles.num_time=handles.num_time+1;

handles.PreLeft = handles.LeftPoint;
handles.PreRight = handles.RightPoint;


handles.sigresult{handles.num_time}=handles.sig;
handles.leftresult{handles.num_time}=handles.PreLeft;
handles.rightesult{handles.num_time}=handles.PreRight;

guidata(hObject, handles);
refresh_Callback(hObject, handles);


% --------------------------------------------------------------------
function spec_envelope_selected_Callback(hObject, eventdata, handles)
% hObject    handle to spec_envelope_selected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 打印选中区域的谱包络到figure
[scale spec_env_result]=cep_env_all(handles.sig,handles.fs,handles.LeftPoint,handles.RightPoint);
figure;
plot(scale,spec_env_result,'b');
xlabel('Frequency(Hz)');
ylabel('Amplitude(dB)');
axis([1 handles.fs/2 inf inf*1.4]);
% --------------------------------------------------------------------
function power_spec_envelope_selected_Callback(hObject, eventdata, handles)
% hObject    handle to power_spec_envelope_selected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 打印选中区域的的功率谱和谱包络到figure
figure(2);
hold on;
[scale spec_log]=fft_all(handles.sig,handles.fs,handles.LeftPoint,handles.RightPoint);
plot(scale,spec_log);
[scale spec_env_result]=cep_env_all(handles.sig,handles.fs,handles.LeftPoint,handles.RightPoint);
plot(scale,spec_env_result);
axis([1 handles.fs/2 inf inf]);
xlabel('Frequency(Hz)');
ylabel('Amplitude(dB)');





function refresh_Callback(hObject, handles)
% hObject    handle to file_refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%功能：刷新窗口并画图

handles = guidata(gcbo);


handles.sig=handles.sigresult{handles.num_time};
handles.PreLeft=handles.leftresult{handles.num_time};
handles.PreRight=handles.rightesult{handles.num_time};

axes(handles.axes1);
sig_len=length(handles.sig);
time_len=sig_len/handles.fs;
scale=[0:time_len/sig_len:time_len]';

sig_disp=zeros(sig_len,2);
sig_disp(1:sig_len,1)=handles.sig(1:sig_len,1);
sig_disp(1:sig_len,2)=scale(1:sig_len,1);

plot(sig_disp(:,2),sig_disp(:,1),'b');
LeftTime=handles.PreLeft;
RightTime=handles.PreRight;
axis([LeftTime,RightTime,-1,1]);
xlabel(handles.axes1,'时间(s)');


axes(handles.axes2);
cla reset

yyaxis left
hold on;
switch handles.bandswitch
    case 1
        specgram(handles.sig,512,handles.fs,50,49);
    case 2
        specgram(handles.sig,512,handles.fs,200,199);
end

switch handles.colormap
    case 1
        colormap(flipud(gray));
    case 2
        colormap(hsv);
    case 3
        colormap(jet);
end

LeftTime= handles.PreLeft;
RightTime=handles.PreRight;
axis([LeftTime,RightTime,0, handles.fs/2]);
xlabel(handles.axes2,'时间(s)');
ylabel(handles.axes2,'频率(Hz)');

if handles.FileOpened
    line(handles.axes1,[handles.LeftPoint, handles.LeftPoint], [-1, 1], 'color', 'g');
    line(handles.axes1,[handles.RightPoint, handles.RightPoint], [-1, 1], 'color', 'r');
    line(handles.axes2,[handles.LeftPoint, handles.LeftPoint], [1,handles.fs*0.5], 'color', 'g');
    line(handles.axes2,[handles.RightPoint, handles.RightPoint], [1,handles.fs*0.5], 'color', 'r');
end

yyaxis right
if handles.powerswitch==1
    power_display_scale=[0:time_len/handles.power_len:time_len-0.001]';
    plot(power_display_scale,handles.power_para,'b.-');
end

if handles.amplitudeswitch==1
    amplitude_display_scale=[0:time_len/handles.amplitude_len:time_len-0.001]';
    plot(amplitude_display_scale,handles.amplitude_para,'g.-');
    axis([LeftTime,RightTime,0,100]);
end

if handles.f0switch==1
    f0_display_scale=[0:time_len/length(handles.f0):time_len-0.001]';
    plot(handles.axes2,f0_display_scale,handles.f0,'b.');
    axis([LeftTime,RightTime,0,500]);
end

if handles.f0cepswitch==1
    f0_display_scale=[0:time_len/length(handles.f0_cep):time_len-0.001]';
    plot(handles.axes2,f0_display_scale,handles.f0_cep,'g.');
    axis([LeftTime,RightTime,0,500]);
end

if handles.f0kawaharaswitch==1
    f0_display_scale=[0:time_len/length(handles.f0_kawahara(:,1)):time_len-0.001]';
    plot(handles.axes2,f0_display_scale,handles.f0_kawahara,'r.');
    axis([LeftTime,RightTime,0,500]);
end

if handles.formantswitch==1
    formant_display_scale=[0:time_len/length(handles.formant_output):time_len-0.001]';
    plot(handles.axes2,formant_display_scale,handles.formant_output,'.');
    axis([LeftTime,RightTime,0,5500]);
end

guidata(hObject, handles);
