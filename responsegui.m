% choice = menu('Plot for this folder only or all subfolders:','this folder only', 'all subfolders');
function response2 = responsegui(name, query1, query2);
figure1 = figure('NumberTitle','off','Name', name,'Position', [810 475 200 130], 'MenuBar', 'none');
button1 = uicontrol('FontSize', 10, 'Style', 'push', 'String', query1, 'Position', [40 20 120 30], 'Callback', @choice);
button2 = uicontrol('FontSize', 10, 'Style', 'push', 'String', query2, 'Position', [40 80 120 30], 'Callback', @choice);
set(gcf, 'Visible','on');
function choice(source,~)
    response1 = get(source, 'String');
    close(gcf)
end
waitfor(gcf);
response2 = response1;
end