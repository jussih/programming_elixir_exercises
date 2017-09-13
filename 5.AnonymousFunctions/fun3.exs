fun = fn 
  (0, 0, _) -> "FizzBuzz"
  (0, _, _) -> "Fizz"
  (_, 0, _) -> "Buzz"
  (_, _, c) -> c
end

usefun = fn (n) ->
  fun.(rem(n,3), rem(n,5), n)
end

10..16
|> Enum.map(&usefun.(&1))
|> IO.inspect
  
