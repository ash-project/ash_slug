defmodule AshSlugTest.Domain do
  @moduledoc false
  use Ash.Domain

  resources do
    resource(AshSlugTest.Resource1)
    resource(AshSlugTest.Resource2)
  end
end
