function [best_candidates_matrix] = compute_corners_from_video(video, corners, U, V, p, L, sigma, mesh, neighbourhood)

    best_candidates_matrix = [corners];
    best_candidates = corners;
    N = get(video, 'numberOfFrames');
    
    for i=1:N
        i
        if hasFrame(video)
            current_frame = readFrame(video);

            % Compute the optimal corners for the current frame
            %best_candidates_matrix(:,:,end)
            best_candidates = compute_corners_from_image(current_frame, best_candidates, U, V, p, L, sigma, mesh, neighbourhood);

            % Record it in matrix
            best_candidates_matrix = cat(3, best_candidates_matrix, best_candidates);
        end
    end

end
