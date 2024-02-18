set SynModuleInfo {
  {SRCNAME matrix_mult MODELNAME matrix_mult RTLNAME matrix_mult IS_TOP 1
    SUBMODULES {
      {MODELNAME matrix_mult_mul_8ns_8ns_16_1_1 RTLNAME matrix_mult_mul_8ns_8ns_16_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME matrix_mult_mac_muladd_8ns_8ns_16ns_17_4_1 RTLNAME matrix_mult_mac_muladd_8ns_8ns_16ns_17_4_1 BINDTYPE op TYPE all IMPL dsp_slice LATENCY 3 ALLOW_PRAGMA 1}
      {MODELNAME matrix_mult_flow_control_loop_pipe RTLNAME matrix_mult_flow_control_loop_pipe BINDTYPE interface TYPE internal_upc_flow_control INSTNAME matrix_mult_flow_control_loop_pipe_U}
    }
  }
}
