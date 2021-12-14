# Use an official Elixir runtime as a parent image.
FROM elixir:latest

RUN apt-get update && \
  apt-get install -y postgresql-client

# Create app directory and copy the Elixir projects into it.
RUN mkdir /app
WORKDIR /app
COPY . .

# Install Hex package manager.
RUN mix local.hex --force
RUN mix local.rebar --force

# COPY mix.exs ./

RUN mix deps.get

# Compile the project.
RUN mix do compile
RUN mix ecto.create

EXPOSE 4000


CMD ["mix","phx.server"]






