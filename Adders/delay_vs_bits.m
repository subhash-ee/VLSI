% Sample data
bits  = [4 8 16 32 64 128 256];
RCA = [0.32 0.53 0.95 1.79 3.46 6.80 13.48];
CSA = [0.32 0.39 0.50 0.81 1.41 2.62 5.03];
BPA = [0.35 0.61 0.73 0.97 1.45 2.41 4.33];
CLA = [0.22 0.44 0.49 0.59 0.75 0.99 1.26];

figure;
hold on;

plot(bits, RCA, 'LineWidth', 1.8, 'Color', 'r');
plot(bits, CSA, 'LineWidth', 1.8, 'Color', 'b');
plot(bits, BPA, 'LineWidth', 1.8, 'Color', 'g');
plot(bits, CLA, 'LineWidth', 1.8, 'Color', 'm');

xlabel('Bits');
ylabel('Delay (ns)');
title('Delay vs Number of Bits');

% 🔹 Fix X-axis tick labels
xticks(bits);
xticklabels(string(bits));

legend('RCA', 'CSA', 'BPA', 'CLA', 'Location', 'best');
grid on;

hold off;
