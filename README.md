# AES 128 Verification using UVM
This project focuses on the Verification of Advanced Encryption Standard (AES-128) Using the Universal Verification Methodology (UVM).


## UVM Architecture

![aes uvm env - Page 1 (1)](https://github.com/OmniaMohamed12/AES-128-Verification-Using-UVM/assets/110364388/2197052d-b997-45db-9777-add177133271)

## Coverage Results

- **Functional Coverage**:
    ![image](https://github.com/OmniaMohamed12/AES-128-Verification-Using-UVM/assets/110364388/4a1396b8-3f80-4b4f-8919-22f3cb9e605b)


- **Code Coverage**: 
  ![image](https://github.com/OmniaMohamed12/AES-128-Verification-Using-UVM/assets/110364388/5242c5d6-338b-4d96-951d-8914afa0d95f)


Detailed coverage reports can be found in the `docs` directory, specifically in the `code_coverage_report.txt` file and `functional_coverage_report.txt` file.

## Compilation and Simulation Steps

To compile the design and testbench, use the following command:

```bash
vlog AES_Pack.svh AES_Top.sv +cover
```
To simulate and run test with coverage analysis, use the following command:

```bash
vsim -batch AES_Top -coverage -do "run -all; coverage report -codeAll -cvg -verbose" 
```
