library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Controler is
	port(clk: in std_logic;
		  hour: out std_logic_vector(9 downto 0);
		  ledout: out bit; -- ula
		  
		  Entrada_Saida: in bit;
		  Botao: in bit;
		  Carro_Moto: in std_logic_vector(1 downto 0);
		  EnderecoEntrada: in std_logic_vector(3 downto 0);
		  Numero_vagas: out std_logic_vector(6 downto 0);
		  LedInput: out bit
		  
		  			  		 		  
		);
end Controler;

architecture arc of Controler is

------- INICIO DOS COMPONENTES -----------------

component Ula is
	port (horario_entrada: in std_logic_vector(9 downto 0);
			horario_atual: in std_logic_vector(9 downto 0);
			led: out bit-- se 0: verde,não paga. 1: vermelho, paga
			);
end component;

component InputModule is
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
end component;

component conversorBCD is
port( BCD : in STD_LOGIC_VECTOR(3 DOWNTO 0);      
      SEG : out STD_LOGIC_VECTOR(6 DOWNTO 0)
	 );  
end component;

component registerBankParking is 
	port (clock,reset: in std_logic; -- lw_sw: '1' escreve, '0' ler.
		  remove_auto,lw_sw: in bit;
		  endereco: in std_logic_vector(3 downto 0); -- São apenas 5 vagas.
		  entrada_dados: in std_logic_vector(9 downto 0); -- apenas os minutos: 59.
		  saida_dados: out std_logic_vector(9 downto 0)
		 );

end component;

------------------ SINAIS PARA PORT MAP ---------------------

signal leed: bit := '0';
signal res: std_logic;
signal saida_register: std_logic_vector(9 downto 0);

signal out_bcd,EnderecoSaida: std_logic_vector(3 downto 0);
signal codigo, remover,ledinp: bit;
signal num_vagas: std_logic_vector(6 downto 0);

-------------- SINAL DO RELOGIO DO CONTROLADOR ---------------------
signal h: std_logic_vector(9 downto 0) := "0000000000";
begin
Numero_vagas <= num_vagas;
LedInput <= ledinp;
ledout <= leed;
hour <= h;

process(clk)
begin
	if(clk = '1' and clk'event) then	
		h <= h + "0000000001";
	
	if (h = "0000111011") then	
		h <= "0000000000";
		
	end if;
	end if;
end process;

					I0: Ula port map (saida_register,h,leed);		
						
					I1: InputModule port map(Entrada_Saida,Botao,Carro_Moto,
													 EnderecoEntrada,EnderecoSaida,codigo,
													 remover,ledinp,out_bcd);
													 
					I2: ConversorBCD port map(out_bcd,num_vagas);
					
					I3: registerBankParking port map(clk,res,remover,codigo,EnderecoEntrada,h,saida_register);
													  


end arc;
