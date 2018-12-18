defmodule Action.CaptureTest do
  use ExUnit.Case
  alias Action.Capture
  alias Checkout.State, as: CheckoutState

  test "prepares and commit capture" do
    checkout = %CheckoutState{authorization_ref: "authorization_123", amount: 1000}

    assert {:ok, transaction} = Capture.prepare(checkout, nil)
    assert {:ok, updated_checkout, _result} = Capture.commit(checkout, transaction)

    assert not is_nil(updated_checkout.capture_ref)
  end
end
