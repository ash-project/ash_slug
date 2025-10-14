# SPDX-FileCopyrightText: 2024 ash_slug contributors <https://github.com/ash-project/ash_slug/graphs.contributors>
#
# SPDX-License-Identifier: MIT

defmodule AshSlugTest.Domain do
  @moduledoc false
  use Ash.Domain

  resources do
    resource(AshSlugTest.Resource)
  end
end
