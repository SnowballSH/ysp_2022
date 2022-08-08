using Primes

#=
Fermat's Little Theorem
If p is prime and a∈ℤ and gcd(a, p) = 1, then a^(p-1) ≡ 1 (mod p)

Converse is "almost true"
=#

fermat(a::Int, p::Int)::Bool = isprime(p) && gcd(a, p) == 1

println(fermat(2, 3))   # true
println(fermat(7, 4))   # false
println(fermat(22, 11)) # false
println(fermat(24, 11)) # true
