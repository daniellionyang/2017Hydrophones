function [data0,data1,data2,data3] = parse_hydrophones(filename, buf_size, data_index)
%PARSE_HYDROPHONES Parse hydrophone data stored in .log files
%FILENAME the name of the file to read
%BUF_SIZE the size of each batch of data, pass in 512
%DATA_INDEX the index of the data to read when the file has more than 1
%batch of data
file = fopen(filename);
fseek(file,(data_index-1)*buf_size*4+2,'bof'); %Skip past batches data_index times

%Find the 2 ff bytes that indicate the start of hydrophone data
double_byte = fread(file,1,'uint16');
while double_byte ~= intmax('uint16')
    fseek(file,-1,'cof');
    double_byte = fread(file,1,'uint16');
end

%Create variables to return
data0 = zeros(buf_size,1);
data1 = zeros(buf_size,1);
data2 = zeros(buf_size,1);
data3 = zeros(buf_size,1);

for i=1:buf_size*4
    nib = fread(file,1,'ubit4',0,'b'); %Get the 4 bit hydrophone identifier
    assert(nib == floor((i-1)/buf_size)); %Make sure the identifier is correct
    %Update the 4 output data
    switch nib
        case 0
            data0(mod((i-1),buf_size)+1) = fread(file,1,'ubit12',0,'b');
        case 1
            data1(mod((i-1),buf_size)+1) = fread(file,1,'ubit12',0,'b');
        case 2
            data2(mod((i-1),buf_size)+1) = fread(file,1,'ubit12',0,'b');
        case 3
            data3(mod((i-1),buf_size)+1) = fread(file,1,'ubit12',0,'b');
    end
end