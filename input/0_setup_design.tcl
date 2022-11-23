####################################################################################################
# Top module selection
####################################################################################################

#set DESIGN_NAME "mycpu"
#set DESIGN_NAME "mux_2x16"
#set DESIGN_NAME "mux_3x16"
#set DESIGN_NAME "fu"
#set DESIGN_NAME "ir"
set DESIGN_NAME "pc"
#set DESIGN_NAME "rb"
#set DESIGN_NAME "cu"

####################################################################################################
# Design Parameters
####################################################################################################

set CLK_PERIOD          5                             ; # Clock period in ns.

####################################################################################################
# Settings for all tools
####################################################################################################

set CLOCK_NAMES          { "clk" }
set CLOCK_PERIODS        [list  $CLK_PERIOD]
set RESET_NAMES          { "rst_n" }
set RESET_LEVELS         {   0  }
set RESET_STYLES         { "async" }
set RTL_LANGUAGE         "SystemVerilog"

set SHOW_REPORTS 0                                   ; # 1= EDA tool opens reports after script has ended

if { [file exists "input/tcl_procedures.tcl" ] } {
    source "input/tcl_procedures.tcl"                ; # Misc. user settings just in case
}

####################################################################################################
# RTL Verification
####################################################################################################

set VLOG_RTL_OPTIONS    "-suppress 13314 +define+RTL_SIM"
set VSIM_RTL_OPTIONS    "-suppress 13314"
set RTL_POWER_ESTIMATION       1                     ; # Enable SAIF activity file dumping
set RTL_SIMULATION_TIME "-all"                       ; # "-all" (run to $finish) all time+unit, e.g. 1ms"
set VSIM_SCHEMATIC      1                            ; # 1: QuestaSim generates schematic (can be slow)
set VSIM_WLF_SIZE_LIMIT 0                            ; # Maximim size of Wave file in MB (0 = unlimited)
set SVA_BIND_FILE       "input/mycpu_svabind.svh"    ; # Assertion module bindings
set JASPER_INIT_FILE    "input/jasper_seq.tcl"       ; # Jasper Gold init file

####################################################################################################
# Logic Synthesis
####################################################################################################

set DC_SUPPRESS_MESSAGES { "UID-401" "TEST-130" "TIM-104" "VER-26" "TIM-179" }
set DC_WRITE_PARASITICS  1                           ; # Enable SD file dumping in Design Compiler

####################################################################################################
# Gate-Level Simulation
####################################################################################################

set GATELEVEL_SIMULATION_TIME "-all"
set VSIM_GATELEVEL_OPTIONS    "+nowarn3448 +nowarn3438 +nowarn8756 -suppress 3009 -debugdb"
set VSIM_GATELEVEL_WAVES      "input/5_vsim_module_gatelevel_waves.tcl"
set VSIM_GATELEVEL_LOG        0
set GATELEVEL_SDF             MAX
set POSTLAYOUT_SDF            MAX

####################################################################################################
# Top-module-specific settings
####################################################################################################

if { [info exists DESIGN_NAME] == 0 } {
    puts "Error: Variable DESIGN_NAME has not been defined."
    exit
}

switch $DESIGN_NAME {

    "mycpu" {

	set DESIGN_FILES { \
			       "input/mycpu_pkg.sv" \
			       "input/fu.sv"        "input/fu_svamod.sv" \
			       "input/mux_2x16.sv"  "input/mux_2x16_svamod.sv" \
			       "input/mux_3x16.sv"  "input/mux_3x16_svamod.sv" \
			       "input/ir.sv"        "input/ir_svamod.sv" \
			       "input/pc.sv"        "input/pc_svamod.sv" \
			       "input/rb.sv"        "input/rb_svamod.sv" \
			       "input/cu.sv"        "input/cu_svamod.sv" \
			       "input/mycpu.sv"     "input/mycpu_svamod.sv" \
			   }

	set TESTBENCH_FILES { \
				  "input/mycpu_tb.sv"      "input/mycpu_test.sv" \
			      }
	set SYNTHESIS_DONT_UNGROUP { "MUXM" "MUXD" "MUXB" "RB" "FU" "CU" "IR" "PC" }
	set SDC_FILE            "input/mycpu.sdc"
	set QUESTA_INIT_FILE    "input/questa_seq.tcl"    ; # Initialization file for Questa tools
    }


    "mux_2x16" {

	set DESIGN_FILES { \
			       "input/mycpu_pkg.sv" \
			       "input/mux_2x16.sv"  "input/mux_2x16_svamod.sv" \
			   }

	set TESTBENCH_FILES { \
				  "input/mux_2x16_test.sv" "input/mux_2x16_tb.sv" \
			      }
	set SDC_FILE            "input/tc_comb.sdc"
	set CLOCK_NAMES          {  }
	set RESET_NAMES          {  }
	set QUESTA_INIT_FILE    "input/questa_comb.tcl"
    }


    "mux_3x16" {

	set DESIGN_FILES { \
			       "input/mycpu_pkg.sv" \
			       "input/mux_3x16.sv"  "input/mux_3x16_svamod.sv" \
			   }

	set TESTBENCH_FILES { \
				  "input/mux_3x16_test.sv" "input/mux_3x16_tb.sv" \
			      }
	set SDC_FILE            "input/tc_comb.sdc"
	set CLOCK_NAMES          {  }
	set RESET_NAMES          {  }
	set QUESTA_INIT_FILE    "input/questa_comb.tcl"
    }


    "fu" {

	set DESIGN_FILES { \
			       "input/mycpu_pkg.sv" \
			       "input/fu.sv"        "input/fu_svamod.sv" \
			   }

	set TESTBENCH_FILES { \
				  "input/fu_test.sv"       "input/fu_tb.sv" \
			      }
	set SDC_FILE            "input/tc_comb.sdc"
	set CLOCK_NAMES          {  }
	set RESET_NAMES          {  }
	set QUESTA_INIT_FILE    "input/questa_comb.tcl"
    }


    "ir" {

	set DESIGN_FILES { \
			       "input/mycpu_pkg.sv" \
			       "input/ir.sv"        "input/ir_svamod.sv" \
			   }

	set TESTBENCH_FILES { \
				  "input/ir_test.sv"       "input/ir_tb.sv" \
			      }

	set SDC_FILE            "input/tc_seq.sdc"
	set QUESTA_INIT_FILE    "input/questa_seq.tcl"

    }


    "pc" {

	set DESIGN_FILES { \
			       "input/mycpu_pkg.sv" \
			       "input/pc.sv"        "input/pc_svamod.sv" \
			   }

	set TESTBENCH_FILES { \
				  "input/pc_test.sv"       "input/pc_tb.sv" \
			      }
	set SDC_FILE            "input/tc_seq.sdc"
	set QUESTA_INIT_FILE    "input/questa_seq.tcl"
    }


    "rb" {

	set DESIGN_FILES { \
			       "input/mycpu_pkg.sv" \
			       "input/rb.sv"        "input/rb_svamod.sv" \
			   }

	set TESTBENCH_FILES { \
				  "input/rb_test.sv"       "input/rb_tb.sv" \
			      }
	set SDC_FILE            "input/tc_seq.sdc"
	set QUESTA_INIT_FILE    "input/questa_seq.tcl"
    }


    "cu" {

	set DESIGN_FILES { \
			       "input/mycpu_pkg.sv" \
			       "input/cu.sv"        "input/cu_svamod.sv" \
			   }

	set TESTBENCH_FILES { \
				  "input/cu_pkg.sv" "input/cu_test.sv"       "input/cu_tb.sv" \
			      }
	set SDC_FILE            "input/tc_seq.sdc"
	set QUESTA_INIT_FILE    "input/questa_seq.tcl"
    }

}






