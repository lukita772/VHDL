-- Realice una desc de un registro de desplazamiento con entrada serie, salida paralelo y reset sincronico.
-- pag. 6
library ieee;
use ieee.std_logic_1164.all;

entity registro is
	generic (N: integer := 8);
	port( 
		clk: in std_logic;
		rst: in std_logic;
		entradaSerie : in std_logic;
		salidaParalelo: out std_logic_vector(N-1 downto 0)
	);
end registro;

architecture arch_reg of registro is
	signal c_reg : std_logic_vector(N-1 downto 0);
	
begin

	process(clk, rst)
	begin
		if rising_edge(clk) then
			if rst = '1' then c_reg <= (others => '0');
			else 
				c_reg(N-1) <= entradaSerie;
				for i in 0 to N-2 loop
					c_reg(i) <= c_reg(i+1);
				end loop;
			end if;
			
		end if;
	end process;
	
 salidaParalelo <= c_reg;

end arch_reg;
