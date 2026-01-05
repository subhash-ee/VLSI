clc; clear; close all;

%% ================= SETTINGS =================
input_file   = 'Input_Data.txt';
verilog_file = 'output_tracker.txt';

FRAC_BITS = 12;
SCALE = 2^FRAC_BITS;

% 8-tap FIR coefficients (hex, signed, Q3.12)
coef_hex = {
    'fea8'
    'ff18'
    '02ec'
    '068a'
    '068a'
    '02ec'
    'ff18'
    'fea8'
};
%% ============================================


%% ---------- HEX → SIGNED DECIMAL ----------
hex_to_dec = @(h) ...
    double(typecast(uint16(hex2dec(h)), 'int16')) / SCALE;


%% ---------- READ INPUT DATA ----------
raw = fileread(input_file);
input_hex = regexp(raw, '\s+', 'split');
input_hex = input_hex(~cellfun('isempty', input_hex));
x = cellfun(hex_to_dec, input_hex);


%% ---------- READ VERILOG OUTPUT ----------
raw = fileread(verilog_file);
verilog_hex = regexp(raw, '\s+', 'split');
verilog_hex = verilog_hex(~cellfun('isempty', verilog_hex));
y_verilog = cellfun(hex_to_dec, verilog_hex);


%% ---------- COEFFICIENTS ----------
h = cellfun(hex_to_dec, coef_hex);


%% ---------- FIR (DECIMAL GOLDEN) ----------
y_golden = filter(h, 1, x);


%% ---------- ERROR ----------
err = y_golden - y_verilog;


%% ---------- PLOTS ----------
figure('Color','w');

% --- Golden & Verilog on SAME AXIS ---
subplot(2,1,1);
plot(y_golden, 'LineWidth',1.3); hold on;
plot(y_verilog, '--', 'LineWidth',1.3);
grid on;
title('FIR Output Comparison');
ylabel('Amplitude');
legend('Golden Reference','Verilog Output');

% --- Error plot ---
subplot(2,1,2);
plot(err, 'LineWidth',1.2);
grid on;
title('Error (Golden − Verilog)');
xlabel('Sample Index');
ylabel('Error');
