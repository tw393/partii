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
    catch message
        fprintf(1,'Pass %d\n%s\n%s\n\n',k, list(k).name, message.message)
        clearvars('-except', 'k', 'list', 'Ma')
        continue
    end
    clearvars('-except', 'k', 'list', 'Ma')
end
%% create logical index for calculating the mean ignoring zeros
% because some flies have no data
logMa = logical(Ma);
%% c7 vs c3
index_column = logMa(:,5);
data_column = Ma(:,5);
indexed_data = data_column(index_column);
y = indexed_data;
%% create figure
f = figure('Visible','off','MenuBar','none');
p1 = bar(1:length(indexed_data), y);
set(f, 'Visible','on');