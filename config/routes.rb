Rails.application.routes.draw do

  post 'add_answer_option_ajax' => 'answer_options#add_answer_option_ajax'
  resources :answer_options

  get 'questions/:id/edit/:survey_id' => 'questions#edit'
  get 'questions/new/:survey_id' => 'questions#new'
  resources :questions

  get 'surveys/:id/preview' => 'surveys#preview', as: 'survey_preview'
  resources :surveys
  
  post 'assign_student_to_course' => 'courses#assign_student_to_course'
  post 'remove_student_from_course' => 'courses#remove_student_from_course'
  get 'courses/:id/assign_students' => 'courses#assign_students', as: 'assign_students'
  resources :courses
  
  get 'users' => 'users#index'
  get 'user/:id' => 'users#show'
  get 'users/:id/edit' => 'users#edit_user'
  patch 'users/:id/edit' => 'users#update_user'
  delete 'user/:id' => 'users#destroy'
  get 'new_user' => 'users#new_user'
  post 'users/create_user' => 'users#create_user'
  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all
  devise_for :users
  get 'dashboard/index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'dashboard#index'

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
