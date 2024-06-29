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

%% Correction
odd = [1:2:N_pixel]'; % Odd row index
even = [2:2:N_pixel]'; % Even row index
dx = 2; % How many pixel shift?

data(even,[dx+1:N_pixel],:,:) = data(even,[1:N_pixel-dx],:,:); % Shifting
    
%% Display result
image(mean(data(:,:,:,[1:30]),4)./511);

%% Save TIF image
imwrite(data(:,:,:,1)./255,[name((1:length(name)-4)) '_cor.tif']);
for i=2:N_img
    imwrite(data(:,:,:,i)./255,[name((1:length(name)-4)) '_cor.tif'],'writemode','append');
end
    
    