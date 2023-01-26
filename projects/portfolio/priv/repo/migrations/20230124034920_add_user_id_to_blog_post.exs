defmodule Portfolio.Repo.Migrations.AddUserIdToBlogPost do
  use Ecto.Migration

  def change do
    alter table(:blog_posts) do
      add :user_id, references("users")
    end
  end
end
