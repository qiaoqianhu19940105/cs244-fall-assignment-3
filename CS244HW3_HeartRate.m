close all
clear all
data = csvread('C:/Users/Qiaoqian/Desktop/UCI FALL 2017/CS244 Embedded system/takashin_Homework_sample.csv', 1,0);
% data = xlsread('C:/Users/Qiaoqian/Desktop/UCI FALL 2017/CS244 Embedded system/takashin_Homework_sample.csv', 'A2:C4502');
t=data(:,1); % A column in csv file stands for time (second)
RED=data(:,2); % B column in csv file stands for IR

[b1,a1] = butter(2,[0.04 0.08],'bandpass'); % 1-2 HZ
RED_out = filter(b1,a1,RED);
a=1;
b=4501;
threshold=40; % this is adjustable w.r.t actual situation
t_try=t(a:b);
RED_try=RED_out(a:b);
p=peak(RED_try);
k=1;
for j=1:length(p)-1
        if (abs(RED_try(p(j))-RED_try(p(j)+10))>=threshold)&&(RED_try(p(j))>0)
            p_filtered(k)=p(j);
            k=k+1;
        end
end
for j=length(p)
        if (abs(RED_try(p(j))-RED_try(p(j)-10))>=threshold)&&(RED_try(p(j))>0)
            p_filtered(k)=p(j);
            k=k+1;
        end
end

% Calculate Heart Rate 
sampling_rate=50;
for k=1:(length(p_filtered)-1)
%     adjacent_peak_intervals(k)= t_try(p_filtered(k+1))-t_try(p_filtered(k));
    adjacent_peak_intervals(k)=p_filtered(k+1)-p_filtered(k);
    t_heart_rate(k)=t_try(p_filtered(k));
    %should calculate times between two peaks
end
heart_rate=60*sampling_rate./adjacent_peak_intervals;
HR_avg=mean(heart_rate);
HR_max=max(heart_rate);
HR_min=min(heart_rate);
figure(1)
plot(t_heart_rate,heart_rate)
xlabel('time')
ylabel('instant heart rate')
title('t vs instant heart rate')

% heart_rate_average plotting 60 seconds as a interval
for i=1:length(heart_rate)-60
    heart_rate_sum=0;
    for j=i:(i+60)
        heart_rate_sum=heart_rate_sum+heart_rate(j);
    end
    heart_rate_avg(i)=heart_rate_sum/60;
    t_heart_rate_avg(i)=t_try(p_filtered(i));
end
figure(2)
plot(t_heart_rate_avg,heart_rate_avg) 
xlabel('time')
ylabel('average heart rate')
title('t vs average heart rate')

% plot(t_try,RED_try)
% title('RED_try')
% hold on
% for i=1:length(p_filtered)
% scatter(t_try(p_filtered(i)),RED_try(p_filtered(i)),'o')
% end
% hold off