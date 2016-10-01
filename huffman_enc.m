function [ bits_in_final ] = huffman_enc( data )
%% Huffman Encoding
data = single(data);
symbols = unique(data);
counts = hist(data(:), symbols);
p = counts ./ sum(counts); 
sp = round(p * 1000);
dict = huffmandict(symbols, p');
comp = huffmanenco(data, dict);
bits_in_final = length(comp) + 8 * length(symbols) + 8 * length(sp);
end

