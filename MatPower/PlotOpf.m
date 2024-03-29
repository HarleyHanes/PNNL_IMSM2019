function yyy= PlotOpf(Network)
NetworkTrue=cell(1,4);
NetworkFalse=cell(1,4);

j=1;k=1;
iter=size(Network);
for i=1:iter(1)
    if Network{i,end}==1
        NetworkTrue(j,:)=Network(i,:);
        j=j+1;
    elseif Network{i,end}==0
        NetworkFalse(k,:)=Network(i,:);
        k=k+1;
    else
        warning('No success Input')
        keyboard
    end
end


Perturb=cell2mat(NetworkTrue(:,1));
Cost=cell2mat(NetworkTrue(:,3));

PerturbF=cell2mat(NetworkFalse(:,1));
CostF=cell2mat(NetworkFalse(:,3));

%xa=Network(:,1);
%ya=Network(:,3);
%ayyy=cost(xa,ya);


figure(1)
plot(Perturb,Cost,'*')
title('Figure of pertubation and cost');
xlabel('pertubation');
ylabel('cost');
hold on 
plot(PerturbF,CostF,'r*')
title('Figure of pertubation and cost');
xlabel('pertubation');
ylabel('cost');
hold off

figure(2)
h = histogram2(Perturb,Cost);
title('Histogram of pertubation and cost - for success points')
xlabel('pertubation');
ylabel('cost');


figure(3)
h = histogram2(PerturbF,CostF);
title('Histogram of pertubation and cost - for failure points')
xlabel('pertubation');
ylabel('cost');
end