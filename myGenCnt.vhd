-- Generar secuncia 000-100-010-111 , cada val. de secuencia debe permanecer
-- 100ns. Suponga que el clock del sistema tiene un periodo de 10ns e implemente
-- con rst sincronico
library ieee;
use ieee.std_logic_1164.all;

entity myGenCnt is
	port(
		clk: in std_logic;
		rst: in std_logic;
		q: out std_logic_vector(2 downto 0)
	);
end myGenCnt;

architecture arch_myGenCnt of myGenCnt is
	type state is (a,b,c,d);
	signal c_reg : state := a;
	signal nx_reg : state;

begin
	
	process(clk, rst)
	
	variable num_ck : integer := 0;
	
	begin
		if rising_edge(clk) then 
			num_ck := num_ck+1;
			if rst = '1' then c_reg <= a;
			elsif num_ck=10 then 
				c_reg <= nx_reg;
				num_ck := 0;
			end if;
		end if;
	end process;
	
	process(c_reg, nx_reg)
	begin
		case c_reg is
			when a => q <= "000"; nx_reg <= b;
			when b => q <= "100"; nx_reg <= c;
			when c => q <= "010"; nx_reg <= d;
			when d => q <= "111"; nx_reg <= a;
		end case;
	end process;
	
		
end arch_myGenCnt;
