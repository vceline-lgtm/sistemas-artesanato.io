\# Sistema de Gestão Rodoviária
## 1\. Descrição do Minimundo
Este projeto visa resolver os desafios operacionais e logísticos de uma \*\*Empresa de Transporte Rodoviário Intermunicipal e Interestadual\*\*. O sistema tem como objetivo principal gerenciar a venda de passagens, o agendamento de viagens, a alocação de frota de ônibus e o mapeamento de itinerários.

## 2\. Problema do Mundo Real a ser Resolvido
Em linhas rodoviárias de média e longa distância, uma viagem não transporta apenas passageiros do ponto inicial ao ponto final da rota. O ônibus realiza paradas em diversas
\*\*cidades intermediárias\*\* ao longo do percurso. O problema central que este banco de dados resolve é permitir que uma passagem comprada por um cliente possa cobrir apenas o \*\*trecho fracionado\*\* em que ele realmente viajará. Dessa forma, o passageiro pode embarcar na cidade de origem e desembarcar em uma cidade intermediária, ou embarcar em uma cidade intermediária e ir até o destino final (ou entre duas cidades intermediárias), otimizando a venda de assentos e o controle de embarque.

## 3\. Regras de Negócio e Processos Atendidos
\* \*\*Gestão de Passageiros\*\*: Cada passageiro é identificado unicamente pelo seu CPF e pode realizar a compra de múltiplos bilhetes ao longo do tempo.
\* \*\*Emissão de Passagens Por Trecho\*\*: Cada passagem vendida vincula-se a uma viagem específica e indica obrigatoriamente a \*\*cidade de embarque\*\* e a \*\*cidade de desembarque\*\* do passageiro, além do número da poltrona reservada. \* \*\*Controle de Viagens e Frota\*\*: Uma viagem é uma execução agendada de uma rota em data e horário definidos, realizada por um ônibus específico. \* \*\*Lotação dos Veículos\*\*: O sistema controla a capacidade de assentos (\`cap\_assentos\`) de cada ônibus para evitar a venda de passagens acima da lotação máxima (\*overbooking\*). 
\* \*\*Itinerários e Paradas Intermediárias\*\*: Uma rota possui uma sequência de cidades por onde o ônibus passa. O sistema registra a ordem exata de parada (\`ordem\_parada\`) de cada cidade dentro do itinerário da linha.
