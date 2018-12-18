defmodule Action.BookTest do
  use ExUnit.Case
  alias Checkout.State, as: CheckoutState

  alias Action.Book
  alias Model.Product

  test "prepares and commit booking" do
    checkout = %CheckoutState{booking_ref: nil, product_ref: "product_123"}

    assert {:ok, transaction} = Book.prepare(checkout, nil)
    assert {:ok, updated_checkout, _result} = Book.commit(checkout, transaction)

    assert not is_nil(updated_checkout.booking_ref)
  end
end
