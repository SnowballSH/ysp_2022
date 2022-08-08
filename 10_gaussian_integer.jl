import Base: ==, +, -, *, /, \, inv, ^, <, <=, <<, >>, %, ÷

# 𝚉[i] is the Gaussian Integer in the form a + bi
struct ZI
    real::Int
    imag::Int
end

tostring(self::ZI)::String = "($(self.real) + $(self.imag)i)"

# Conjugate
conj(self::ZI)::ZI = ZI(self.real, -self.imag)
# Length from origin to the 𝚉[i] on the complex plane
len(self::ZI)::Float64 = sqrt(self.real^2 + self.imag^2)
# Norm of 𝚉[i] = length^2
norm(self::ZI)::Int = self.real^2 + self.imag^2

# Binary operations
+(a::ZI, b::ZI)::ZI = ZI(a.real + b.real, a.imag + b.imag)
-(a::ZI, b::ZI)::ZI = ZI(a.real - b.real, a.imag - b.imag)
*(a::ZI, b::ZI)::ZI = ZI(a.real * b.real - a.imag * b.imag, a.real * b.imag + a.imag * b.real)

# Euclidean Algorithm on Gaussian Integers
function gcdzi(a::ZI, b::ZI)::ZI
    if (norm(a) < norm(b))
        a, b = b, a
    end
    while norm(b) != 0
        prod = a * conj(b)
        denom = norm(b)
        q = ZI(round(Int, prod.real / denom), round(Int, prod.imag / denom))
        r = a - b * q
        # println(tostring(a), " / ", tostring(b), " = ", tostring(q), " r ", tostring(r))
        a = b
        b = r
    end
    return a
end

# Extended Euclidean Algorithm on Gaussian Integers
function gcdxzi(a::ZI, b::ZI)::Tuple{ZI,Int,Int}
    swapped = false
    if (norm(a) < norm(b))
        a, b = b, a
        swapped = true
    end
    s0, s1, t0, t1 = 1, 0, 0, 1
    while norm(b) != 0
        prod = a * conj(b)
        denom = norm(b)
        q = ZI(round(Int, prod.real / denom), round(Int, prod.imag / denom))
        a, b = b, a - b * q
        s0, s1 = s1, s0 - s1 * q.real
        t0, t1 = t1, t0 - t1 * q.real
    end
    if (swapped)
        s0, t0 = t0, s0
    end
    return (a, s0, t0)
end

println(gcdxzi(ZI(-7, 11), ZI(-4, 7)))
