library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test1 is
    generic(
      	constant_width : integer := 8
      );
    port(
    	in_a, in_b : in std_logic_vector(3 downto 0);
    	in_clk, in_rst, in_strt: in std_logic;
    	out_rdy: out std_logic;
    	out_res : out std_logic_vector(7 downto 0)
		
    );
end test1;

architecture test1_arch of test1 is
--types
	type tip_edo is(disp, nulo, carg, oper);

--signals
	signal decr_out : unsigned (3 downto 0);
	signal sum_out : unsigned (7 downto 0);
	
	signal ra_fut, rb_fut : std_logic_vector(3 downto 0);
	signal ra, rb : std_logic_vector(3 downto 0);
	
	signal r, r_fut : std_logic_vector(7 downto 0);
	
	signal beq0, aeq0, rbeq0 : std_logic;
	
	signal rstat, rstat_fut : tip_edo;
	
begin
--data path

--segment 1 / operators
	decr_out <= unsigned(rb) - 1;
	sum_out <= unsigned(ra) + unsigned(r);
--segment 2 / comparators
	beq0 <= '1' when in_b = "0000" else '0';
	aeq0 <= '1' when in_a = "0000" else '0';	 
	rbeq0 <= '1' when rb_fut = "0000" else '0';
--segment 3 / muxes
	process(decr_out, sum_out, in_a, in_b, rstat)
	
	begin
		case rstat is
			when nulo | carg => 
				ra_fut <= in_a;
				rb_fut <= in_b;
				r_fut  <= r;			
			when oper => 
				r_fut <= std_logic_vector(sum_out);
				rb_fut <= std_logic_vector(decr_out);
				ra_fut <= ra;
			when disp => 
				ra_fut <= in_a;
				rb_fut <= in_b;
				r_fut <= r;
		end case;
	end process;
--segment 4 / data regs.
	process(in_clk,in_rst)
	
	begin
		if in_rst = '1' then
			ra <= (others =>'0');
			rb <= (others =>'0');
			r <= (others =>'0');
		elsif rising_edge(in_clk) then 
			ra <= ra_fut;
			rb <= rb_fut;
			r <= r_fut;
		end if;
		
	end process;

--segment 5 / output logic.
	out_res <= r;
	
--control path
--segment 6 / state regs
	process(in_clk,in_rst)
	begin
	
	if in_rst = '1' then rstat <= disp;
	elsif rising_edge(in_clk) then rstat <= rstat_fut;
	end if;
	
	end process;
--segment 7 future logic state
	process(rstat, in_strt, aeq0, beq0, rbeq0)
	begin
	
	case rstat is
		when disp => 
			if in_strt = '1' then
				if(aeq0 = '1' or beq0 = '1') then rstat_fut <= nulo;
				else rstat_fut <= carg;
				end if;
			else rstat_fut <= disp;
			end if;
		when nulo => rstat_fut <= disp;
		when carg => rstat_fut <= oper;
		when oper => 
			if rbeq0 = '1' then rstat_fut <= disp;
			else rstat_fut <= oper;
			end if;
	end case;
	end process;
--segment 8 / output logic
	out_rdy <= '1' when rstat <= disp else '0';
	
end architecture test1_arch;
