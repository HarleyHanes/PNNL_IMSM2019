%NetworkInvestigate
%Main file for writing data sets from Matpower cases by perturbing bus P
%and Q values and writing them to harddrive
%SubFiles
    % NewNetworkNorm
    % NewNetworkUnif
    % OutputData

%% Problem Setup
Testtype='Norm';                                %Determines whether perturbations 
                                                %follow normal or uniform 
                                                %distribution
                                                
folderpath=['C:\\Users\\X1\\OneDrive\\'...      %Folder Location to store
    'Documents\\Student Research\\SAMSI ISSM']; %data

TestID='case300Norm25000Sample';                 %Name of data folder

c=loadcase('case300');                          %MatPower Case ID
m=loadcase(c);
iter=25000;                                     %Number of Different MatPower 
                                                %perturbations to run
%mpopt=mpoption(['verbose',0,'out.all',0,...     %MatPower Options, see Manual
%    'out.suppress_detail',1]);                  %for further details

mpopt=mpoption('verbose',0,'out.all',0,'out.suppress_detail',1);
Case=runopf(c,mpopt);
sd=.1;                                          %Standard Deviation of
                                                %pertubations for normal
mean=1;                                         %Mean of perturbations
                                                %for normal distribution
delta=.5;                                       %Range of Perturbation for 
                                                %for uniform distribution

%% Model Generation and Solving
if strcmpi(Testtype,'norm')
    perturb=[mean,sd];
    Networks=NewNetworkNorm(m,iter,perturb,mpopt);
elseif strcmpi(Testtype,'unif')
    Networks=NewNetworkUnif(m,iter,delta,mpopt);
end

%% Data Outputing 
OutputData(Networks,Testtype,folderpath,TestID,Case);


