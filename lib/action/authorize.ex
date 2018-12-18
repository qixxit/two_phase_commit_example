defmodule Action.Authorize do
  require Logger
  @behaviour TwoPhaseCommit.Action

  @impl true
  def prepare(checkout_state, payment) do
    request_id = UUID.uuid4()
    {:ok, %{request_id: request_id, card: payment.card, amount: checkout_state.amount}}
  end

  @impl true
  def commit(checkout_state, transaction) do
    {:ok, authorization_ref} =
      do_authorize(transaction.request_id, transaction.card, transaction.amount)

    updated_checkout_state = %{checkout_state | authorization_ref: authorization_ref}
    {:ok, updated_checkout_state, []}
  end

  defp do_authorize(request_id, card, amount) do
    Logger.info(
      "authorize request #{inspect(request_id)}, card #{inspect(card)}, for #{inspect(amount)} amount"
    )

    {:ok, UUID.uuid4()}
  end
end
