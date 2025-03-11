using Processes
struct TestAlgo end

function (::TestAlgo)(args)
    @hasarg if ja
        println("Ja")
    end
    @hasarg if nej
        println("Nej")
    end
    return
end

p = Process(TestAlgo, ja = 1)
start(p)