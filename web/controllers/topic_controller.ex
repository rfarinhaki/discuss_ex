defmodule Discuss.TopicController do 
  use Discuss.Web, :controller

  def new(conn, _params) do 
    IO.puts "++++"
    IO.inspect conn
    IO.puts "++++"
  end
end