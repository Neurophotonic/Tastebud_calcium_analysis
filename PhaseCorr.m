clear all;
close all;

[name path] = uigetfile('*.TIF','Select the stack');
cd(path);
N_img = length(imfinfo(name)); % Number of images
N_pixel = 256; % 512 by 512 pixels
data = zeros(N_pixel,N_pixel,3,N_img);
for i = 1:N_img
    tmp1 = imread(name,'TIF',i); 
    data(:,:,:,i) = tmp1(:,:,:); % Load the RGB images
end
clear tmp;

%% 두 픽셀 단위로 어긋남 (phase = 2 pixel)

y_odd = [(1:4:256) (2:4:256)];
y_even = [(3:4:256) (4:4:256)];
phase = 2;


data(y_even,(1+phase:256),:,:) = data(y_even,(1:256-phase),:,:);

image(mean(data(:,:,2,:),4))

%%
imwrite(data(:,:,:,1)./300,[name((1:length(name)-4)) '_corr.tif']);

for i=2:N_img
    imwrite(data(:,:,:,i)./300,[name((1:length(name)-4)) '_corr.tif'],'writemode','append');
end
