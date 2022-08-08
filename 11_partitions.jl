#=
Integer Partitions
p(n) = # of non-increasing sequences of positive integers that sum to N
=#

# O(N^2) algorithm to compute p(n) up to maxn
function p_table(maxn::Int)::Vector{Int}
    table = zeros(Int, maxn, maxn)
    for n = 1:maxn
        for k = reverse(1:n)
            if k > n
                table[k, n] = 0
            elseif k == n
                table[k, n] = 1
            else
                table[k, n] = table[k, n-k] + table[k+1, n]
            end
        end
    end

    result = zeros(Int, maxn)
    for i = 1:maxn
        result[i] = table[1, i]
    end

    return result
end

p = p_table(1000)

for i = 1:10
    println(p[i])
end

println(p[123])
