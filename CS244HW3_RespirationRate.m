close all
clear all
data = csvread('C:/Users/Qiaoqian/Desktop/UCI FALL 2017/CS244 Embedded system/takashin_Homework_sample.csv', 1,0);
% data = xlsread('C:/Users/Qiaoqian/Desktop/UCI FALL 2017/CS244 Embedded system/takashin_Homework_sample.csv', 'A2:C4502');
t=data(:,1); % A column in csv file stands for time (second)
RED=data(:,2); % B column in csv file stands for IR
IR=data(:,3); % C column in csv file stands for 

[b1,a1] = butter(2,[0.0067 0.01],'bandpass'); % 1/6-1/3 HZ
RED_out = filter(b1,a1,RED);

a=1;
b=4501;
t_try=t(a:b);
RED_try=RED_out(a:b);
p=peak(RED_try);
p_filtered=filter_max(RED_try,p);

plot(t_try,RED_try)
xlabel('time')
ylabel('RED signal')
title('filtered RED signal')
hold on
for i=1:length(p_filtered)
    scatter(t_try(p_filtered(i)),RED_try(p_filtered(i)),'o')
end
hold off
num=length(p_filtered)/(90/60)