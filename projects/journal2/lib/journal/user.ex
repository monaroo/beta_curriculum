defmodule Journal.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :email, :string

    has_many :entries, Journal.Entry
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:name, :email])
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end
end
