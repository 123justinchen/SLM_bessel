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
blazePeriod = 9;

phaseModulation = 2*pi; % radian
dataWidth = heds_slm_width_px;
dataHeight = heds_slm_height_px;
phaseData1 = zeros(dataHeight, dataWidth, 'single');
%初始光栅相位
for x = 1:dataWidth
  grayValue = phaseModulation * (x-1) / blazePeriod;
  for y = 1:dataHeight
    phaseData1(y, x) = grayValue;
  end
  % phaseData(:,x) = grayValue; % faster but less general
end
% phaseData1 = imrotate(phaseData1,40,"crop");
% innerRadius = heds_slm_height_px;
innerRadius1 = 1000;
centerX = 0;
centerY = 0;

x = (1:dataWidth) - dataWidth/2 - centerX;
x2 = single(x.*x);
  
y = (1:dataHeight) - dataHeight/2 + centerY;
y2 = y.*y;
y2 = single(y2');

% Calculate phase data matrix:
phaseData2 = -single(phaseModulation) * (ones(dataHeight, 1, 'single')*x2 + y2*ones(1, dataWidth, 'single')) / single(innerRadius1*innerRadius1);

% x = (1:dataWidth) - dataWidth/2 - centerX;
% x2 = single(x.*x);
%   
% y = (1:dataHeight) - dataHeight/2 + centerY;
% y2 = y.*y;
% y2 = single(y2');
% 
% % Calculate phase data matrix:
% phaseData3 = -single(phaseModulation) * (ones(dataHeight, 1, 'single')*x2 + y2*ones(1, dataWidth, 'single')) / single(innerRadius*innerRadius);


% phaseData = mod(phaseData1+phaseData2+phaseData3,phaseModulation);
% % Show phase data on SLM:
% heds_show_phasevalues(phaseData)

% 实际20um一层   1000--400
for e= 1:4
    for u= 1:6
        u1 = 0.5*u
        for t=0:3:360
            phaseData4 = imrotate(phaseData1,t,"crop");
%             heds_utils_wait_ms(40);
        %     phaseData = mod(phaseData4+phaseData2+phaseData3,phaseModulation);
            phaseData = mod(phaseData4+phaseData2,phaseModulation);
            % Show phase data on SLM:
            heds_show_phasevalues(phaseData);
            heds_utils_wait_ms(40);
        end
        blazePeriod1 = blazePeriod + u1;
    
        for x = 1:dataWidth
        grayValue = phaseModulation * (x-1) / blazePeriod1;
            for y = 1:dataHeight
            phaseData1(y, x) = grayValue;
            end
        % phaseData(:,x) = grayValue; % faster but less general
        end
    end
   
innerRadius1 = innerRadius1 - 150
phaseData = -single(phaseModulation) * (ones(dataHeight, 1, 'single')*x2 + y2*ones(1, dataWidth, 'single')) / single(innerRadius1*innerRadius1);
end

% 400--200
for e= 1:5
    for u= 0:6
        u1 = 0.5*u
        for t=0:3:360
            phaseData4 = imrotate(phaseData1,t,"crop");
%             heds_utils_wait_ms(40);
        %     phaseData = mod(phaseData4+phaseData2+phaseData3,phaseModulation);
            phaseData = mod(phaseData4+phaseData2,phaseModulation);
            % Show phase data on SLM:
            heds_show_phasevalues(phaseData);
            heds_utils_wait_ms(40);
        end
        blazePeriod1 = blazePeriod + u1;
    
        for x = 1:dataWidth
        grayValue = phaseModulation * (x-1) / blazePeriod1;
            for y = 1:dataHeight
            phaseData1(y, x) = grayValue;
            end
        % phaseData(:,x) = grayValue; % faster but less general
        end
    end
   
innerRadius1 = innerRadius1 - 40
phaseData = -single(phaseModulation) * (ones(dataHeight, 1, 'single')*x2 + y2*ones(1, dataWidth, 'single')) / single(innerRadius1*innerRadius1);
end
% 200--120
for e= 1:10
    for u= -1:6
        u1 = 0.5*u
        for t=0:3:360
            phaseData4 = imrotate(phaseData1,t,"crop");
%             heds_utils_wait_ms(40);
        %     phaseData = mod(phaseData4+phaseData2+phaseData3,phaseModulation);
            phaseData = mod(phaseData4+phaseData2,phaseModulation);
            % Show phase data on SLM:
            heds_show_phasevalues(phaseData);
            heds_utils_wait_ms(40);
        end
        blazePeriod1 = blazePeriod + u1;
    
        for x = 1:dataWidth
        grayValue = phaseModulation * (x-1) / blazePeriod1;
            for y = 1:dataHeight
            phaseData1(y, x) = grayValue;
            end
        % phaseData(:,x) = grayValue; % faster but less general
        end
    end
   
innerRadius1 = innerRadius1 - 8
phaseData = -single(phaseModulation) * (ones(dataHeight, 1, 'single')*x2 + y2*ones(1, dataWidth, 'single')) / single(innerRadius1*innerRadius1);
end
% Please uncomment to close SDK at the end:
% heds_close_slm
