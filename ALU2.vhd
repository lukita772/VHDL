library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test1 is
	generic( N: integer := 8 );
	port(
		a: in std_logic_vector(N-1 downto 0);
		b: in std_logic_vector(N-1 downto 0);
		r: out std_logic_vector(N-1 downto 0);
		ov: out std_logic;
		op: in std_logic_vector(1 downto 0)
	);
end test1;

architecture archALU of test1 is

	signal signed_sum, signed_subs: signed(N-1 downto 0);
	signal unsigned_sum, unsigned_subs: unsigned(N downto 0);
	signal signed_ov_sum, signed_ov_subs: std_logic;
	signal r_reg: std_logic_vector(N-1 downto 0);

	begin

	signed_sum <= signed(a)+signed(b);
	signed_subs <= signed(a)-signed(b);
	unsigned_sum <= unsigned('0' & a)+unsigned('0' & b);
	unsigned_subs <= unsigned('0' & a)-unsigned('0' & b);


	signed_ov_sum <= (a(N-1) and b(N-1) and not r_reg(N-1)) or
				 (not a(N-1) and not b(N-1) and r_reg(N-1));

	signed_ov_subs <= (not a(N-1) and b(N-1) and r_reg(N-1)) or
				 (a(N-1) and not b(N-1) and not r_reg(N-1));

	with op select
	 r_reg <= std_logic_vector(signed_sum) when "00",
	 		     std_logic_vector(signed_subs) when "01",
	 		     std_logic_vector(unsigned_sum(N-1 downto 0)) when "10",
			     std_logic_vector(unsigned_subs(N-1 downto 0)) when "11",
					 (others=> '0') when others;

	with op select
		ov <= std_logic(signed_ov_sum) when "00", --signed sum
			    std_logic(signed_ov_subs) when "01",  --signed subs
					unsigned_sum(N) when "10", --unsigned sum
					unsigned_subs(N) when "11", --unsigned subs
					'0' when others;

	r <= r_reg;

end architecture archALU;


-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;

entity test1_tb is
	generic( N: integer := 8 );
end test1_tb;

architecture tb of test1_tb is
  signal a: std_logic_vector(N-1 downto 0);
	signal b: std_logic_vector(N-1 downto 0);
	signal r: std_logic_vector(N-1 downto 0);
	signal ov: std_logic;
	signal op: std_logic_vector(1 downto 0);
begin
    -- connecting testbench signals with half_adder.vhd
    UUT : entity work.test1 port map (a => a, b => b, r => r, ov => ov, op => op);

    -- inputs
    op<= "00",
    	   "01" after 10 ns,
         "10" after 20 ns,
         "11" after 30 ns,
         "00" after 40 ns;
    a <= "00000010";
    	 --"01101010" after 20 ns,
        -- "10101111" after 40 ns,
        -- "10100000" after 60 ns;
    b <= "00000011";
    	 --"10101100" after 40 ns;
end tb;


