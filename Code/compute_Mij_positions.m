function Mij = compute_Mij_positions(U, V, p, L, corners)
    Mij = [];
    for seg=1:4
       Mi = [];
       for v=-V:V
            for u=-U:U
                P1 = corners(:,seg);
                P2 = corners(:,mod(seg,4)+1); 
                vector = (P2-P1)/norm(P2-P1);
                point = (P2+P1)/2 + u*p/(2*U)*(P2-P1) + v*L*[-vector(2); vector(1)];
                Mi = [Mi round(point)];
            end
       end
       Mij = cat(3, Mij, Mi);
    end
end

