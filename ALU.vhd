-- a y b son operandos, r resultado de la op, ov, indica si hubo overflow,
-- 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity myALU is
	generic (N : integer := 8);
	port(
		a: in std_logic_vector(N-1 downto 0);
		b: in std_logic_vector(N-1 downto 0);
		r: out std_logic_vector(N-1 downto 0);
		ov: out std_logic;
		op: in std_logic_vector(1 downto 0)
	);
end myALU;

architecture myALU_arch of myALU is

	signal sig_sum, sig_rest : signed(N-1 downto 0);
	signal ov_res, ov_sum : std_logic;
	signal sig_r : std_logic_vector(N-1 downto 0);
begin
	sig_sum <= signed(a) + signed(b);
	sig_rest <= signed(a) - signed(b); 

	with op select
		   sig_r <= std_logic_vector(sig_sum) when "00",
			std_logic_vector(sig_rest) when "01",
			(a and b) when "10",
			(a or b) when "11";
	
	ov_sum <= ( a(N-1) and b(N-1) and not sig_r(N-1) ) or ( not a(N-1) and not b(N-1) and sig_r(N-1) );		
	ov_res <= ( not a(N-1) and b(N-1) and sig_r(N-1) ) or ( a(N-1) and not b(N-1) and not sig_r(N-1) );	

	with op select
		ov <= ov_sum when "00", ov_res when "01", '0' when others;
		
	r <= sig_r;	
		
end myALU_arch;

--casos de overflow: en suma: (a(:1 b:1 r:0), (a:0 b:0 r:1)   (a+b siendo positivos no puede dar neg. ni al revez)
--casos de overflow : en resta: (a:0, b:1, r:1), (a:1, b:0, r:0) (a-(-Magnitud de b) termina siendo suma de dos pos, no puede dar neg.
--nota: solo miro el MSB, ya que indica el signo.
