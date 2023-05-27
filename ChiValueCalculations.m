DEMArray = ["beas" "C:\Users\DELL\Desktop\individual basins from mergedDEM\beas.tif";
 "chenab" "C:\Users\DELL\Desktop\individual basins from mergedDEM\chenab.tif";
 "jhelum" "C:\Users\DELL\Desktop\individual basins from mergedDEM\jhelum.tif";
"rabi" "C:\Users\DELL\Desktop\individual basins from mergedDEM\rabi.tif";
"sutlej" "C:\Users\DELL\Desktop\individual basins from mergedDEM\sutlej.tif"]
for i = 1:5
    DEM = GRIDobj(DEMArray(i,2));
    FD = FLOWobj(DEM,'preprocess','carve');
    S = STREAMobj(FD,'minarea',500);
    S = klargestconncomps(S,1);
    D = drainagebasins(FD,S);
    A = flowacc(FD);
    chiplot(S,DEM,A,'mnplot',true,'plot',false)
    C = chiplot(S,DEM,A);
    C
    mn = C.mn
    c = chitransform(S,A,'mn',mn);
    MS = STREAMobj2mapstruct(S,'seglength',1000,'attributes',...
    {'chi' c @mean ...
     });
    shapewrite(MS,strcat('C:\Users\DELL\Desktop\individual basins from mergedDEM\chi values\',DEMArray(i,1),'CHI.shp'));
end
