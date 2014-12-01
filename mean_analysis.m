%% plots speeds of droso and predator against frame number
line_width = 2;
load(uigetfile('distance_analysis.mat'));
if exist('SpEeD_droso') == 0;
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
%% save figures in single folder
saveas(gcf, ['F:\analysis\' pngstr1], 'png');
saveas(gcf, ['F:\analysis\' figstr1], 'fig');
%% save figures in current folder
saveas(gcf, figstr1, 'fig');
saveas(gcf, pngstr1, 'png');

mean_speed_droso = mean(SpEeD_droso);
mean_speed_killer = mean(SpEeD_killer);
variance_speed_droso = var(SpEeD_droso);
variance_speed_killer = var(SpEeD_killer);
max_speed_droso = max(SpEeD_droso);
max_speed_killer = max(SpEeD_killer);
