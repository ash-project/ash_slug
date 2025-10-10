# SPDX-FileCopyrightText: 2024 Rolf Håvard Blindheim
#
# SPDX-License-Identifier: MIT

defmodule AshSlugTest do
  use ExUnit.Case
  doctest AshSlug

  test "ensure value is slugified" do
    resource =
      AshSlugTest.Resource
      |> Ash.Changeset.for_create(:create, %{text1: "Hello, World!"})
      |> Ash.Changeset.set_context(%{foo: :bar})
      |> Ash.create!()

    assert resource.text1 == "Hello-World"
  end

  test "ensure value is slugified when resource is updated" do
    resource =
      AshSlugTest.Resource
      |> Ash.Changeset.for_create(:create, %{text1: "Hello, World!"})
      |> Ash.Changeset.set_context(%{foo: :bar})
      |> Ash.create!()

    assert resource.text1 == "Hello-World"

    resource =
      resource
      |> Ash.Changeset.for_update(:update, %{text1: "Hello, World! Again"})
      |> Ash.Changeset.set_context(%{foo: :bar})
      |> Ash.update!()

    assert resource.text1 == "Hello-World-Again"
  end

  test "ensure Ash.CiString value is slugified" do
    resource =
      AshSlugTest.Resource
      |> Ash.Changeset.for_create(:create, %{text3: Ash.CiString.new("Hello, World!")})
      |> Ash.Changeset.set_context(%{foo: :bar})
      |> Ash.create!()

    assert resource.text3_slug == "hello-world"
  end

  test "ensure value is slugified into another attribute" do
    resource =
      AshSlugTest.Resource
      |> Ash.Changeset.for_create(:create, %{text2: "Hello, World!"})
      |> Ash.Changeset.set_context(%{foo: :bar})
      |> Ash.create!()

    assert resource.text2 == "Hello, World!"
    assert resource.text2_slug == "hello-world"
  end

  test "ensure non-string fields raise error" do
    assert_raise Ash.Error.Invalid, ~r/is not a string value/, fn ->
      AshSlugTest.Resource
      |> Ash.Changeset.for_create(:create, %{bool: false})
      |> Ash.Changeset.set_context(%{foo: :bar})
      |> Ash.create!()
    end
  end
end
