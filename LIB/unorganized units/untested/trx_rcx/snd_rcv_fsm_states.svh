`ifndef SND_RCV_FSM_STATES
`define SND_RCV_FSM_STATES

typedef enum logic[1:0] { 
    IDLE = 2'b00,
    VALID = 2'b01,
    READY = 2'b10,
} snd_rcv_state_t;


`endif //SND_RCV_FSM_STATES