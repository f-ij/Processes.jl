using Processes
struct TestAlgo end

function (::TestAlgo)(args)
    @hasarg if ja
        println(ja)
    end
    @hasarg if nej
        println(nej)
    end
    return
end

p = Process(TestAlgo, ja = 1)
start(p).,/