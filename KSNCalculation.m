DEMArray = ["beas" "C:\Users\DELL\Desktop\individual basins from mergedDEM\beas.tif";
 "chenab" "C:\Users\DELL\Desktop\individual basins from mergedDEM\chenab.tif";
 "jhelum" "C:\Users\DELL\Desktop\individual basins from mergedDEM\jhelum.tif";
"rabi" "C:\Users\DELL\Desktop\individual basins from mergedDEM\rabi.tif";
"sutlej" "C:\Users\DELL\Desktop\individual basins from mergedDEM\sutlej.tif"]
for i = 1:5
    DEM = GRIDobj(DEMArray(i,2));
    FD = FLOWobj(DEM,'preprocess','carve');
  S  = STREAMobj(FD,'minarea',1000);
S  = klargestconncomps(S,1);
STATS = slopearea(S,DEM,A);
g   = gradient(S,DEM);
a   = getnal(S,A)*A.cellsize^2;
ksn = g./(a.^STATS.theta);ksna = smooth(S,ksn,'K',20);
ksna = aggregate(S,ksn,'seglength',1000);
    MS = STREAMobj2mapstruct(S,'seglength',1000,'attributes',...
    {'ksna' ksna @mean ...
     'uparea' a @mean ...
     'gradient' g @mean});
shapewrite(MS,strcat('C:\Users\DELL\Desktop\individual basins from mergedDEM\ksn values\',DEMArray(i,1),'KSN.shp'));
end
