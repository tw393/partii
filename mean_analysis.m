%% plots speeds of droso and predator against frame number
line_width = 2;
line_length = 40;
arrow_annotation_switch = 'yes'; %choose whether to label the catch
switch arrow_annotation_switch;
    case 'yes'
        catch_frame = 1+ killer_catchframe - Killer_1stmovingframe;
        xa1 = catch_frame + line_length;
        xa2 = catch_frame;
        ya1 = SpEeD_killer(xa2) + line_length + 10;
        ya2 = ya1 - line_length - 10;
        anno_line_width = 1.5;
        anno_head_style = 'vback3';
end



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
% ticks = get(ax, 'XTick');
% lower_limit = ticks < catch_frame;
% upper_limit = ticks > catch_frame;
% lower_half = [ticks(lower_limit)];
% number_lower = length(lower_half);
% number_higher = length(upper_half);
% lower_half(1:end-1);
% upper_half = [ticks(upper_limit)];
% upper_half = upper_half(2:end);
% new_ticks = [lower_half catch_frame upper_half];
% set(ax, 'XTick', new_ticks);
% % set(ax, 'XTickLabel', {
switch arrow_annotation_switch;
    case 'yes'
        a1 = annotation('arrow', xaf, yaf);
        str1 = 'catch';
        text(xa1 + 5, ya1 + 10, str1, 'FontSize', 11)
        set(a1, 'LineWidth', anno_line_width, 'HeadStyle', anno_head_style);
end

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
