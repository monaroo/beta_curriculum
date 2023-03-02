defmodule Portfolio.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :content, :text
      add :blog_id, references(:blog_posts, on_delete: :delete_all), null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:comments, [:blog_id])
    create index(:comments, [:user_id])
  end
end
