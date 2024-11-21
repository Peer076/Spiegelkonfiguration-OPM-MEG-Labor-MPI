function  lwa_direction = getReflection(beta, angle, mirror_name)
    
R = [cosd(beta) -sind(beta); sind(beta) cosd(beta)];

    
switch mirror_name
    case '1.Spiegel'
         lwa_direction = R * [cosd(angle); -sind(angle)];
  
    case '2.Spiegel'
         lwa_direction = R * [cosd(angle); sind(angle)]; 
        
    otherwise
      
        % No Reflection @ Screen
end

end