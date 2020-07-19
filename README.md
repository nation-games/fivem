# nation_nitro
## Sistema simples de nitro para vRPex
![Alt text](https://cdn.discordapp.com/attachments/696769248990593110/734192489640099911/unknown.png "Screenshot")

## Instalação:
###### [1] - Dentro da tabela vrp_user_vehicles, crie uma nova coluna com o nome de "nitro", selecione o tipo de dado "INT" e defina seu valor padrão como 0.
![Alt text](https://cdn.discordapp.com/attachments/696769248990593110/734194764689440975/unknown.png "Screenshot2")

###### [2] - Coloque o script nation_nitro dentro da pasta resources de seu servidor e inicie ele pelo seu arquivo de configuração (server.cfg).

###### [3] - Para conseguir instalar o nitro em algum veículo, você deve acionar o evento "nation:nitro" (client-side), utilizando as funções TriggerEvent, TriggerClientEvent ou TriggerServerEvent. Por padrão, o evento aciona uma função chamada func.takeNitro(), a qual checa se o player possui o item "nitronos" no inventário. Você pode facilmente alterar a função e modificar o item dentro do server.lua. Você deve definir quando o evento será acionado, seja através de um item usável, ou algum comando, etc... Seja criativo! 

###### [4] - Com o nitro instalado no veículo, segure o "X" para ativá-lo.

## Qualquer dúvida --> Discord: Nation#4347
