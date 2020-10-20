defmodule Discuss.TopicController do 
  use Discuss.Web, :controller
  
  alias Discuss.Topic

  def new(conn, params) do 
    struct = %Topic{}

    params = %{}

    changeset = Topic.changeset(struct, params)

    render conn, "new.html", changeset: changeset
  end

  def create(conn, params) do
    #IO.puts("+++++")
    #IO.inspect(params)
    #IO.puts("+++++")

    %{"topic" => topic} = params
    IO.inspect(topic)
  end
  
end