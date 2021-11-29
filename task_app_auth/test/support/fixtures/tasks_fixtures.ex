defmodule TaskAppAuth.TasksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TaskAppAuth.Tasks` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        completed: true,
        desc: "some desc"
      })
      |> TaskAppAuth.Tasks.create_task()

    task
  end
end
