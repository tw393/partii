%% figure options
font_name = 'Arial';
font_size = 12;
bold_tog = 'bold';

%% get distance between bead and fly at takeoff
% load each *_distance_analysis.mat
% save into matrix    c1 = distance to fly at start of head flick
%                     c2 = distance at end of head flick
%                     c3 = distance at takeoff
%                     c4 = duration of head flick
%                     c5 = time between start of head flick and takeoff
%                     c6 = time betweeen end of head flick and takeoff
%                     c7 = time to catch
% plot each of each versus distance
%% get variables
cd('F:\analysis\analysis_data');
list = dir('*_distance_analysis.mat');
%% collate data into one matrix
for k = 1:length(list);
    load(list(k).name)
    try
    diffx_head_flick_s = recon_CuRvEdroso(holcoheadmove_frames(1),1) - recon_CuRvEkiller(holcoheadmove_frames(1),1);
    diffy_head_flick_s = recon_CuRvEdroso(holcoheadmove_frames(1),2) - recon_CuRvEkiller(holcoheadmove_frames(1),2);
    diffz_head_flick_s = recon_CuRvEdroso(holcoheadmove_frames(1),3) - recon_CuRvEkiller(holcoheadmove_frames(1),3);
    diffx_head_flick_e = recon_CuRvEdroso(holcoheadmove_frames(2),1) - recon_CuRvEkiller(holcoheadmove_frames(2),1);
    diffy_head_flick_e = recon_CuRvEdroso(holcoheadmove_frames(2),2) - recon_CuRvEkiller(holcoheadmove_frames(2),2);
    diffz_head_flick_e = recon_CuRvEdroso(holcoheadmove_frames(2),3) - recon_CuRvEkiller(holcoheadmove_frames(2),3);
    diffx_takeoff = recon_CuRvEdroso(Killer_1stmovingframe,1) - recon_CuRvEkiller(Killer_1stmovingframe,1);
    diffy_takeoff = recon_CuRvEdroso(Killer_1stmovingframe,2) - recon_CuRvEkiller(Killer_1stmovingframe,2);
    diffz_takeoff = recon_CuRvEdroso(Killer_1stmovingframe,3) - recon_CuRvEkiller(Killer_1stmovingframe,3);
    
    Ma(k,1) = sqrt(diffx_head_flick_s.^2 + diffy_head_flick_s.^2 + diffz_head_flick_s.^2);
    Ma(k,2) = sqrt(diffx_head_flick_e.^2 + diffy_head_flick_e.^2 + diffz_head_flick_e.^2);
    Ma(k,3) = sqrt(diffx_takeoff.^2 + diffy_takeoff.^2 + diffz_takeoff.^2);
    Ma(k,4) = holcoheadmove_frames(2) - holcoheadmove_frames(1);
    Ma(k,5) = Killer_1stmovingframe - holcoheadmove_frames(1);
    Ma(k,6) = Killer_1stmovingframe - holcoheadmove_frames(2);  
    Ma(k,7) = killer_catchframe - Killer_1stmovingframe;
    fprintf(1, 'pass %d is %s\n', k, list(k).name)
    catch message
        fprintf(1,'Pass %d\n%s\n%s\n\n',k, list(k).name, message.message)
        clearvars('-except', 'k', 'list', 'Ma', 'font_name', 'font_size', 'bold_tog');
        continue
    end
    clearvars('-except', 'k', 'list', 'Ma', 'font_name', 'font_size', 'bold_tog');
end
%% create logical index for calculating the mean ignoring zeros
% because some flies have no data
logMa = logical(Ma);
%% what to plot
query  = {sprintf('4 = duration of head flick\n5 = time for start of flick --> takeoff\n6 = time for end of flick --> takeoff\n7 = time to catch')...
            , sprintf('1 = distance to fly at start of head flick\n2 = distance at end of head flick\n3 = distance at takeoff')};
answer = {'answer1', 'answer2'};
answer = inputdlg(query, 'y vs x');
answer1 = str2num(answer{1});
answer2 = str2num(answer{2});
%% figure labels
switch answer1
    case 4
        yaxis_label = {'Duration of head flick', '/ms'};
        title1 = yaxis_label{1};
    case 5
        yaxis_label = {'Start of head flick to takeoff', '/ms'};
        title1 = yaxis_label{1};

    case 6
        yaxis_label = {'End of head flick to takeoff', '/ms'};
        title1 = yaxis_label{1};
    case 7
        yaxis_label = {'Duration of flight', '/ms'};
        title1 = yaxis_label{1};
end
switch answer2
    case 1
        xaxis_label = {'Distance to prey','(at start of head flick) /mm'};
        title2 = xaxis_label{1};
    case 2
        xaxis_label = {'Distance to prey','(at end of head flick) /mm'};
        title2 = xaxis_label{1};
    case 3
        xaxis_label = {'Distance to prey','(at takeoff) /mm'};
        title2 = xaxis_label{1};
end
%% y axis
index_column = logMa(:,answer1);
data_column = Ma(:,answer1);
indexed_data = data_column(index_column);
y = indexed_data;
%% x axis
index_column2 = logMa(:,answer2);
data_column2 = Ma(:,answer2);
indexed_data2 = data_column2(index_column2);
x = indexed_data2;
%% create figure
f = figure('MenuBar', 'none', 'Position', [360 215 1200 650]);
hold on;
set(gcf, 'Visible', 'off');
p1 = scatter(x, y, 'o', 'r');
title(sprintf('%s vs. %s', title1, title2), 'FontName', font_name, 'FontSize', font_size, 'FontWeight', bold_tog)
xlabel(xaxis_label, 'FontName', font_name, 'FontSize', font_size, 'FontWeight', bold_tog)
ylabel(yaxis_label, 'FontName', font_name, 'FontSize', font_size, 'FontWeight', bold_tog)
set(f, 'Visible','on');
%% save figures in current folder
t = clock();
figtitle = sprintf('F:/analysis/figures/%.1f_%s_%s.fig', t(6), title1, title2);
pngtitle = sprintf('F:/analysis/figures/%.1f_%s_%s.png', t(6), title1, title2);
saveas(gcf, figtitle, 'fig');
saveas(gcf, pngtitle, 'png');

f = fopen(sprintf('F:/analysis/figures/%.1f flies used.txt', t(6)), 'a+');
for i = 1:length(list)
fprintf(f, '%s\n\n', list(i).name);
end
fclose(f);