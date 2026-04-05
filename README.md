A Tournament Branch Predictor implemented in Verilog HDL that combines Global and Local prediction techniques using a dynamic chooser (selector) to improve branch prediction accuracy and processor performance.
This project demonstrates how modern processors reduce control hazards and enhance Instruction-Level Parallelism (ILP) using adaptive prediction strategies.

📌 Overview
Branch prediction is a crucial technique in modern processors to minimize pipeline stalls caused by control hazards.
The Tournament Predictor improves prediction accuracy by:
Maintaining both Global and Local predictors
Dynamically selecting the best predictor using a chooser mechanism

This approach is inspired by real-world architectures such as the Alpha 21264.

🏗️ Architecture
🔹 Components
Global Predictor
Uses Global History Register (GHR)
Captures overall branch behavior patterns
Local Predictor
Uses Local History Table (LHT)
Tracks branch-specific behavior
Chooser (Selector)
Uses 2-bit saturating counters
Selects between global and local predictor dynamically
FSM (Finite State Machine)
Implements prediction states (Strong/Weak Taken & Not Taken)

⚙️ Working Principle
Branch instruction is fetched
Both global and local predictors generate predictions
Chooser selects the most reliable predictor
Prediction is compared with actual outcome
All structures (GHR, LHT, chooser) are updated accordingly

📊 Features
✅ Hybrid prediction (Global + Local)
✅ 2-bit saturating counter implementation
✅ FSM-based design
✅ Improved prediction accuracy over single predictors
✅ Verilog HDL implementation
✅ Simulation and verification included

🛠️ Tech Stack
Hardware Description Language: Verilog
Simulation Tool: ModelSim / Vivado / Icarus Verilog
Concepts Used:
Computer Architecture
Branch Prediction
FSM Design
Pipeline Optimization

📁 Project Structure
📦 Tournament-Branch-Predictor
 ┣ 📂 src
 ┃ ┣ global_predictor.v
 ┃ ┣ local_predictor.v
 ┃ ┣ chooser.v
 ┃ ┗ top_module.v
 ┣ 📂 testbench
 ┃ ┗ tb_predictor.v
 ┣ 📂 results
 ┃ ┗ simulation_waveforms/
 ┣ README.md

▶️ How to Run
Clone the repository:
git clone https://github.com/invincibleSailor/Tournament_Predictor.git
cd Tournament_Predictor

Compile and simulate:
iverilog -o output src/*.v testbench/tb_predictor.v
vvp output
View waveform (optional):
gtkwave dump.vcd

📈 Learning Outcomes
Deep understanding of branch prediction techniques
Practical knowledge of Verilog-based hardware design
Insight into real-world CPU architecture (hybrid predictors)
Experience with debugging and simulation workflows

🎯 Applications
CPU and processor design
VLSI system development
Performance optimization in pipelined architectures
Academic research in Computer Architecture

🤝 Contributors
Kashyap Joshi
Khushi Karangiya

📌 Future Improvements
🔹 Add Branch Target Buffer (BTB)
🔹 Implement gshare predictor
🔹 Add performance metrics (accuracy comparison)
🔹 FPGA implementation

📜 License
This project is for educational and research purposes.
