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
    et,ck: in std_logic;
    q: out std_logic_vector(3 downto 0);
    tc: out std_logic
  );
  end component;

  signal q: std_logic_vector(3 downto 0);
  signal et,ck,tc: std_logic;
  begin

  test10: test1 port map(q=>q,et=>et,ck=>ck,tc=>tc);


  process
  begin
    ck <= '0';
    wait for 5 ms;
    ck <= '1';
    wait for 5 ms;
  end process;

  testProcess : process
  begin
    et <= '1';
    wait for 150 ms;
    et <= '0';
    wait;
  end process testProcess;

end architecture test1_tb_arch;

