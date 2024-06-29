%% Load image data
[name path] = uigetfile('*.TIF','Select the stack');
cd(path);
N_img = length(imfinfo(name)); % Number of images
N_pixel = 256; % 256 by 256 pixels
data = zeros(N_pixel,N_pixel,3,N_img);
for i = 1:N_img
    tmp1 = imread(name,'TIF',i); 
    data(:,:,:,i) = tmp1(:,:,:); % Load the RGB images
end
clear tmp;

%% Set parameters for image registration
[optimizer metric] = imregconfig('monomodal');
optimizer.GradientMagnitudeTolerance = 5.0e-04;
optimizer.MinimumStepLength = 5.0e-05;
optimizer.MaximumStepLength = 6.25e-02;
optimizer.MaximumIterations = 100;
optimizer.RelaxationFactor = 0.5;

% Registration
data_reg = zeros(size(data));
ref_img = mean(data(:,:,1,[1:30]),4); % Reference image

for i = 1:N_img
    tform = imregtform(data(:,:,1,i), ref_img, 'translation', optimizer, metric); % Get the transform
    data_reg(:,:,1,i) = imwarp(data(:,:,1,i), tform, 'OutputView', imref2d(size(ref_img)));
    data_reg(:,:,2,i) = imwarp(data(:,:,2,i), tform, 'OutputView', imref2d(size(ref_img)));

    if i == 1
        disp('Registration in progress');
    elseif i == N_img
        disp('Registration completed');
    end
end

%% Save TIF image
imwrite(data_reg(:,:,:,1)./255,[name((1:length(name)-4)) '_reg.tif']);
for i=2:N_img
    imwrite(data_reg(:,:,:,i)./255,[name((1:length(name)-4)) '_reg.tif'],'writemode','append');
end