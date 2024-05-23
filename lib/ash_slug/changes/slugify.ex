defmodule AshSlug.Changes.Slugify do
  @moduledoc false
  use Ash.Resource.Change

  def change(changeset, opts, _) do
    Ash.Changeset.before_action(changeset, fn changeset ->
      attribute = opts[:field]
      slug_opts = opts[:opts]

      with {:ok, value} when is_binary(value) <- Ash.Changeset.fetch_argument(changeset, attribute),
           slug when is_binary(slug) <- Slug.slugify(value, slug_opts) do
        changeset
        |> Ash.Changeset.force_change_attribute(attribute, slug)
      else
        {:ok, _} ->
          Ash.Changeset.add_error(changeset, field: attribute, message: "is not a string value")

        :error ->
          changeset
      end
    end)
  end
end
