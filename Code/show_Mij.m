function show_Mij(Mij, frame, corners)
    figure, imshow(frame);
    % Show Mij's positions
    nbcolonne = size(Mij(:, :, 1),2);
    for segment=1:4
        for colonne=1:nbcolonne
            hold on
            Mij_h = plot(Mij(2, colonne, segment),Mij(1,colonne, segment), 'r+', 'MarkerSize', 3, 'LineWidth', 1);
        end
    end
    hold on
    % Show the parallelogram again
    parallelogram_h = line([corners(2,:) corners(2,1)], [corners(1,:) corners(1,1)],'Color',[0,0.7,0.9],'LineWidth',2);
    legend([Mij_h, parallelogram_h], "Points of interest", "Current parallelogram");
end

