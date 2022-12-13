defmodule Math do
  @spec add(value(), value()) :: value()
  def add(num1, num2)
      when (is_integer(num1) and is_integer(num2)) or
             (is_float(num1) and is_float(num2)) do
    num1 + num2
  end

  def add(string1, string2) when is_binary(string1) and is_binary(string2) do
    string1 <> string2
  end

  def add(list1, list2) when is_list(list1) and is_list(list2) do
    if Keyword.keyword?(list1) and Keyword.keyword?(list2) do
      Keyword.merge(list1, list2, fn _k, v1, v2 -> v1 + v2 end)
    else
      list1 ++ list2
    end
  end

  def add(map1, map2) when is_map(map1) and is_map(map2) do
    Map.merge(map1, map2, fn _k, v1, v2 -> v1 + v2 end)
  end

  def subtract(num1, num2)
      when (is_integer(num1) and is_integer(num2)) or
             (is_float(num1) and is_float(num2)) do
    num1 - num2
  end

  def subtract(str1, str2) when is_bitstring(str1) and is_bitstring(str2) do
    String.replace(str1, str2, "", trim: true)
  end

  def subtract(list1, list2) when is_list(list1) and is_list(list2) do
    if Keyword.keyword?(list1) and Keyword.keyword?(list2) do
      keys = Keyword.keys(list2)
      Keyword.drop(list1, keys)
    else
      list1 -- list2
    end
  end

  def subtract(map1, map2) when is_map(map1) and is_map(map2) do
    keys = Map.keys(map2)
    Map.drop(map1, keys)
  end
end

ExUnit.start(auto_run: false)

defmodule MathTest do
  use ExUnit.Case

  describe "Math.add/2" do
    test "integers" do
      assert Math.add(1, 4) === 5
    end

    test "floats" do
      assert Math.add(1.2, 5.7) === 6.9
    end

    test "strings" do
      assert Math.add("hi ", "there") === "hi there"
    end

    test "lists" do
      assert Math.add([1, 4], [5, 8]) === [1, 4, 5, 8]
    end

    test "maps" do
      assert Math.add(%{map1: 1}, %{map2: 2}) === %{map1: 1, map2: 2}
    end

    test "keyword lists" do
      assert Math.add([list1: 1], list2: 2) === [list1: 1, list2: 2]
    end
  end

  describe "Math.subtract/2" do
    test "integers" do
      assert Math.subtract(4, 3) === 1
    end

    test "floats" do
      assert Math.subtract(5.0, 4.0) === 1.0
    end

    test "strings" do
      assert Math.subtract("ab", "a") === "b"
    end

    test "lists" do
      assert Math.subtract([1, 4, 5, 8], [5, 8]) === [1, 4]
    end

    test "maps" do
      assert Math.subtract(%{map1: 1, map2: 2}, %{map2: 2}) === %{map1: 1}
    end

    test "keyword lists" do
      assert Math.subtract([list1: 1, list2: 2], list2: 2) === [list1: 1]
    end
  end
end

ExUnit.run()
