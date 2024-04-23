// 1-bit Carry Adder 
function Bit#(2) fa (Bit#(1) a, Bit#(1) b, Bit#(1) c_in);
    Bit#(1) s = (a ^ b) ^ c_in;
    Bit#(1) c_out = (a & b) | (c_in & (a ^ b));
    return {c_out,s};
endfunction

// 2-bit Ripple Carry Adder
function Bit#(3) add(Bit#(2) x, Bit#(2) y, Bit#(1) c0);
    Bit#(2) s;
    Bit#(3) c = {?,c0};

    let cs0 = fa(x[0], y[0], c[0]);
    c[1] = cs0[1]; s[0] = cs0[0];
    let cs1 = fa(x[1], y[1], c[1]);
    c[2] = cs1[1]; s[1] = cs1[0];

    return {c[2],s};
endfunction

// a normal form of ripple adder
function Bit#(TAdd#(w,1)) addN (Bit#(w) x, Bit#(w) y, Bit#(1) c0);
    Bit#(w) s;
    Bit#(TAdd#(w,1)) c = {?, c0};
    for(Integer i = 0; i < valueOf(w); i = i + 1) begin        
        let cs = fa (x[i], y[i], c[i]);
        c[i+1] = cs[1]; s[i] = cs[0];
    end
    return {c[valueOf(w)], s};
endfunction

// Testbench module to verify addN function
module mkTb();
    // Declare test variables
    Bit#(4) x = 4'b1010;  // Example test inputs
    Bit#(4) y = 4'b0101;
    Bit#(1) c0 = 1'b0;    // Initial carry-in
    Bit#(5) result;

    // Instantiate and execute the addN function
    result = addN(x, y, c0);

    // Test and display the result
    rule check_addN;
        $display("Test Result: %b + %b with carry %b = %b", x, y, c0, result);
        if (result == 5'b01111) begin
            $display("Test Passed!");
        end else begin
            $display("Test Failed!");
        end
        $finish;  // Terminate the simulation
    endrule
endmodule
