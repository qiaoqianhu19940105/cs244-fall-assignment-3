function [p_filtered]=filter_max(v,p)
ratio=0.7;
v_cor=xcorr(v);

[v_max,index_max]=max(v_cor);
a=v_cor(index_max+1:end);
b=peak(a);
delta_max=b(1);
k=1;
for i=1
    if abs(p(i)-p(i+1))<ratio*delta_max
        if p(i)>=p(i+1)
            std=p(i);
            p_filtered(k)=std;
            k=k+1;
            i=i+1;
        else
            std=p(i+1);
            p_filtered(k)=std;
            k=k+1;
            i=i+1;
        end
    else
        p_filtered(k)=p(i);
        p_filtered(k+1)=p(i+1);
        std=p(i+1);
        k=k+2;
        i=i+1;
    end
end

for i=2:length(p)-1
    if abs(std-p(i+1))<ratio*delta_max
        i=i+1;
    else
        p_filtered(k)=p(i+1);
        std=p(i+1);
        k=k+1;
        i=i+1;
    end
end

end