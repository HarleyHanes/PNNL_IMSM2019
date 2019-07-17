
%%%graph
x_special=Network(:,4)
for i in 1:range(x_special)
if (x_special[i]==0)
    x_0=Network(i,1);
    y_0=Network(i,3);
else
    x_1=Network(i,1);
    y_1=Network(i,3);
end

figure(1)
scatter(x_0,y_0,'b','field')
hold on
scatter(x_1,y_1,'r','field')
title('Figure of pertubation and cost');
xlabel('pertubation');
ylabel('cost');

figure(2)
histogram2(x_0,y_0,'b','field');
hold on
histogram2(x_1,y_1,'r','field')
title('Histogram of pertubation and cost');
xlabel('pertubation');
ylabel('cost');
end

