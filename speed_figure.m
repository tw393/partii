%% plots speeds of droso and predator against frame number
line_width = 2;
load(uigetfile('distance_analysis.mat'));
if exist('SpEeD_droso') == 0;
    fprinf(1, 'Incorrect variables found.\n');
    return
end
%%
figure('MenuBar', 'none');
hold on;
set(gcf, 'Visible', 'off');
p1 = plot(SpEeD_droso, 'LineWidth', line_width, 'Color', 'r');
p2 = plot(SpEeD_killer, 'LineWidth', line_width, 'Color', 'b');
xlabel({'Frame number'}, 'FontSize', 12, 'FontWeight', 'bold')
ylabel({'Speed of object', '(mm/s)'}, 'FontSize', 12, 'FontWeight', 'bold')
title('Graph of speeds of predator and prey', 'FontSize', 12, 'FontWeight', 'bold')
legend('Speed of prey', 'Speed of predator', 'location', 'southeast')
set(gca, 'TickDir', 'out')
set(gcf, 'Visible', 'on');
%% get details for figure name and save figures in collective folder
str2 = genpath(pwd);
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

pngstr1 = sprintf('%s_%s_speed.png', substr1, substr2);
figstr1 = sprintf('%s_%s_speed.fig', substr1, substr2);

saveas(gcf, ['F:\analysis\' pngstr1], 'png');
saveas(gcf, ['F:\analysis\' figstr1], 'fig');
%% save figures in current folder
saveas(gcf, figstr1, 'fig');
saveas(gcf, pngstr1, 'png');
%% save some variables 
droso.mean_speed = mean(SpEeD_droso);
killer.mean_speed = mean(SpEeD_killer);
droso.variance_speed = var(SpEeD_droso);
killer.variance_speed = var(SpEeD_killer);
droso.max_speed = max(SpEeD_droso);
killer.max_speed = max(SpEeD_killer);
droso.mean_acceleration = mean(Acceleration_plain_droso);
killer.mean_acceleration = mean(Acceleration_plain_killer);
droso.variance_acceleration = var(Acceleration_plain_droso);
killer.variance_acceleration = var(Acceleration_plain_killer);
droso.max_acceleration = max(Acceleration_plain_droso);
killer.max_acceleration = max(Acceleration_plain_killer);

save('analysis.mat', 'droso', 'killer');