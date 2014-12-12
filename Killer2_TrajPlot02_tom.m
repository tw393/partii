function Killer2_TrajPlot02_tom(folderPath,KillerStart,KillerCatch)
% This function brings in the XYZ coordinates for Killer and prey and also
% the stereo calibration data to allow the plotting and measurement of
% killer and prey trajectories

%% Setup Figure Positions and Sizes
scrsz = get(0,'ScreenSize'); % ScreenSize = [X Y Width Height]
fig1 = figure; position = get(fig1,'Position');
outerpos = get(fig1,'OuterPosition'); borders = outerpos - position;
scrszedge = -borders(1)/2;
scrszposLeft = [scrszedge, (scrsz(4)/6), scrsz(3)/2 - scrszedge, ...
    scrsz(4)/1.2];
% scrszposRight = [scrsz(3)/2 + scrszedge, scrszposLeft(2),...
%     scrszposLeft(3), scrszposLeft(4)];
cInfo.scrszposFull = [scrszedge, (scrsz(4)/6),...
    scrszposLeft(3)*2, scrsz(4)/1.2];
clear scrsz scrszedge fig1 outerpos position borders scrszposLeft;
close all;

%% Import Stereo Calibration data
FNamePattern = 'Calib_Results*.mat';
Cali = dir(FNamePattern);
load(Cali.name)
cInfo.Cali = load(Cali.name, 'om','T','fc_left','cc_left',...
    'kc_left','alpha_c_left','fc_right','cc_right','kc_right','alpha_c_right');

% Import Droso coordinates
FNamePattern = '*Droso.mat'; droso = dir(FNamePattern);
Droso = load(fullfile(folderPath,droso.name));

% Import Killer coordinates
FNamePattern = '*Killer.mat'; killer = dir(FNamePattern);
Killer = load(fullfile(folderPath,killer.name));

%% Open video in dos
% FNamePattern = '*c1bwTrim.tif';
% Traj = dir(FNamePattern); eval(['dos ' Traj.name ';']);
% FNamePattern = '*c2bwTrim.tif';
% Traj = dir(FNamePattern); eval(['dos ' Traj.name ';']);
% clear FNamePattern Traj;

%% Ask for Positions
%tf = isfield(Droso, 'DrosoStart');
%if tf == 0;
   % FrameNo = inputdlg({'Which Frame did the Droso move?'}, ...
    %    'Provide Frame number', 1, {'1'});
    FrameNo = '1';
    DrosoStart = str2double(FrameNo); clear FrameNo;
    eval('C1 = Droso.C1;'); eval('C2 = Droso.C2;');
    eval(['save ' droso.name ' C1 C2 DrosoStart;']); clear C1 C2;
    Droso.DrosoStart = DrosoStart;
%end
%tf = isfield(Killer, 'KillerStart');
%if tf == 0;
   % FrameNo = inputdlg({'Which Frame did the KillerFly move?'}, ...
    %    'Provide Frame number', 1, {'1'});
   % KillerStart = str2double(FrameNo{:}); clear FrameNo;
   % FrameNo = inputdlg({'Which Frame did the KillerFly Catch?'}, ...
    %    'Provide Frame number', 1, {'1'});
 %   KillerCatch = str2double(FrameNo{:}); clear FrameNo;
   eval('C1 = Killer.C1;'); eval('C2 = Killer.C2;');
   eval(['save ' killer.name ' C1 C2 KillerStart KillerCatch;']);
   Killer.KillerCatch = KillerCatch; Killer.KillerStart = KillerStart;
%end
clear C1 C2 killer droso Cali FNamePattern;

%% Convert 2D matrix into 3D using calibration data
% Bring in Data and Calibration
xL = Killer.C1.Basepts; xR = Killer.C2.Basepts; C = cInfo.Cali;
iMGsize = size(Killer.C1.StartImage,2);
% Flip Vertical axis due to matlab image flip
xL(:,2) = abs(xL(:,2)-iMGsize);
xR(:,2) = abs(xR(:,2)-iMGsize);
% Rotate matrix due to stereo_tri needs LeftRight data
xL = xL'; xR = xR';
% Perform stereo triangulation
[Killer.XL,~] = stereo_triangulation(xL,xR,C.om,C.T,C.fc_left,...
    C.cc_left,C.kc_left,C.alpha_c_left,C.fc_right,...
    C.cc_right,C.kc_right,C.alpha_c_right);

% Bring in Data
xL = Droso.C1.Basepts; xR = Droso.C2.Basepts;
% Flip Vertical axis due to matlab image flip
xL(:,2) = abs(xL(:,2)-iMGsize);
xR(:,2) = abs(xR(:,2)-iMGsize);
% Rotate matrix due to stereo_tri needs LeftRight data
xL = xL'; xR = xR';
% Perform stereo triangulation
[Droso.XL,~] = stereo_triangulation(xL,xR,C.om,C.T,C.fc_left,...
    C.cc_left,C.kc_left,C.alpha_c_left,C.fc_right,...
    C.cc_right,C.kc_right,C.alpha_c_right);
clear xL xR C;

%% Plot Data
f3Dtraj = figure('Name','Killer vs Prey 3D trajectory','OuterPosition',cInfo.scrszposFull);
col=hsv(Killer.KillerCatch);
% Plot 3D trajectory
for i = 1:10:size(Killer.XL,2)
    X1 = Killer.XL(1,i); Z1 = Killer.XL(2,i); Y1 = Killer.XL(3,i);
    X2 = Droso.XL(1,i); Z2 = Droso.XL(2,i); Y2 = Droso.XL(3,i); hold all; grid on;
    if i < Killer.KillerCatch || Killer.KillerCatch == i
        if i > Droso.DrosoStart || Droso.DrosoStart == i
            scatter3(X1,Y1,Z1,'MarkerEdgeColor',col(i,:),'SizeData',2);
            scatter3(X2,Y2,Z2,'MarkerEdgeColor',col(i,:),'SizeData',2,...
                'MarkerFaceColor',col(i,:));
            if i > Killer.KillerStart || Killer.KillerStart == i
                plot3([X1,X2],[Y1,Y2],[Z1,Z2],'color',col(i,:));
            end
        end
    end
end
clear i X1 X2 Y1 Y2 Z1 Z2;
axis square;
% Set Azimuth and Elevation angles for the plot
view([45 45]); rotate3d on;

%% Make name for saving Figure
Clock = clock;
Clock = [num2str(Clock(4)),num2str(Clock(5)),num2str(round(Clock(6)))];
Vidname = Killer.C1.Files(1,1).name(1:end-7);
FileName = [Vidname,'_',num2str(Clock),'_3D_trajectory'];
eval(['save ' FileName ' cInfo Droso Killer;']);

% Save Figure as fig and tiff
saveas(f3Dtraj,FileName,'fig');
set(f3Dtraj,'PaperPositionMode','auto');
set(f3Dtraj,'PaperUnits','inches');
set(f3Dtraj,'PaperSize',[20 10]);
eval(['print -dtiff -f1 -r300 ' FileName ';']);
% close all;
end

