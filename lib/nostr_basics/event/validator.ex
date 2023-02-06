defmodule NostrBasics.Event.Validator do
  @moduledoc """
  Makes sure a signature is valid
  """

  alias K256.Schnorr
  alias NostrBasics.Event

  @spec(validate_event(Event.t()) :: :ok, {:error, message})
  def validate_event(%Event{} = event) do
    with :ok <- validate_id(event),
         :ok <- validate_signature(event) do
      :ok
    else
      {:error, message} -> {:error, message}
    end
  end

  @spec(validate_id(Event.t()) :: :ok, {:error, message})
  def validate_id(%Event{id: id} = event) do
    case id == Event.create_id(event) do
      true -> :ok
      false -> {:error, "generated ID and the one in the event don't match"}
    end
  end

  @spec validate_signature(Event.t()) :: :ok | {:error, atom()}
  def validate_signature(%Event{id: hex_id, sig: sig, pubkey: pubkey}) do
    id = Binary.from_hex(hex_id)

    Schnorr.verify_message_digest(id, sig, pubkey)
  end
end
