defmodule Discuss.TopicController do 
  use Discuss.Web, :controller
  
  alias Discuss.Topic


  def index(conn, _params) do
    topics = Repo.all(from t in Topic, order_by: t.id)

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
      {:ok, topic} ->
        IO.puts("++topic++")
        IO.inspect(topic) 
        conn 
        |> put_flash(:info, "Topic created: #{topic.title}")
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} -> 
        render conn, "new.html", changeset: changeset
    end
  end


  def edit(conn, %{"id" => topic_id}) do 
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic)

    render conn, "edit.html", changeset: changeset, topic: topic
  end

  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    old_topic = Repo.get(Topic, topic_id)
    changeset =  Topic.changeset(old_topic, topic)

    case Repo.update(changeset) do
      {:ok, topic} -> 
        conn
        |>put_flash(:info, "Topic updated: #{topic.title}")
        |>redirect(to: topic_path(conn, :index))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, topic: old_topic
    end
  end

  def delete(conn, %{"id" => topic_id}) do
    Repo.get!(Topic, topic_id) |> Repo.delete!
    conn
      |>put_flash(:info, "Topic deleted")
      |>redirect(to: topic_path(conn, :index))
  end
  
end