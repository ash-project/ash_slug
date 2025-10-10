# SPDX-FileCopyrightText: 2024 Rolf Håvard Blindheim
#
# SPDX-License-Identifier: MIT

defmodule AshSlug do
  @moduledoc """
  An extension for slugifying attributes on a resource.
  """
  use Spark.Dsl.Extension, imports: [AshSlug.Changes]
end
