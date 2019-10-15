defmodule CrawlerChallenge.NebulexCache do
  use Nebulex.Cache,
    otp_app: :crawler_challenge,
    adapter: Nebulex.Adapters.Local

  def set_cache(key, process) do
    set(key, process, ttl: 86400) 
  end

  def get_cache(token) do
    case get(token) do
      nil -> {:error, :not_found}
      process -> {:ok, process}
    end
  end
end
