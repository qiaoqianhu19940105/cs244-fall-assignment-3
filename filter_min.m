function [p_filtered]=filter_min(v,p)
ratio=0.8;
v_cor=xcorr(v);

[v_min,index_min]=min(v_cor);
a=v_cor(index_min+1:end);
b=valley(a);
delta_min=b(1);
k=1;
for i=1
    if abs(p(i)-p(i+1))<ratio*delta_min
        if p(i)<=p(i+1)
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
    if abs(std-p(i+1))<ratio*delta_min
        i=i+1;
    else
        p_filtered(k)=p(i+1);
        std=p(i+1);
        k=k+1;
        i=i+1;
    end
end

end