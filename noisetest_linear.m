n  = 100;  %num pixels
m  = 50;   %num iterations
nd = 50;   %num dates
dn = 1:50; %dates

intid = nchoosek(1:nd,2);
dt    = diff(dn(intid),[],2);


dgam = 0.93;
stds = sqrt(-2*log(dgam));
%stds = 0.2; %standard deviation of phase on each date, radians
%noise = stds*exprnd(1,nd*m);
noise = stds*randn(nd,n,m);

wgts=linspace(0,1,n);
%wgts=ones(1,n);
for i=1:n
    noise(:,i,:)=noise(:,i,:)*wgts(i);
end

for i=1:nd
    slcs(i,:,:)=exp(1j*noise(i,:,:));
end
slcs = cumprod(slcs,1);
ints = slcs(intid(:,2),:,:).*conj(slcs(intid(:,1),:,:));
cors = squeeze(abs(mean(ints,2)));
acor = mean(cors,2);


nivar=stds.^2*unique(dt);
coh=exp(-nivar/2);


figure


subplot(1,2,1)
triplot(cors(:,1),1:nd,intid)
subplot(1,2,2)
plot(dt,acor,'.');
hold on
plot(unique(dt),coh,'k.')
hold off
%axis([0 50 -4 0])
