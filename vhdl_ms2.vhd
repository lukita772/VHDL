library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test1 is
	generic(
      constant_width : integer := 8
  	);
	port(
		clk, reset : in std_logic;
		y : out std_logic_vector(2 downto 0);

	);
end test1;

architecture test1_arch of test1 is

	type state is (a,b,c,d,e,f,g);
	
	signal curr_st : state := a;
	signal next_st : state;
	
begin

	process(clk, reset)
	begin
		if reset = '1' then state <= a;
		elsif rising_edge(clk) then curr_st <= next_st;
		end if;
	
	end process;
	
	process(curr_st, next_st)
	
	begin
		case curr_st is
			when a => y <= "100"; next_st <= b;					
			when b => y <= "010"; next_st <= c;
			when c => y <= "001"; next_st <= d;
			when d => y <= "000"; next_st <= e;
			when e => y <= "111"; next_st <= f;
			when f => y <= "000"; next_st <= g;
			when g => y <= "111"; next_st <= a;
		end case;
	end process;

end architecture test1_arch;
