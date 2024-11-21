function s = initializeStruct(varname)

if strcmp(varname, 'ray') || strcmp(varname, 'ipoint') || strcmp(varname, 'angle') || strcmp(varname,'ray_direction')
    s = struct('left', 0, 'right', 0, 'center', 0);
else 

end 
end
