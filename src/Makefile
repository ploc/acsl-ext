FRAMACLIB=`frama-c -print-lib-path`

CMXSODIUM=frama_c_init.cmx unmarshal.cmx unmarshal_nums.cmx sysutil.cmx unz.cmx dynlink_common_interface.cmx structural_descr.cmx type.cmx descr.cmx FCSet.cmx FCMap.cmx FCHashtbl.cmx extlib.cmx pretty_utils.cmx hook.cmx bag.cmx indexer.cmx vector.cmx bitvector.cmx qstack.cmx integer.cmx filepath.cmx config.cmx log.cmx cmdline.cmx project_skeleton.cmx datatype.cmx journal.cmx state.cmx state_dependency_graph.cmx state_topological.cmx state_selection.cmx project.cmx state_builder.cmx binary_cache.cmx hptmap.cmx hptset.cmx cil_datatype.cmx typed_parameter.cmx dynamic.cmx parameter_category.cmx parameter_customize.cmx parameter_state.cmx parameter_builder.cmx plugin.cmx kernel.cmx emitter.cmx floating_point.cmx rangemap.cmx printer_builder.cmx cilmsg.cmx alpha.cmx cilconfig.cmx cil_state_builder.cmx utf8_logic.cmx machdeps.cmx cil_const.cmx logic_env.cmx escape.cmx logic_const.cmx cil.cmx cil_printer.cmx cil_descriptive_printer.cmx errorloc.cmx cabs.cmx cabs_debug.cmx cabshelper.cmx logic_utils.cmx logic_builtin.cmx logic_print.cmx logic_parser.cmx logic_lexer.cmx lexerhack.cmx mergecil.cmx rmtmps.cmx logic_typing.cmx cprint.cmx cabsvisit.cmx cabs2cil.cmx clexer.cmx cparser.cmx logic_preprocess.cmx frontc.cmx callgraph.cmx dataflow.cmx oneret.cmx cfg.cmx ast_info.cmx ast.cmx globals.cmx kernel_function.cmx property.cmx property_status.cmx annotations.cmx printer.cmx stmts_graph.cmx ordered_stmt.cmx dataflows.cmx dataflow2.cmx dominators.cmx description.cmx statuses_by_call.cmx alarms.cmx messages.cmx abstract_interp.cmx int_Base.cmx unicode.cmx service_graph.cmx ival.cmx bit_utils.cmx base.cmx origin.cmx map_Lattice.cmx trace.cmx value_messages.cmx cilE.cmx tr_offset.cmx offsetmap.cmx int_Intervals.cmx locations.cmx precise_locs.cmx lmap.cmx lmap_bitwise.cmx function_Froms.cmx cvalue.cmx widen_type.cmx visitor.cmx clone.cmx loop.cmx inout_type.cmx pdgIndex.cmx pdgTypes.cmx pdgMarks.cmx slicingInternals.cmx slicingTypes.cmx value_types.cmx db.cmx command.cmx task.cmx file.cmx exn_flow.cmx translate_lightweight.cmx unroll_loops.cmx filter.cmx special_hooks.cmx logic_interp.cmx infer_annotations.cmx allocates.cmx

# git rev b27c57e03430c7aa586df3416ac91c149551f4ed
CMXGIT=frama_c_init.cmx unmarshal.cmx unmarshal_nums.cmx sysutil.cmx unz.cmx dynlink_common_interface.cmx structural_descr.cmx type.cmx descr.cmx FCSet.cmx FCMap.cmx FCHashtbl.cmx extlib.cmx pretty_utils.cmx hook.cmx bag.cmx indexer.cmx vector.cmx bitvector.cmx qstack.cmx integer.cmx filepath.cmx config.cmx fc_version.cmx log.cmx cmdline.cmx project_skeleton.cmx datatype.cmx journal.cmx state.cmx state_dependency_graph.cmx state_topological.cmx state_selection.cmx project.cmx state_builder.cmx binary_cache.cmx hptmap.cmx hptset.cmx cil_datatype.cmx typed_parameter.cmx dynamic.cmx parameter_category.cmx parameter_customize.cmx parameter_state.cmx parameter_builder.cmx plugin.cmx kernel.cmx emitter.cmx floating_point.cmx rangemap.cmx printer_builder.cmx alpha.cmx cilconfig.cmx cil_state_builder.cmx utf8_logic.cmx machdeps.cmx cil_const.cmx logic_env.cmx escape.cmx logic_const.cmx cil.cmx cil_printer.cmx cil_descriptive_printer.cmx errorloc.cmx cabs.cmx cabs_debug.cmx cabshelper.cmx logic_utils.cmx logic_builtin.cmx logic_print.cmx logic_parser.cmx logic_lexer.cmx lexerhack.cmx mergecil.cmx rmtmps.cmx logic_typing.cmx cprint.cmx cabsvisit.cmx cabs2cil.cmx clexer.cmx cparser.cmx logic_preprocess.cmx frontc.cmx callgraph.cmx dataflow.cmx oneret.cmx cfg.cmx ast_info.cmx ast.cmx globals.cmx kernel_function.cmx property.cmx property_status.cmx annotations.cmx printer.cmx stmts_graph.cmx ordered_stmt.cmx dataflows.cmx dataflow2.cmx dominators.cmx description.cmx statuses_by_call.cmx alarms.cmx messages.cmx lattice_messages.cmx abstract_interp.cmx int_Base.cmx unicode.cmx service_graph.cmx ival.cmx bit_utils.cmx base.cmx origin.cmx map_Lattice.cmx trace.cmx cilE.cmx tr_offset.cmx offsetmap.cmx int_Intervals.cmx locations.cmx precise_locs.cmx lmap.cmx lmap_bitwise.cmx function_Froms.cmx cvalue.cmx widen_type.cmx visitor.cmx clone.cmx loop.cmx inout_type.cmx pdgIndex.cmx pdgTypes.cmx pdgMarks.cmx slicingInternals.cmx slicingTypes.cmx value_types.cmx db.cmx command.cmx task.cmx filecheck.cmx file.cmx exn_flow.cmx translate_lightweight.cmx unroll_loops.cmx filter.cmx logic_interp.cmx infer_annotations.cmx allocates.cmx special_hooks.cmx boot.cmx

# Direct compilation without packs
approach1: 
	ocamlopt -c -I ${FRAMACLIB}  main_non_pack.ml
	ocamlopt -I ${FRAMACLIB} \
	-I `ocamlfind query findlib` -I `ocamlfind query zarith` -I \
      `ocamlfind query dynlink` -I `ocamlfind query str` -I `ocamlfind query \
      num` -I `ocamlfind query bigarray` -I `ocamlfind query unix` -I \
      `ocamlfind query ocamlgraph` \
nums.cmxa unix.cmxa bigarray.cmxa str.cmxa findlib.cmxa  dynlink.cmxa  ${FRAMACLIB}/buckx_c.o  graph.cmxa zarith.cmxa \
${CMXSODIUM} \
main_non_pack.cmx -o main_non_pack.native

# With Packs
../lib/framaC.cmxa:
	$(MAKE) -C ../lib

approach2: ../lib/framaC.cmxa
	ocamlopt -c -I ${FRAMACLIB} -I ../lib/ main_pack.ml 
	ocamlopt -I `ocamlfind query findlib` -I `ocamlfind query zarith` -I \
	      `ocamlfind query dynlink` -I `ocamlfind query str` -I `ocamlfind query \
	      num` -I `ocamlfind query bigarray` -I `ocamlfind query unix` -I \
	      `ocamlfind query ocamlgraph` dynlink.cmxa str.cmxa bigarray.cmxa \
	      nums.cmxa -I ../lib unix.cmxa findlib.cmxa graph.cmxa zarith.cmxa \
	      framaC.cmxa main_pack.cmx -o main_pack.native

clean:
	@rm -f *.cmx *.cmi *.o 

distclean: clean
	@rm -rf *.native

.PHONY: clean distclean

all:
	ocamlbuild -classic-display -use-ocamlfind main.native
