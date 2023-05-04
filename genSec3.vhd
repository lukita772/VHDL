-- Generar secuncia 000-100-010-111 , cada val. de secuencia debe permanecer
-- 100ns. Suponga que el clock del sistema tiene un periodo de 10ns e implemente
-- con rst sincronico
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test1 is
	port(
		clk: in std_logic;
		rst: in std_logic;
		q: out std_logic_vector(2 downto 0)
	);
end test1;

architecture arch_myGenCnt of test1 is
	type state is (a,b,c,d);
	signal c_reg : state := a;
	signal nx_reg : state;

begin

	process(clk, rst)

	variable num_ck : integer range 0 to 16 := 0;

	begin
		if rising_edge(clk) then
			num_ck := num_ck+1;

			if rst = '1' then
				c_reg <= a;
				num_ck := 0;
			elsif num_ck=10 then
				num_ck := 0;
				c_reg <= nx_reg;
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

-- test bench

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test1_tb is
end entity;

architecture test1_tb_arch of test1_tb is

--Declaración del componente
  component test1 is
    --generic (T_PERIOD_MS : integer :=500);
    --generic(
    --    constant_width : integer := 8
    --  );
  port(
    clk: in std_logic;
    rst: in std_logic;
    q: out std_logic_vector(2 downto 0)
  );
  end component;

  signal clk: std_logic;
  signal rst: std_logic;
  signal q: std_logic_vector(2 downto 0);

  begin

  test100: test1 port map(clk=>clk, rst=>rst, q=>q);

  clkProcess: process
  begin
    for i in 0 to 1000 loop
      clk <= '1';
      wait for 5 ns;
      clk <= '0';
      wait for 5 ns;
    end loop;
    wait; -- IMPORTANTE!
  end process clkPRocess;

  testProcess : process
  begin
    rst <= '1';
    wait for 150 ns;
    rst <= '0';
    wait;
  end process testProcess;

end architecture test1_tb_arch;


