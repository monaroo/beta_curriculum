defmodule Portfolio.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  alias Portfolio.Blog.Blog_Post

  schema "comments" do
    field :content, :string

    belongs_to :blog_post, Blog_Post, foreign_key: :blog_id
    belongs_to :user, Portfolio.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(comment) do
    comment
    |> cast(comment.params, [:content])
    |> validate_required([:content])
  end
end
