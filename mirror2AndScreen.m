function mirror2AndScreen(ipoint_right,ipoint_left,mirror_name)

vektor=ipoint_right-ipoint_left;

mir_para = [ipoint_left, ipoint_left + vektor];

plot(mir_para(1,:), mir_para(2,:), 'Color', [0 0 0], 'LineWidth', 2);

fprintf('Die horizontale Weite am %s beträgt: %4.0f mm',mirror_name, norm(vektor));
fprintf('\n');


end 