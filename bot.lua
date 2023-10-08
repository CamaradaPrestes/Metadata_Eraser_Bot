local discordia = require('discordia')
local client = discordia.Client()

client:on('messageCreate', function(message)
    if message.author.bot then
        return -- Ignorar mensagens de outros bots
    end

    if message.attachments and #message.attachments > 0 then
        local lastAttachment = message.attachments[#message.attachments] -- Pegar a última imagem anexada

        local fileName = lastAttachment.filename
        local imageUrl = lastAttachment.url
        local imageMessage = message.content
        local authorName = message.author.username

        -- Crie um embed e configure a imagem como um campo
        local embed = {
            title = authorName .. " :", -- Nome do autor da mensagem original
            image = { url = imageUrl },
            color = 0xFF0000, -- Cor do embed (vermelho)

            -- Se tiver uma mensagem junto com a imagem anexada, aparecerá no rodapé do embed
            footer = {
                text = imageMessage ~= "" and imageMessage or "Sem mensagem adicional."
            },

        }

        -- Envie o embed no mesmo chat.
        message.channel:send { embed = embed }

        -- Apague a mensagem original com a imagem
        message:delete()
    end
end)

client:run('Bot YOUR_BOT_TOKEN')
