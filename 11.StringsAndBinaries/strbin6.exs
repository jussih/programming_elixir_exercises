defmodule Str do
  def capitalize_sentences(str), do: do_capitalize_sentences(str, true)
  @spec do_capitalize_sentences(binary, boolean) :: integer
  defp do_capitalize_sentences(<<>>, _), do: <<>>
  defp do_capitalize_sentences(<<". ", tail::binary>>, _), do: <<". ", do_capitalize_sentences(tail, true)::binary>>
  defp do_capitalize_sentences(<<head::utf8, tail::binary>>, true), do: <<String.upcase(<<head::utf8>>)::binary, do_capitalize_sentences(tail, false)::binary>>
  defp do_capitalize_sentences(<<head::utf8, tail::binary>>, false), do: <<String.downcase(<<head::utf8>>)::binary, do_capitalize_sentences(tail, false)::binary>>
end
