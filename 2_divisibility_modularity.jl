# Divisibility

# a, b∈𝐍: a | b ⟺ ak = b for some k∈𝐍

# Naive Implementation
divides_naive(a::Int, b::Int)::Bool = any(k -> a * k == b, 1:b)

println("Naive Divisibility")
println(divides_naive(3, 12))
println(divides_naive(5, 12))
println(divides_naive(12, 3))

println()

divides_rem(a::Int, b::Int)::Bool = mod(b, a) == 0

println("Divisibility With Remainder")
println(divides_rem(3, 12))
println(divides_rem(5, 12))
println(divides_rem(12, 3))

println()

#=
Prime Numbers & Composite
Will be discussed in detail later
=#

#=
Modularity
m, n, k, r∈𝐙: m = nk + r ⟺ m ≡ r (mod n)

x ≡ a (mod k), y ≡ b (mod k) ⟹
1. x + y ≡ a + b (mod k)
2. x - y ≡ a - b (mod k)
3. xy ≡ ab (mod k)
4. x/y ≡ a/b (mod k) if gcd(y, k) = 1 and gcd(b, k) = 1
=#

function euclidean_division(a::Int, b::Int)::Pair{Int,Int}
    q = a ÷ b
    r = a % b
    if r < 0
        if b > 0
            q -= 1
            r += b
        else
            q += 1
            r -= b
        end
    end
    return Pair(q, r)
end

println("Euclidean Division")
q, r = euclidean_division(16, 3)
println("16 ÷ 3 = $q rem $r")
q, r = euclidean_division(2937107, 743)
println("2937107 ÷ 743 = $q rem $r")
q, r = euclidean_division(-89361761, 15735)
println("-89361761 ÷ 15735 = $q rem $r")
