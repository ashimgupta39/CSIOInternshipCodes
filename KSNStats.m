for grp = 10:10:150
min=9999999;max=0;avg=0;no=0;sum=0;
for i = 1:4975
 if BeasKSNBinning{i,'Group'}==grp & BeasKSNBinning{i,'ksna'}<min
   min = BeasKSNBinning{i,'ksna'}; 
 end
 if BeasKSNBinning{i,'Group'}==grp & BeasKSNBinning{i,'ksna'}>max
   max = BeasKSNBinning{i,'ksna'}; 
 end
 if BeasKSNBinning{i,'Group'}==grp
   sum = sum + BeasKSNBinning{i,'ksna'};
   no = no + 1;
 end
end

fprintf('%.1f\n',grp);
avg = sum/no;
SDSum = 0;
for i= 1:4975
if BeasKSNBinning{i,'Group'}==grp
x = (BeasKSNBinning{i,'ksna'} - avg)*(BeasKSNBinning{i,'ksna'} - avg);
SDSum = SDSum+x;
end
end
SD = sqrt(SDSum/no);
fprintf('%.3f\n',min);
fprintf('%.3f\n',max);
fprintf('%.3f\n',avg);
fprintf('%.3f\n',SD);
end 
