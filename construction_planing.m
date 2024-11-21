function construction_planing(first_ipoint,second_ipoint,alu1,alu2,tuer1,tuer2,mirror1_start,mirror1_end,mirror1_angle,front_MSR,back_MSR,left_MSR,right_MSR,mirror2_start,mirror2_end,mirror2_angle)

hold on;


origin=[0;0];

%% Plotte Umgebung
plot_lines(alu1,alu2,'r','-',2);
plot_lines(front_MSR.left,front_MSR.right,'k','-',2);
plot_lines(left_MSR.lower,left_MSR.upper,'k','-',2);
plot_lines(mirror1_start,mirror1_end,'k','-',1);
plot_lines(mirror2_start,mirror2_end,'k','-',1);
plot_lines(tuer1,tuer2,'m','-',1);

glasscheibe_x_pos1 = mirror1_end(1)+10;
glasscheibe_x_pos2 = glasscheibe_x_pos1+6; %6 mm Materialstärke 

plot([(glasscheibe_x_pos1),(glasscheibe_x_pos1)],[243,(mirror1_end(2)+10)],'b','LineWidth',1);
plot([(glasscheibe_x_pos2),(glasscheibe_x_pos2)],[243,(mirror1_end(2)+10)],'b','LineWidth',1);

%%

intersection_y = alu2(2)+78;


slope_mirror2 = tand(mirror2_angle);


intersection_x = (intersection_y - mirror2_start(2)) / slope_mirror2 + mirror2_start(1);

intersection_point = [intersection_x; intersection_y];

plot(intersection_point(1),intersection_point(2),'gx','LineWidth',1.5);

staerke_hProfil=2.5;
staerke_secPlatte = 6; 
ges_staerke=staerke_hProfil+staerke_secPlatte;

plot_lines([glasscheibe_x_pos2,(alu2(2)+ges_staerke)],[mirror2_end(1);(alu2(2)+ges_staerke)],'c','-',1); % 2.Trägerplatte 

mirror2_end_Verlaengerung=mirror2_end+[6.7430;6.7430];

plot(mirror2_end_Verlaengerung(1),mirror2_end_Verlaengerung(2),'gx','LineWidth',1.5);

len_mir2=norm(mirror2_end-intersection_point);
fprintf('\n\n');
fprintf(['Die Gesamtlänge des 2.Spiegels beträgt: ' num2str(len_mir2)]);


% getlabel([intersection_point(1);(alu2(2)+ges_staerke)],intersection_point,0,'v'); % Länge der kurzen Trapezseite des 2.Spiegels
% 
% getlabel([mirror2_end_Verlaengerung(1);(alu2(2)+ges_staerke)],mirror2_end_Verlaengerung,0,'v'); %Länge der langen vertikalen Trapezseite des 2.Spiegels
% 
% getlabel([mirror1_start(1);mirror1_end(2)],mirror1_end,0,'h'); % horizontale Länge des 1.Spiegels 
% 
% getlabel([mirror1_start(1);alu1(2)],mirror1_start,0,'v');      % Länge der kurzen Trapezseite des 1. Spiegels
% 
% getlabel([mirror1_end(1);alu2(2)],mirror1_end,0,'v');

% getlabel([mirror2_end_Verlaengerung(1);intersection_point(2)],mirror2_end_Verla,0,'v');  

% getlabel(intersection_point,[mirror2_end_Verlaengerung(1);intersection_point(2)],0,'h'); % Länge der unteren Trapezseite des 2.Spiegels 

% getlabel([glasscheibe_x_pos2;intersection_point(2)],intersection_point,0,'h');

% getlabel([origin(1);intersection_point(2)],intersection_point,0,'h');

% getlabel([mirror2_end(1);intersection_point(2)],[tuer2(1);intersection_point(2)],0,'h');


getlabel(alu1,[glasscheibe_x_pos2;alu1(2)],0,'h');

getlabel([glasscheibe_x_pos2(1);intersection_point(2)],intersection_point,0,'h');

getlabel([intersection_point(1);(alu2(2)+ges_staerke)],intersection_point,0,'v');

%% PLot Einstellungen 
xlim([left_MSR.lower(1)-100,1100]);
ylim([0,1000]);
grid on;
daspect([1 1 1]);
hold off;

end