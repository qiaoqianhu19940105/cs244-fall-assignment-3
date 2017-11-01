function [v_out]=valley(v_in)
% function [t_out,v_out]=peaks(t_in,v_in)
% This function is supposed to output a peak vector and corresponding time
% vector
warning off
ds=diff(v_in);
ds=[ds(1);ds];%pad diff
filter=find(ds(2:end)==0)+1;%%find zeros
ds(filter)=ds(filter-1);%%replace zeros
ds=sign(ds);
ds=diff(ds);
v_out=find(ds>0);


