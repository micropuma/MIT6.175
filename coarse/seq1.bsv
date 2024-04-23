import RegFile::*;

// Define a simple increment function f.
function Bit#(32) f(Bit#(32) s);
    return s + 1;
endfunction

// Define the mkTb module with registers and the step rule.
module mkTb();
    // Initialize s with an undefined value, and i with 0.
    Reg#(Bit#(32)) s <- mkRegU();
    Reg#(Bit#(6)) i <- mkReg(0); // Change this to 0 so that the rule can execute.

    // The rule to perform the iteration.
    // Rule for when the condition is true
    rule step if (i < 32);
        s <= f(s);
        i <= i + 1;
        $display("Value of s: %0d, Value of i: %0d", s, i); // Display values each time the rule fires.
    endrule

    // Rule for when the condition is false
    rule step_else if (i >= 32); // This is the 'else' part
        // Your 'else' actions go here
        $display("Iteration has finished. Final value of s: %0d, Value of i: %0d", s, i);
        // You could also invoke $finish here to end the simulation if that's your intent
        $finish;
    endrule
endmodule
