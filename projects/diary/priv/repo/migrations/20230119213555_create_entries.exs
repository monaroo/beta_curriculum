defmodule Diary.Repo.Migrations.CreateEntries do
  use Ecto.Migration

  def change do
    create table(:entries) do
      add :title, :string
      add :content, :text
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:entries, [:user_id])
  end
end
