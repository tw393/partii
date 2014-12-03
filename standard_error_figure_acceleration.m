%% plots accelerations of droso and predator against frame number
% figure appearance settings
line_width = 3;
font_size = 20;
bold_tog = 'normal';
font_name = 'default';
%% load data
load(uigetfile('standard_error_matrices.mat'));
if exist('aparams_perframe_droso') == 0;
    fprinf(1, 'Incorrect variables found.\n');
    return
end
%% convert matrix rows into vectors with easy names
killer_mean = aparams_perframe_holco(1,:);
droso_mean = aparams_perframe_droso(1,:);
killer_std = aparams_perframe_holco(2,:);
droso_std = aparams_perframe_droso(2,:);
killer_se = aparams_perframe_holco(3,:);
droso_se = aparams_perframe_droso(3,:);
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
ylabel({'Mean acceleration', '(mm/s^2)'}, 'FontName', font_name, 'FontSize', font_size, 'FontWeight', bold_tog)
title('Acceleration of predator and prey vs. time', 'FontName', font_name, 'FontSize', font_size, 'FontWeight', bold_tog)
l = legend('prey', 'holco', 'location', 'southeast');
set(l, 'FontName', font_name, 'FontSize', font_size - 10);
set(gca, 'TickDir', 'out')
set(gcf, 'Visible', 'on');
%% save figures in current folder
figtitle = sprintf('F:/analysis/figures/error_bars_acceleration_%d_fly.fig', aparams_perframe_holco(4,1));
pngtitle = sprintf('F:/analysis/figures/error_bars_acceleration_%d_fly.png', aparams_perframe_holco(4,1));
saveas(gcf, figtitle, 'fig');
saveas(gcf, pngtitle, 'png');