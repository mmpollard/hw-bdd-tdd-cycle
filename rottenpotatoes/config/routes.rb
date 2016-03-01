Rottenpotatoes::Application.routes.draw do
  
  get 'movies/director/:id' => 'movies#director', :as => :director
  
  resources :movies
  
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  
end
