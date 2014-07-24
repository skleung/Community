Community::Application.routes.draw do
  get "welcome/index"
  get 'my_groups' => "groups#my_groups", as: :my_groups
  get 'group/attempt/:id' => "groups#attempt_to_join_group", as: :attempt_join_group
  post 'group/attempt/:id' => "groups#join_group", as: :attempt_join_group_post
  #devise_for :diners #this needs to be at the top of the file.
  devise_for :diners, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout', :sign_up => "signup"}, 
      controllers: { registrations: "registrations", sessions: "sessions", passwords: "passwords" }

  resources :ingredients
  resources :meals

  resources :groups

  post 'change_current_group/:id' => "groups#change_current_group", as: :change_current_group

  
  post 'meals/pay' => "meals#pay", as: :pay
  post 'meals/signup_post' => 'meals#signup_post', as: :signup_meal
  post 'meals/get_attendence' => 'meals#get_attendance', as: :get_attendence_meal

  resources :diners
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'meals#signup'

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
