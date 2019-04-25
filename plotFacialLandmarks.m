function [p] = plotFacialLandmarks(landMarkXY, titleStr)
% Plot 68 facial landmarks line based on provided X, Y point

%figure();
% Line style of drawing face.
lineStyle = '-b';

% Hold on for multiple plotting.
hold on;
axis off
% initail x and y value
landMarkX = landMarkXY(:, 1);
landMarkY = landMarkXY(:, 2);

% original y is upside down landmarn then subtract from 128 which is full
% scale

landMarkY = 128 - landMarkY;

% face chin shape
plot(landMarkX(1:17), landMarkY(1:17), lineStyle);

% eyebrow
plot(landMarkX(18:22), landMarkY(18:22), lineStyle);
plot(landMarkX(23:27), landMarkY(23:27), lineStyle);

% nose
plot(landMarkX(28:31), landMarkY(28:31), lineStyle);
plot(landMarkX(32:36), landMarkY(32:36),lineStyle);

% left eye
plot(landMarkX(37:42), landMarkY(37:42), lineStyle);
plot(landMarkX([42 37]), landMarkY([42 37]), lineStyle);


% right eye
plot(landMarkX(43:48), landMarkY(43:48), lineStyle);
plot(landMarkX([48 43]), landMarkY([48 43]), lineStyle);

%lips outer
plot(landMarkX(49:60), landMarkY(49:60), lineStyle);
plot(landMarkX([49 60]), landMarkY([49 60]), lineStyle);
%lips inner
plot(landMarkX(61:68), landMarkY(61:68), lineStyle);
p = plot(landMarkX([68 61]), landMarkY([68 61]), lineStyle);

title(titleStr);
hold off;

end

