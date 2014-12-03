%% plots speeds of droso and predator against frame number
%% figure appearance settings
line_width = 3;
font_size = 28;
bold_tog = 'normal';
font_name = 'default';
%% load data
% load(uigetfile('distance_analysis.mat'));
% if exist('SpEeD_droso') == 0;
%     fprinf(1, 'Incorrect variables found.\n');
%     return
% end
%% create figure
figure('MenuBar', 'none', 'Position', [360 215 1200 650]);
set(gcf, 'Visible', 'off');

%% define series
x = 1:27;
speed_series_holco = holco_array(:,1);
speed_series_droso = droso_array(:,1);


%% plot multiple speeds on one figure
bar(x, speed_series_holco,0.8, 'FaceColor', [0.2,0.2,0.5]);
hold on;
bar(x, speed_series_droso,0.4, 'FaceColor',[1,0.196,0.196], 'EdgeColor', [1,0.196,0.196]);
hold off
% for k = 1:length(droso_array);
% bar(k,droso_array(k,1),'r');
% end
% p2 = plot(SpEeD_killer, 'LineWidth', line_width, 'Color', 'b');
xlabel({'Fly number'}, 'FontName', font_name, 'FontSize', font_size, 'FontWeight', bold_tog)
ylabel({'Mean speed during run', '(mm/s)'}, 'FontName', font_name, 'FontSize', font_size, 'FontWeight', bold_tog)
title('Mean speed of prey', 'FontName', font_name, 'FontSize', font_size, 'FontWeight', bold_tog)
l = legend('holco', 'droso');
set(l, 'FontName', font_name, 'FontSize', font_size - 14);
set(gca, 'TickDir', 'out');
% set(gca, 'XTick', 1:4:30);
set(gcf, 'Visible', 'on');
%% get details for figure name and save figures in collective folder
str2 = pwd();
str2 = strrep(str2, '\', '-');
q = strfind(str2, 'Fly');
w = strfind(str2, '_calib');
substr1 = str2(q:q + 4);
if strcmp(str2(w - 1), 'w') == 1;
    substr2 = str2(w - 3:w + 5);
elseif strcmp(str2(w - 1), 'd') == 1;
    substr2 = str2(w - 3:w + 5);
else
    substr2 = str2(w - 1:w + 5);
end

pngstr1 = sprintf('%s_%s_mean_speeds.png', substr1, substr2);
figstr1 = sprintf('%s_%s_mean_speeds.fig', substr1, substr2);
%% save figures in current folder
saveas(gcf, figstr1, 'fig');
saveas(gcf, pngstr1, 'png');
%% save some variables 
% droso.mean_speed = mean(SpEeD_droso);
% killer.mean_speed = mean(SpEeD_killer);
% droso.variance_speed = var(SpEeD_droso);
% killer.variance_speed = var(SpEeD_killer);
% droso.max_speed = max(SpEeD_droso);
% killer.max_speed = max(SpEeD_killer);
% droso.mean_acceleration = mean(Acceleration_plain_droso);
% killer.mean_acceleration = mean(Acceleration_plain_killer);
% droso.variance_acceleration = var(Acceleration_plain_droso);
% killer.variance_acceleration = var(Acceleration_plain_killer);
% droso.max_acceleration = max(Acceleration_plain_droso);
% killer.max_acceleration = max(Acceleration_plain_killer);

% save('analysis.mat', 'droso', 'killer');