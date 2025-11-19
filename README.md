# Traffic Light Controller Core on RedPitaya FPGA
This program implements a traffic light state machine (FSM) on an FPGA. It uses a clock divider to split a 125MHz clock input into millisecond and second timing pulses. The ms and s ticks drive the FSM, allowing each state (RED, GREEN, YELLOW) to be active for the correct duration.

This program has been helping me learn VHDL, configure FPGA cores within Vivado block designs, and scripting in Python to automate processes to prepare for FPGA applications in my research.

## Configuring Block Design
Make sure you have Vivado and Koheron SDK installed on your machine.

Open terminal and enter ``cd Documents/koheron-sdk`` to change the directory to Koheron SDK.
Enter ``make CONFIG=path/to/your/instrument/config.yml block_design`` to open your block design in Vivado.

## Testing
Open terminal and enter ``cd Documents/koheron-sdk`` to change the directory to Koheron SDK.
Enter ``make CORE=path/to/your/instrument/make_core`` to test your core in Vivado.