function lwe_direction = getRay(gamma,ray_name)
switch ray_name
    case 'right'
        lwe_direction = [sind(gamma); cosd(gamma)];
    case 'left'
        lwe_direction = [sind(-gamma); cosd(-gamma)];
    case 'center'
        gamma = 0;
        lwe_direction = [sind(gamma); cosd(gamma)];
    otherwise
       
end

end 