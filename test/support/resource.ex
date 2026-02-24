# SPDX-FileCopyrightText: 2024 ash_slug contributors <https://github.com/ash-project/ash_slug/graphs/contributors>
#
# SPDX-License-Identifier: MIT

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
    attribute(:text3, :ci_string, public?: true)
    attribute(:text3_slug, :string)
    attribute(:text4, :string, public?: true)

    attribute(:text4_slug, :string) do
      allow_nil?(false)
      public?(true)
    end

    attribute(:bool, :boolean, public?: true)
  end

  actions do
    create :create do
      primary?(true)
      accept([:text1, :text2, :text3, :text4, :text4_slug, :bool])

      change(slugify(:text1, lowercase?: false))
      change(slugify(:text2, into: :text2_slug))
      change(slugify(:text3, into: :text3_slug))
      change(slugify(:text4, into: :text4_slug, skip_if_present?: true))
      change(slugify(:bool))
    end

    update :update do
      require_atomic?(false)
      accept([:text1])

      change(slugify(:text1, lowercase?: false))
    end
  end
end
