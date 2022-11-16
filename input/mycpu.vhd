-------------------------------------------------------------------------------
-- Template for top level entity/architecture and testbench
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- Entity declaration
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;


entity mycpu is

  port (
    clk		     : in  std_logic;
    rst_n	     : in  std_logic

    );

end mycpu;

-------------------------------------------------------------------------------
-- Architecture body
-------------------------------------------------------------------------------

architecture RTL of mycpu is

begin


end RTL;


-------------------------------------------------------------------------------
-- Testbench
--
-- Notice: cfg_top_level_tb.vhd instantiates a testbench "DESIGN_TB"
-- If you use another name, change it into all cfg* files.
--
-------------------------------------------------------------------------------


-- pragma synthesis_off


library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;


entity DESIGN_TB is
  generic (
    COMPARE_MODELS : boolean := false);
end DESIGN_TB;

architecture FUNCTIONAL_SIMULATION of DESIGN_TB is

  component mycpu
    port (
      clk	       : in  std_logic;
      rst_n	       : in  std_logic

      );

  end component;


  signal clk, rst_n	    : std_logic;

begin


  CLK_GEN : process
  begin
    if clk = '0' then
      clk <= '1';
    else
      clk <= '0';
    end if;
    wait for 20 ns;
  end process CLK_GEN;


  rst_n	     <= '0' after 0 ns, '1' after 25 ns;



  DUT_INSTANCE : mycpu

    port map (
      clk	       => clk,
      rst_n	       => rst_n

      );

  REFERENCE_MODEL : if COMPARE_MODELS = true generate

    REFERENCE_INSTANCE : mycpu

      port map (
	clk		 => clk,
	rst_n		 => rst_n

	);


  end generate REFERENCE_MODEL;


end FUNCTIONAL_SIMULATION;

-- pragma synthesis_on


