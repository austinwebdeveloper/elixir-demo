defmodule TaskAppAuth.UserDetails do
  @moduledoc """
  The UserDetails context.
  """

  import Ecto.Query, warn: false
  alias TaskAppAuth.Repo

  alias TaskAppAuth.UserDetails.UserDetail

  @doc """
  Returns the list of user_detail.

  ## Examples

      iex> list_user_detail()
      [%UserDetail{}, ...]

  """
  def list_user_detail do
    Repo.all(UserDetail)
  end

  @doc """
  Gets a single user_detail.

  Raises `Ecto.NoResultsError` if the User detail does not exist.

  ## Examples

      iex> get_user_detail!(123)
      %UserDetail{}

      iex> get_user_detail!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_detail!(id), do: Repo.get!(UserDetail, id)

  @doc """
  Creates a user_detail.

  ## Examples

      iex> create_user_detail(%{field: value})
      {:ok, %UserDetail{}}

      iex> create_user_detail(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_detail(attrs \\ %{}) do
    %UserDetail{}
    |> UserDetail.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_detail.

  ## Examples

      iex> update_user_detail(user_detail, %{field: new_value})
      {:ok, %UserDetail{}}

      iex> update_user_detail(user_detail, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_detail(%UserDetail{} = user_detail, attrs) do
    user_detail
    |> UserDetail.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_detail.

  ## Examples

      iex> delete_user_detail(user_detail)
      {:ok, %UserDetail{}}

      iex> delete_user_detail(user_detail)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_detail(%UserDetail{} = user_detail) do
    Repo.delete(user_detail)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_detail changes.

  ## Examples

      iex> change_user_detail(user_detail)
      %Ecto.Changeset{data: %UserDetail{}}

  """
  def change_user_detail(%UserDetail{} = user_detail, attrs \\ %{}) do
    UserDetail.changeset(user_detail, attrs)
  end
end
