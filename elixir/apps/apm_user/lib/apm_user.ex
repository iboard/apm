defmodule ApmUser do
  @moduledoc """
  Documentation for ApmUser.
  """

  alias ApmUser.Role

  @doc """
  Roles are configured in config. Default role is :guest


  ## Examples

    iex> Enum.find_value( ApmUser.roles, fn(role) -> role.key == :guest end)
    true
      

  """
  def roles do
    [
      %Role{ key: :guest, name: "Guest" },
      %Role{ key: :admin, name: "Admin" },
      %Role{ key: :customer, name: "Customer" },
      %Role{ key: :product_manager, name: "Product Manager" },
      %Role{ key: :product_owner, name: "Product Owner" },
      %Role{ key: :developer, name: "Developer" },
      %Role{ key: :qa_engineer, name: "QA Engineer" },
      %Role{ key: :operator, name: "Operator" }
    ]
  end
end
