prefix = fn (prefix) ->
  fn (suffix) ->
    "#{prefix} #{suffix}"
  end
end

mrs = prefix.("Mrs")
IO.inspect(mrs.("Smith"))
IO.inspect(prefix.("Elixir").("Rocks"))
