defmodule AshSlug.Info do
  @moduledoc """
  Introspection functions for the `AshSlug` extension.
  """
  use Spark.InfoGenerator, extension: AshSlug, sections: [:slug]
end
