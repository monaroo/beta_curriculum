defmodule Portfolio.Repo.Migrations.CreateBlogPosts do
  use Ecto.Migration

  def change do
    create table(:blog_posts) do
      add :title, :string
      add :subtitle, :string
      add :content, :text

      timestamps()
    end
  end
end
