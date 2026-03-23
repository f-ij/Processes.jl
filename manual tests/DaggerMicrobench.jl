include("_env.jl")

using BenchmarkTools
using Dagger
using Random
using Statistics

@inline merge_ctx(base::B, deltas::Vararg{Any,N}) where {B,N} = isempty(deltas) ? base : merge(base, deltas...)

@inline function source_x(base::B) where {B}
    x = base.x_signal
    @inbounds @simd for i in eachindex(x)
        xi = x[i]
        x[i] = sin(xi + 0.01) + cos(0.25 * xi - 0.01) + 0.0000004 * i
    end
    return (; x_signal = x)
end

@inline function source_y(base::B) where {B}
    y = base.y_signal
    @inbounds @simd for i in eachindex(y)
        yi = y[i]
        y[i] = cos(yi + 0.015) + tanh(0.5 * yi - 0.015) + 0.0000003 * i
    end
    return (; y_signal = y)
end

@inline function stage_a(base::B, deltas::Vararg{Any,N}) where {B,N}
    ctx = merge_ctx(base, deltas...)
    x = ctx.x_signal
    y = ctx.a_vec
    @inbounds @simd for i in eachindex(y)
        xi = x[i]
        y[i] = sin(xi) + sqrt(abs(xi) + 1)
    end
    return (; a_vec = y)
end

@inline function stage_b(base::B, deltas::Vararg{Any,N}) where {B,N}
    ctx = merge_ctx(base, deltas...)
    x = ctx.x_signal
    y = ctx.b_vec
    @inbounds @simd for i in eachindex(y)
        xi = x[i]
        y[i] = cos(xi) + abs(xi)
    end
    return (; b_vec = y)
end

@inline function stage_c(base::B, deltas::Vararg{Any,N}) where {B,N}
    ctx = merge_ctx(base, deltas...)
    x = ctx.y_signal
    y = ctx.c_vec
    @inbounds @simd for i in eachindex(y)
        xi = x[i]
        y[i] = exp(-abs(xi)) + 0.001 * xi * xi
    end
    return (; c_vec = y)
end

@inline function join_d(base::B, deltas::Vararg{Any,N}) where {B,N}
    ctx = merge_ctx(base, deltas...)
    a = ctx.a_vec
    c = ctx.c_vec
    y = ctx.d_vec
    @inbounds @simd for i in eachindex(y)
        ai = a[i]
        ci = c[i]
        y[i] = muladd(0.7, ai, 0.3 * ci) + sin(ai - ci)
    end
    return (; d_vec = y)
end

@inline function join_e(base::B, deltas::Vararg{Any,N}) where {B,N}
    ctx = merge_ctx(base, deltas...)
    b = ctx.b_vec
    c = ctx.c_vec
    y = ctx.e_vec
    @inbounds @simd for i in eachindex(y)
        bi = b[i]
        ci = c[i]
        y[i] = 0.5 * bi + 0.5 * ci + cos(bi + ci)
    end
    return (; e_vec = y)
end

@inline function stage_f(base::B, deltas::Vararg{Any,N}) where {B,N}
    ctx = merge_ctx(base, deltas...)
    a = ctx.a_vec
    e = ctx.e_vec
    y = ctx.f_vec
    @inbounds @simd for i in eachindex(y)
        ai = a[i]
        ei = e[i]
        y[i] = tanh(ai + ei) + 0.1 * (ai - ei)
    end
    return (; f_vec = y)
end

@inline function stage_g(base::B, deltas::Vararg{Any,N}) where {B,N}
    ctx = merge_ctx(base, deltas...)
    d = ctx.d_vec
    e = ctx.e_vec
    y = ctx.g_vec
    @inbounds @simd for i in eachindex(y)
        di = d[i]
        ei = e[i]
        y[i] = sqrt(abs(di * ei) + 1) + sin(di) - cos(ei)
    end
    return (; g_vec = y)
end

@inline function stage_h(base::B, deltas::Vararg{Any,N}) where {B,N}
    ctx = merge_ctx(base, deltas...)
    b = ctx.b_vec
    d = ctx.d_vec
    y = ctx.h_vec
    @inbounds @simd for i in eachindex(y)
        bi = b[i]
        di = d[i]
        y[i] = exp(-abs(bi - di)) + 0.05 * (bi + di)
    end
    return (; h_vec = y)
end

@inline function reducer_vec(base::B, deltas::Vararg{Any,N}) where {B,N}
    ctx = merge_ctx(base, deltas...)
    f = ctx.f_vec
    g = ctx.g_vec
    h = ctx.h_vec
    total = 0.0
    @inbounds @simd for i in eachindex(f)
        fi = f[i]
        gi = g[i]
        hi = h[i]
        total += fi + gi + hi + 0.1 * fi * gi
    end
    return (; total)
end

@inline function metric_a(base::B, deltas::Vararg{Any,N}) where {B,N}
    ctx = merge_ctx(base, deltas...)
    x = ctx.x_signal
    total = 0.0
    @inbounds for rep in 1:12
        @simd for i in eachindex(x)
            xi = x[i]
            total += sin(xi + 0.03 * rep) + cos(1.1 * xi - 0.02 * rep) + sqrt(abs(xi) + rep)
        end
    end
    return (; a_metric = total)
end

@inline function metric_b(base::B, deltas::Vararg{Any,N}) where {B,N}
    ctx = merge_ctx(base, deltas...)
    x = ctx.x_signal
    total = 0.0
    @inbounds for rep in 1:12
        @simd for i in eachindex(x)
            xi = x[i]
            total += tanh(xi + rep) + abs(xi) / (rep + 1)
        end
    end
    return (; b_metric = total)
end

@inline function metric_c(base::B, deltas::Vararg{Any,N}) where {B,N}
    ctx = merge_ctx(base, deltas...)
    x = ctx.y_signal
    total = 0.0
    @inbounds for rep in 1:12
        @simd for i in eachindex(x)
            xi = x[i]
            total += exp(-abs(xi) / (rep + 1)) + 0.002 * xi * xi
        end
    end
    return (; c_metric = total)
end

@inline function metric_d(base::B, deltas::Vararg{Any,N}) where {B,N}
    ctx = merge_ctx(base, deltas...)
    return (; d_metric = 0.7 * ctx.a_metric + 0.3 * ctx.c_metric + sin(ctx.a_metric - ctx.c_metric))
end

@inline function metric_e(base::B, deltas::Vararg{Any,N}) where {B,N}
    ctx = merge_ctx(base, deltas...)
    return (; e_metric = 0.5 * ctx.b_metric + 0.5 * ctx.c_metric + cos(ctx.b_metric + ctx.c_metric))
end

@inline function metric_f(base::B, deltas::Vararg{Any,N}) where {B,N}
    ctx = merge_ctx(base, deltas...)
    return (; f_metric = tanh(ctx.a_metric + ctx.e_metric) + 0.1 * (ctx.a_metric - ctx.e_metric))
end

@inline function metric_g(base::B, deltas::Vararg{Any,N}) where {B,N}
    ctx = merge_ctx(base, deltas...)
    return (; g_metric = sqrt(abs(ctx.d_metric * ctx.e_metric) + 1) + sin(ctx.d_metric) - cos(ctx.e_metric))
end

@inline function metric_h(base::B, deltas::Vararg{Any,N}) where {B,N}
    ctx = merge_ctx(base, deltas...)
    return (; h_metric = exp(-abs(ctx.b_metric - ctx.d_metric)) + 0.05 * (ctx.b_metric + ctx.d_metric))
end

@inline function reducer_metric(base::B, deltas::Vararg{Any,N}) where {B,N}
    ctx = merge_ctx(base, deltas...)
    total = ctx.f_metric + ctx.g_metric + ctx.h_metric + 0.1 * ctx.f_metric * ctx.g_metric
    return (; total)
end

function make_vector_bases(n, start_x, start_y)
    return (
        sx = (; x_signal = copy(start_x)),
        sy = (; y_signal = copy(start_y)),
        a = (; a_vec = zeros(n)),
        b = (; b_vec = zeros(n)),
        c = (; c_vec = zeros(n)),
        d = (; d_vec = zeros(n)),
        e = (; e_vec = zeros(n)),
        f = (; f_vec = zeros(n)),
        g = (; g_vec = zeros(n)),
        h = (; h_vec = zeros(n)),
        r = (;),
    )
end

function make_metric_bases(start_x, start_y)
    return (
        sx = (; x_signal = copy(start_x)),
        sy = (; y_signal = copy(start_y)),
        a = (;),
        b = (;),
        c = (;),
        d = (;),
        e = (;),
        f = (;),
        g = (;),
        h = (;),
        r = (;),
    )
end

function run_seq_vector(b::B) where {B}
    sx = source_x(b.sx)
    sy = source_y(b.sy)
    a = stage_a(b.a, sx)
    bb = stage_b(b.b, sx)
    c = stage_c(b.c, sy)
    d = join_d(b.d, a, c)
    e = join_e(b.e, bb, c)
    f = stage_f(b.f, a, e)
    g = stage_g(b.g, d, e)
    h = stage_h(b.h, bb, d)
    return reducer_vec(b.r, f, g, h)
end

function run_threads_vector(b::B) where {B}
    sx = Threads.@spawn source_x(b.sx)
    sy = Threads.@spawn source_y(b.sy)
    a = Threads.@spawn stage_a(b.a, fetch(sx))
    bb = Threads.@spawn stage_b(b.b, fetch(sx))
    c = Threads.@spawn stage_c(b.c, fetch(sy))
    d = Threads.@spawn join_d(b.d, fetch(a), fetch(c))
    e = Threads.@spawn join_e(b.e, fetch(bb), fetch(c))
    f = Threads.@spawn stage_f(b.f, fetch(a), fetch(e))
    g = Threads.@spawn stage_g(b.g, fetch(d), fetch(e))
    h = Threads.@spawn stage_h(b.h, fetch(bb), fetch(d))
    r = Threads.@spawn reducer_vec(b.r, fetch(f), fetch(g), fetch(h))
    return fetch(r)
end

function run_dagger_vector(b::B) where {B}
    sx = Dagger.@spawn source_x(b.sx)
    sy = Dagger.@spawn source_y(b.sy)
    a = Dagger.@spawn stage_a(b.a, sx)
    bb = Dagger.@spawn stage_b(b.b, sx)
    c = Dagger.@spawn stage_c(b.c, sy)
    d = Dagger.@spawn join_d(b.d, a, c)
    e = Dagger.@spawn join_e(b.e, bb, c)
    f = Dagger.@spawn stage_f(b.f, a, e)
    g = Dagger.@spawn stage_g(b.g, d, e)
    h = Dagger.@spawn stage_h(b.h, bb, d)
    r = Dagger.@spawn reducer_vec(b.r, f, g, h)
    return fetch(r)
end

@inline function dagger_vector_left(b::B) where {B}
    sx = source_x(b.sx)
    a = stage_a(b.a, sx)
    bb = stage_b(b.b, sx)
    return (; sx..., a..., bb...)
end

@inline function dagger_vector_right(b::B) where {B}
    sy = source_y(b.sy)
    c = stage_c(b.c, sy)
    return (; sy..., c...)
end

@inline function dagger_vector_tail(b::B, tx::TX, ty::TY) where {B,TX,TY}
    d = join_d(b.d, tx, ty)
    e = join_e(b.e, tx, ty)
    f = stage_f(b.f, tx, e)
    g = stage_g(b.g, d, e)
    h = stage_h(b.h, tx, d)
    return reducer_vec(b.r, f, g, h)
end

function run_dagger_vector_coarse(b::B) where {B}
    tx = Dagger.@spawn dagger_vector_left(b)
    ty = Dagger.@spawn dagger_vector_right(b)
    tr = Dagger.@spawn dagger_vector_tail(b, tx, ty)

    return fetch(tr)
end

function run_seq_metric(b::B) where {B}
    sx = source_x(b.sx)
    sy = source_y(b.sy)
    a = metric_a(b.a, sx)
    bb = metric_b(b.b, sx)
    c = metric_c(b.c, sy)
    d = metric_d(b.d, a, c)
    e = metric_e(b.e, bb, c)
    f = metric_f(b.f, a, e)
    g = metric_g(b.g, d, e)
    h = metric_h(b.h, bb, d)
    return reducer_metric(b.r, f, g, h)
end

function run_threads_metric(b::B) where {B}
    sx = Threads.@spawn source_x(b.sx)
    sy = Threads.@spawn source_y(b.sy)
    a = Threads.@spawn metric_a(b.a, fetch(sx))
    bb = Threads.@spawn metric_b(b.b, fetch(sx))
    c = Threads.@spawn metric_c(b.c, fetch(sy))
    d = Threads.@spawn metric_d(b.d, fetch(a), fetch(c))
    e = Threads.@spawn metric_e(b.e, fetch(bb), fetch(c))
    f = Threads.@spawn metric_f(b.f, fetch(a), fetch(e))
    g = Threads.@spawn metric_g(b.g, fetch(d), fetch(e))
    h = Threads.@spawn metric_h(b.h, fetch(bb), fetch(d))
    r = Threads.@spawn reducer_metric(b.r, fetch(f), fetch(g), fetch(h))
    return fetch(r)
end

function run_dagger_metric(b::B) where {B}
    sx = Dagger.@spawn source_x(b.sx)
    sy = Dagger.@spawn source_y(b.sy)
    a = Dagger.@spawn metric_a(b.a, sx)
    bb = Dagger.@spawn metric_b(b.b, sx)
    c = Dagger.@spawn metric_c(b.c, sy)
    d = Dagger.@spawn metric_d(b.d, a, c)
    e = Dagger.@spawn metric_e(b.e, bb, c)
    f = Dagger.@spawn metric_f(b.f, a, e)
    g = Dagger.@spawn metric_g(b.g, d, e)
    h = Dagger.@spawn metric_h(b.h, bb, d)
    r = Dagger.@spawn reducer_metric(b.r, f, g, h)
    return fetch(r)
end

@inline function dagger_metric_left(b::B) where {B}
    sx = source_x(b.sx)
    a = metric_a(b.a, sx)
    bb = metric_b(b.b, sx)
    return (; sx..., a..., bb...)
end

@inline function dagger_metric_right(b::B) where {B}
    sy = source_y(b.sy)
    c = metric_c(b.c, sy)
    return (; sy..., c...)
end

@inline function dagger_metric_tail(b::B, tx::TX, ty::TY) where {B,TX,TY}
    d = metric_d(b.d, tx, ty)
    e = metric_e(b.e, tx, ty)
    f = metric_f(b.f, tx, e)
    g = metric_g(b.g, d, e)
    h = metric_h(b.h, tx, d)
    return reducer_metric(b.r, f, g, h)
end

function run_dagger_metric_coarse(b::B) where {B}
    tx = Dagger.@spawn dagger_metric_left(b)
    ty = Dagger.@spawn dagger_metric_right(b)
    tr = Dagger.@spawn dagger_metric_tail(b, tx, ty)

    return fetch(tr)
end

function bench_seconds(f::F, builder::B; samples = 8) where {F,B}
    bench = @benchmarkable $f(bases) setup = (bases = $(builder)()) evals = 1
    bench.params.samples = samples
    trial = run(bench)
    return (
        minimum = minimum(trial).time / 1e9,
        median = median(trial).time / 1e9,
        mean = mean(trial).time / 1e9,
        allocs = trial.allocs,
        bytes = trial.memory,
    )
end

function print_case(name, seq, th, dag)
    println(name)
    println("  Sequential median: ", round(seq.median; digits = 6), " s")
    println("  Threads median:    ", round(th.median; digits = 6), " s")
    println("  Dagger median:     ", round(dag.median; digits = 6), " s")
    println("  Threads / Seq:     ", round(th.median / seq.median; digits = 3), "x")
    println("  Dagger / Seq:      ", round(dag.median / seq.median; digits = 3), "x")
    println("  Dagger / Threads:  ", round(dag.median / th.median; digits = 3), "x")
    println("  Threads bytes:     ", th.bytes)
    println("  Dagger bytes:      ", dag.bytes)
    println()
end

function main()
    Random.seed!(1234)

    nvec = 250_000
    start_x_vec = randn(nvec)
    start_y_vec = randn(nvec)

    nmetric = 200_000
    start_x_metric = randn(nmetric)
    start_y_metric = randn(nmetric)

    vec_builder = () -> make_vector_bases(nvec, start_x_vec, start_y_vec)
    metric_builder = () -> make_metric_bases(start_x_metric, start_y_metric)

    seq_vec_once = run_seq_vector(vec_builder())
    th_vec_once = run_threads_vector(vec_builder())
    dag_vec_once = run_dagger_vector(vec_builder())
    dag_vec_coarse_once = run_dagger_vector_coarse(vec_builder())
    @assert isapprox(seq_vec_once.total, th_vec_once.total; rtol = 0.0, atol = 1e-8)
    @assert isapprox(seq_vec_once.total, dag_vec_once.total; rtol = 0.0, atol = 1e-8)
    @assert isapprox(seq_vec_once.total, dag_vec_coarse_once.total; rtol = 0.0, atol = 1e-8)

    seq_metric_once = run_seq_metric(metric_builder())
    th_metric_once = run_threads_metric(metric_builder())
    dag_metric_once = run_dagger_metric(metric_builder())
    dag_metric_coarse_once = run_dagger_metric_coarse(metric_builder())
    @assert isapprox(seq_metric_once.total, th_metric_once.total; rtol = 0.0, atol = 1e-8)
    @assert isapprox(seq_metric_once.total, dag_metric_once.total; rtol = 0.0, atol = 1e-8)
    @assert isapprox(seq_metric_once.total, dag_metric_coarse_once.total; rtol = 0.0, atol = 1e-8)

    vec_seq = bench_seconds(run_seq_vector, vec_builder)
    vec_th = bench_seconds(run_threads_vector, vec_builder)
    vec_dag = bench_seconds(run_dagger_vector, vec_builder)
    vec_dag_coarse = bench_seconds(run_dagger_vector_coarse, vec_builder)

    metric_seq = bench_seconds(run_seq_metric, metric_builder)
    metric_th = bench_seconds(run_threads_metric, metric_builder)
    metric_dag = bench_seconds(run_dagger_metric, metric_builder)
    metric_dag_coarse = bench_seconds(run_dagger_metric_coarse, metric_builder)

    println("Standalone Dagger microbench")
    println()
    print_case("Vector DAG", vec_seq, vec_th, vec_dag)
    print_case("Vector DAG (coarse Dagger)", vec_seq, vec_th, vec_dag_coarse)
    print_case("Scalar-heavy DAG", metric_seq, metric_th, metric_dag)
    print_case("Scalar-heavy DAG (coarse Dagger)", metric_seq, metric_th, metric_dag_coarse)
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
