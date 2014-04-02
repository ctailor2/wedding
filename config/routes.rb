Wedding::Application.routes.draw do
	root 'application#index'
	get '/our_story', to: 'application#our_story', as: 'our_story'
	get '/events', to: 'application#events', as: 'events'
  get '/accomodations', to: 'application#accomodations', as: 'accomodations'
	get '/bridal_party', to: 'application#bridal_party', as: 'bridal_party'
	get '/photos', to: 'application#photos', as: 'photos'

	post '/groups/find', to: 'groups#find', as: 'group_finder'
	resources :groups, only: [] do
		post '/rsvp', to: 'groups#rsvp', as: 'rsvp'
		resources :members, only: [:create, :destroy]
		resources :invites, only: [:index]
	end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
