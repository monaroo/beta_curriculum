defmodule HelloWorld.Name do
  def random do
    Enum.random(["Peter", "Bruce", "Tony"])
  end
end

defmodule HelloWorld do
  def hello do
    "Hello, #{HelloWorld.Name.random()}."
  end

  def randomhello do
    "Hello, #{Faker.Person.first_name()}."
  end
end
