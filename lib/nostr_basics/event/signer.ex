defmodule NostrBasics.Event.Signer do
  @moduledoc """
  Signs events, making sure they're going to be accepted on the nostr network as the user's own
  """

  alias NostrBasics.Event
  alias K256.Schnorr

  @doc """
  Applies the schnorr signatures to an event and adds signature to it if successful
  """
  @spec sign_event(Event.t(), <<_::256>>) :: {:ok, Event.t()} | {:error, String.t()}
  def sign_event(%Event{id: _id} = event, privkey) do
    json_for_id = Event.json_for_id(event)

    case Schnorr.create_signature(json_for_id, privkey) do
      {:ok, sig} -> {:ok, %{event | sig: sig}}
      {:error, message} when is_atom(message) -> {:error, Atom.to_string(message)}
    end
  end
end
