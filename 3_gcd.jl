# Euclidean Algorithm. Calculates the GCD of two integers
# Julia builtin: gcd()
function euclidean_algorithm(a::Int, b::Int)::Int
    # force a > n
    if a < b
        a, b = b, a
    end
    while (b != 0)
        q = a ÷ b
        r = a - b * q

        a, b = b, r
    end
    return a
end

println("gcd(13753, 55029) = ", euclidean_algorithm(13753, 55029))

# Extended Euclidean Algorithm. Calculates the GCD of two integers AND the Bézout Coefficients
# Julia builtin: gcdx()
function extended_euclidean_algorithm(a::Int, b::Int)::Tuple{Int,Int,Int}
    # force a > n
    swapped = false
    if a < b
        a, b = b, a
        swapped = true
    end
    s0, s1, t0, t1 = 1, 0, 0, 1
    while (b != 0)
        q = a ÷ b
        a, b = b, a - b * q
        s0, s1 = s1, s0 - s1 * q
        t0, t1 = t1, t0 - t1 * q
    end
    if (swapped)
        s0, t0 = t0, s0
    end
    return (a, s0, t0)
end

res = extended_euclidean_algorithm(13753, 55029)
println("                  = 13753 * $(res[2]) + 55029 * $(res[3])")
