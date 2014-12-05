json.array!(@movies) do |movie|
  json.extract! movie, :id, :title, :year, :avg_v, :avg_n, :avg_l, :avg_at
  json.url movie_url(movie, format: :json)
end
