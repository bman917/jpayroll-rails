RailsApp::Application.routes.draw do
  resources :employees

  resources :time_entries

  match "time_table" => "time_entries#table"

  get "multi_date_picker/all"
  get "multi_date_picker/fist_half"
  get "multi_date_picker/seconf_half"
  get "multi_date_picker/clear_all"

  post "salary/calc"
  match "salary" => "salary#index"

  resources :holidays
  
  match  "holidays/month/:month" => "holidays#month"

  resources :tax_records

  resources :taxes

  get "tax_sv/simple"
  get "tax_sv/test"
  get "tax_sv/new"
  post "tax_sv/calc"
  post "tax_sv/calco"
  get "tax_sv/calco"

  get "say/hello"

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
  root :to => 'tax_sv#new', :as => 'tax'
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
