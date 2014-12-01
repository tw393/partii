% choice = menu('Plot for this folder only or all subfolders:','this folder only', 'all subfolders');
function response2 = responsegui();
button1 = uicontrol('Style', 'push', 'String', 'This folder only', 'Position', [20 340 100 50], 'Callback', @choice);
button2 = uicontrol('Style', 'push', 'String', 'All subfolders', 'Position', [20 200 100 50], 'Callback', @choice);
set(gcf, 'Visible','on');
function choice(source,~)
    response1 = get(source, 'String');
    close(gcf)
end
waitfor(gcf);
response2 = response1;
end