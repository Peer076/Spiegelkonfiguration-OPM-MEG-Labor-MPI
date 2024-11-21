function printAngles(mirror, angle_left, angle_center, angle_right)
    fprintf('%s:\n', mirror);
    fprintf('Der Einfallswinkel zwischen linker Lichtstrahl und %s beträgt: %4.1f Grad\n', mirror, angle_left);
    fprintf('Der Einfallswinkel zwischen Leitstrahl und %s beträgt: %4.1f Grad\n', mirror, angle_center);
    fprintf('Der Einfallswinkel zwischen rechter Lichtstrahl und %s beträgt: %4.1f Grad\n\n', mirror, angle_right);

end