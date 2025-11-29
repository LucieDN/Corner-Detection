close all
clear
addpath("Code\")

%% Define parameters

% Gradient computation
sigma = 3;
mesh = 9;

% Mij's grid
U = 20;
V = 2;
p = 0.6;
L = 1;

% Construct a neighbourhood to explore
neighbourhood_limit = 3; % Parametrizes the size of the neighbourhood
neighbourhood =[];
for i=-neighbourhood_limit:neighbourhood_limit
    for j=-neighbourhood_limit:neighbourhood_limit
        neighbourhood = [neighbourhood, [i;j]];
    end
end

%% Load data and manually select first corners

video = VideoReader("Data/vid_in2.mp4");
% if hasFrame(video)
%     first_frame = readFrame(video);
% end

% corners = manual_corner_selection(first_frame) % select it yourself
corners = [345 310 393 434; 987 1125 1137 987]; % White Lego

res = compute_corners_from_video(video, corners(:,:,end), U, V, p, L, sigma, mesh, neighbourhood);

%% Save results as a video
v=VideoWriter("Data/real-world-results.mp4",'MPEG-4')
open(v)
video = VideoReader("Data/vid_in2.mp4");
N = get(video, 'numberOfFrames');
for i=1:N
    frame = readFrame(video);
    imshow(frame);
    hold on
    plot(res(2,:,i),res(1,:,i),"+", "Color","red", 'LineWidth',2, 'MarkerSize',10)
    hold on
    line([res(2,:,i) res(2,1,i)], [res(1,:,i) res(1,1,i)], "Color","white");
    frame_res = getframe(gcf);
    writeVideo(v,frame_res)
end
close(v)