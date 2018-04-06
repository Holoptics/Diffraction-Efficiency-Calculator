% hudDEredir.m -- determining diffraction efficiency of redirection hologram
% Written by Craig Draper & Joshua McDonald
% 4/5/2018

clear
clear all

%variables
pic = []; %Picture to be used
imp = []; %Imported Pixels
I = []; %Intensity vector
ii=1;
Px1 = 0; %Pulled pixel 1
Px2 = 0; %Pulled pixel 2
Px3 = 0; %pulled pixel 3
PxT = 0; %Total Pixel Intensity from px1-3
PxM = 0; %Average Pixel Intensity from px1-3
PxD = 0; %Difference between PxT and PxM
PxP = 0; % "%" difference between the Average and Distance
Pxt = 0; % Temporary Total
Pxm = 0; % Temporary Average
prcnt = .97

%Import & Prepare Picture
pic = imread('D:\Holoptics\Pictures\DiffEffiCalc_Test.JPG');
pic = rgb2gray(pic); % convert image to gray scale
imshow(pic)

%Select row of pixels to use
imp = improfile;

%Average Data Out
while ii <= length(imp)
    if or(ii == 1,ii == length(imp))
        I(ii) = imp(ii);
        ii=ii+1;
    else
        Px1 = imp(ii-1);
        Px2 = imp(ii);
        Px3 = imp(ii+1);
        PxT = Px1+Px2+Px3;
        PxM = PxT/3;
        PxD = PxT-PxM;
        PxP = PxT/PxM;
        if PxP >= prcnt
            I(ii)=PxM;
        elseif PxP < prcnt
            if Px3 > Px2
                Pxt = Px1 + Px2;
                Pxm = mean(Pxt);
                I(ii) = Pxm;
            end
            if Px1 > Px2
                Pxt = Px2 + Px3;
                Pxm = mean(Pxt);
                I(ii) = Pxm;
            end
        end
        ii = ii+1;
    end
end

figure
plot(I)