defmodule AshSlugTest.Domain do
  @moduledoc false
  use Ash.Domain

  resources do
    resource(AshSlugTest.Resource)
  end
end
