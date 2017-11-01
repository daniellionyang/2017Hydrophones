
——————HYDROPHONES——————
This code calculates the Time Difference Of Arrival through the cross correlation of the signals of a hydrophone. The algorithm employed is the Convolution Theorem, which states that the inverse courier-transform of the element-wise multiplication off the Fast Fourier Transform (FFT) and the conjugate of the other FFT returns the cross correlational graph. To prevent aliasing, with a buffer size of 512 data points, a 1024-point FFT is preformed. The FFT returns the cross correlational graph in a strange order (high frequencies first), the index on this order is calculated. Then, the data is sent by UART protocol to a computer, which preforms multilateration of the signals, outputting the angle and expected distance from one of the sensors to the signal source. 

The code is implemented to the FPGA (Nexus-4 DDR) through using the HDL-code functionality of Simulink. Then, the code is synthesized by Vivado.

Although Hydrophones is coded for my robotics team, it had been an individual endeavor, and the code attached is written solely by myself in the past two years. Currently, I am training a new member of the team to understand the code.

—————FIR Filter Coefficients———
FIR filter coefficients are generated through the get_filter_coefficients.m MATLAB code.

—————How to Parse Data——————
Hydrophone data is stored as raw bytes of data.
The start of a chunk of data is two bytes of the value ff (or in binary, 11111111).
We currently use a 12 bit ADC, so each data point is a 12 bit number.
UART only sends 8 bits/1 byte at a time, so each 12 bit data point is stored in 2 bytes.
The first 4 bits (1 nibble) represents which hydrophone the data is coming from (0000 for hydrophone 0, 0011 for hydrophone 3, etc.)
The last 12 bits represents the data point.
You don't actually really need to understand this, the parse_hydrophones.m function will parse the data automatically.

Every data file contains batches of 512 data points for each hydrophone.
The three data files starting with "bad" are bad because in those, hydrophone 3 read an extremely high voltage for unknown reasons. (We never figured out the cause for this). They might be slightly useful as data that doesn't contain any frequency, but it's OK to ignore them. The other 2 data files contain hydrophone data collected for a pinger frequency of 30 kHz and a sampling frequency of 100kHz:
"dolphinpool.log" contains a single batch of data collected in the dolphin pool. It looks very distinct and has a good frequency graph, but don't expect all data to look this ideal.


