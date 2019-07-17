
%%%graph

xa=Network(:,1);
ya=Network(:,2);
yyy=cost(xa,ya);

function yyy= cost(x,y)
figure(1)
plot(x,y)
title('Figure of pertubation and cost');
xlabel('pertubation');
ylabel('cost');


figure(2)
h = histogram2(x,y);
title('Histogram of pertubation and cost')
xlabel('pertubation');
ylabel('cost');
end

