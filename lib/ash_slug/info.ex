# SPDX-FileCopyrightText: 2024 Rolf Håvard Blindheim
#
# SPDX-License-Identifier: MIT

defmodule AshSlug.Info do
  @moduledoc """
  Introspection functions for the `AshSlug` extension.
  """
  use Spark.InfoGenerator, extension: AshSlug
end
