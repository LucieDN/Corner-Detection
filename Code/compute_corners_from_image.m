function [best_candidates] = compute_corners_from_image(image, corners, U, V, p, L, sigma, mesh, neighbourhood)
    
    % Reframe for computation optimization
    ymin = max(min(corners(1,1),corners(1,2))-20, 1);
    ymax = min(max(corners(1,3),corners(1,4))+20, size(image, 1));
    xmin = max(min(corners(2,1),corners(2,4))-20, 1);
    xmax = min(max(corners(2,2),corners(2,3))+20, size(image, 2));
    frame = image(ymin:ymax, xmin:xmax, :);

    % Update corner positions to reframed image
    corners(1,:) = corners(1,:)-ymin;
    corners(2,:) = corners(2,:)-xmin;

    % Create a virtual image for theoretical gradient computation
    virtual_image = compute_virtual_image(frame(:,:,1), corners(2,:), corners(1,:));

    % Compute Mij's grid
    Mij = compute_Mij_positions(U,V,p,L,corners);

    % Gradient computation
    theoretical_gradient = compute_gradient(virtual_image,sigma,mesh);
    actual_gradient = compute_gradient(frame,sigma,mesh);

    % Initial C criterion
    C_criterion_per_segment = compute_C_criterion(actual_gradient, theoretical_gradient, Mij);
    C_criterion = sum(C_criterion_per_segment)/4;

    % Initialize to original selected points
    best_candidates = corners(:,:);

    % Initialize iteration variables
    is_still_optimizing = true;
    iteration = 0;
    C_x_axis = 0;

    % Optimize C criterion
    while is_still_optimizing
        is_still_optimizing = false; % Update to true when finding a better position than current
        
        % Find the worst corner position
        corner_to_fix = find(C_criterion_per_segment==max(C_criterion_per_segment));
        if C_criterion_per_segment(mod(corner_to_fix-2,4)+1) < C_criterion_per_segment(mod(corner_to_fix,4)+1)
            corner_to_fix = mod(corner_to_fix,4)+1;
        end

        for neighbour=neighbourhood
            % Update iterative variables
            iteration = iteration + 1;
            intermediate_corners = best_candidates;

            % Choose a neighbour of corner_to_fix in predefined neighbourhood to explore
            intermediate_corners(:, corner_to_fix) = best_candidates(:, corner_to_fix) + neighbour;

            if ([0;0] < max(intermediate_corners,[],2)) & (max(intermediate_corners,[],2) < size(frame, [1 2]).')
                % Recompute actual gradient for this neighbour and the criterion associated with this change
                intermediate_Mij = compute_Mij_positions(U, V, p, L, intermediate_corners);
                intermediate_virtual_image = compute_virtual_image(frame(:, :, 1), intermediate_corners(2,:), intermediate_corners(1,:));
                intermediate_theoretical_gradient = compute_gradient(intermediate_virtual_image,sigma,mesh);
                
                % Compute C criterion for the new positions
                intermediate_C_criterion_per_segment = compute_C_criterion(actual_gradient, intermediate_theoretical_gradient, intermediate_Mij);
                intermediate_C_criterion = sum(intermediate_C_criterion_per_segment)/4;

                % If criterion is lower, update the intermediate positions as the best candidates
                if (intermediate_C_criterion<C_criterion(end))
                    best_candidates = intermediate_corners;
                    C_criterion_per_segment = intermediate_C_criterion_per_segment;
                    C_criterion = [C_criterion intermediate_C_criterion];
                    C_x_axis = [C_x_axis iteration];
                    is_still_optimizing = true; % Found a better position than current
                end
            end
        end
    end

    % Update corners to original frame
    best_candidates(1,:) = best_candidates(1,:) + ymin;
    best_candidates(2,:) = best_candidates(2,:) + xmin;

end