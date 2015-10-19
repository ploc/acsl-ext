open Ocamlbuild_plugin
open Command

let cclib l = List.flatten (List.map (fun x -> [A"-cclib"; A x]) l)

;;

dispatch begin function
| After_rules ->
    (* We declare external libraries *)
   (*   ocaml_lib ~extern:true ~dir:"/usr/local/lib/frama-c" "framac"; *)
(*      ocaml_lib ~extern:true ~dir:"/home/ploc/Repositories/git/cea/frama-c/ploc" "framaC"; *)
    ocaml_lib ~extern:true ~dir:"/home/ploc/Repositories/git/github/acsl_ext/lib" "framaC"; 
    ocaml_lib ~extern:true ~dir:"/usr/local/lib/frama-c" "framaCcmi";
    flag ["link"; "ocaml"] & S([A "-ccopt"; A "-L/home/ploc/Repositories/git/github/acsl_ext/lib"; A"-cclib"; A "-lframaC"]);
| _ -> ()
end
