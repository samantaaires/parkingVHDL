library ieee;
use ieee.std_logic_1164.all;

entity registerBankParking is 
	port (clock,reset: in std_logic; -- lw_sw: '1' escreve, '0' ler.
			remove_auto,lw_sw: in bit;
		  endereco: in std_logic_vector(3 downto 0); -- São apenas 5 vagas.
		  entrada_dados: in std_logic_vector(9 downto 0); -- apenas os minutos: 59.
		  saida_dados: out std_logic_vector(9 downto 0)
		 );

end registerBankParking;

architecture arc of registerBankParking is
signal reg0: std_logic_vector(9 downto 0) := "0000000001";
signal reg1: std_logic_vector(9 downto 0) := "0000000010";
signal reg2: std_logic_vector(9 downto 0) := "0000000100";
signal reg3: std_logic_vector(9 downto 0) := "0000001000";
signal reg4: std_logic_vector(9 downto 0) := "0000010000";
signal reg5: std_logic_vector(9 downto 0) := "0000100000";
signal reg6: std_logic_vector(9 downto 0) := "0001000000";
signal reg7: std_logic_vector(9 downto 0) := "0010000000";
signal reg8: std_logic_vector(9 downto 0) := "0100000000";
signal reg9: std_logic_vector(9 downto 0) := "1000000000";
begin


with endereco select -- leitura dos dados
	saida_dados <= reg0 when "0000",
						reg1 when "0001",
						reg2 when "0010",
						reg3 when "0011",
						reg4 when "0100",
						reg5 when "0101",
						reg6 when "0110",
						reg7 when "0111",
						reg8 when "1000",
						reg9 when "1001",

						"0000000000" when others;

process(clock,reset,remove_auto)
begin

	if (reset = '1' and remove_auto /= '1') then
		reg0 <= "0000000000";
		reg1 <= "0000000000";
		reg2 <= "0000000000";
		reg3 <= "0000000000";
		reg4 <= "0000000000";
		reg5 <= "0000000000";
		reg6 <= "0000000000";
		reg7 <= "0000000000";
		reg8 <= "0000000000";
		reg9 <= "0000000000";


	elsif (clock = '1' and clock'event) then
		if(lw_sw = '1') then -- escrita dos dados
			case endereco is
				when "0000" => reg0 <= entrada_dados;
				when "0001" => reg1 <= entrada_dados;
				when "0010" => reg3 <= entrada_dados;
				when "0011" => reg3 <= entrada_dados;
				when "0100" => reg4 <= entrada_dados;
				when "0101" => reg5 <= entrada_dados;
				when "0110" => reg6 <= entrada_dados;
				when "0111" => reg7 <= entrada_dados;
				when "1000" => reg8 <= entrada_dados;
				when "1001" => reg9 <= entrada_dados;
						
				when others => reg0 <= "0000000000";	
			end case;
		end if;
	
		if(remove_auto= '1') then
			case endereco is
				when "0000" => reg0 <= "0000000000";
				when "0001" => reg1 <= "0000000000";
				when "0010" => reg3 <= "0000000000";
				when "0011" => reg3 <= "0000000000";
				when "0100" => reg4 <= "0000000000";
				when "0101" => reg5 <= "0000000000";
				when "0110" => reg6 <= "0000000000";
				when "0111" => reg7 <= "0000000000";
				when "1000" => reg8 <= "0000000000";
				when "1001" => reg9 <= "0000000000";
						
				when others => reg0 <= "0000000000";	
			end case;
		end if;
	end if;
end process;

end arc;
