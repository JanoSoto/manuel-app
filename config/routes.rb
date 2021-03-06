Rails.application.routes.draw do

  post 'add_answer_option_ajax' => 'answer_options#add_answer_option_ajax'
  resources :answer_options

  post 'questions_by_survey' => 'questions#find_by_survey'
  get 'questions/:id/edit/:survey_id' => 'questions#edit'
  get 'questions/new/:survey_id' => 'questions#new'
  resources :questions

  get 'results_by_group/:course_id/:survey_name/:group_name' => 'surveys#results_by_group', as: 'results_by_group'
  get 'results_by_user/:survey_id' => 'surveys#results_by_user', as: 'results_by_user'
  get 'my_surveys/:id/results/:course_id/:survey_name/:evaluated_user_id/:user_id' => 'surveys#results', as: 'survey_results'
  post 'save_survey_answers' => 'surveys#save_survey_answers'
  get 'survey/:id/answer' => 'surveys#answer_survey', as: 'answer_survey'
  get 'my_surveys/pending' => 'surveys#my_pending_surveys', as: 'my_pending_surveys'
  get 'my_surveys' => 'surveys#my_surveys'
  get 'surveys/:id/preview' => 'surveys#preview', as: 'survey_preview'
  resources :surveys
  
  get 'couses/:course_id/results/:survey_name/group/:group_name' => 'courses#survey_results_by_group', as: 'survey_group_results'
  post 'update_assigned_survey' => 'courses#update_assigned_survey'
  get 'courses/:course_id/edit_assigned_survey/:survey_id' => 'courses#edit_assigned_survey', as: 'edit_assigned_survey'
  get 'courses/:course_id/assigned_survey/:survey_name' => 'courses#assigned_survey_details', as: 'assigned_survey_details'
  post 'save_assigned_survey' => 'courses#save_assigned_survey'
  get 'course/:id/assign_survey' => 'courses#assign_survey', as: 'assign_survey'
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
