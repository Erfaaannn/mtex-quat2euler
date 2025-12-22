clear all
clc
%% Step 1 — Define crystal and specimen symmetry
CS = crystalSymmetry('m-3m');  % adjust if needed
SS = specimenSymmetry('1');

%% Step 2 — Import quaternion data
data = load('inc0.txt');  % assumes 4 columns: q0 q1 q2 q3

q0 = data(:,1);
q1 = data(:,2);
q2 = data(:,3);
q3 = data(:,4);

%% Step 3 — Create quaternion objects
quatObj = quaternion(q0, q1, q2, q3);

%% Step 4 — Convert quaternions to orientations
ori = orientation(quatObj, CS, SS);

%% Step 5 — Extract Euler angles (in radians)
eulerAngles_rad = Euler(ori);

%% Step 6 — Convert to degrees for readability
eulerAngles_deg = eulerAngles_rad ./ degree;  % columns: phi1, Phi, phi2

%% Step 7 — Save to a text file (optional)
output = [eulerAngles_deg(:,1), eulerAngles_deg(:,2), eulerAngles_deg(:,3)];
writematrix(output, 'euler_angles.txt', 'Delimiter', '\t');

disp('Euler angles saved to euler_angles.txt');
