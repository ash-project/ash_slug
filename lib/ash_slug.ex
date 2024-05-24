defmodule AshSlug do
  @moduledoc """
  An extension for slugifying attributes on a resource.
  """

  @transformers [
    AshSlug.Transformers.SetupSlug
  ]

  @slug %Spark.Dsl.Section{
    name: :slug,
    describe: "Slugify attributes of a resource",
    schema: [
      attributes: [
        doc: "The attribute or attributes to slugify.",
        type: {:wrap_list, :atom},
        default: []
      ],
      options: [
        doc: "Keyword list options to pass to `Slugify.slugify/2`",
        type: :keyword_list,
        default: []
      ]
    ]
  }

  use Spark.Dsl.Extension, sections: [@slug], transformers: @transformers
end
