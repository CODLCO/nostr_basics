# NostrBasics

Basic structures both useful for nostr relays and clients

Takes care of:

- Client nostr messages
  - Event
  - Req
  - Close

- Cryptography
  - SHA256
  - Schnorr Signatures

- Events
  - Parsing
  - Serialization
  - Signing
  - Validation

- Filters
  - Parsing
  - Serialization

## Installation

The package can be installed by adding `nostr_basics` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:nostr_basics, "~> 0.0.6"}
  ]
end
```

