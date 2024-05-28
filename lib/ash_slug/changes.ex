defmodule AshSlug.Changes do
  @moduledoc """
  Change functions for the `AshSlug` extension.
  """

  @doc """
  Slugify a string attribute on a changeset.

  ## Options

  #{Spark.Options.docs(AshSlug.Changes.Slugify.opt_schema())}

  ## Examples

      change slugify(:text)
      change slugify(:text, into: :text_slug, lowercase?: false, ignore: [".", "!"])
  """
  def slugify(attribute, opts \\ []) do
    {AshSlug.Changes.Slugify, Keyword.merge(opts, attribute: attribute)}
  end
end
