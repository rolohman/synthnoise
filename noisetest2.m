n  = 100;
m  = 75;
maxd = 50;
nd=50;
nperc=30;
percs = linspace(0,100,nperc);
intid = nchoosek(1:nd,2);
dt    = intid(:,2)-intid(:,1);
[dts,~,ic]=unique(dt);



for j=1:nperc
    perc=percs(j);
    %noise=exprnd(1,nd*m);
    noise=randn(nd,n,m);
    
    k=round(n/100*perc);
    noise(:,1:k,:)=0;
    cp=0.5*ones(1,nd);
    
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

% end
%     triplot(b(:,1),1:nd,intid)
%     return
%     plot(dt,mean(b,2),'.');
    %axis([0 50 -4 0])
