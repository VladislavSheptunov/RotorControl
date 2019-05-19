function [t, ksi] = RCStabilisation(RCParameters)
    [A, B, W, timeStab] = RCGetSystem(RCParameters);
    T = [0, timeStab * 1.5];
    
    alpha = RCParameters.RotorPosition.alpha;
    beta  = RCParameters.RotorPosition.beta;
    x     = RCParameters.RotorPosition.x;
    y     = RCParameters.RotorPosition.y;

    ksi0 = [alpha; beta; x; y; 0; 0; 0; 0];
    [t, ksi] = ode45(@(t,ksi)valrot(t, ksi, A, B, W), T, ksi0);
end
