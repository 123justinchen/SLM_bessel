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
% Uses the built-in blank screen function to show a given grayscale value on the full SLM.
% Then we load a Zernike parameter set from a Zernike parameter file to create a wavefront
% deformation overlay from the loaded parameters.

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
% The additional flag ShowZernikeRadius presses the button to
% show the Zernike radius visualization in preview window from code.
show_slm_preview(0.0, heds_slmpreview_flags.ShowZernikeRadius);

% Configure the blank screen:
grayValue = 128

% Show gray value on SLM without using a handle:
heds_show_blankscreen(grayValue);

% Load a file containing the Zernike parameters and the Zernike radius:
heds_slm_zernike_load('data/zernike_parameters.zernike.txt');
disp('Zernike values were applied successfully.');

% Caution: When not resetting applied Zernike values, these values will persist until the SDK is reinitialized.
% To clear Zernike parameters, please either call heds_slm_init() again to re-initialize the SLM completely,
% or call heds_slm_zernike(0) to only clear Zernike parameters.

% Clear Zernike values
%heds_utils_wait_s(5);
%heds_slm_zernike(0);
%disp('Zernike values were reset to defaults.');



% Please uncomment to close SDK at the end:
% heds_close_slm
