# Traffic Light Controller Core on RedPitaya FPGA
This program implements a traffic light state machine on an FPGA. It uses a clock divider to split a 250mHz clock frequencies into milliseconds and seconds. The ms and s ticks of the clock to control the timing of the state machine. 

This program has been helping me learn VHDL, configure FPGA cores within Vivado block designs, and scripting in Python to automate processes to prepare for FPGA applications in my research.

## Setup & Initialization
Open terminal and enter ``cd koheron`` to change the directory to Koheron SDK.
Enter ``make CONFIG=/path/to/your/instrument/config.yml block_design`` to open your block design in Vivado.

## Testing
Open terminal and enter ``cd koheron`` to change the directory to Koheron SDK.
Enter ``make CORE=/path/to/your/instrument/make_core`` to test your core in Vivado.