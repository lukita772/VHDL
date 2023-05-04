-- conversor gray a binario utilizando xor y for generate

library ieee;
use ieee.std_logic_1164.all;

entity grayBinario is
	generic (N: integer := 8);
	port( 
		gray: in std_logic_vector(N-1 downto 0);
		binario : out std_logic_vector(N-1 downto 0)
	);
end grayBinario;

architecture arch_grayBinario of grayBinario is

begin

	binario(N-1) <= gray(N-1);
	
	for i in N-2 downto 0 generate
		binario(i) <= binario(n-1) xor gray(i);
	end generate;
	
end arch_grayBinario;
