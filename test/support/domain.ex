# SPDX-FileCopyrightText: 2024 Rolf Håvard Blindheim
#
# SPDX-License-Identifier: MIT

defmodule AshSlugTest.Domain do
  @moduledoc false
  use Ash.Domain

  resources do
    resource(AshSlugTest.Resource)
  end
end
