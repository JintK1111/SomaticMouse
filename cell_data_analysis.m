
load ("cell_data.csv")
T = readtable("cell_data.csv");
cellno = 2
diftable = [];
for a=(1:cellno)
    for b=(a+1:cellno)
        
        k =sqrt((T.Var1(a)-T.Var1(b))^2+(T.Var2(a)-T.Var2(b))^2+(T.Var3(a)-T.Var3(b))^2);
        diftable(a,b)=k;
        diftable(b,a)=k;
        end
end
diftable;


cellmaxdist = max(diftable);
realmaxdist = max(cellmaxdist);

for a=(1:cellno);
    diftable(a,a)=realmaxdist+1;
end

cellmindist=min(diftable);
cellmeandist=mean(mean(diftable))
maxofmindist=max(cellmindist)
minofmindist=min(cellmindist)
averagemindist=mean(cellmindist)
histogram(cellmindist);

x=-T.Var1;
y=T.Var3;
data = [x,y];
hist3(data,'Ctrs',{0:100:6000 -5000:100:5000},'CDataMode','auto','FaceColor','interp');
colorbar
