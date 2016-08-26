Rails.application.routes.draw do
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get 'regionals/regional_dashboard'
  get 'branches/branch_dashboard'
  get 'warehouses/warehouse_dashboard'
  get 'customers/customer_dashboard'
  get 'transporters/transporter_dashboard'
  get 'pagemasters/pagesetting_page'
  post 'pagemasters/pagesetting'
  get 'users/user_dashboard'
  post 'users/user_report' 
  get 'images/image_browse'
  post 'images/image_browse'

  get 'images/save_image'
  post 'images/save_image'

  get 'images/image_classification'
  post 'images/save_image_classification'

 get 'images/classification_update'
 post 'images/classification_update'

 get 'images/create_folder'
 post 'images/create_folder'
 get 'images/home'
 post'images/home'

 get 'images/create_attribute'
  post 'images/create_attribute'

  get 'images/attribute_creation'
  post 'images/attribute_creation'

  get 'images/child_attribute_creation'
  post 'images/child_attribute_creation'

  get 'images/child_attribute'
  post 'images/child_attribute'

  get 'images/create_child_attribute'
  post 'images/create_child_attribute'

  get 'images/classification_creation'
  post 'images/classification_creation'

  get 'images/create_classification'
  post 'images/create_classification'

  get 'images/destroy'

  get 'images/destroy_field'

  get 'images/destroy_child_field'  

  get 'images/allocation_classification'
 post 'images/allocated_classification'

 get 'images/allocation_digitization'
 post 'images/allocated_digitization'

 get  'users/login'
  post 'users/login'

  get  'users/validate_login'
  post 'users/validate_login'

  get  'images/dropdownvalue'
  post 'images/dropdownvalue'
  
  get  'images/create_dropdownvalue'
  post 'images/create_dropdownvalue'

     get  'images/select_classification'
  post 'images/select_classification'

  get  'images/digitization'
  post 'images/digitization'

  get  'images/create_digitization'
  post 'images/create_digitization'

   get  'images/document_allocate_digitization'
   post 'images/document_allocated_digitization'

   get 'images/self_audit'
   post 'images/update_classification'

  get 'images/download_template'
  post 'images/download_template'

  get 'images/import_data'
  post 'images/import_data'

  get 'images/import_file'
  post 'images/import_file'

  post 'images/create_child_dropdownvalue'

  get 'images/image_dashboard'
  post 'images/image_dashboard'

  post 'images/subchild_update'
  get 'images/subchild_update'

  post 'images/save_remark'

  get 'images/exception_details'

  get 'images/sub_data'
    post 'images/sub_data'
  
  resources :images
  resources :users
  resources :pagemasters
  resources :usertypes
  resources :customerbranches
  resources :customers
  resources :transporters
  resources :warehouses
  resources :branches
  resources :regionals
  resources :sessions, only: [:new, :create, :destroy]
  root 'sessions#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
