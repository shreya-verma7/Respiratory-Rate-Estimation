clear;
clc;
scale =100;%ָ��ÿ�ֺ���ģʽ�����Ĵ���
n_class=7;%���������
SUMTIME=60; %��ʱ��
C=cell(2,scale*n_class);
for i=1:scale
    %1:Eupnea  
    C(1,i)={Eupnea_function(SUMTIME,5*SUMTIME/60)};
    C(2,i)={1};
    %2:Bradypnea
    C(1,i+scale)={Bradypnea_function(SUMTIME,5*SUMTIME/60)};
    C(2,i+scale)={2};
    %3 Tachypnea
    C(1,i+scale*2)={Tachypnea_function(SUMTIME,5*SUMTIME/60)};
    C(2,i+scale*2)={3};
    %4 Biots
    C(1,i+scale*3)={Biots_function(SUMTIME,5*SUMTIME/60)};
    C(2,i+scale*3)={4};
    %5 Cheyne_stokes
    C(1,i+scale*4)={Cheyne_Stokes_function(SUMTIME)};
    C(2,i+scale*4)={5};
    %6 Central_Apnea
    C(1,i+scale*5)={Central_Apnea_function(SUMTIME,5)};
    C(2,i+scale*5)={6};
    %7. Noise
    C(1,i+scale*6)={Noise_function(SUMTIME,10*SUMTIME/60)};
    C(2,i+scale*6)={7};
    
end
signal=zeros(n_class*scale,SUMTIME*10+1);
for i= 1:n_class*scale
signal(i,2:SUMTIME*10+1)=C{1,i};
end
%��һ������
signal=mapminmax(signal,0,1);
for i=1:n_class*scale
signal(i,1)=C{2,i};    
end
r=randperm( size(signal,1) );   %���ɹ������������������������
Breathing=signal(r, :);                              %����������ж�A������������
%�洢csv
store_name = strcat('Breathing_TEST',num2str(SUMTIME),'.csv');
csvwrite(store_name,Breathing);
