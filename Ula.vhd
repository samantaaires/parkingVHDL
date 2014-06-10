library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Ula is
	port (horario_entrada: in std_logic_vector(9 downto 0);
			horario_atual: in std_logic_vector(9 downto 0);
			led: out bit -- se 0: verde,não paga. 1: vermelho, paga
			);
end Ula;

architecture arc of Ula is
signal horarioEntrada,horarioAtual: std_logic_vector(9 downto 0);
begin

horarioEntrada <= horario_entrada;
horarioAtual <= horario_atual;

process(horarioEntrada,horarioAtual)
begin
	if (horarioEntrada + "0000000010" <= horarioAtual) then
		led <= '1'; -- Pagará.	
	end if;
	
end process;
end arc;
		
