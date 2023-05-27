da = ["sutlej" "D:\dems\sutlejutm.tif";
"beas" "D:\dems\beasutm.tif";
"chenab" "D:\dems\chenabutm.tif";
"jhelum" "D:\dems\jhelumutm.tif";
"ravi" "D:\dems\raviutm.tif";
"yamuna" "D:\dems\yamunautm.tif";
"ganga" "D:\dems\gangautm.tif"]

for i = 1:7
DEM = GRIDobj(da(i,2));
FD  = FLOWobj(DEM);
S   = STREAMobj(FD,'minarea',1000);
S   = klargestconncomps(S,1);
A   = flowacc(FD);

ST  = trunk(S,A);
[D,AS] = dbasymmetry(FD,ST,'extractlongest',true);
GRIDobj2geotiff(D,strcat('D:\Data\dbmaps\',da(i,1),'.tif'))
DB  = drainagebasins(FD,ST);
DM  = upslopestats(FD,D,'mean');
CST = STREAMobj2cell(ST);
for r = 1:numel(CST)
    subplot(numel(CST),1,r);
    plotdz(CST{r},DM,'dunit','km')
    hold on
    plot(xlim,[.5 .5],':k')
    ylabel("Asymmetry of "+da(i,1))
    ylim([0 1])
    yyaxis right
    plotdz(CST{r},DEM,'dunit','km')
    if r < numel(CST)
        xlabel('')
    end
end
end
