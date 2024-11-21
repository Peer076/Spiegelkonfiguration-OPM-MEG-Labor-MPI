clc;
clear;
close all;

fprintf('<strong>OPM-Varianten:</strong>\n');
fprintf('\n');
fprintf('<strong>1.Variante:</strong> mir1_angle = 49°, mir2_angle = 45°, mir1_mir2_distance = 890 mm');
fprintf('\n');
fprintf('<strong>2.Variante:</1strong> mir1_angle = 45°, mir2_angle = 45°, mir1_mir2_distance = 890 mm');
fprintf('\n\n'); 
opm_varianten=input('Welche OPM-Variante?: ');

fprintf('\n\n'); 

fprintf('<strong>MEG-Varianten:</strong>\n');
fprintf('\n');
fprintf('<strong>1.Variante:</strong> mir1_angle = 49°, mir2_angle = 45°, mir1_mir2_distance = 620 mm');
fprintf('\n');
fprintf('<strong>2.Variante:</strong> mir1_angle = 45°, mir2_angle = 45°, mir1_mir2_distance = 690 mm');
fprintf('\n\n'); 

meg_varianten=input('Welche MEG-Variante?: ');

setup=struct('opm','opm','meg','meg');
format=struct('small','small','large','large');

fg1=figure(1);
hold on;
set(fg1,'Position',[0, 0, 800, 1000]);


switch opm_varianten
    case 1
        mirror1Angle = 49;
        mirror2Angle = 45;
        d2=890;
    case 2
        mirror1Angle = 45;
        mirror2Angle = 45;
        d2=890;
    case 3
    	mirror1Angle = 49;
        mirror2Angle = 47;
        d2=890;
end 

newMirror(setup.opm, d2, mirror1Angle, mirror2Angle, format.large);

fg2=figure(2);
hold on;
set(fg2,'Position',[800, 0, 800, 1000]);


switch meg_varianten
    case 1
        mirror1Angle = 49;
        mirror2Angle = 45;
        d2=620;
    case 2
        mirror1Angle = 45;
        mirror2Angle = 45;
        d2=690;
    case 3
    	mirror1Angle = 49;
        mirror2Angle = 47;
        d2=690;

end 

newMirror(setup.meg,d2,mirror1Angle,mirror2Angle,format.large);


