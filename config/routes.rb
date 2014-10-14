DecisionMakerApp::Application.routes.draw do
 
  # root :to => 'pages#home'
  
  get '/home' => 'pages#home', as: 'home'
  
  get '/start' => 'pages#start', as: 'start'
  post '/initial_contact' => 'pages#initial_contact', as: 'initial_contact'
  
  post '/new_round' => 'pages#new_round', as: 'new_round'
  post '/set_options' => 'pages#set_options', as: 'set_options'
  
  get '/round/:encrypted_url/new_contacts' => 'pages#new_contacts', as: 'new_contacts' # don't forget to pass the encrypted_url
  post '/round/:encrypted_url/create_contacts' => 'pages#create_contacts', as: 'create_contacts' # don't forget to pass the encrypted_url
  
  get '/vote/:encrypted_id' => 'pages#vote', as: 'vote' # don't forget to pass the encrypted_id
  post '/vote/:encrypted_id' => 'pages#create_vote', as: 'create_vote' # don't forget to pass the encrypted_id
  
  get '/confirmation/:encrypted_url' => 'pages#confirm', as: 'confirm' # don't forget to pass the encrypted_url
  get '/round/:encrypted_url' => 'pages#show_round', as: 'show_round' # don't forget to pass the encrypted_url
  
  
  # get '/new/:id/task' => 'tasks#new', as: 'org_task'


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
