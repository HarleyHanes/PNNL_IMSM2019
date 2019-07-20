%% Analyze generated data failures

% The following code will take the generated data results from a Matpower
% simulation and analyze the distribution of the data points and the costs
% involved with running the system.

clear
clc
close all

%% Read folders into a cell file

% ATTENTION: To run this code with anything other than the case30
% information and generated data, you must adjust this section and the
% section with the subplots.

tic


% ATTENTION:  To run this code on your own computer, the following "F" and
% "S" must follow the location on your computer for these files.  You must
% replace the purple text below with your own tag information.

% 30 case
% cf=9201;  % # of total files in the failure folder
% cs=20797; % # of total files in the success folder
% F=('/Users/jennasjunneson/Desktop/Stuff/RIT Degree/Workshops2019/Failure');
% S=('/Users/jennasjunneson/Desktop/Stuff/RIT Degree/Workshops2019/Success');

% 300 case
cf=4564;  % # of total files in the failure folder
cs=4999; % # of total files in the success folder
F=('/Users/jennasjunneson/Desktop/Stuff/RIT Degree/Workshops2019/case300data/Failure');
S=('/Users/jennasjunneson/Desktop/Stuff/RIT Degree/Workshops2019/case300data/Case300Norm5000Success');

NetF=cell(cf+1,1);
NetS=cell(cs+1,1);


for i=0:cf
    f=sprintf('NormTestFail%d',i);
    file=strcat(F,'/',f);
    NetF{i+1,1}=load(file);
end
for i=0:cs
    s=sprintf('NormTestSuccess%d',i);
    file=strcat(S,'/',s);
    NetS{i+1,1}=load(file);
end
timetoloadfiles=toc;

%% Now analyze the data within these files

% Determine the p and q variations within the failures and successes and
% compare the two sets of values.

[n,~]=size(NetF{1,1}.Results.bus);

[js,~]=size(NetS);
[jf,~]=size(NetF);

pmx=min(NetF{1,1}.Results.gen(:,4)); % lowest maximum for bus pmax value
pmn=max(NetF{1,1}.Results.gen(:,5)); % highest minimum for bus pmin value

qmx=min(NetS{1,1}.Results.gen(:,9)); % lowest maximum for bus qmax value
qmn=max(NetS{1,1}.Results.gen(:,10)); % highest minimum for bus qmin value

XCol3F=cell(jf,1);
YCol4F=cell(jf,1);

for i=1:jf
    XCol3F{i,1}=NetF{i,1}.Results.bus(:,3);
    YCol4F{i,1}=NetF{i,1}.Results.bus(:,4);
end

XCol3S=cell(js,1);
YCol4S=cell(js,1);

for i=1:js
    XCol3S{i,1}=NetS{i,1}.Results.bus(:,3);
    YCol4S{i,1}=NetS{i,1}.Results.bus(:,4);
end

%% Plot the p versus q values for the failures
% Include vertical lines for the pmax and pmin values and horizontal lines
% for the qmax and qmin values

figure
scatterF=scatter(cell2mat(XCol3F(1:25:end)), cell2mat(YCol4F(1:25:end)),'r');
scatterF.MarkerEdgeAlpha=0.2;
% title('p versus q values for all buses','FontSize',22);
hold on
% vline(pmn,'k','maximum p min for all bus')
% hline(qmx,'r','minimum q max for all bus')
% hline(qmn,'r','maximum q min for all bus')
% vline(pmx,'k','minimum p max for all bus')
scatterS=scatter(cell2mat(XCol3S(1:25:end)), cell2mat(YCol4S(1:25:end)),'b');
scatterS.MarkerEdgeAlpha=0.2;
legend({'fail values','suc values'},'FontSize',14)
xlabel('p values','FontSize',16);
ylabel('q values','FontSize',16);

%% Divide data into buses and graph each bus

[a,~]=size(XCol3F);
[b,~]=size(XCol3S);

BusF3=zeros(n,a);
BusF4=zeros(n,a);
BusS3=zeros(n,b);
BusS4=zeros(n,b);

for i=1:a
    BusF3(:,i)=XCol3F{i,1};
    BusF4(:,i)=YCol4F{i,1};
end

for i=1:b
    BusS3(:,i)=XCol3S{i,1};
    BusS4(:,i)=YCol4S{i,1};
end

% ATTENTION:  When using data generated that is NOT a part of case30, you
% must comment out the following figures.

% figure
% for i=1:n
%    subplot(5,6,i);
%    s=scatter(BusF3(i,:),BusF4(i,:),'r');
%    title(['Bus ',sprintf('%d',i),' fail pq'])
%    s.MarkerEdgeAlpha=0.2;
% end
% 
% figure
% for i=1:n
%    subplot(5,6,i);
%    s=scatter(BusS3(i,:),BusS4(i,:),'b');
%    title(['Bus ',sprintf('%d',i),' suc pq'])
%    s.MarkerEdgeAlpha=0.2;
% end

%% Find max and min for p and q for each bus and plot

pmaxF=zeros(n,1);
pminF=zeros(n,1);
qmaxF=zeros(n,1);
qminF=zeros(n,1);

pmaxS=zeros(n,1);
pminS=zeros(n,1);
qmaxS=zeros(n,1);
qminS=zeros(n,1);

for i=1:n
    pmaxF(i)=max(BusF3(i,:));
    pminF(i)=min(BusF3(i,:));
    qmaxF(i)=max(BusF4(i,:));
    qminF(i)=min(BusF4(i,:));
    pmaxS(i)=max(BusS3(i,:));
    pminS(i)=min(BusS3(i,:));
    qmaxS(i)=max(BusS4(i,:));
    qminS(i)=min(BusS4(i,:));
end

X=1:n;

% LINE GRAPHS COMMENTED OUT

% figure
% plot(X,pmaxF,'r');
% hold on
% plot(X,qmaxF,'k');
% plot(X,pminF,'r');
% plot(X,qminF,'k');
% legend('Fail p','Fail q');
% title('Failures p and q max and min values');
% xlabel=('Bus Number');
% ylabel=('Value');
% 
% figure
% plot(X,pmaxS,'b');
% hold on
% plot(X,qmaxS,'g');
% plot(X,pminS,'b');
% plot(X,qminS,'g');
% legend('Suc p','Suc q');
% title('Successes p and q max and min values');
% xlabel=('Bus Number');
% ylabel=('Value');


% YF=[pmaxF pminF qmaxF qminF];
% figure
% bar(YF);
% legend('Fail p max','Fail p min','Fail q max','Fail q min');
% title('Failure p and q max and mins');
% xlabel('Bus Number');
% ylabel('value');
% 
% YS=[pmaxS pminS qmaxS qminS];
% figure
% bar(YS);
% legend('Suc p max','Suc p min','Suc q max','Suc q min');
% title('Success p and q max and mins');
% xlabel('Bus Number');
% ylabel('value');

figure
plot(X,pmaxF,'r')
hold on
plot(X,pmaxS,'b')
legend('Fail p max','Suc p max')
% title('p max values','FontSize',22)
xlabel('Bus Number','FontSize',16);
ylabel('value','FontSize',16);

figure
plot(X,pminF,'r')
hold on
plot(X,pminS,'b')
legend('Fail p min','Suc p min')
% title('p min values','FontSize',22)
xlabel('Bus Number','FontSize',16);
ylabel('value','FontSize',16);

figure
plot(X,qmaxF,'r')
hold on
plot(X,qmaxS,'b')
legend('Fail q max','Suc q max')
% title('q max values','FontSize',22)
xlabel('Bus Number','FontSize',16);
ylabel('value','FontSize',16);

figure
plot(X,qminF,'r')
hold on
plot(X,qminS,'b')
legend('Fail q min','Suc q min')
% title('q min values','FontSize',22)
xlabel('Bus Number','FontSize',16);
ylabel('value','FontSize',16);

%% Plot the cost for each of the functions in failures and successes

XF=1:jf;

YcostF=zeros(jf,1);

for i=1:jf
    YcostF(i)=NetF{i,1}.Results.f;
end

XS=1:js;

YcostS=zeros(js,1);

for i=1:js
    YcostS(i)=NetS{i,1}.Results.f;
end

% SCATTER PLOTS FOR COSTS PER FAILURES AND SUCCESSES COMMENTED OUT
% figure
% scatterCF=scatter(XF,YcostF,'r');
% title('Costs for the failures')
% scatterCF.MarkerEdgeAlpha=0.3;
% xlabel('Simulation Number');
% ylabel('Cost');
% 
% figure
% scatterCS=scatter(XS,YcostS,'b');
% title('Costs for the successes')
% scatterCS.MarkerEdgeAlpha=0.3;
% xlabel('Simulation Number');
% ylabel('Cost');

%% Plot the costs of both together

[CFmax,fmax]=max(YcostF);
[CFmin,fmin]=min(YcostF);

[CSmax,smax]=max(YcostS);
[CSmin,smin]=min(YcostS);


figure
scatterC=scatter(XF,YcostF,'r');
xlim([0 5500])
% xlim([0 26000])
hold on
scatterC2=scatter(XS,YcostS,'b');
scatterC.MarkerEdgeAlpha=0.2;
scatterC2.MarkerEdgeAlpha=0.2;
hline(CFmax,'r');
hline(CFmin,'r');
hline(CSmax,'b');
hline(CSmin,'b');
% title('Cost of failures(red) and successes(blue)','FontSize',22);
% text(22000,775,['Fail Max $',num2str(round(CFmax,2))],'Color','r','FontSize',14)
% text(22000,579,['Fail Min $',num2str(round(CFmin,2))],'Color','r','FontSize',14)
% text(22000,681,['Suc Max $',num2str(round(CSmax,2))],'Color','b','FontSize',14)
% text(22000,465,['Suc Min $',num2str(round(CSmin,2))],'Color','b','FontSize',14)
text(4800,790000,['Fail Max $',num2str(round(CFmax,2))],'Color','r','FontSize',14)
text(4800,690000,['Fail Min $',num2str(round(CFmin,2))],'Color','r','FontSize',14)
text(4800,764000,['Suc Max $',num2str(round(CSmax,2))],'Color','b','FontSize',14)
text(4800,674000,['Suc Min $',num2str(round(CSmin,2))],'Color','b','FontSize',14)
xlabel('Simulation Number','FontSize',16)
ylabel('Cost per Hour','FontSize',16)
legend({'fail values','suc values'},'Location','north','FontSize',14)



