macro Test(expr)
    return QuoteNode(:a)
end

@Test function impossibledef(a,b; @test = (;g = 1))
    return a + b
end