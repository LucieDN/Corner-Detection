function C_criteria = compute_C_criteria(actual_gradient, theoretical_gradient, Mij)
    C_criteria = [];
    for border=1:4
        % Compute C criteria for current segment
        C = 0;
        Mij_points = Mij(:,:,border); % Get Mij position for the current segment

        for point=1:size(Mij,2) % Iterate on each point in Mij positions
            x = Mij_points(1, point); % X-axis component of current Mij point
            y = Mij_points(2, point); % Y-axis component of current Mij point

            % Get gradients values for the current point
            vect_actual_gradient = [actual_gradient(x,y,1) ; actual_gradient(x,y,2)];
            vect_theoretical_gradient = [theoretical_gradient(x,y,1) ; theoretical_gradient(x,y,2)];

            % Compute C criteria
            score = abs(dot(vect_actual_gradient, vect_theoretical_gradient)/(norm(vect_theoretical_gradient)*norm(vect_actual_gradient)));
            if dot(vect_actual_gradient, vect_theoretical_gradient)==0 % Fix the undefined case "one of the gradient is 0"
                score = 0;
            end 
            C = C + 1 - score; % Sum for each Mij point of this segment
            
        end
        C_criteria = [C_criteria C/size(Mij,2)]; % Keep the mean of C criteria on Mij points for each segment
    end