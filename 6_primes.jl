#=
Mersenne Primes
A Mersenne Prime is a prime number in the form of 2^p - 1
=#

# Lucas–Lehmer test
function is_mersenne(p::Int)::Bool
    if p == 2
        return true
    end

    s::UInt128 = 4
    m::UInt128 = 2^p - 1
    for _ = 1:(p-2)
        s = s * s - 2
        s = mod(s, m)
    end

    return iszero(s)
end

println(2^3 - 1, " ", is_mersenne(3))   # true
println(2^11 - 1, " ", is_mersenne(11)) # false
println(2^23 - 1, " ", is_mersenne(23)) # false
println(2^31 - 1, " ", is_mersenne(31)) # true


#=
Approximation of prime numbers below n
=#

# Borrowed from chapter 5
function sieve_of_eratosthenes(n::Int)::Vector{Int}
    table::Vector{Bool} = ones(Bool, n)

    for i = 2:isqrt(n)
        if table[i]
            k = i^2
            while k <= n
                table[k] = false
                k += i
            end
        end
    end

    result = empty(Vector{Int}(undef, 0))
    for i = 2:n
        if table[i]
            push!(result, i)
        end
    end

    return result
end

# π(n) ≈ n / log(n)
function approx_prime(n::Int)::Int
    return ceil(n / log(n))
end

for n in [10, 100, 1000, 10000, 100000, 10000000]
    actual = length(sieve_of_eratosthenes(n))
    approx = approx_prime(n)
    diff = approx - actual
    println("N = $n, Actual = $actual, Approx = $approx, Diff = $diff")
end
