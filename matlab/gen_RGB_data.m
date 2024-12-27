clc;
clear;

image = imread('../color_test.png');

R = image(:,:,1);
G = image(:,:,2);
B = image(:,:,3);

fileID = fopen("RGB_color_test.h", "w");
fprintf(fileID, '#ifndef PHOTO_CAT_H_\n#define PHOTO_CAT_H_\n\n#include \"utils.h\"\n');
fprintf(fileID, "const uint8_t R1[320*256] = {\n");

for i = 1:256
    for j = 1:320
        fprintf(fileID, "0x%x, ", R(i, j));
    end
end
fprintf(fileID, "\n};\n\n");

fprintf(fileID, "const uint8_t G1[320*256] = {\n");

for i = 1:256
    for j = 1:320
        fprintf(fileID, "0x%x, ", G(i, j));
    end
end
fprintf(fileID, "\n};\n\n");

fprintf(fileID, "const uint8_t B1[320*256] = {\n");

for i = 1:256
    for j = 1:320
        fprintf(fileID, "0x%x, ", B(i, j));
    end
end
fprintf(fileID, "\n};\n\n");

fprintf(fileID, "#endif\n");

fclose(fileID);