%% plots acceleration of droso and predator against frame number
line_width = 2;
load(uigetfile('distance_analysis.mat'));
if exist('SpEeD_droso') == 0;
    return
end
%%
figure('MenuBar', 'none');
hold on;
set(gcf, 'Visible', 'off');
p1 = plot(Acceleration_plain_droso, 'LineWidth', line_width, 'Color', 'r');
p2 = plot(Acceleration_plain_killer, 'LineWidth', line_width, 'Color', 'b');
xlabel({'Frame number'}, 'FontSize', 12, 'FontWeight', 'bold')
ylabel({'Acceleration of object', '(mm/s^2)'}, 'FontSize', 12, 'FontWeight', 'bold')
title('Graph of accelerations of predator and prey', 'FontSize', 12, 'FontWeight', 'bold')
legend('Acceleration of prey', 'Acceleration of predator', 'location', 'southeast')
set(gca, 'TickDir', 'out')

set(gcf, 'Visible', 'on');