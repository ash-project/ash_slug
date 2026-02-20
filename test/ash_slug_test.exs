# SPDX-FileCopyrightText: 2024 ash_slug contributors <https://github.com/ash-project/ash_slug/graphs.contributors>
#
# SPDX-License-Identifier: MIT

defmodule AshSlugTest do
  use ExUnit.Case
  doctest AshSlug

  @base_params %{text4: "My Slugified Version Can Not Be Null"}

  test "ensure value is slugified" do
    resource =
      AshSlugTest.Resource
      |> Ash.Changeset.for_create(:create, build_params(%{text1: "Hello, World!"}))
      |> Ash.Changeset.set_context(%{foo: :bar})
      |> Ash.create!()

    assert resource.text1 == "Hello-World"
  end

  test "ensure value is slugified for mandatory field" do
    resource = AshSlugTest.Domain.create_resource!(%{text4: "My Test Value!"})

    assert resource.text4_slug == "my-test-value"
  end

  test "skip slugifying for field that is already being changed" do
    resource = AshSlugTest.Domain.create_resource!(%{text4: "My Test Value!", text4_slug: "test-one"})

    assert resource.text4_slug == "test-one"
  end

  test "ensure value is slugified when resource is updated" do
    resource =
      AshSlugTest.Resource
      |> Ash.Changeset.for_create(:create, build_params(%{text1: "Hello, World!"}))
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
      |> Ash.Changeset.for_create(:create, build_params(%{text3: Ash.CiString.new("Hello, World!")}))
      |> Ash.Changeset.set_context(%{foo: :bar})
      |> Ash.create!()

    assert resource.text3_slug == "hello-world"
  end

  test "ensure value is slugified into another attribute" do
    resource =
      AshSlugTest.Resource
      |> Ash.Changeset.for_create(:create, build_params(%{text2: "Hello, World!"}))
      |> Ash.Changeset.set_context(%{foo: :bar})
      |> Ash.create!()

    assert resource.text2 == "Hello, World!"
    assert resource.text2_slug == "hello-world"
  end

  test "ensure non-string fields raise error" do
    assert_raise Ash.Error.Invalid, ~r/is not a string value/, fn ->
      AshSlugTest.Resource
      |> Ash.Changeset.for_create(:create, build_params(%{bool: false}))
      |> Ash.Changeset.set_context(%{foo: :bar})
      |> Ash.create!()
    end
  end

  defp build_params(params), do: Map.merge(@base_params, params)
end
