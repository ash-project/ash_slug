![Logo](https://github.com/ash-project/ash/blob/main/logos/cropped-for-header-black-text.png?raw=true#gh-light-mode-only)
![Logo](https://github.com/ash-project/ash/blob/main/logos/cropped-for-header-white-text.png?raw=true#gh-dark-mode-only)

# AshSlug

AshSlug is an [Ash](https://hexdocs.pm/ash) extension to slugify string attributes on a resource.
The extension is a thin wrapper around the [Slugify](https://hex.pm/packages/slugify) library, and supports 
the same options.

### Example usage

``` elixir
defmodule MyDomain.Resource do
  @moduledoc false

  use Ash.Resource,
    domain: MyDomain,
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
    attributes [:text]        # Pass in a list of attribute names to slugify
    options lowercase: false  # Pass in any keyword options supported by the `Slugify` library
  end
end
```

