using Processes

const data = rand(1000)

function Update(args)
    (;data) = args
    i = rand(1:length(data))
    data[i] = -data[i]
end

ps = [Process(Update;data) for i in 1:8]

start.(ps)
