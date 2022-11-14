library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test1 is
    generic(
      constant_width : integer := 8
      );
    port(
        i_A, i_B : in std_logic_vector(constant_width -1 downto 0);
        i_Ci : in std_logic;
        o_Co : out std_logic;
        o_S : out std_logic_vector(constant_width -1 downto 0)
    );
end test1;

architecture test1_arch of test1 is

signal s_S : std_logic_vector(constant_width downto 0);

begin

    process(i_A, i_B, i_Ci)

    variable var_A : integer := to_integer(unsigned(i_A));
    variable var_B : integer := to_integer(unsigned(i_B));
    variable var_S : integer := 0;

    begin
    	if i_Ci = '1' then
    		var_S := var_A + var_B + 1;
    	else
    		var_S := var_A + var_B;
    	end if;

        s_S <= std_logic_vector(to_unsigned(var_S, constant_width+1));

    end process;

    o_S <= s_S(constant_width -1 downto 0);
    o_Co <= s_S(constant_width);


end architecture test1_arch;
