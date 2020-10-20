defmodule Discuss.TopicController do 
  use Discuss.Web, :controller
  
  alias Discuss.Topic


  def index(conn, _params) do
    topics = Repo.all(Topic)

    render conn, "index.html", topics: topics
  end

  def new(conn, params) do 
    struct = %Topic{}

    params = %{}

    changeset = Topic.changeset(struct, params)

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"topic" => topic} = _params) do
    #IO.puts("+++++")
    #IO.inspect(params)
    #IO.puts("+++++")

    changeset = Topic.changeset(%Topic{}, topic)
    case Repo.insert(changeset) do
      {:ok, post} -> 
        conn 
        |> put_flash(:info, "Topic created")
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} -> 
        render conn, "new.html", changeset: changeset
    end
  end
  
end