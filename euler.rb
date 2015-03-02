require 'pry'

def prime?(x)
  range = (3..Math.sqrt(x).to_i).to_a
  if x % 2 == 0
    return false
  else
    range.each do |number|
      if x % number == 0
        return false
      end
    end
  end
  return true
end

def get_all_primes(max)
  primes = (1..Math.sqrt(max).to_i).to_a
  primes.reject! {|num| !prime?(num)}
end

def prime_sieve(num)
  range = (2..num).to_a
  p = range[0]
  primes = []
  until range.empty?
    range.map do |num|
      if num%p == 0
        primes << p
        range.delete(num)
      end
    end
    p = range[0]
  end
  primes.uniq
end

def palindrone?(num)
  num.to_s.split('') == num.to_s.split('').reverse
end

def largest_palindrone
  max = 999 ** 2
  range = (100..999).to_a.reverse
  highest_num = 0
  highest_y = 0
  range.each do |x|
    if x > highest_y
      range.each do |y|
        if palindrone?(x*y) && x*y > highest_num
          highest_num = x*y
          highest_y = y
        end
      end
    else
      break
    end
  end
  highest_num
end

def largest_prime_factor(max)
  primes = []
  range = (1..Math.sqrt(max).to_i).to_a.reverse
  range.each do |num|
    if prime?(num)
      if max % num == 0
        return num
      end
    end
  end
  "No prime factors found"
end

def multiple_of_range?(range,num)
  range.each do |x|
    if num % x != 0
      return false
    end
  end
end

def smallest_mult(max)
  range = (1..max).to_a.reverse
  mult = max * (max-1) * (max-2)
  smallest = nil
  until smallest
    if multiple_of_range?(range, mult)
      smallest = mult
    end
    mult += max * (max-1) * (max-2)
  end
  smallest
end


def sum_sq_diff(limit)
  range = (1..limit).to_a
  sum_sq = 0
  sq_sum = 0
  range.each  do |x|
    sum_sq += x**2
    sq_sum += x
  end
  sq_sum**2 - sum_sq
end

def prime_to_length(limit)
  largest_prime = [2]
  num_check = 3
  while largest_prime.length < limit
    if prime?(num_check)
      largest_prime << num_check
    end
    num_check += 2
  end

  largest_prime[-1]

end


# problem 8
def multiply_array(array)
  product = 1
  array.each do |x|
    product = product * x.to_i
  end
  product
end


def largest_product(series, width)
  largest = 0
  array = series.to_s.split('')
  array[0..-width].each_with_index do |x, x_index|
    # binding.pry
    prod = multiply_array(array[x_index...x_index+width])
    if prod > largest
      largest = prod
    end
  end
  largest
end

# Problem 9
def pyth_finder(limit)
  a = (Math.sqrt(limit).to_i..limit/2)
  result = nil
  a.each do |var_a|
    b = (var_a+1..a.last)
    unless result
      b.each do |var_b|
        var_c = Math.sqrt(var_a**2 + var_b**2)
        sum = var_a + var_b + var_c
        if sum == limit
          result = [var_a, var_b, var_c]
          break
        end
      end
    end
  end
  p "a - #{result[0]}, b - #{result[1]}, c - #{result[2]}, sum = #{result.reduce(:+)}"
  p "product - #{result.reduce(:*)} "
end


# Problem 10

#  Brute force
def sum_of_primes(limit)
  start = Time.now
  range = (1..limit).to_a
  #  p "Total nums = #{range.length} at #{Time.now - start} sec"
  # range.reject! {|num| num != 2 && num % 2 == 0}
  #  p "After Evens = #{range.length} at #{Time.now - start} sec"
  # range.reject! {|num| num != 3 && num % 3 == 0}
  #  p "After Threes = #{range.length} at #{Time.now - start} sec"
  range.reject! {|num| !prime?(num) }
  p "After Primes = #{range.length} at #{Time.now - start} sec"
  p range.reduce(:+)

  p range.inject {|sum, n| sum + n} + 1
end

p sum_of_primes(2000000)

# largest = %w(08 02 22 97 38 15 00 40 00 75 04 05 07 78 52 12 50 77 91 08
# 49 49 99 40 17 81 18 57 60 87 17 40 98 43 69 48 04 56 62 00
# 81 49 31 73 55 79 14 29 93 71 40 67 53 88 30 03 49 13 36 65
# 52 70 95 23 04 60 11 42 69 24 68 56 01 32 56 71 37 02 36 91
# 22 31 16 71 51 67 63 89 41 92 36 54 22 40 40 28 66 33 13 80
# 24 47 32 60 99 03 45 02 44 75 33 53 78 36 84 20 35 17 12 50
# 32 98 81 28 64 23 67 10 26 38 40 67 59 54 70 66 18 38 64 70
# 67 26 20 68 02 62 12 20 95 63 94 39 63 08 40 91 66 49 94 21
# 24 55 58 05 66 73 99 26 97 17 78 78 96 83 14 88 34 89 63 72
# 21 36 23 09 75 00 76 44 20 45 35 14 00 61 33 97 34 31 33 95
# 78 17 53 28 22 75 31 67 15 94 03 80 04 62 16 14 09 53 56 92
# 16 39 05 42 96 35 31 47 55 58 88 24 00 17 54 24 36 29 85 57
# 86 56 00 48 35 71 89 07 05 44 44 37 44 60 21 58 51 54 17 58
# 19 80 81 68 05 94 47 69 28 73 92 13 86 52 17 77 04 89 55 40
# 04 52 08 83 97 35 99 16 07 97 57 32 16 26 26 79 33 27 98 66
# 88 36 68 87 57 62 20 72 03 46 33 67 46 55 12 32 63 93 53 69
# 04 42 16 73 38 25 39 11 24 94 72 18 08 46 29 32 40 62 76 36
# 20 69 36 41 72 30 23 88 34 62 99 69 82 67 59 85 74 04 36 16
# 20 73 35 29 78 31 90 01 74 31 49 71 48 86 81 16 23 57 05 54
# 01 70 54 71 83 51 54 69 16 92 33 48 61 43 52 01 89 19 67 48)
