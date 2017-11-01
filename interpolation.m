function [int_point_x,int_point_y]=interpolation(v1,v2,p,t,IR)
% This function will output the coordinate of int_point given the order of
% two valleys and one peak, as well as the time and IR array
    v1_x=t(v1);
    v1_y=IR(v1);
    v2_x=t(v2);
    v2_y=IR(v2);
    p_x=t(p);
    int_point_x=p_x;
    int_point_y=(v2_y-v1_y)*p_x/(v2_x-v1_x)+(v2_x*v1_y-v1_x*v2_y)/(v2_x-v1_x);
end