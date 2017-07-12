function plot2funcTimeseries(...
    figuresHandler,aTitle,aLabel,...
    time,y1,y2,...
    yLabel,y1Legend,y2Legend)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here

%% Plot joint trajectories
figH = figure('Name',aTitle,'WindowStyle', 'docked');

figuresHandler.addFigure(figH,aLabel); % Add figure to the figure handler

% If the figure is not docked, use the below command to display it full
% screen.
%set(gcf,'PositionMode','manual','Units','normalized','outerposition',[0 0 1 1]);
title(aTitle,'Fontsize',16,'FontWeight','bold');
hold on

plot(time,y1,'b','lineWidth',1.0);
plot(time,y2,'r','lineWidth',2.0);

hold off
grid ON;
xlabel('Time (sec)','Fontsize',12);
ylabel(yLabel,'Fontsize',12);
legend('Location','BestOutside',y1Legend,y2Legend);
set(gca,'FontSize',12);

end

