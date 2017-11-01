close all
clear all
data = csvread('C:/Users/Qiaoqian/Desktop/UCI FALL 2017/CS244 Embedded system/takashin_Homework_sample.csv', 1,0);
t=data(:,1); % A column in csv file stands for time (second)
IR=data(:,3); % B column in csv file stands for IR
RED=data(:,2); % C column in csv file stands for

IR_out=smooth(IR);
RED_out=smooth(RED);

a=100;
b=4501; % max(b)=4501
t_try=t(a:b);
IR_try=IR_out(a:b);
RED_try=RED_out(a:b);
p=peak(IR_try);
v=valley(IR_try);

% p=filter_max(IR_try,p);% order number
% v=filter_min(IR_try,v);
p_filtered=filtermax(p);% order number
v_filtered=filtermin(v);


diff=length(p_filtered)-length(v_filtered);
if diff==1
    for i=1:length(v_filtered)-1
        [int_point_x_IR(i),int_point_y_IR(i)]=interpolation(v_filtered(i),v_filtered(i+1),p_filtered(i+1),t_try,IR_try);
        [int_point_x_RED(i),int_point_y_RED(i)]=interpolation(v_filtered(i),v_filtered(i+1),p_filtered(i+1),t_try,RED_try);
        peak_index(i)=p_filtered(i+1);
        IR_peak_y(i)=IR_try(peak_index(i));
        RED_peak_y(i)=RED_try(peak_index(i));
    end
elseif diff==-1
    for i=1:length(v_filtered)-1
        [int_point_x_IR(i),int_point_y_IR(i)]=interpolation(v_filtered(i),v_filtered(i+1),p_filtered(i),t_try,IR_try);
        [int_point_x_RED(i),int_point_y_RED(i)]=interpolation(v_filtered(i),v_filtered(i+1),p_filtered(i),t_try,RED_try);
        peak_index(i)=p_filtered(i);
        IR_peak_y(i)=IR_try(peak_index(i));
        RED_peak_y(i)=RED_try(peak_index(i));
    end
elseif p_filtered(1)<v_filtered(1) % start with peak but end with valley
    for i=1:length(p_filtered)-1
        [int_point_x_IR(i),int_point_y_IR(i)]=interpolation(v_filtered(i),v_filtered(i+1),p_filtered(i+1),t_try,IR_try);
        [int_point_x_RED(i),int_point_y_RED(i)]=interpolation(v_filtered(i),v_filtered(i+1),p_filtered(i+1),t_try,RED_try);
        peak_index(i)=p_filtered(i+1);
        IR_peak_y(i)=IR_try(peak_index(i));
        RED_peak_y(i)=RED_try(peak_index(i));
    end
else
    for i=1:length(p_filtered)-1 % start with valley but end with peak
        [int_point_x_IR(i),int_point_y_IR(i)]=interpolation(v_filtered(i),v_filtered(i+1),p_filtered(i),t_try,IR_try);
        [int_point_x_RED(i),int_point_y_RED(i)]=interpolation(v_filtered(i),v_filtered(i+1),p_filtered(i),t_try,RED_try);
        peak_index(i)=p_filtered(i);
        IR_peak_y(i)=IR_try(peak_index(i));
        RED_peak_y(i)=RED_try(peak_index(i));
    end
end

AC_RED=RED_peak_y-int_point_y_RED;
DC_RED=int_point_y_RED;
AC_IR=IR_peak_y-int_point_y_IR;
DC_IR=int_point_y_IR;
R=AC_RED.*DC_IR./(AC_IR.*DC_RED);
ratioAverage=R;
SPO2= -45.060.*ratioAverage.* ratioAverage + 30.354 .*ratioAverage + 94.845;
SPO2_avg=mean(SPO2)


plot(SPO2)
title('instant SPO2 vs time')
% 
% 
% figure
% subplot(2,1,1)
% plot(t_try,IR_try)
% title('IR_try')
% hold on
% for i=1:length(p_filtered)
% scatter(t_try(p_filtered(i)),IR_try(p_filtered(i)),'o')
% end
% hold off
% hold on
% for i=1:length(v_filtered)
% scatter(t_try(v_filtered(i)),IR_try(v_filtered(i)),'*')
% end
% hold off
% 
% subplot(2,1,2)
% plot(t_try,IR_try)
% title('IR_try')
% hold on
% for i=1:length(p)
% scatter(t_try(p(i)),IR_try(p(i)),'o')
% end
% hold off
% hold on
% for i=1:length(v)
% scatter(t_try(v(i)),IR_try(v(i)),'*')
% end
% hold off