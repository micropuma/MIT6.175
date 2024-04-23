package Tb2;
import DeepThought::*;

(* synthesize *)
module mkTb (Empty);

    Ifc_type ifc <- mkModuleDeepThougsht;

    rule theultimateAnswer;
        $display ("Hello World! The answer is: %0d",ifc.the_answer (10, 15, 17));
        $finish (0);
    endrule
endmodule: mkTb

endpackage: Tb2