function [ data_volume, battery_life ] = volume_for_beacons_and_time( number_of_beacons, time )
% 
battery_life = [62, 60, 58, 56, 54, 51, 49, 46, 44, 41, 38, 35, 32, 28, 25, 21, 18, 14, 12, 9, 7, 5];
transmission_interval = [2000, 1900, 1800, 1700, 1600, 1500, 1400, 1300, 1200, 1100, 1000, 900, 800, 700, 600, 500, 400, 300, 250, 200, 150, 100];

transmission_freq = 1000 ./ transmission_interval;
data_volume = 256 * time * number_of_beacons * transmission_freq;
end

