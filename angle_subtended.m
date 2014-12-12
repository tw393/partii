%% information needed: takeoff frame; distance at takeoff; bead size; 
% calculation is:
% bead radius = x
% distance from fly to bead = h
% angle subtended by half triangle = a
% full angle subtended is 2 * a
% angle = tan-1 of x / h
% angle = atan(x / h)
% angle in deg = rad2deg(atan(x/h))
%% get bead radius
x = inputdlg('bead radius?');
x = str2double(x);
%% get numbers needed
takeoff_frame = killertakeoff{1};
% convert to double
takeoff_frame = str2double(takeoff_frame);
% locations at this frame
droso_loc = recon_CuRvEdroso(1,:);
holco_loc = recon_CuRvEkiller(1,:);
% distance between these two points = root of the sum of the square of the
% differences
differences = droso_loc - holco_loc;
clear droso_loc holco_loc
squared = differences.^2;
clear differences
summed = sum(squared);
clear squared
rooted = sqrt(summed);
clear summed
distance = rooted;
clear rooted
h = distance; % as defined at the start
clear distance
%% angle
rad_angle = 2 * atan(x / h);
deg_angle = rad2deg(rad_angle);
