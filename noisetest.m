n=100;
m=50;
nd=50;
perc=59;
%noise=exprnd(1,nd*m);
noise=randn(nd,n,m);

k=n/100*perc;
noise(:,1:k,:)=0;
cp=0.5*ones(1,nd);
cp(20)=2;
for i=1:nd
    data(i,:,:)=exp(1j*cp(i)*noise(i,:,:));
end
data=cumprod(data,1);

intid=nchoosek(1:nd,2);
dt=intid(:,2)-intid(:,1);

ints=data(intid(:,2),:,:).*conj(data(intid(:,1),:,:));

b=squeeze(abs(mean(ints,2)));
c=mean(b,2);

subplot(1,2,1)
triplot(b(:,1),1:nd,intid)
subplot(1,2,2)
plot(dt,mean(b,2),'.');
%axis([0 50 -4 0])
