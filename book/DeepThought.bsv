package DeepThought;

interface Ifc_type;
    method int the_answer (int x, int y, int z);
endinterface

(* synthesize *)
module mkModuleDeepThought (Ifc_type);

    method int the_answer (int x, int y, int z);
        return x + y + z;
    endmethod

endmodule: mkModuleDeepThought

endpackage: DeepThought