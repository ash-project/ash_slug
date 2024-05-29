defmodule AshSlugTest.Resource do
  @moduledoc false

  use Ash.Resource,
    domain: AshSlugTest.Domain,
    data_layer: Ash.DataLayer.Ets,
    extensions: [AshSlug]

  ets do
    private?(true)
  end

  attributes do
    uuid_primary_key(:id)
    attribute(:text1, :string, public?: true)
    attribute(:text2, :string, public?: true)
    attribute(:text2_slug, :string)
    attribute(:bool, :boolean, public?: true)
  end

  actions do
    create :create do
      accept([:text1, :text2, :bool])

      change(slugify(:text1, lowercase?: false))
      change(slugify(:text2, into: :text2_slug))
      change(slugify(:bool))
    end
  end
end
