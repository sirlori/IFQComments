Rails.application.routes.draw do
  root to: "comments#index"
  resources :comments, only: :index do 
  	collection do 
  		post :get_comments
  	end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
