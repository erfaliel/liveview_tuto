defmodule LiveViewCounterWeb.Counter do
  use Phoenix.LiveView
  alias LiveViewCounter.Count
  alias Phoenix.PubSub

  @topic Count.topic

  def mount(_params, _session, socket) do
    PubSub.subscribe(LiveViewCounter.Pubsub, @topic) # subscribe to the channel
    
    {:ok, assign(socket, :val, count.current())}
  end

  def handle_event("inc", _, socket) do
    {:noreply, assign(socket, :val, count.incr())}
  end

  def handle_event("dec", _value, socket) do
    {:noreply, ssign(socket, :val, count.decr())}
  end

  def handle_info({:count, count}, socket) do
    {:noreply, assign(socket, val: count)}
  end

  def render(assigns) do
    ~L"""
    <div>
      <h1>The count is: <%= @val %></h1>
      <button phx-click="dec">-</button>
      <button phx-click="inc">+</button>
    </div>
    """
  end
end

