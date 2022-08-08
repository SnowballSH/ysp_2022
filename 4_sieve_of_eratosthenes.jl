# Sieve of Erathosthenes generates all prime numbers not exceeding n
# Time Complexity: O(n * log(log(n)))
# There are O(n) variations of this algorithm, but this is the simplest.
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

println(sieve_of_eratosthenes(1000))
