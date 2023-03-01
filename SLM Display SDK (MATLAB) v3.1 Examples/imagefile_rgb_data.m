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
% Loads an RGB image file and shows it on the SLM.

% Import SDK:
add_heds_path;

% Check if the installed SDK supports the required API version
heds_requires_version(4);

% Make some enumerations available locally to avoid too much code:
heds_types;

% Detect SLMs and open a window on the selected SLM:
heds_slm_init;

% Open the SLM preview window in "Fit" mode:
% Please adapt the file show_slm_preview.m if preview window
% is not at the right position or even not visible.
show_slm_preview(0.0);

% Show image file data on SLM:
filename = strcat( fileparts(mfilename('fullpath')), '/data/RGBCMY01.png' )

% Load the data from image file:
image = imread(filename);

if (1)
    heds_show_data(image, heds_showflags.Auto);
else
    handle = heds_load_data(image);
    heds_show_datahandle(handle.id, heds_showflags.Auto);
end

% Please uncomment to close SDK at the end:
% heds_close_slm
