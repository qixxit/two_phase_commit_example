defmodule Action.AuthorizeTest do
  use ExUnit.Case
  alias Action.Authorize
  alias Model.Payment
  alias Checkout.State, as: CheckoutState

  test "prepares and commit authorization" do
    checkout = %CheckoutState{authorization_ref: nil, amount: 1000}
    payment = %Payment{card: "123"}

    assert {:ok, transaction} = Authorize.prepare(checkout, payment)
    assert {:ok, updated_checkout, _result} = Authorize.commit(checkout, transaction)

    assert not is_nil(updated_checkout.authorization_ref)
  end
end
