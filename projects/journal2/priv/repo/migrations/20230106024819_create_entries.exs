defmodule Journal.Repo.Migrations.CreateEntries do
  use Ecto.Migration

  def change do
    create table(:entries) do
      add :title, :string
      add :content, :text
      add :user_id, references(:users)

      timestamps()
    end
  end
end
