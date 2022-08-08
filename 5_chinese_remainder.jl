#=
The Chinese Remainder Theorem (Sun Tzu's Theorem, 孙子定理)
states that if one knows the remainders of the Euclidean division of an integer n by several integers,
then one can determine uniquely the remainder of the division of n by the product of these integers, under the condition that the divisors are pairwise coprime
=#

# nums is a vector of pairs (x[i], y[i]) where z ≡ x[i] (mod y[i])
# returns pair(a, b), the optimal solution a and the modulus b. Any (a + bk) where k ∈ 𝚉 is a solution for z.
function chinese_remainder(nums::Vector{Pair{Int,Int}})::Pair{Int,Int}
    if (length(nums) == 0)
        return (0, 0)
    end
    if (length(nums) == 1)
        return nums[1]
    end

    while (length(nums) > 1)
        b, bm = pop!(nums)
        a, am = pop!(nums)

        d, s, = gcdx(am, bm)  # gcd(am, bm) and Bezout coefficient for am
        m = am * bm ÷ d  # lcm(am, bm)

        z = mod(am * s * (b - a) + a, m)
        push!(nums, z => m)
    end

    return nums[1]
end

println(Tuple(chinese_remainder([7 => 9, 3 => 25, 9 => 22])))
