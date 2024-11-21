function getlabel(arrow_start,arrow_end,rotation,orientation)

x_mid = (arrow_start(1) + arrow_end(1)) / 2;
y_mid = (arrow_start(2) + arrow_end(2)) / 2;
label_text = sprintf("%4.0f mm", norm(arrow_end-arrow_start));  

arrow_color = "#A2142F"; 
arrow_scale_factor = 0.5; 

switch orientation

    case 'h'
    offset=[0;10];
    arrow_start_offset=arrow_start+offset;
    arrow_end_offset=arrow_end+offset;
    text(x_mid, y_mid, label_text , 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Position', [x_mid , y_mid+100]);
    quiver(arrow_start_offset(1), arrow_start_offset(2), arrow_end_offset(1) - arrow_start_offset(1), arrow_end_offset(2) - arrow_start_offset(2), 0, 'Color', arrow_color, 'LineWidth', 1, 'MaxHeadSize', 0.1,'AutoScale', 'off', 'AutoScaleFactor', arrow_scale_factor);
    quiver(arrow_end_offset(1), arrow_end_offset(2), arrow_start_offset(1) - arrow_end_offset(1), arrow_start_offset(2) - arrow_end_offset(2), 0, 'Color', arrow_color, 'LineWidth', 1, 'MaxHeadSize', 0.1,'AutoScale', 'off', 'AutoScaleFactor', arrow_scale_factor);
    plot_lines(arrow_start,arrow_start_offset,'k',':',1);
    plot_lines(arrow_end,arrow_end_offset,'k',':',1);
    
    case 'v'
    offset=[10;0];
    arrow_start_offset=arrow_start+offset;
    arrow_end_offset=arrow_end+offset;
    text(x_mid, y_mid, label_text , 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Position', [x_mid+50 , y_mid]);
    quiver(arrow_start_offset(1), arrow_start_offset(2), arrow_end_offset(1) - arrow_start_offset(1), arrow_end_offset(2) - arrow_start_offset(2), 0, 'Color', arrow_color, 'LineWidth', 1, 'MaxHeadSize', 0.1,'AutoScale', 'off', 'AutoScaleFactor', arrow_scale_factor);
    quiver(arrow_end_offset(1), arrow_end_offset(2), arrow_start_offset(1) - arrow_end_offset(1), arrow_start_offset(2) - arrow_end_offset(2), 0, 'Color', arrow_color, 'LineWidth', 1, 'MaxHeadSize', 0.1,'AutoScale', 'off', 'AutoScaleFactor', arrow_scale_factor);
    plot_lines(arrow_start,arrow_start_offset,'k',':',1);
    plot_lines(arrow_end,arrow_end_offset,'k',':',1);
    case 'r'
    text(x_mid, y_mid, label_text , 'HorizontalAlignment', 'center','Rotation',rotation, 'VerticalAlignment', 'middle', 'Position', [x_mid , y_mid]);
    quiver(arrow_start(1), arrow_start(2), arrow_end(1) - arrow_start(1), arrow_end(2) - arrow_start(2), 0, 'Color', arrow_color, 'LineWidth', 1, 'MaxHeadSize', 0.1,'AutoScale', 'off', 'AutoScaleFactor', arrow_scale_factor);
    quiver(arrow_end(1), arrow_end(2), arrow_start(1) - arrow_end(1), arrow_start(2) - arrow_end(2), 0, 'Color', arrow_color, 'LineWidth', 1, 'MaxHeadSize', 0.1,'AutoScale', 'off', 'AutoScaleFactor', arrow_scale_factor);
   
end 



end 