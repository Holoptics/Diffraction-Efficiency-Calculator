% DiffEffiCalc.m -- determining diffraction efficiency of redirection hologram
% Written by Craig Draper & Joshua McDonald
% V0.2 4/28/2018

clear
clear all

%-------------------------------------------------------------------------%

%Filters
    %Noise Reduction
    nr1 = (1/9)*[1,1,1; 1,1,1; 1,1,1;];
    nr2 = (1/10)*[1,1,1; 1,2,1; 1,1,1;];
    nr3 = (1/25)*[1,1,1,1,1; 1,1,1,1,1; 1,1,1,1,1; 1,1,1,1,1; 1,1,1,1,1;];
    
    %Edge Detection
    norm = [0,0,0; 0,1,0; 0,0,0];
    hpf1 = [0,-1,0; -1,4,-1; 0,-1,0];
    hpf2 = [-1,-1,-1; -1,8,-1; -1,-1,-1];
    hpf3 = [-2,-2,-2;-2,17,-2;-2,-2,-2];
    edg1 = norm + hpf1;
    edg2 = norm + hpf2;
    edg3 = norm + hpf3;
    
%-------------------------------------------------------------------------%

  %This section of the code pulls an image and prepares it to be Analyzed.

%Variables in Section
binaryImage = [];
croped = [];

%Select Picture
[file,path,indx] = uigetfile('*.jpg;*.jpeg;*.png');
if isequal(file,0)
   return
else
   pic = imread(fullfile(path, file));
end

%Convert image to greyscal
if size(pic,3)==3
    pic = rgb2gray(pic);
end

%Select Portion of Interest
figure, imshow(pic, []);
axis on;
title('Contour Region Required');
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
message = sprintf('Left click and hold to begin drawing.\nRelease Mouse Button when Completed');
uiwait(msgbox(message));
hFH = imrect;

%Mask image
binaryImage = createMask(hFH);
blackMaskedImage = pic;
blackMaskedImage(~binaryImage) = 0;
 
%Crop Rest of Image
rect = getPosition(hFH);
croped = imcrop(blackMaskedImage,rect);
% croped = double(croped);
close

%-------------------------------------------------------------------------%

    %This seciton of the Code manipulates the images for Processing

%Variables in section
edgeimg = [];
noiseimg = [];

%Noise Reduction
noiseimg = medfilt2(croped);
noiseimg = medfilt2(noiseimg);

%Edge Enhancement Concolution
edgeimg = conv2(croped,edg3,'same');

%-------------------------------------------------------------------------%

    %This section of the code processes the diffraction Efficiency

%Variables in section

%Get reference Point for Highest Energy

%Calculate Efficiency Given Reference

%Find Maximum Efficiency

%Find Average Efficiency


%-------------------------------------------------------------------------%

%Plot Data

%Present Non-Visual Data

%-------------------------------------------------------------------------%

%%Old Variables
% pic = []; %Picture to be used
% imp = []; %Imported Pixels
% I = []; %Intensity vector
% ii=1;
% Px1 = 0; %Pulled pixel 1
% Px2 = 0; %Pulled pixel 2
% Px3 = 0; %pulled pixel 3
% PxT = 0; %Total Pixel Intensity from px1-3
% PxM = 0; %Average Pixel Intensity from px1-3
% PxD = 0; %Difference between PxT and PxM
% PxP = 0; % "%" difference between the Average and Distance
% Pxt = 0; % Temporary Total
% Pxm = 0; % Temporary Average
% prcnt = .97;

%-------------------------------------------------------------------------%

%Last Version Code

%Average Data Out
% while ii <= length(imp)
%     if or(ii == 1,ii == length(imp))
%         I(ii) = imp(ii);
%         ii=ii+1;
%     else
%         Px1 = imp(ii-1);
%         Px2 = imp(ii);
%         Px3 = imp(ii+1);
%         PxT = Px1+Px2+Px3;
%         PxM = PxT/3;
%         PxD = PxT-PxM;
%         PxP = PxT/PxM;
%         if PxP >= prcnt
%             I(ii)=PxM;
%         elseif PxP < prcnt
%             if Px3 > Px2
%                 Pxt = Px1 + Px2;
%                 Pxm = mean(Pxt);
%                 I(ii) = Pxm;
%             end
%             if Px1 > Px2
%                 Pxt = Px2 + Px3;
%                 Pxm = mean(Pxt);
%                 I(ii) = Pxm;
%             end
%         end
%         ii = ii+1;
%     end
% end
