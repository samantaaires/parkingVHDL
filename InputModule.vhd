library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity InputModule is
	port(in_out: in bit; -- 0: entra; 1: sai.
		  button: in bit; -- para enviar os dados.
		  Car_Moto: in std_logic_vector(1 downto 0); -- 00: carro; 01: moto; outros: falho.
		  AdressIn: in std_logic_vector(3 downto 0); -- endereço pra tirar do reg.
		  
		  AdressOut: out std_logic_vector(3 downto 0);
		  ticket: out bit; -- 1: abre a cancela e recebe o horário.
		  remove: out bit;
		  led: out bit; -- 0: verde, 1: vermelho
		  saida_bcd: out std_logic_vector(3 downto 0) 
		  );
end InputModule;

architecture arc of InputModule is
signal num_vagas: std_logic_vector(3 downto 0) := "1010";
begin
saida_bcd <= num_vagas;
	process(in_out,button,Car_Moto,AdressIn)
	begin
		if (button = '1') then
			if (in_out = '0') then
					if (Car_Moto = "00" or Car_Moto = "01") then
						ticket <= '1';
						num_vagas <= num_vagas - "0001";
						led <= '0';
					else
						led <= '1'; -- invalido
					end if;
				end if;
		end if;
		if (In_out = '1') then 
			remove <= '1'; -- ler e resetar o registrador do endereco que passar.
			AdressOut <= AdressIn;
			led <= '0';
			num_vagas <= num_vagas + "0001";
			end if;
	end process;
end arc;
