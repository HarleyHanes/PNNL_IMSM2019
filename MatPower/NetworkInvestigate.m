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
    'Documents\\Student Research\\SAMSI ISSM'];
  %data

TestID='case300Weird5000Sample';                 %Name of data folder

c=loadcase('case300');                          %MatPower Case ID
m=loadcase(c);
iter=5000;                                     %Number of Different MatPower 
                                                %perturbations to run
%mpopt=mpoption(['verbose',0,'out.all',0,...     %MatPower Options, see Manual
%    'out.suppress_detail',1]);                  %for further details

mpopt=mpoption('verbose',0,'out.all',0,'out.suppress_detail',1);
Case=runopf(c,mpopt);
sd=.2;                                          %Standard Deviation of
                                                %pertubations for normal
mean=1;                                         %Mean of perturbations
                                                %for normal distribution
delta=.5;                                       %Range of Perturbation for 
                                                %for uniform distribution
Trim=1;                                         %trims results structures to
                                                %reduce file size, enter as
                                                %1 to trim, 0 to not.
                                                %NOTE: Trimming deletes
                                                %fields from results
                                                %structures that may be
                                                %important to other
                                                %functions or future
                                                %analysis. See below for
                                                %the structure elements
                                                %that are deleted
delete={'order','om','x','mu','var','nle','nli','qdc','et','raw'};

%% Model Generation and Solving
if strcmpi(Testtype,'norm')
    perturb=[mean,sd];
    [time]=NewNetworkNormSave(m,iter,perturb,mpopt,folderpath, TestID, Trim,delete);
elseif strcmpi(Testtype,'unif')
    Networks=NewNetworkUnif(m,iter,delta,mpopt,Trim,delete);
elseif strcmpi(Testtype,'gen')
    [Networks, time]=GenInvestigate(m,iter,perturb,mpopt,folderpath, TestID, Trim, delete);
end

%% Data Outputing 
%OutputData(Networks,Testtype,folderpath,TestID,Case);
close all



