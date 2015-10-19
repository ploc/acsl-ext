type annotation_t = Cil_types.code_annotation

type definition_t = Cil_types.global_annotation
                      
let pp_ann fmt ann = Printer.pp_code_annotation fmt ann

let pp_def fmt def = Printer.pp_global_annotation fmt def


let _ =
  let pred = Logic_const.ptrue in
  let annot = Cil_types.AAssert ([], (* applies to all? behaviors *)
  		     pred)
  in
  let ann = Logic_const.new_code_annotation annot in
  Format.printf "My dummy code annot: %a@." pp_ann ann
    

		
