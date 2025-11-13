function res = show_gradient(image, gradient, Mij)
    figure, imshow(image);
    res = 0;
    for segment=1:4
        for colonne=1:size(Mij(:,:,segment),2)
            x = Mij(2, colonne, segment); %colonne
            y = Mij(1, colonne, segment); %ligne
            hold on
            gradient_arrows = quiver(x, y, 10*gradient(y,x,1)/norm(gradient(y,x,1)), 10*gradient(y,x,2)/norm(gradient(y,x,2)), 'b-' , 'MarkerSize', 5, 'LineWidth', 0.5);
        end
    end
    legend(gradient_arrows, "Gradients");
end

