function end_point= adjustRayLength(start_point, direction, intersection_point)
   
    intersection_distance = intersection_point - start_point;
    end_point = start_point + norm(intersection_distance) * direction;
    plot_lines(start_point,end_point,'r','-',1);
    plot(end_point(1), end_point(2), 'ro', 'MarkerSize', 8, 'LineWidth', 2);

end