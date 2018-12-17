defmodule ACMETest do
  use ExUnit.Case
  doctest ACME

  test "greets the world" do
    assert ACME.hello() == :world
  end
end
