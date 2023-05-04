library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test1 is
	generic(
      constant_width : integer := 8
  	);
	port(
		i_gray1, i_gray2: in std_logic_vector(3 downto 0);
		o_dist: out std_logic_vector(3 downto 0)
	);
end test1;

architecture test1_arch of test1 is

	signal gtob1, gtob2, p, q: unsigned(3 downto 0);
	signal msel : std_logic;
	--signal p, q : integer;

begin

-- gray to bin
	gtob1(3) <= i_gray1(3);
	gtob2(3) <= i_gray2(3);

	 gtob: for n in 2 downto 0 generate
	 	gtob1(n) <= gtob1(n+1) xor i_gray1(n);
	 	gtob2(n) <= gtob2(n+1) xor i_gray2(n);
	 end generate gtob;

-- comparador

	msel <= '1' when (gtob1 > gtob2) else '0';

-- muxes
	with msel select p <= gtob1 when '1',
						  gtob2 when '0';

	with msel select q <= gtob2 when '1',
						  gtob1 when '0';
-- p-q

	o_dist <= std_logic_vector(to_unsigned(to_integer(p)-to_integer(q),4));


end architecture test1_arch;
