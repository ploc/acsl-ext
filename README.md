# acsl-ext
Trying to access frama-c from external ocaml program without beeing compiled as a plugin.

Hypothesis: at least frama-c installed somewhere including the cmi/cmx files
available in frama-c -print-lib-path

$FRAMACLIB=`frama-c -print-lib-path`

* Approach 1: direct compilation without packs

we rely on these cmx files to compile main_non_pack
1. compile into cmx providing the path to cmi files
   ocamlopt -c -I ${FRAMACLIB} main_non_pack.ml

2. link with all required cmx/cmxa/buckx_c.o

   see Makefile main_non_pack_direct target

* Approach 2: direct compilation with packs

It is possible to add extra pack information in framaC source files.

** Recompile frama-c with pack option for ml files and fPIC option for buckx_c
The idea: 
- every kernel file should be compile with -for-pack FramaC, and
- every plugin P file should be compiled with -for-pack FramaC.P

In Makefile.plugin, change the pack names into FramaC.$(PLUGIN_NAME)
Then:
FRAMAC_USER_FLAGS="-for-pack FramaC" GEN_BUCKX_CFLAGS="-fPIC" make

In practice it doesn't work well because of strange behavior of frama-c
makefiles.

*** Strange makefiles 

- In Makefile.plugin (line 362), you use -for-pack and -pack to package each plugin. Why
  do you use this only for native code?
- It seems that this modification impacts the compilation of all files:
  eg. look the compilation flags for ocamlopt structural_descr.ml,
  unmarshal.ml, src/type/type.ml , etc ... all of them are compiled with the
  flags -for-pack Aorai. This is incorrect.

VERBOSEMAKE=true make opt | tee -a logopt

- But this behavior does not happen if one compiles them directly: 

ploc@eyne:~/Local/src/frama-c/frama-c-Sodium-20150201$ rm src/type/structural_descr.cmx

ploc@eyne:~/Local/src/frama-c/frama-c-Sodium-20150201$ VERBOSEMAKE=yes make src/type/structural_descr.cmx

ocamlopt.opt -c -w +a-3-4-6-9-41-44-45-48 -annot -bin-annot  -g -I src/misc -I
src/ai -I src/memory_state -I src/toplevel -I src/slicing_types -I src/pdg_types
-I src/kernel -I src/logic -I src/lib -I src/printer -I src/project -I src/type
-I src/buckx -I src/gui -I external -I cil/src -I cil/src/ext -I cil/src/frontc
-I cil/src/logic -I cil/ocamlutil -I
/home/ploc/Local/src/frama-c/frama-c-Sodium-20150201/lib/plugins -I lib -I
/home/ploc/.opam/4.01.0/lib/ocamlgraph  -I /home/ploc/.opam/4.01.0/lib/zarith
-compact src/type/structural_descr.ml

Here not -for-pack Aorai appears

*** Workaround
compile first the kernel, then the plugins

# kernel only
EXTERNAL_PLUGINS="" VERBOSEMAKE=yes FRAMAC_USER_FLAGS="-for-pack FramaC" GEN_BUCKX_CFLAGS="-fPIC" make

# remaining uncompiled plugins
VERBOSEMAKE=yes FRAMAC_USER_FLAGS="-for-pack FramaC" GEN_BUCKX_CFLAGS="-fPIC" make

# install
sudo make install

Still, when executing the binary at the end of the process (make
approach2). One get kernel errors:
[kernel] user error: cannot load plug-in 'frama-c-aorai': cannot load module
[kernel] user error: cannot load plug-in 'frama-c-obfuscator': cannot load module
[kernel] user error: cannot load plug-in 'frama-c-report': cannot load module
[kernel] user error: cannot load plug-in 'frama-c-security_slicing': cannot load module
[kernel] user error: cannot load plug-in 'frama-c-wp': cannot load module

It looks like frama-c library doesn't find the cmxs.

But the binary frama-c seems ok with those plugins.


** Prepare the library/pack framaC.cmxa 

  - Go into the folder lib
    1. create the pack file containing only cmx files
       ocamlopt.opt -pack -o framaC.cmx -I ${FRAMACLIB} all_cmx_files_except_ptest
    2. create a lib containing only C stubs
       ocamlmklib -o framaCstub ${FRAMACLIB}/buckx_c.o
    3. build the framaC.cmxa file, declaring packages
       ocamlfind ocamlopt -a  -package num -package  unix -package bigarray \
       -package str -package findlib -package dynlink -cclib -lframaCstub \
       -package zarith  -package ocamlgraph  framaC.cmx -o framaC.cmxa

** Use the library when compiling main_pack.ml

   1. Generate cmx providing both access to cmi files (in FRAMACLIB) and the
      framac.cmi pack file (in the local lib folder)
      
      ocamlopt -c -I ${FRAMACLIB} main_non_pack.ml 
      ocamlopt -c -I ${FRAMACLIB} -I ../lib/ main_pack.ml 

   2. Link files together

      ocamlopt -I `ocamlfind query findlib` -I `ocamlfind query zarith` -I \
      `ocamlfind query dynlink` -I `ocamlfind query str` -I `ocamlfind query \
      num` -I `ocamlfind query bigarray` -I `ocamlfind query unix` -I \
      `ocamlfind query ocamlgraph` dynlink.cmxa str.cmxa bigarray.cmxa \
      nums.cmxa -I ../lib unix.cmxa findlib.cmxa graph.cmxa zarith.cmxa \
      framaC.cmxa main_pack.cmx -o main_pack.native



* Approach 3: ocamlbuild with packs
  Once the framaC.cmxa lib has been created using a more classical compilation,
  one can use ocamlbuild to compile and link.

  - declare the framaC lib as an external one bound to framaC.cmxa
  - declare the framaCcmi lib as an external one bound to $(FRAMACLIB).
    It will not be used for linking, only to provide access to compiled CMI.

  - in _tags
    - declare *.ml to rely on framaCcmi
    - declare *.native to rely on framaC lib 

* Summary 

En gros, ca marche bien en direct. En version avec les packs, ca galere encore
un peu sur la compil de framaC. Mais apres, pour construire le cmxa et
l'utiliser ça roule.

L'idéal serait d'avoir par defaut dans frama-c:
- le fpic pour buckx
- un systeme de package propre pour pouvoir preparer un bundle cmxa

Pour info j'ai testé avec Sodium et git b27c57e03430c7aa586df3416ac91c149551f4ed
