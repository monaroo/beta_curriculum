defmodule Journal3.Repo.Migrations.CreateNotes do
  use Ecto.Migration

  def change do
     create table(:notes) do
      add :content, :text

      timestamps()
     end
  end
end
