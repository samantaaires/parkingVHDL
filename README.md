parkingVHDL
===========

COMO COMPILAR E EXECUTAR O PROJETO

Para fins visuais, decidimos executar o projeto no compilador/ simulador ModelSim, da Altera.

1. Crie um projeto no ModelSim: File > New > Project;
2. Abrirá uma janela na qual deverá ser escolhida a opção “ Add Existing File”, então adicione os arquivos “. vhd” ao projeto;
3. Na barra de menus escolha a opção Compile > Compile All;
4. Em seguida na barra de menus selecione a opção Simulation > Start Simulation;
5. Na janela que abrirá, escolha a biblioteca “ work”, selecione todos os arquivos e clique em OK;
6. Na janela flutuante “Objects” selecione os seguintes itens: clk, Entrada_Saida, Botao, Carro_Moto, EnderecoEntrada, Numero_vagas e Falha, clique com o botão direito em cima da seleção e selecione Add to > Wave > Selected Signals;
7. Na janela flutuante Wave informe o valor desejado para cada item de entrada e, escolha na barra de menu a opção Simulate > Run > Run All (F9).
