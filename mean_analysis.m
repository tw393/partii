%% plots speeds of droso and predator against frame number
line_width = 2;

%%
f2 = figure();
hold on;
set(f2, 'Visible', 'off');
p1 = plot(SpEeD_droso, 'LineWidth', line_width, 'Color', 'r');
p2 = plot(SpEeD_killer, 'LineWidth', line_width, 'Color', 'b');
xlabel({'Frame number'}, 'FontSize', 12, 'FontWeight', 'bold')
ylabel({'Speed of object', '(mm/s)'}, 'FontSize', 12, 'FontWeight', 'bold')
title('Graph of speeds of predator and prey', 'FontSize', 12, 'FontWeight', 'bold')
legend('Speed of prey', 'Speed of predator', 'location', 'southeast')
set(gca, 'TickDir', 'out')
ax = gca;
[xaf, yaf] = ds2nfu([xa1, xa2], [ya1, ya2]);


set(f2, 'Visible', 'on');
%% save figure as png and fig
saveas(f2, 'speed_holco_versus_droso.png', 'png');
saveas(f2, 'speed_holco_versu_droso.fig', 'fig');
% pause(9);
% close()
mean_speed_droso = mean(SpEeD_droso);
mean_speed_killer = mean(SpEeD_killer);
variance_speed_droso = var(SpEeD_droso);
variance_speed_killer = var(SpEeD_killer);
