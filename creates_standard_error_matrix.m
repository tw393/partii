%% creates Matrix Ms and Ma containing speed and acceleration calculations for droso and holco
clear all
cd('F:\analysis\analysis_data');
list = dir('*_distance_analysis.mat');
%% collate data about speed into one matrix
for k = 1:length(list);
    load(list(k).name)
    if min(SpEeD_droso(150:end)) < 20; % removes droso which change direction - approximated as those whose speed dips below 20
        fprintf(1, '%s fly skipped because droso changes direction\n\n', list(k).name);
        continue
    end
    try
    Mad(k,1:length(Acceleration_plain_droso)) = Acceleration_plain_droso;
    Msd(k,1:length(SpEeD_droso)) = SpEeD_droso;
    Mah(k,1:length(Acceleration_plain_killer)) = Acceleration_plain_killer;
    Msh(k,1:length(SpEeD_killer)) = SpEeD_killer;
    catch message
        fprintf(1,'%s\n',message.message)
        continue
    end
    clearvars('-except', 'k', 'list', 'Msd', 'Mad', 'Msh', 'Mah')
end

%% create logical index for calculating the mean ignoring zeros
% because different flys are different lengths of frame number
% and therefore have trailing zeros in a 718 long matrix
logMsd = logical(Msd);
logMad = logical(Mad);
logMsh = logical(Msh);
logMah = logical(Mah);
%% creates a matrix where       (1,k) = mean of speeds of all flies at frame k
%                               (2,k) = standard deviation of speeds of all flies at frame k
%                               (3,k) = standard error ...
%                               (4,k) = sum of flies used ...
                            
for k = 1:length(Msd);
    slogical_column = logMsd(:,k);
    smean_column = mean(Msd(slogical_column,k));
    sstd_column = std(Msd(slogical_column,k));
    ssum_column = sum(logMsd(:,k));
    sparams_perframe_droso(1,k) = smean_column;
    sparams_perframe_droso(2,k) = sstd_column;
    sparams_perframe_droso(3,k) = sstd_column / sqrt(ssum_column);
    sparams_perframe_droso(4,k) = ssum_column;
end
for k = 1:length(Mad);
    alogical_column = logMad(:,k);
    amean_column = mean(Mad(alogical_column,k));
    astd_column = std(Mad(alogical_column,k));
    asum_column = sum(logMad(:,k));
    aparams_perframe_droso(1,k) = amean_column;
    aparams_perframe_droso(2,k) = astd_column;
    aparams_perframe_droso(3,k) = astd_column / sqrt(asum_column);
    aparams_perframe_droso(4,k) = asum_column;
end
clearvars('-except', 'logMah', 'logMsh', 'logMsd', 'logMad', 'Mad', 'Msd', 'Mah', 'Msh', 'sparams_perframe_droso', 'aparams_perframe_droso', 'sparams_perframe_holco', 'aparams_perframe_holco');
for k = 1:length(Msh);
    slogical_column = logMsh(:,k);
    smean_column = mean(Msh(slogical_column,k));
    sstd_column = std(Msh(slogical_column,k));
    ssum_column = sum(logMsh(:,k));
    sparams_perframe_holco(1,k) = smean_column;
    sparams_perframe_holco(2,k) = sstd_column;
    sparams_perframe_holco(3,k) = sstd_column / sqrt(ssum_column);
    sparams_perframe_holco(4,k) = ssum_column;
end
for k = 1:length(Mah);
    alogical_column = logMah(:,k);
    amean_column = mean(Mah(alogical_column,k));
    astd_column = std(Mah(alogical_column,k));
    asum_column = sum(logMah(:,k));
    aparams_perframe_holco(1,k) = amean_column;
    aparams_perframe_holco(2,k) = astd_column;
    aparams_perframe_holco(3,k) = astd_column / sqrt(asum_column);
    aparams_perframe_holco(4,k) = asum_column;
end
clearvars('-except', 'logMa', 'logMs', 'Mad', 'Mah', 'Msd', 'Msh', 'sparams_perframe_droso', 'aparams_perframe_droso', 'sparams_perframe_holco', 'aparams_perframe_holco');
save('standard_error_matrices.mat','Msd', 'Mad', 'Msh', 'Mah', 'sparams_perframe_droso', 'aparams_perframe_droso', 'sparams_perframe_holco', 'aparams_perframe_holco');
