%% plots speeds of droso and predator against frame number
%% garther data into matrix
%files contained in F:/analysis/analysis_data
list = dir('*_distance_analysis.mat');
M = zeros(35,718); %718 is the length of the longest video in frames
killer_mean_std_per_frame = zeros(4,718); % this matrix will contain the 
% data we pull from the individual *distance_analysis.mat files
%% collate data about speed into one matrix
for k = 1:length(list);
    load(list(k).name)
    try
    M(k,1:length(Acceleration_plain_droso)) = Acceleration_plain_droso;
    catch message
        fprintf(1,'%s\n',message.message)
        continue
    end
    clearvars('-except', 'k', 'list', 'M')
end

%% create logical index for calculating the mean ignoring zeros
% because different flys are different lengths of frame number
% and therefore have trailing zeros in a 718 long matrix
logM = logical(M);
%% creates a matrix where       (1,k) = mean of speeds of all flies at frame k
%                               (2,k) = standard deviation of speeds of all flies at frame k
%                               (3,k) = standard error ...
%                               (4,k) = sum of flies used ...
                            
for k = 1:length(M);
    logical_column = logM(:,k);
    mean_column = mean(M(logical_column,k));
    std_column = std(M(logical_column,k));
    sum_column = sum(logM(:,k));
    adroso_mean_std_per_frame(1,k) = mean_column;
    adroso_mean_std_per_frame(2,k) = std_column;
    adroso_mean_std_per_frame(3,k) = std_column / sqrt(sum_column);
    adroso_mean_std_per_frame(4,k) = sum_column;
end
clearvars('-except', 'logM', 'M', 'adroso_mean_std_per_frame');


%%
%% NEXT SECTION
%%
%% figure appearance settings
line_width = 3;
font_size = 20;
bold_tog = 'normal';
font_name = 'default';
%% load data
load(uigetfile('matrix_data.mat'));
if exist('droso_mean_std_per_frame') == 0;
    fprinf(1, 'Incorrect variables found.\n');
    return
end
%% convert matrix rows into vectors with easy names
killer_mean = killer_mean_std_per_frame(1,:);
droso_mean = droso_mean_std_per_frame(1,:);
killer_std = killer_mean_std_per_frame(2,:);
droso_std = droso_mean_std_per_frame(2,:);
killer_se = killer_mean_std_per_frame(3,:);
droso_se = droso_mean_std_per_frame(3,:);
%% only plot error every 20th frame
index = (mod(1:length(droso_mean), 40) > 0);
err_droso_mean = droso_mean;
err_droso_se = droso_se;
err_killer_mean = killer_mean;
err_killer_se = killer_se;
err_droso_mean(index) = NaN;
err_droso_se(index) = NaN;
err_killer_mean(index) = NaN;
err_killer_se(index) = NaN;
%% make figure
f = figure('MenuBar', 'none', 'Position', [360 215 1200 650]);
hold on;
set(gcf, 'Visible', 'off');
p1 = plot(droso_mean, 'LineWidth', line_width, 'Color', 'r');
p2 = plot(killer_mean, 'LineWidth', line_width, 'Color', 'b');
errorbar(err_droso_mean, err_droso_se, 'Color', 'k', 'LineWidth', 1.25);
errorbar(err_killer_mean, err_killer_se, 'Color', 'k', 'LineWidth', 1.25);
xlabel({'Time since takeoff (ms)'}, 'FontName', font_name, 'FontSize', font_size, 'FontWeight', bold_tog)
ylabel({'Mean speed', '(mm/s)'}, 'FontName', font_name, 'FontSize', font_size, 'FontWeight', bold_tog)
title('Speed of predator and prey vs. time', 'FontName', font_name, 'FontSize', font_size, 'FontWeight', bold_tog)
l = legend('prey', 'holco', 'location', 'southeast');
set(l, 'FontName', font_name, 'FontSize', font_size - 10);
set(gca, 'TickDir', 'out')
set(gcf, 'Visible', 'on');
%% save figures in current folder
saveas(gcf, 'F:/analysis/figures/average_speed.fig', 'fig');
saveas(gcf, 'F:/analysis/figures/average_speed.png', 'png');