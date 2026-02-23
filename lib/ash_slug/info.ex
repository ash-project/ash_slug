# SPDX-FileCopyrightText: 2024 ash_slug contributors <https://github.com/ash-project/ash_slug/graphs/contributors>
#
# SPDX-License-Identifier: MIT

defmodule AshSlug.Info do
  @moduledoc """
  Introspection functions for the `AshSlug` extension.
  """
  use Spark.InfoGenerator, extension: AshSlug
end
