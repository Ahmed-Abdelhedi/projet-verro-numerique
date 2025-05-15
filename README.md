# Digital Lock with Multiplier (UAL Project)

This repository contains a VHDL implementation of a dual-purpose digital system that functions both as a **digital lock** with security features and a **4-bit multiplier**.

## Features

### 🔐 Digital Lock Mode
- Secure access system with a 4-bit secret code
- Three-attempt security mechanism
- Status indicators for **locked**, **unlocked**, and **blocked** states
- FPGA-compatible implementation with reset functionality

### ✖️ Multiplier Mode
- 4-bit by 4-bit multiplication
- 7-segment display output for result visualization
- Easy switching between **lock** and **calculator** modes

---

## 🔌 Hardware Interface

| Signal       | Direction | Width | Description                                      |
|--------------|-----------|-------|--------------------------------------------------|
| `CLK`        | Input     | 1     | System clock                                     |
| `RESET`      | Input     | 1     | System reset                                     |
| `INPUT_BITS` | Input     | 4     | 4-bit input for code entry                       |
| `VALIDATE`   | Input     | 1     | Code validation signal                           |
| `SEL_OP`     | Input     | 1     | Mode selection (`0`: Lock, `1`: Multiplier)      |
| `CALCULATE`  | Input     | 1     | Trigger multiplication operation                 |
| `MULT_A`     | Input     | 4     | First operand for multiplication                 |
| `MULT_B`     | Input     | 4     | Second operand for multiplication                |
| `UNLOCKED`   | Output    | 1     | Indicates unlocked state                         |
| `BLOCKED`    | Output    | 1     | Indicates blocked state (after 3 failed attempts)|
| `LOCKED`     | Output    | 1     | Indicates locked state                           |
| `SEGMENTS`   | Output    | 7     | 7-segment display data                           |
| `ANODE`      | Output    | 4     | 7-segment display anode control                  |

---

## ⚙️ Implementation Details

The system uses a finite state machine (FSM) with three main states:

1. **Locked** (default): Waiting for the correct code input  
2. **Unlocked**: Activated when the correct code is entered  
3. **Blocked**: Triggered after three incorrect attempts  

In **Multiplier Mode**, the system calculates the product of two 4-bit values and shows the result on a 7-segment display.

---

## 🚀 Usage

### 🔐 Lock Mode (`SEL_OP = '0'`)
- Enter the 4-bit code using `INPUT_BITS`
- Assert `VALIDATE` to check the code
- System updates the `LOCKED`, `UNLOCKED`, or `BLOCKED` signals

### ✖️ Multiplier Mode (`SEL_OP = '1'`)
- Set operands using `MULT_A` and `MULT_B`
- Assert `CALCULATE` to perform the multiplication
- Result is shown on the 7-segment display

---

## 🛠️ Getting Started

To deploy this design on your FPGA:

1. Clone this repository:
   ```bash
   git clone https://github.com/Ahmed-Abdelhedi/projet-verro-numerique
