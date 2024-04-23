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

// a shift operators
// that is a static shift operators
function Bit#(w) logical_shift_left (Integer n, Bit #(w) arg);
    Bit #(w) result = 0;
    for (Integer j=0; j < (valueOf(w)-n); j=j+1) 
        result [j] = arg [j+n];
    return result;
endfunction

function Bit#(w) logical_shift_right (Integer n, Bit #(w) arg);
    Bit #(w) result = 0;
    for (Integer j = (valueOf(w)-n); j < valueOf(w); j = j+1)
        result[j] = arg[j - valueOf(w) + n];
    return result;
endfunction

// @todo: finish logical shift right/left by a dynamic amount

// Multiplication function
function Bit#(64) mul32(Bit#(32) a, Bit#(32) b);
    Bit#(32) prod = 0;
    Bit#(32) tp = 0;
    for (Integer i=0; i<32; i=i+1) begin
        Bit#(32) m = (a[i]==0)? 0 : b;
        Bit#(33) sum = add32(m,tp,0);
        prod[i] = sum[0];
        tp = truncateLSB(sum);
    end
    return {tp,prod};
endfunction

// Combinational ALUs
function Data alu (Data a, Data b, AluFunc func);
    Data res = case(func)
        Add : (a + b);
        Sub : (a - b);
        And : (a & b);
        Or : (a | b);
        Xor : (a ^ b);
        Nor : ~(a | b);
        Slt : zeroExtend( pack( signedLT(a, b) ) );
        Sltu : zeroExtend( pack( a < b ) );
        LShift: (a << b[4:0]);
        RShift: (a >> b[4:0]);
        Sra : signedShiftRight(a, b[4:0]);
    endcase;
    return res;
endfunction

function Bool aluBr (Data a, Data b, BrFunc brFunc);
    Bool brTaken = case(brFunc)
        Eq : (a == b);
        Neq : (a != b);
        Le : signedLE(a, 0);
        Lt : signedLT(a, 0);
        Ge : signedGE(a, 0);
        Gt : signedGT(a, 0);
        AT : True;
        NT : False;
    endcase;
    return brTaken;
endfunction

