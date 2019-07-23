%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
% hold the original case file


%% Settings
clear 
Case='case30';
def=5;             %Iterations is 20^2*GenNumber
mpopt=mpoption('verbose',0,'out.all',0,'out.suppress_detail',1);



%% Computing
m=loadcase(Case);
ROpt=runopf(m,mpopt);

%Rt.gen=[ROpt.gen(6,:); ROpt.gen(1:5,:)];
%ROpt.gen=Rt.gen;
S=size(ROpt.gen);
GenNumber=2;

InitSettings=cell(def,def,GenNumber);
GenResults=cell(def,def,GenNumber);


for i=1:GenNumber
    PVar(i,:)=linspace(ROpt.gen(i,10),ROpt.gen(i,9),def);
    QVar(i,:)=linspace(ROpt.gen(i,5),ROpt.gen(i,4),def);
end

for Gen=1:GenNumber
%    [PMesh,QMesh]=meshgrid(PVar(Gen,:),QVar(Gen,:));
    subplot(3,2,Gen)
    hold on
    for k=1:def
        for j=1:def
            r=ROpt;
            P=PVar(Gen,k);
            Q=QVar(Gen,j);
            r.gen(Gen,2)=P;
            r.gen(Gen,3)=Q;
            Results=runpf(r,mpopt);
            Ppoints=[P, Results.gen(Gen,2)]
            Qpoints=[Q, Results.gen(Gen,3)]
            plot(Ppoints,Qpoints,'b-')
            %InitSettings{k,j,Gen}=[P,Q];
            %GenResults{k,j,Gen}=Results;
        end
    end
    if Gen==3
        ylabel('Q')
    elseif Gen==5 || Gen==6
        xlabel('P')
    end
    title(sprintf('Generator %d',Gen))
    plot(ROpt.gen(Gen,2),ROpt.gen(Gen,3),'r*')
end

%% Plotting
% for J=1:6
%     subplot(3,2,J)
%     hold on
%     for k=1:def
%         for j=1:def
%             Results=GenResults{k,j,J};
%             %Init=InitSettings{k,j,J};
%             Init=[PVar(J,k),QVar(J,j)];
%             %Ppoints=[Init(1), Results.gen(J,2)]
%             %Qpoints=[Init(2), Results.gen(J,3)]
%             plot(Ppoints,Qpoints,'b-')
%             %plot(Init,Results.gen(J,2:3),'b-')
%         end
%     end
%     if J==3
%         ylabel('Q')
%     elseif J==5 || J==6
%         xlabel('P')
%     end
%     title(sprintf('Generator %d',J))
%     plot(ROpt.gen(J,2),ROpt.gen(J,3),'r*')
% end




