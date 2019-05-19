function checkRes = checkRCParameters(RCParameters)
checkRes = FALSE;

xv = RCParameters.RotorPosition.x + RCParameters.RotorPosition.beta  * RCParameters.SpecificModel.l1;
xl = RCParameters.RotorPosition.x - RCParameters.RotorPosition.beta  * RCParameters.SpecificModel.l2;
yv = RCParameters.RotorPosition.y - RCParameters.RotorPosition.alpha * RCParameters.SpecificModel.l1;
yl = RCParameters.RotorPosition.y + RCParameters.RotorPosition.alpha * RCParameters.SpecificModel.l2;

S0 = RCParameters.SpecificModel.S0;

if (xv^2 + yv^2 <= S0^2) && (xl^2 + yl^2 <= S0^2) 
    checkRes = TRUE;

return checkRes;

end
