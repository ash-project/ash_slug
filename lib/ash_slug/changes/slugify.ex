# SPDX-FileCopyrightText: 2024 ash_slug contributors <https://github.com/ash-project/ash_slug/graphs.contributors>
#
# SPDX-License-Identifier: MIT

defmodule AshSlug.Changes.Slugify do
  @moduledoc false
  use Ash.Resource.Change

  @opt_schema [
    attribute: [
      doc: "The attribute to slugify.",
      required: true,
      type: :atom
    ],
    into: [
      doc: "The attribute to store the slug in. Unless specified, the slug will be stored in the same attribute.",
      type: :atom,
      required: false
    ],
    lowercase?: [
      doc: "Whether to lowercase the slug.",
      type: :boolean,
      default: true
    ],
    separator: [
      doc: "The separator to use between words in the slug.",
      type: :string,
      default: "-"
    ],
    truncate: [
      doc: "Truncates the slug at this character length, shortened to the nearest word.",
      type: :integer,
      required: false
    ],
    ignore: [
      doc: "A string or list of strings of characters to ignore when slugifying.",
      type: {:wrap_list, :string},
      default: []
    ],
    skip_if_present?: [
      doc: "Skip slug generation when the destination attribute is already being changed.",
      type: :boolean,
      default: false
    ]
  ]

  def opt_schema, do: @opt_schema

  @impl true
  def init(opts) do
    case Spark.Options.validate(opts, opt_schema()) do
      {:ok, opts} -> {:ok, replace_lowercase_opts(opts)}
      {:error, error} -> {:error, Exception.message(error)}
    end
  end

  @impl true
  def change(changeset, opts, _) do
    with {attribute, opts} <- Keyword.pop(opts, :attribute),
         {into, opts} <- Keyword.pop(opts, :into, attribute),
         {skip_if_present?, opts} <- Keyword.pop(opts, :skip_if_present?),
         {:ok, value} when is_binary(value) <- get_attribute(changeset, attribute),
         slug <- Slug.slugify(value, opts) do
      if skip_if_present? && Ash.Changeset.changing_attribute?(changeset, into) do
        changeset
      else
        changeset
        |> Ash.Changeset.force_change_attribute(into, slug)
      end
    else
      {:ok, _} -> Ash.Changeset.add_error(changeset, field: opts[:attribute], message: "is not a string value")
      :error -> changeset
    end
  end

  defp get_attribute(changeset, attribute) do
    case Ash.Changeset.fetch_argument_or_change(changeset, attribute) do
      {:ok, %Ash.CiString{} = value} -> {:ok, Ash.CiString.value(value)}
      res -> res
    end
  end

  @spec replace_lowercase_opts(Keyword.t()) :: Keyword.t()
  defp replace_lowercase_opts(opts) do
    Keyword.pop(opts, :lowercase?)
    |> then(fn {lowercase, opts} -> Keyword.put(opts, :lowercase, lowercase) end)
  end
end
