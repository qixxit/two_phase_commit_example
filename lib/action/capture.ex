defmodule Action.Capture do
  require Logger
  @behaviour Traktor.Action

  @impl true
  def prepare(checkout_state, _args) do
    request_id = UUID.uuid4()
    {:ok, %{request_id: request_id, authorization_ref: checkout_state.authorization_ref}}
  end

  @impl true
  def commit(checkout_state, transaction) do
    {:ok, capture_ref} = do_capture(transaction.request_id, transaction.authorization_ref)

    updated_checkout_state = %{checkout_state | capture_ref: capture_ref}
    {:ok, updated_checkout_state, []}
  end

  defp do_capture(request_id, authorization_ref) do
    Logger.info(
      "capture request #{inspect(request_id)} for authorization #{inspect(authorization_ref)}"
    )

    {:ok, UUID.uuid4()}
  end
end
