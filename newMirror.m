
function newMirror(setup,d2,mir1_Angle,mir2_Angle,format)

if strcmp(format,'large')
    gamma = 6.8; %Öffnungswinkel 16:9 Format + Max. Zoom
else 
    gamma = 4.6; %Öffnungswinkel 4:3 Format + Max. Zoom
end

fprintf('\n\n'); 
if strcmp(setup,'opm')
    fprintf('<strong>OPM-Setup:</strong>\n');
else 
    fprintf('<strong>MEG-Setup:</strong>\n');
end 
fprintf('\n'); 

%%

length_MSR = 3950;
width_MSR = 2940;

%% Define MSR cabine + visualization

front_MSR=struct('left',0,'right',0);
left_MSR = struct('lower',0,'upper',0);
right_MSR = struct('lower',0,'upper',0);
back_MSR = struct('left',0,'right',0);

front_MSR.left=[-430,190];
front_MSR.right=[(front_MSR.left(1)+width_MSR),front_MSR.left(2)];

left_MSR.lower=[front_MSR.left(1),front_MSR.left(2)];
left_MSR.upper=[left_MSR.lower(1),(left_MSR.lower(2)+length_MSR)];

right_MSR.lower=front_MSR.right;
right_MSR.upper=[right_MSR.lower(1),(right_MSR.lower(2)+length_MSR)];

back_MSR.left=left_MSR.upper;
back_MSR.right=right_MSR.upper;



ray_name = initializeStruct('ray');
ray_name.left = 'left';
ray_name.right= 'right';
ray_name.center= 'center';

mirror_name = struct('Sp1','1.Spiegel','Sp2','2.Spiegel','Sp3','Screen');


%%

ylim([0,(back_MSR.right(2)+100)]);


plot_lines(front_MSR.left,front_MSR.right,'k','-',2);
plot_lines(back_MSR.left,back_MSR.right,'k','-',2);
plot_lines(left_MSR.lower,left_MSR.upper,'k','-',2);
plot_lines(right_MSR.lower,right_MSR.upper,'k','-',2);


xline(((front_MSR.right(1)+front_MSR.left(1))/2),'k','LineStyle','-.','LineWidth',2);

screen  = struct('angle', 0, 'length', 1170);

distance_d2_d3 = 1480; %Min Distanz bei max zoom in der MEG-Konfiguration


%% Darstellung Alu-blech
alu1=[-137;243];
alu2=[683;243];
plot_lines(alu1,alu2,'c','-',4);


%% Darstelluhng MSR_Tür
tuer1=[978+left_MSR.lower(1);211];
tuer2=[tuer1(1)+990;211];
plot_lines(tuer1,tuer2,'c','-',4);

%% Beschriftung Alu-blech + MSR_Tür
alux_mid=alu1(1)+alu2(1)/2;
aluy_mid=alu1(2)+alu2(2)/2;
tuerx_mid=(tuer1(1)+tuer2(1))/2;
tuery_mid=tuer1(2)+tuer2(2)/2;
text(alux_mid, aluy_mid, 'Alublech', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Position', [alux_mid, aluy_mid-100],'FontWeight','bold');
text(tuerx_mid, tuery_mid, 'MSR-Tür', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Position', [tuerx_mid, tuery_mid-75],'FontWeight','bold');

%% Plot MEG Position

meg_start=[(873+left_MSR.lower(1)),(front_MSR.left(2)+2495)];
meg_end=[(meg_start(1)+950),(front_MSR.left(2)+2395)];
megpos=(meg_start+meg_end)/2;
set_marker(megpos,'mx');

text(megpos(1), megpos(2), 'MEG' , 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Position', [megpos(1) , megpos(2)+50],'FontWeight','bold');
plot([meg_start(1),meg_end(1)],[meg_start(2),meg_end(2)],'k','LineWidth',0.75);


mirror1 = struct('angle', mir1_Angle, 'length', 240);
mirror2 = struct('angle', mir2_Angle, 'length', 300);
    
distance = struct('d1', 360, 'd2', d2, 'd3', 0); 
    
distance.d3 = distance_d2_d3 - distance.d2;
fprintf(['Die Distanz zwischen dem 2.Spiegel und der Projektionsebene beträgt: ' num2str(distance.d3) ' mm']);
fprintf('\n');    
fprintf(['Die Gesamtdistanz beträgt: ' num2str(distance.d1+distance.d2+distance.d3) ' mm']);
fprintf('\n'); 

 
if strcmp(setup,'opm')
    %% Plot OPM Position

    opm_box_ul=[(left_MSR.lower(1)+456),(front_MSR.left(2)+295)];
    opm_box_ol=[opm_box_ul(1),(1977+opm_box_ul(2))];
    opm_box_or=[(opm_box_ol(1)+2022),opm_box_ol(2)];
    opm_box_ur=[(opm_box_or(1)),opm_box_ul(2)];

    set_marker(opm_box_ur,'kx');
    set_marker(opm_box_or,'kx');
    set_marker(opm_box_ul,'kx');
    set_marker(opm_box_ol,'kx');

    plot_lines(opm_box_ul,opm_box_ur,'k','--',0.5);
    plot_lines(opm_box_ul,opm_box_ol,'k','--',0.5);
    plot_lines(opm_box_ol,opm_box_or,'k','--',0.5);
    plot_lines(opm_box_ur,opm_box_or,'k','--',0.5);

    opm_box_x=[opm_box_ul(1),opm_box_ol(1),opm_box_or(1),opm_box_ur(1)];
    opm_box_y=[opm_box_ul(2),opm_box_ol(2),opm_box_or(2),opm_box_ur(2)];
    opmpos=[mean(opm_box_x);mean(opm_box_y)];

    set_marker(opmpos,'mx');

    text(opmpos(1), opmpos(2), 'OPM' , 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Position', [opmpos(1) , opmpos(2)+50],'FontWeight','bold');

    [first_ipoint,second_ipoint,third_ipoint,mir1_end,mir1_start,mir2_end_opm,mir2_start_opm]=visualizeMirrorProblem(mirror1, mirror2,screen, distance, gamma,ray_name,mirror_name,tuer2,opmpos);

    title('Visualisierung des Spiegelproblems OPM-Setup');
else 
    title('Visualisierung des Spiegelproblems MEG-Setup');
    %% Blickrichtung MEG
    meg_vek=meg_end-meg_start;
    R=[0 1; -1 0];
    blickrichtung=R*meg_vek';
    meg_para = [megpos', megpos' + blickrichtung*0.25];
    [first_ipoint,second_ipoint,third_ipoint,mir1_end,mir1_start,mir2_end_meg,mir2_start_meg]=visualizeMirrorProblem(mirror1, mirror2,screen, distance, gamma,ray_name,mirror_name,tuer2,megpos');
    quiver(meg_para(1,1), meg_para(2,1), meg_para(1,2) - meg_para(1,1), meg_para(2,2) - meg_para(2,1), 'Color', 'm', 'LineWidth', 3, 'MaxHeadSize', 0.75);

end 

annotation('textbox', [0.50, 0.7, 0.1, 0.1], 'String', ...
    {['HW am 2.Spiegel: ' num2str(round(norm(second_ipoint.right - second_ipoint.left), 0)) ' mm'], ...
    ['HW am Screen: ' num2str(round(norm(third_ipoint.left - third_ipoint.right), 0)) ' mm'], ...
    ['Distance 1.mirror-2.mirror: ' num2str(distance.d2) ' mm'], ...
    ['Distance 2.mirror-Screen: ' num2str(distance.d3) ' mm'], ...
    ['Total distance: ' num2str(distance.d1+distance.d2+distance.d3) ' mm']});

daspect([1 1 1]);
grset = gca;
set(gca,'YTick',grset.XTick);
set(gca,'YTickLabel',grset.XTickLabel);
set(gca, 'XTickMode', 'manual');
set(gca, 'YTickMode', 'manual');


grid on;
hold off;

f=figure(3);
f.Position = [100 100 1000 900];

if setup == 'opm'
    subplot(2,1,1);
    construction_planing(first_ipoint,second_ipoint,alu1,alu2,tuer1,tuer2,mir1_start,mir1_end,mir1_Angle,front_MSR,back_MSR,left_MSR,right_MSR,mir2_start_opm,mir2_end_opm,mir2_Angle);
    title('Konstruktion des Spiegelsystems für OPM-Setup');

else
    subplot(2,1,2);
    construction_planing(first_ipoint,second_ipoint,alu1,alu2,tuer1,tuer2,mir1_start,mir1_end,mir1_Angle,front_MSR,back_MSR,left_MSR,right_MSR,mir2_start_meg,mir2_end_meg,mir2_Angle);
    title('Konstruktion des Spiegelsystems für MEG-Setup');
end 

end 



