% Sample data
bits  = [4 8 16 32 64 128 256];
RCA = [87.514 169.442000 333.298000 661.010000 1316.434000 2627.282 5248.978];
CSA = [87.514000 202.160000 431.452000 890.036000 1807.204000 3641.54 7310.212];
BPA = [97.09 188.594 371.602 737.618 1469.65 2933.714 5861.842];
CLA = [83.524000 168.644000 362.824000 900.676000 2302.230000 6408.738000 16422.84];

figure;
hold on;

plot(bits, RCA, 'LineWidth', 1.8, 'Color', 'r');
plot(bits, CSA, 'LineWidth', 1.8, 'Color', 'b');
plot(bits, BPA, 'LineWidth', 1.8, 'Color', 'g');
plot(bits, CLA, 'LineWidth', 1.8, 'Color', 'm');

xlabel('Bits');
ylabel('Area (units)');
title('Area vs Number of Bits');

% 🔹 Fix X-axis tick labels
xticks(bits);
xticklabels(string(bits));

legend('RCA', 'CSA', 'BPA', 'CLA', 'Location', 'best');
grid on;

hold off;
