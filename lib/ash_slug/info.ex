defmodule AshSlug.Info do
  @moduledoc """
  Introspection functinos for the `AshSlug` extension.
  """
  use Spark.InfoGenerator, extension: AshSlug, sections: [:slug]
end
