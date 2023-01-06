defmodule Journal.Entry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "entries" do
    field :title, :string
    field :content, :string

    belongs_to :user, Journal.User

    timestamps()
  end

  def changeset(entry, params \\ %{}) do
    entry
    |> cast(params, [:title, :content, :user_id])
    |> validate_required([:title, :content])
  end

end
