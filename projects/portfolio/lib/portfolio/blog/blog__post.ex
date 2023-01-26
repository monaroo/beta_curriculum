defmodule Portfolio.Blog.Blog_Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Portfolio.Accounts.User

  schema "blog_posts" do
    field :content, :string
    field :subtitle, :string
    field :title, :string

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(blog__post, attrs) do
    blog__post
    |> cast(attrs, [:title, :subtitle, :content, :user_id])
    |> validate_required([:title, :subtitle, :content])
  end
end
