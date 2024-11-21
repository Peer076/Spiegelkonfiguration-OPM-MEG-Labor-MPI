function  [intersection_point,incident_angle] =getIntersectionPoint(mir_start,mir_vektor,lwe_direction,lwe_start)

A = [lwe_direction, -mir_vektor];
b = mir_start - lwe_start;
intersection_t = A\b; 
intersection_point = lwe_start + intersection_t(1) * lwe_direction;
incident_angle = acosd(dot(lwe_direction,mir_vektor)/(norm(lwe_direction)*norm(mir_vektor)));
    
end