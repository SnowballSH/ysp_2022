# Sigma Sum function
# Computes the sum of fn(x) for all integers a ≤ x ≤ b
function Σ(a::Int, b::Int, fn)
    r = 0
    for x = a:b
        r += fn(x)
    end
    return r
end

# Example
println(Σ(2, 5, x -> x))  # 2 + 3 + 4 + 5 = 14

# Example 1: Sum of squares - sum of numbers
ex1(n) = Σ(1, n, x -> x^2) - Σ(1, n, x -> x)

println(ex1(5))  # 1^2 + 2^2 + 3^2 + 4^2 + 5^2 - 1 - 2 - 3 - 4 - 5 = 40
println(ex1(12345))  # 627121983760

# Σ(1, n, x -> x^2) - Σ(1, n, x -> x) = n(n + 1)(2n + 1)/6 - n(n + 1)/2 = n(n + 1)(n - 1)/3
ex1_algebra(n) = n * (n + 1) * (n - 1) / 3

println(Int(ex1_algebra(12345)))  # 627121983760, but (probably) faster
