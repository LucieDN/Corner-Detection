function grad = compute_gradient(image, sigma, mesh)
    [X,Y]=meshgrid(-mesh:mesh);
    Hx = -X.*exp(-(X.^2+Y.^2)/(2*sigma^2));
    Hy = -Y.*exp(-(X.^2+Y.^2)/(2*sigma^2));

    if (size(image, 3) == 3)
        L = image(:,:,1)/3+image(:,:,2)/3+image(:,:,3)/3;
    else
        L = image(:,:);
    end

    Gx = conv2(L,Hx,'same');
    Gy = conv2(L,Hy,'same');
    grad = cat(3, Gx, Gy);
end

