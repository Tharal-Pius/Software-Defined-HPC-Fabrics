//gaurds

typedef struct packed {
    logic [3:0] power_info;   // 4 bits for power information of the host device
    logic [2:0] power_mode;   // 3 bits for power mode
    logic       parity_bit;   // 1 bit for parity(even) ????
} power_info_t;

typedef struct packed {

    logic [47:0] data;      // 64-bit data
} data_48_t; //data can be 64 bit, 56bit,  48 bit

typedef struct packed {

    logic [55:0] data;      // 64-bit data
} data_56_t;

typedef struct packed {

    logic [63:0] data;      // 64-bit data

} data_64_t;

//TBD
typedef struct packed {
    //??? parity of data, type of current + 3 packet, does the data contain instru? (data composition), 
    //should the host generate data btw pckts if there is a parity error should you throw out all the pckts recieved after the erroneous pckt?? or use hamming code??
} control_t; 8bit 



struct packed {
            data_48_t data_snd_rcv;    // 48-bit data
            control_t control_snd_rcv;
            power_info_t power_info_snd_rcv;
} data_control_power_t;


struct packed {
            data_56_t data_snd_rcv;    // 56-bit data
            control_t control_snd_rcv;
} data_control_t;


typedef union packed{
        data_64_t data_snd_rcv;       
        data_control_t data_control_snd_rcv;
        data_control_power_t data_control_power_snd_rcv;
} packet_t;