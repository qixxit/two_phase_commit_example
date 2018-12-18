defmodule Action.Book do
  require Logger
  @behaviour TwoPhaseCommit.Action

  @impl true
  def prepare(checkout_state, _args) do
    request_id = UUID.uuid4()
    {:ok, %{request_id: request_id, product_ref: checkout_state.product_ref}}
  end

  @impl true
  def commit(checkout_state, transaction) do
    {:ok, booking_ref} = do_book(transaction.request_id, transaction.product_ref)
    updated_checkout_state = %{checkout_state | booking_ref: booking_ref}
    {:ok, updated_checkout_state, []}
  end

  defp do_book(request_id, product_ref) do
    Logger.info("book request #{inspect(request_id)}, for product: #{inspect(product_ref)}")
    {:ok, UUID.uuid4()}
  end
end
