library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test1_tb is
end entity;

architecture test1_tb_arch of test1_tb is

--Declaración del componente
  component test1 is
  --generic (T_PERIOD_MS : integer :=500);
  generic(
    constant_width : integer := 8
    );
  port(
      i_A, i_B : in std_logic_vector(constant_width -1 downto 0);
      i_Ci : in std_logic;
      o_Co : out std_logic;
      o_S : out std_logic_vector(constant_width -1 downto 0)
  );
  end component;

  signal BA: std_logic_vector(1 downto 0);
  signal SE: std_logic; --select
  signal Y: std_logic;
  begin

  test10: test1 port map(BA=>BA,SE=>SE,Y=>Y);

  testProcess : process
  begin
    SE <= '1';
    for I in 0 to 3 loop
      BA <= std_logic_vector(to_unsigned(I,2));
      wait for 10 ms;
    end loop;
    wait for 20 ms;
    SE <= '0';
    for I in 0 to 3 loop
      BA <= std_logic_vector(to_unsigned(I,2));
      wait for 10 ms;
    end loop;
    wait;
  end process testProcess;

end architecture test1_tb_arch;
