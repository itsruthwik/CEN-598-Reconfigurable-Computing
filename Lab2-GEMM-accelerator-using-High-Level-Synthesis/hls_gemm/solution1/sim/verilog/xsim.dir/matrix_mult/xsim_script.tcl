set_param project.enableReportConfiguration 0
load_feature core
current_fileset
xsim {matrix_mult} -view {{matrix_mult_dataflow_ana.wcfg}} -tclbatch {matrix_mult.tcl} -protoinst {matrix_mult.protoinst}
