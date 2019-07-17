function [Cost,Network] = NewNetwork(m,iter,perturb)
%NewNetwork - making perturbations of the data in the power cases

Network=cell(iter,3);

morig=m;

[j,k]=size(m.bus);

pertval=randn(j,iter)*perturb(2)+perturb(1);


for i=1:iter
    m=morig;
    m.bus(:,[3:4])=m.bus(:,[3,4])+pertval(i)*m.bus(:,[3,4]);
    Network{i,1}=pertval(i);
    Network{i,2}=m.bus;
    results=runopf(m);
    Network{i,3}=results.f;
end


end

