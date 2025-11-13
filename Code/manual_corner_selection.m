function corners = manual_corner_selection(firstImage)
    % This function ask user to manually select the corners for the image given as input
    close all
    figure, imshow(firstImage)

    [x,y] = ginput(4);
    x=fix(x);
    y=fix(y);
    corners = [y.' ; x.']; % Transpose for consistency
    line([corners(2,:) corners(2,1)], [corners(1,:) corners(1,1)],'Color',[0,0.7,0.9],'LineWidth',2) % Plot the selected rectangle
    hold on
    plot(corners(2,:), corners(1,:), "o", "Color", "red", 'LineWidth',2)
    legend('Reconstructed parallelogram', "Manually selected corners")
end