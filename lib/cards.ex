defmodule Cards do
  @moduledoc """
  Provides methods for creating and handling a deck of cards
  """

  @doc """
  returns a list of string representing a deck of playing cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for value <- values, suit <- suits do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    deck |> Enum.shuffle()
  end

  @doc """
  Determines whether a deck contains a given card

  ## Examples

      iex> deck = Cards.create_deck()
      iex> Cards.contains?(deck, "Ace of Spades")
      true
  """
  def contains?(deck, hand) do
    deck |> Enum.member?(hand)
  end

  @doc """
  Divides a deck into a hand and the remainder of the deck.
  The `hand_size` argument indicates how many cards should be
  in the hand

  ## Examples

      iex> deck = Cards.create_deck()
      iex> {hand, _deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    deck |> Enum.split(hand_size)
  end

  def save(dec, filename) do
    binary = :erlang.term_to_binary(dec)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _} -> "File does not exists"
    end
  end

  def create_hand(hand_size) do
    create_deck()
    |> shuffle()
    |> deal(hand_size)
  end
end
