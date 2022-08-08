using Primes

function ϕ(n)::Int
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

#=
Euler's Theorem
If a,n∈ℤ and gcd(a, n) = 1, then a^ϕ(n) ≡ 1 (mod n)
=#

# Computes a^ϕ(n) mod n
euler(a::Int, n::Int) = gcd(a, n) == 1 ? 1 : mod(a^ϕ(n), n)

println(euler(3, 4))   # 1
println(euler(8, 22))  # 12
println(euler(nextprime(1547653632), nextprime(1218424522542462)))  # 1
