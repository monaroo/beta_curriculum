defmodule UtilsTest do
  use ExUnit.Case
  doctest Utils
  alias Utils.Factory
  alias Utils.Notebooks
  alias Utils.Solutions

  test "table/1" do
    Utils.Table.__info__(:functions)
    |> Enum.each(fn {table_name, _arity} ->
      assert %Kino.JS.Live{} = Utils.table(table_name)
    end)
  end

  test "graph/1" do
    Utils.Graph.__info__(:functions)
    |> Enum.each(fn {graph_name, _arity} ->
      assert %Kino.JS.Live{} = Utils.graph(graph_name)
    end)
  end

  test "constants/1" do
    Utils.Constants.__info__(:functions)
    |> Enum.each(fn {constant_name, _arity} ->
      assert Utils.constants(constant_name)
    end)
  end

  test "form/1" do
    Utils.Form.__info__(:functions)
    |> Enum.each(fn {form_name, _arity} ->
      assert %Kino.JS{} = Utils.form(form_name)
    end)
  end

  test "random" do
    assert Utils.random(:rock_paper_scissors) in [:rock, :paper, :scissors]
    assert Utils.random(1..9) in 1..9
  end

  test "feedback/2" do
    Enum.each(Utils.Feedback.test_names(), fn each ->
      exists = Keyword.has_key?(Solutions.__info__(:functions), each)

      if !exists do
        raise "define a Solutions.#{Atom.to_string(each)} function."
      end
    end)

    execute_tests_until_failure(Utils.Feedback.test_names())
  end

  test "feedback/2 with invalid atom" do
    atom = String.to_atom(Factory.string())

    assert Utils.feedback(atom, "non-nil answer") ==
             "Something went wrong, feedback does not exist for #{atom}. Please speak to your teacher and/or reset the exercise."
  end

  defp execute_tests_until_failure([]), do: nil

  defp execute_tests_until_failure([test | tail]) do
    test_failed = Utils.feedback(test, apply(Solutions, test, [])).failures > 0

    unless test_failed do
      execute_tests_until_failure(tail)
    end
  end

  @tag :skip_ci
  test "Ensure all .livemd files are formatted." do
    Notebooks.all_livebooks()
    |> Enum.each(fn file_name ->
      file = File.read!(file_name)
      # loading the file in livebook adds a newline, so we add it when we format
      # to avoid changing the file every time a student opens a .livemd file.
      expected = Livebook.LiveMarkdown.MarkdownHelpers.reformat(file) <> "\n"

      assert file == expected,
             """
             #{file_name}: Needs to be formatted.

             Run mix format_notebooks to format all notebooks.
             Sometimes bullet points * can cause formatting issues.
             """
    end)
  end

  test "Prefer links to documentation over backticks" do
    # i.e. prefer [Enum.map/2](https://hexdocs.pm/elixir/Enum.html#map/2) over `Enum.map/2`
    libraries = [
      "Kino",
      "ExUnit",
      "Benchee",
      "IEx",
      "Mix",
      "Poison",
      "HTTPoison"
    ]

    Notebooks.all_livebooks()
    |> Notebooks.stream_lines(fn line, file_name, line_number ->
      Regex.scan(~r/\`([A-Z]\w+)\`|\`([A-Z]\w+)\.\w+!*\?*\/[1-9]\`/, line)
      |> Enum.map(fn
        [_, module, ""] ->
          module

        [_, "", module] ->
          module

        [_, module] ->
          module
      end)
      |> Enum.each(fn module ->
        should_use_documentation =
          match?({:module, _}, Code.ensure_compiled(String.to_atom("Elixir.#{module}"))) or
            module in libraries

        if should_use_documentation do
          flunk("""
          #{file_name}:#{line_number} #{module} should use a documentation link [module](url) instead of backticks.

          run mix update_documentation_links to resolve this issue.
          """)
        end
      end)
    end)
  end

  test "Ensure all external libraries are installed if used" do
    # dependency install name, and usage indicator
    possible_deps = [
      {":youtube", "YouTube."},
      {":tested_cell", "TestedCell."},
      {":smart_animation", "SmartAnimation."},
      {":hidden_cell", "HiddenCell."},
      {":benchee", "Benchee."},
      {":httpoison", "HTTPoison."},
      {":kino_db", "Elixir.KinoDB."},
      {":postgrex", "Kino.start_child({Postgrex}"}
    ]

    Notebooks.all_livebooks()
    |> Enum.each(fn file_name ->
      file = File.read!(file_name)

      Enum.each(possible_deps, fn {install, usage} ->
        if String.contains?(file, usage) do
          assert String.contains?(file, install), "#{file_name}: Add #{install} to Mix.install/2"
        end
      end)
    end)
  end

  test "Ensure no broken / empty links in livebooks" do
    Notebooks.stream_lines(Notebooks.reading() ++ Notebooks.exercises(), fn line, file_name ->
      # Empty Links
      refute Regex.match?(~r/\]\(\)/, line)

      # Invalid Links
      found = Regex.scan(~r/\[(\w+)\]\(((\w|\/|\.)+)\)/, line)

      Enum.each(found, fn [_full, name, path, _] ->
        assert String.length(name) > 0, "Link name should not be empty"

        if Regex.match?(~r/exercises|reading/, path) do
          assert File.exists?(path)
        else
          # Relative Links
          [base_path] = Regex.run(~r/\.\.\/\w+\//, file_name)
          assert File.exists?(base_path <> path)
        end
      end)
    end)
  end

  test "Teacher-only editors are hidden" do
    Notebooks.stream_lines(Notebooks.all_livebooks(), fn line ->
      refute Regex.match?(~r/TestedCell\./, line)
    end)
  end

  test "Headings should be in title case" do
    Notebooks.all_livebooks()
    |> Notebooks.stream_lines(fn line, file_name, line_number ->
      heading =
        case {line, line_number} do
          {"### " <> heading, _} -> heading
          {"## " <> heading, _} -> heading
          {"# " <> heading, 1} -> heading
          # ignore
          _ -> ""
        end

      expected = Notebooks.to_title_case(heading)

      assert heading =~ expected,
             """
             Incorrectly Formatted Heading:
             #{file_name}:#{line_number}.

             Expected: #{expected}
             Received: #{heading}

             Manually resolve the issue or run mix format_headings.
             """
    end)
  end
end
