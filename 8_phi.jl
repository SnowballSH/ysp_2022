using Primes

#=
Euler's Phi(Totient) Function
ϕ(n) = # of k such that k ∈ ℕ and 1 ≤ k ≤ n and gcd(k, n) = 1
=#

#=
Gauss's Theorem
Σ(d | n) ϕ(d) = n
=#

# Approach 1 Naive
function ϕ1(n)::Int
    c::Int = 0
    for k = 1:n
        if gcd(k, n) == 1
            c += 1
        end
    end
    return c
end

# Approach 2 Prime factorize
function ϕ2(n)::Int
    c::Int = 1
    pf = factor(n)
    for f::Pair{Int64,Int64} in pf
        c *= (f[1] - 1) * (f[1]^(f[2] - 1))
    end
    return c
end

# Approach 3 Euler's product formula
function ϕ3(n)::Int
    if isprime(n)
        return n - 1
    end

    c::Int = n
    table = factor(Set, n)

    for p in table
        if mod(n, p) == 0
            c *= p - 1
            c /= p
        end
    end

    return c
end

# Approach 4 Fourier transform
function Σf(a::Int, b::Int, fn)
    r::Float64 = 0
    for x = a:b
        r += fn(x)
    end
    return r
end

function ϕ4(n)::Int
    return round(Σf(1, n, k -> cos(2π * k / n) * gcd(k, n)))
end

# Approach 5 Divisor Sum
μ(n::Int)::Int = reduce(*, (p == 0 ? 0 : e == 1 ? -1 : 0) for (p, e) in factor(n) if p ≥ 0; init=1)

function ϕ5(n)::Int
    r::Int = 0
    for k::Int = 1:isqrt(n)
        if mod(n, k) == 0
            m = div(n, k)
            r += μ(k) * m
            if m != k
                r += μ(m) * k
            end
        end
    end
    return r
end

#=
Testing Performance of different computing methods
=#

# Compile
_ = ϕ1(97)
_ = ϕ2(97)
_ = ϕ3(97)
_ = ϕ4(97)
_ = ϕ5(97)

using Plots

function test_progress(maxn::Int)
    xs = 1:maxn
    ys = zeros(Float64, maxn, 5)

    for i in xs
        #if mod(i, div(maxn, 100)) == 0
        #    println("$(div(i, div(maxn, 100)))%")
        #end

        s = @timed ϕ1(i)
        ys[i, 1] = min(s.time * 1000, 1.0)

        s = @timed ϕ2(i)
        ys[i, 2] = min(s.time * 1000, 1.0)

        s = @timed ϕ3(i)
        ys[i, 3] = min(s.time * 1000, 1.0)

        s = @timed ϕ4(i)
        ys[i, 4] = min(s.time * 1000, 1.0)

        s = @timed ϕ5(i)
        ys[i, 5] = min(s.time * 1000, 1.0)
    end

    plot(xs, ys, label=["Naive" "Prime Factorize" "Product Formula" "Fourier Transform" "Divisor Sum"])

    xlabel!("N")
    ylabel!("Time (ms)")

    savefig("phi_progress.png")
end

test_progress(20000)

function test_avg()
    ranges = [1:100, 100:1000, 1000:10000, 10000:20000]
    ranges_text = ["1:100", "100:1000", "1000:10000", "10000:20000"]
    ys = zeros(Float64, length(ranges), 5)

    for (k, ran) in enumerate(ranges)
        for i in ran
            s = @timed ϕ1(i)
            ys[k, 1] += min(s.time * 1000, 1.0)

            s = @timed ϕ2(i)
            ys[k, 2] += min(s.time * 1000, 1.0)

            s = @timed ϕ3(i)
            ys[k, 3] += min(s.time * 1000, 1.0)

            s = @timed ϕ4(i)
            ys[k, 4] += min(s.time * 1000, 1.0)

            s = @timed ϕ5(i)
            ys[k, 5] += min(s.time * 1000, 1.0)
        end

        for j = 1:5
            ys[k, j] /= length(ran)
        end
    end

    plot(ranges_text, ys)

    xlabel!("Ns")
    ylabel!("Avergae Time (ms)")

    savefig("phi_average.png")
end

test_avg()
