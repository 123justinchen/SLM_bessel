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
% Shows a 2d matrix of phase values with data type float (single) on the SLM.
% The phase values have a range from 0 to 2pi, non-fitting values will be wrapped automatically on the GPU.

% Import SDK:
add_heds_path;

% Check if the installed SDK supports the required API version
heds_requires_version(3);

% Make some enumerations available locally to avoid too much code:
heds_types;

% Detect SLMs and open a window on the selected SLM:
heds_slm_init;

% Open the SLM preview window in non-scaled mode:
% This might have an impact on performance, especially in "Capture SLM screen" mode.
% Please adapt the file show_slm_preview.m if preview window is not at the right position or even not visible.
show_slm_preview(1.0);

% Calculate e.g. a vertical blazed grating:
blazePeriod = 10;

phaseModulation = 2*pi; % radian
dataWidth = heds_slm_width_px;
dataHeight = heds_slm_height_px;
phaseData1 = zeros(dataHeight, dataWidth, 'single');

for x = 1:dataWidth
  grayValue = phaseModulation * (x-1) / blazePeriod;
  for y = 1:dataHeight
    phaseData1(y, x) = grayValue;
  end
  % phaseData(:,x) = grayValue; % faster but less general
end


innerRadius = heds_slm_height_px / 3;
centerX = 0;
centerY = 0;

x = (1:dataWidth) - dataWidth/2 - centerX;
x2 = single(x.*x);
  
y = (1:dataHeight) - dataHeight/2 + centerY;
y2 = y.*y;
y2 = single(y2');

% Calculate phase data matrix:
phaseData2 = single(phaseModulation) * sqrt(ones(dataHeight, 1, 'single')*x2 + y2*ones(1, dataWidth, 'single')) / single(innerRadius);

for t=0:5:380
    t

    phaseData3 = imrotate(phaseData1,t,"crop");
    heds_utils_wait_ms(40);
    phaseData = mod(phaseData3+phaseData2,phaseModulation);
    % Show phase data on SLM:
    heds_show_phasevalues(phaseData)
    heds_utils_wait_ms(40);

end

% Please uncomment to close SDK at the end:
% heds_close_slm
