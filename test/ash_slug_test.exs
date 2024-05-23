defmodule AshSlugTest do
  use ExUnit.Case
  doctest AshSlug

  test "ensure value is slugified" do
    resource =
      AshSlugTest.Resource1
      |> Ash.Changeset.for_create(:create, %{text: "Hello, World!"})
      |> Ash.Changeset.set_context(%{foo: :bar})
      |> Ash.create!()

    assert resource.text == "Hello-World"
  end

  test "ensure non-string fields raise error" do
    assert_raise Ash.Error.Invalid, ~r/is not a string value/, fn ->
      AshSlugTest.Resource2
      |> Ash.Changeset.for_create(:create, %{bool: false})
      |> Ash.Changeset.set_context(%{foo: :bar})
      |> Ash.create!()
    end
  end
end
