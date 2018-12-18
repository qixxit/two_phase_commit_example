defmodule CheckoutTest do
  use ExUnit.Case
  alias Model.{Product, Payment}

  test "successful checkout" do
    product = %Product{amount: 1000, ref: "prod_123"}
    payment = %Payment{card: "123"}

    assert {:ok, ref} = Checkout.init(product)
    assert :ok == Checkout.run(ref, payment)

    assert true == Checkout.authorized?(ref)
    assert true == Checkout.booked?(ref)
    assert true == Checkout.captured?(ref)
  end
end
