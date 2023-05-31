n     = 100;
m     = 75;
maxd  = 50;
nd    = 50;
nperc = 4;
percs = linspace(0,80,nperc);
intid = nchoosek(1:nd,2);
dt    = intid(:,2)-intid(:,1);
[dts,~,ic]=unique(dt);
dcp = 0.5;
dgaml =-dcp^2/2;
cumgaml=dts*dgaml;
cumgam=exp(cumgaml);

for j=1:nperc
    perc=percs(j);
    %noise=exprnd(1,nd*m);
    noise=randn(nd,n,m);
    
    k=round(n/100*perc);
    noise(:,1:k,:)=0;
    cp=dcp*ones(1,nd);
    
    for i=1:nd
        data(i,:,:)=exp(1j*cp(i)*noise(i,:,:));
    end
    data=cumprod(data,1);
    
    ints=data(intid(:,2),:,:).*conj(data(intid(:,1),:,:));
    
    b=squeeze(abs(mean(ints,2)));
    c=mean(b,2);
    for i=1:length(dts)
        allcoh(j,i)=mean(c(ic==i));
    end
end

a=percs/100+cumgam*(1-percs/100);
figure
plot(dts,allcoh)
hold on
plot(dts,cumgam,'k')
plot(dts,a,'b:')