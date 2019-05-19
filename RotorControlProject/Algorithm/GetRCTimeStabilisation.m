function [RCTimeStab] = GetRCTimeStabilisation(RCStab)
global g_RCTimeStab;

index = 0;
for i = 1:length(RCStab.vecKSI)
  k1 = eval(sprintf('%.7f', RCStab.vecKSI(i,1)));
  k2 = eval(sprintf('%.7f', RCStab.vecKSI(i,2)));
  k3 = eval(sprintf('%.7f', RCStab.vecKSI(i,3)));
  k4 = eval(sprintf('%.7f', RCStab.vecKSI(i,4)));
  
  if ((k1 == 0.0) && (k2 == 0.0) && (k3 == 0.0) && (k4 == 0.0))
      break;
  end
  
  index = index + 1;
end

if index > 0
g_RCTimeStab.time   = RCStab.vecT(index);
g_RCTimeStab.index  = index;
else
g_RCTimeStab.time   = 0;
g_RCTimeStab.index  = index;
end

RCTimeStab.time     = g_RCTimeStab.time;
RCTimeStab.index    = index;

end
