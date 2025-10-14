# SPDX-FileCopyrightText: 2024 ash_slug contributors <https://github.com/ash-project/ash_slug/graphs.contributors>
#
# SPDX-License-Identifier: MIT

defmodule AshSlug do
  @moduledoc """
  An extension for slugifying attributes on a resource.
  """
  use Spark.Dsl.Extension, imports: [AshSlug.Changes]
end
