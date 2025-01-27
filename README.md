![Logo](https://github.com/ash-project/ash/blob/main/logos/cropped-for-header-black-text.png?raw=true#gh-light-mode-only)
![Logo](https://github.com/ash-project/ash/blob/main/logos/cropped-for-header-white-text.png?raw=true#gh-dark-mode-only)

![Elixir CI](https://github.com/ash-project/ash_slug/workflows/CI/badge.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Hex version badge](https://img.shields.io/hexpm/v/ash_slug.svg)](https://hex.pm/packages/ash_slug)
[![Hexdocs badge](https://img.shields.io/badge/docs-hexdocs-purple)](https://hexdocs.pm/ash_slug)

# AshSlug

AshSlug is an [Ash](https://hexdocs.pm/ash) extension to slugify string attributes on a resource.

The extension is a thin wrapper around the [Slugify](https://hex.pm/packages/slugify) library, and supports
the same options.

### Example usage

```elixir
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
    attribute(:text_slug, :string)
  end

  actions do
    create :create do
      accept([:text])
      change slugify(:text, into: :text_slug)
    end
  end
end
```

## Reference

- [AshSlug DSL](documentation/dsls/DSL-AshSlug.md)
