% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
%  Copyright (C) 2020 HOLOEYE Photonics AG. All rights reserved.
%  Contact: https://holoeye.com/contact/
%  
%  This file is part of HOLOEYE SLM Display SDK.
%  
%  You may use this file under the terms and conditions of the
%  "HOLOEYE SLM Display SDK Standard License v1.0" license agreement.
%  
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
% Calculates an airy beam and show it on the SLM.

% Import SDK:
add_heds_path;

% Check if the installed SDK supports the required API version
heds_requires_version(3);

% Make some enumerations available locally to avoid too much code:
heds_types;

% Detect SLMs and open a window on the selected SLM:
heds_slm_init;

% Open the SLM preview window in "Fit" mode:
% Please adapt the file show_slm_preview.m if preview window
% is not at the right position or even not visible.
show_slm_preview(0.0);

% Configure the airy beam properties:
onedimensional = false;
innerRadius = heds_slm_height_px / 2.0;
rotAngleDeg = 0.0;
centerX = 0;
centerY = 0;

% Calculate the phase values of an airy beam in a pixel-wise matrix:

% pre-calc. helper variables:
phaseModulation = 2*pi;
dataWidth = heds_slm_width_px;
dataHeight = heds_slm_height_px;

% Move white-black phase wraps out of the center:
cyclicShift = - phaseModulation / 2.0;

angleRad = rotAngleDeg / 360.0 * 2.0 * pi;

% Create and fill the phaseData matrix:

% We try to compute the field using matrix multiplication if possible:
if (rotAngleDeg == 0.0)

    x = (1:dataWidth) - dataWidth/2 - centerX;
    x3 = single(x.*x.*x);
      
    y = (1:dataHeight) - dataHeight/2 + centerY;
    y3 = y.*y.*y;
    y3 = single(y3');

    % Calculate phase data matrix:
    if onedimensional
        phaseData = single(phaseModulation) * ones(dataHeight, 1, 'single')*x3 / single(innerRadius*innerRadius*innerRadius);
    else
        phaseData = single(phaseModulation) * (ones(dataHeight, 1, 'single')*x3 + y3*ones(1, dataWidth, 'single')) / single(innerRadius*innerRadius*innerRadius);
    end

else % we cannot use optimized version in case of arbitrary angles.

    phaseData = zeros(dataHeight, dataWidth, 'single');

    % Warning: "for"-loops are very slow when using Octave.
    for y = 1:dataHeight
        for x = 1:dataWidth
             x0Deg = x - dataWidth / 2 - centerX;
             y0Deg = y - dataHeight / 2 + centerY;
     
             xDeg = cos(angleRad) * x0Deg - sin(angleRad) * y0Deg;
             yDeg = sin(angleRad) * x0Deg + cos(angleRad) * y0Deg;
     
             x3 = xDeg^3.0;
             y3 = yDeg^3.0;
     
             if onedimensional
                 val = x3 * innerRadius^-3.0;
             else
                 val = (x3 + y3) * innerRadius^-3.0;
             end    
             
             phaseData(y,x) = val * phaseModulation;
         end
    end

end

phaseData = phaseData + cyclicShift;

% Show data on the SLM:
heds_show_phasevalues(phaseData)

% Please uncomment to close SDK at the end:
% heds_close_slm