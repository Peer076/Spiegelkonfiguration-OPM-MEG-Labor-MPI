function[first_ipoint,second_ipoint,third_ipoint,mir1_end,mir1_start,mir2_end,mir2_start]= visualizeMirrorProblem(mirror1,mirror2,screen,distance,gamma,ray_name,mirror_name,tuer2,pos)

lwe_direction = initializeStruct('ray_direction');
first_ipoint = initializeStruct('ipoint');
first_incident_angle = initializeStruct('angle');
second_ipoint = initializeStruct('ipoint');
second_incident_angle = initializeStruct('angle');
lwa1_direction = initializeStruct('ray_direction');
lwa2_direction = initializeStruct('ray_direction');
third_ipoint = initializeStruct('ipoint');
third_incident_angle = initializeStruct('angle');

%% Spiegel und Projektionsebene definieren und visualisieren


R1 = [cosd(mirror1.angle) -sind(mirror1.angle); sind(mirror1.angle) cosd(mirror1.angle)];
R2 = [cosd(mirror2.angle) -sind(mirror2.angle); sind(mirror2.angle) cosd(mirror2.angle)];

mir1_start = R1 * [-mirror1.length/2; 0] + [0;distance.d1];
mir1_end = R1 * [mirror1.length/2; 0] + [0;distance.d1];
mir1_vektor=mir1_end-mir1_start;

plot_lines(mir1_start,mir1_end,'k','-',2);

mir2_start = R2 * [-mirror2.length/2; 0] + [distance.d2; distance.d1];
mir2_end = R2 * [mirror2.length/2; 0] + [distance.d2; distance.d1];
mir2_vektor=mir2_end-mir2_start;



screen_start =  [-screen.length/2; 0] + [distance.d2;(distance.d1+distance.d3)];
screen_end =  [screen.length/2; 0] + [distance.d2;(distance.d1+distance.d3)];
screen_vektor=screen_end-screen_start;

origin=[0;0]; %Position Projektor


lwe_direction.left=getRay(gamma,ray_name.left);
lwe_direction.right=getRay(gamma,ray_name.right);
lwe_direction.center=getRay(gamma,ray_name.center);


%% Get Intersection Points @ 1.mirror + Start and direction of reflected ray

[first_ipoint.left,first_incident_angle.left]=getIntersectionPoint(mir1_start,mir1_vektor,lwe_direction.left,origin);
lwa1_direction.left=getReflection(mirror1.angle,first_incident_angle.left, mirror_name.Sp1);

[first_ipoint.right,first_incident_angle.right]=getIntersectionPoint(mir1_start,mir1_vektor,lwe_direction.right,origin);
lwa1_direction.right=getReflection(mirror1.angle,first_incident_angle.right, mirror_name.Sp1);

[first_ipoint.center,first_incident_angle.center]=getIntersectionPoint(mir1_start,mir1_vektor,lwe_direction.center,origin);
lwa1_direction.center=getReflection(mirror1.angle,first_incident_angle.center, mirror_name.Sp1);

fprintf(['Die HW am 1.Spiegel beträgt: ' num2str(norm(first_ipoint.right-first_ipoint.left)) ' mm']);
fprintf('\n');

%% Get Intersection Points @ 2.mirror + Start and direction of reflected ray

[second_ipoint.left,second_incident_angle.left]=getIntersectionPoint(mir2_start,mir2_vektor,lwa1_direction.left,first_ipoint.left);
lwa2_direction.left=getReflection(mirror2.angle,second_incident_angle.left, mirror_name.Sp2);

[second_ipoint.right,second_incident_angle.right]=getIntersectionPoint(mir2_start,mir2_vektor,lwa1_direction.right,first_ipoint.right);
lwa2_direction.right=getReflection(mirror2.angle,second_incident_angle.right, mirror_name.Sp2);

[second_ipoint.center,second_incident_angle.center]=getIntersectionPoint(mir2_start,mir2_vektor,lwa1_direction.center,first_ipoint.center);
lwa2_direction.center=getReflection(mirror2.angle,second_incident_angle.center, mirror_name.Sp2);


%% Adjust Position of 2.mirror to d2

d2 = distance.d2;

center_ray_second = second_ipoint.center - first_ipoint.center;

skalierte_center_ray_second = (d2 / norm(center_ray_second)) * center_ray_second;

second_ipoint.center = first_ipoint.center + skalierte_center_ray_second;

% Verschiebungsvektor, um Mirror2 auf second_ipoint.center zu positionieren
mir2_translation = second_ipoint.center - (mir2_start+mir2_end)/2;

% Aktualisiere die Start- und Endpunkte von Mirror2 entsprechend der Verschiebung
mir2_start = mir2_start + mir2_translation;
mir2_end = mir2_end + mir2_translation;

% Aktualisiere die Start- und Endpunkte von mir2_vektor entsprechend der Verschiebung
mir2_vektor=mir2_end-mir2_start;

[second_ipoint.right,second_incident_angle.right]=getIntersectionPoint(mir2_start,mir2_vektor,lwa1_direction.right,first_ipoint.right);
lwa2_direction.right=getReflection(mirror2.angle,second_incident_angle.right, mirror_name.Sp2);
[second_ipoint.left,second_incident.angle_left]=getIntersectionPoint(mir2_start,mir2_vektor,lwa1_direction.left,first_ipoint.left);
lwa2_direction.left=getReflection(mirror2.angle,second_incident_angle.left, mirror_name.Sp2);

lwa2_direction.center=getReflection(mirror2.angle,second_incident_angle.center, mirror_name.Sp2);
fprintf(['Die optische Weglänge vom Leitstrahl zwischen 1.Mir und 2.Mir beträgt: ' num2str(norm(skalierte_center_ray_second)) ' mm']);
fprintf('\n');
lwa2_direction.left=getReflection(mirror2.angle,second_incident_angle.left, mirror_name.Sp2);

lwa2_direction.right=getReflection(mirror2.angle,second_incident_angle.right, mirror_name.Sp2);
%% Get Intersection Points @screen 

[third_ipoint.left,third_incident_angle.left]=getIntersectionPoint(screen_start,screen_vektor,lwa2_direction.left,second_ipoint.left);
[third_ipoint.right,third_incident_angle.right]=getIntersectionPoint(screen_start,screen_vektor,lwa2_direction.right,second_ipoint.right);
[third_ipoint.center,third_incident_angle.center]=getIntersectionPoint(screen_start,screen_vektor,lwa2_direction.center,second_ipoint.center);

d3 = distance.d3;

center_ray_third= third_ipoint.center - second_ipoint.center;

skalierte_center_ray_third = (d3 / norm(center_ray_third)) * center_ray_third;

third_ipoint.center = second_ipoint.center + skalierte_center_ray_third;


%% Adjust Angle Screen and incident angle of central ray to 90 degrees

R = [0 -1; 1 0];
rotated_screen=R*skalierte_center_ray_third;

[third_ipoint.left,third_incident_angle.left]=getIntersectionPoint(third_ipoint.left,rotated_screen,lwa2_direction.left,second_ipoint.left);
[third_ipoint.right,third_incident_angle.right]=getIntersectionPoint(third_ipoint.left,rotated_screen,lwa2_direction.right,second_ipoint.right);
[third_ipoint.center,third_incident_angle.center]=getIntersectionPoint(third_ipoint.left,rotated_screen,lwa2_direction.center,second_ipoint.center);


fprintf(['Die optische Weglänge vom Leitstrahl zwischen 2.Mir und Screen beträgt: ' num2str(norm(skalierte_center_ray_third)) ' mm']);
fprintf('\n');

%% Visualisierung der Lichstrahlen

adjustRayLength(origin, lwe_direction.left, first_ipoint.left);
adjustRayLength(origin, lwe_direction.right, first_ipoint.right);
adjustRayLength(origin, lwe_direction.center, first_ipoint.center);

second_ipoint.left=adjustRayLength(first_ipoint.left, lwa1_direction.left, second_ipoint.left);
second_ipoint.right=adjustRayLength(first_ipoint.right, lwa1_direction.right, second_ipoint.right);
second_ipoint.center=adjustRayLength(first_ipoint.center, lwa1_direction.center, second_ipoint.center);

third_ipoint.left=adjustRayLength(second_ipoint.left, lwa2_direction.left, third_ipoint.left);
third_ipoint.right=adjustRayLength(second_ipoint.right, lwa2_direction.right, third_ipoint.right);
third_ipoint.center=adjustRayLength(second_ipoint.center, lwa2_direction.center, third_ipoint.center);


%% Visualisierung Screen + 2.Mirror 
mirror2AndScreen(second_ipoint.right,second_ipoint.left,mirror_name.Sp2);

mir2_start=second_ipoint.left;
mir2_end=second_ipoint.right;

mirror2AndScreen(third_ipoint.right,third_ipoint.left,mirror_name.Sp3);


end