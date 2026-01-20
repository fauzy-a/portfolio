Rails.application.routes.draw do
  # Routing untuk autentikasi Devise
  devise_for :users, path: "", path_names: {
  sign_in: "panel-admin",
  sign_out: "logout"
}
  resources :projects do
  member do
  delete "delete_image/:image_id", to: "projects#delete_image", as: :delete_image
  end
  end
  root "projects#index"
  get "admin/settings", to: "users#settings", as: :admin_settings
  patch "admin/update_cv", to: "users#update_cv", as: :update_cv
  delete "admin/delete_cv", to: "users#delete_cv", as: :delete_cv
  patch "admin/update_password", to: "users#update_password", as: :update_password
  get "download_cv", to: "users#track_cv", as: :track_cv
  patch "admin/update_avatar", to: "users#update_avatar", as: :update_avatar
  delete "admin/delete_avatar", to: "users#delete_avatar", as: :delete_avatar
  patch "admin/update_contacts", to: "users#update_contacts", as: :update_contacts
end
