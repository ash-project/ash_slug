defmodule AshSlug.Transformers.SetupSlug do
  @moduledoc false
  use Spark.Dsl.Transformer
  import Ash.Resource.Builder, only: [build_action_argument: 3, build_action_change: 1]

  def transform(dsl) do
    module = Spark.Dsl.Transformer.get_persisted(dsl, :module)
    attributes = AshSlug.Info.slug_attributes!(dsl)
    opts = AshSlug.Info.slug_options!(dsl)

    Enum.reduce_while(attributes, {:ok, dsl}, fn attr, {:ok, dsl} ->
      attribute = Ash.Resource.Info.attribute(dsl, attr)

      unless attribute do
        raise Spark.Error.DslError,
          module: module,
          message: "No attribute called #{inspect(attribute)} found",
          path: [:slug, :attributes]
      end

      if attribute.primary_key? do
        raise Spark.Error.DslError,
          module: module,
          message: "Cannot slugify primary key",
          path: [:slug, :attributes]
      end

      case rewrite_actions(dsl, attribute, opts) do
        {:ok, dsl} -> {:cont, {:ok, dsl}}
        {:error, reason} -> {:halt, {:error, reason}}
      end
    end)
  end

  def after?(Ash.Resource.Transformers.DefaultAccept), do: true
  def after?(_), do: false

  defp rewrite_actions(dsl, attr, opts) do
    dsl
    |> Ash.Resource.Info.actions()
    |> Enum.filter(&(&1.type in [:create, :update]))
    |> Enum.reduce_while({:ok, dsl}, fn action, {:ok, dsl} ->
      if attr.name in action.accept do
        new_accept = action.accept -- [attr.name]

        with {:ok, argument} <- build_action_argument(attr.name, attr.type, constraints: attr.constraints),
             {:ok, change} <- build_action_change({AshSlug.Changes.Slugify, field: attr.name, opts: opts}) do
          {:cont,
           {:ok,
            Spark.Dsl.Transformer.replace_entity(
              dsl,
              [:actions],
              %{
                action
                | arguments: [argument | Enum.reject(action.arguments, &(&1.name == attr.name))],
                  changes: [change | action.changes],
                  accept: new_accept
              },
              &(&1.name == action.name)
            )}}
        else
          other -> {:halt, other}
        end
      else
        {:cont, {:ok, dsl}}
      end
    end)
  end
end
