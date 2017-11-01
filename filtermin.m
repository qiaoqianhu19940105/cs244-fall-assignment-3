function [v_filtered]=filtermin(v)
ratio=0.9;
for i=1:length(v)-1
    delta(i)=v(i+1)-v(i);
end
delta_min=mean(delta);

k=1;
for i=1
    if abs(v(i)-v(i+1))<ratio*delta_min
        if v(i)<=v(i+1)
            std=v(i);
            v_filtered(k)=std;
            k=k+1;
            i=i+1;
        else
            std=v(i+1);
            v_filtered(k)=std;
            k=k+1;
            i=i+1;
        end
    else
        v_filtered(k)=v(i);
        v_filtered(k+1)=v(i+1);
        std=v(i+1);
        k=k+2;
        i=i+1;
    end
end

for i=2:length(v)-1
    if abs(std-v(i+1))<ratio*delta_min
        i=i+1;
    else
        v_filtered(k)=v(i+1);
        std=v(i+1);
        k=k+1;
        i=i+1;
    end
end

end