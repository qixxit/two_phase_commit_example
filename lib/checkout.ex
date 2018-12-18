defmodule Checkout do
  alias TwoPhaseCommit.Store.InMemory, as: Store

  defmodule State do
    defstruct [:authorization_ref, :booking_ref, :capture_ref, :amount, :product_ref]
  end

  def init(product) do
    state = %State{amount: product.amount, product_ref: product.ref}

    Store.start_link(state)
  end

  def run(ref, payment) do
    with {:ok, revision, state} <- Store.get(ref),
         {:ok, state, revision, _result} <-
           run_action(Action.Authorize, ref, revision, state, payment),
         {:ok, state, revision, _result} <- run_action(Action.Book, ref, revision, state, nil),
         {:ok, _state, _revision, _result} <-
           run_action(Action.Capture, ref, revision, state, nil) do
      :ok
    end
  end

  def authorized?(ref) do
    with {:ok, _revision, state} <- Store.get(ref) do
      not is_nil(state.authorization_ref)
    else
      error -> throw(error)
    end
  end

  def booked?(ref) do
    with {:ok, _revision, state} <- Store.get(ref) do
      not is_nil(state.booking_ref)
    else
      error -> throw(error)
    end
  end

  def captured?(ref) do
    with {:ok, _revision, state} <- Store.get(ref) do
      not is_nil(state.capture_ref)
    else
      error -> throw(error)
    end
  end

  defp run_action(action, ref, revision, state, args) do
    TwoPhaseCommit.apply(
      action,
      state,
      args,
      Store,
      ref,
      revision
    )
  end
end
