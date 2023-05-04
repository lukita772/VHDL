library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test1 is
	generic(
      constant_width : integer := 8
  	);
	port(
		id, reset, clk: in std_logic;
		o: out std_logic
	);
end test1;

architecture test1_arch of test1 is

	type state is (a,b,c,d,e,f);
	
	signal currState : state := a;
	signal nxState : state;

begin

	clk_switch: process(clk, reset)
	begin
		if reset = '1' then currState <= a;
		elsif rising_edge(clk) then currState <= nxState; 
		else currState <= currState;
		end if;
	end process clk_switch;
	
	process(id, currState)
	begin
	
	case currState is
		when a =>
			if id='1' then nxState <= b;
			else nxState <= a;
			end if;
		when b =>
			if id='1' then nxState <= c;
			else nxState <= a;
			end if;
		
		when c =>
			if id='1' then nxState <= d;
			else nxState <= a;
			end if;
		
		when d =>
			if id='1' then nxState <= d;
			else nxState <= e;
			end if;
		
		when e =>
			if id='1' then nxState <= d;
			else nxState <= f;
			end if;
		
		when f =>
			if id='1' then nxState <= d;
			else nxState <= a;
			end if;
		
	end case;
	end process;

end architecture test1_arch;
