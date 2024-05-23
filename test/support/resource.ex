defmodule AshSlugTest.Resource1 do
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
    attribute(:text, :string, public?: true)
  end

  actions do
    defaults([:read, :destroy, create: :text, update: :text])
  end

  slug do
    attributes [:text]
    options(lowercase: false)
  end
end

defmodule AshSlugTest.Resource2 do
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
    attribute(:bool, :boolean, public?: true)
  end

  actions do
    defaults([:read, :destroy, create: :bool, update: :bool])
  end

  slug do
    attributes [:bool]
  end
end
