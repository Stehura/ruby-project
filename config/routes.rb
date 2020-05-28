Rails.application.routes.draw do
  #ROOT
  root "main#index", as: :main
  #----------------------------------------------------------------------------

  #GET requests
  get "/posts",             to: "posts#all",         as: :all_posts
  get "/posts/search",                               as: :search
  get "/posts/new",         to: "posts#new",         as: :new_post
  get "/posts/:id",         to: "posts#show",        as: :post
  get "/posts/:id/edit",    to: "posts#edit",        as: :edit_post
  get "/posts/:id/comment", to: "posts#new_comment", as: :new_comment
  get "/login",             to: "login#load",        as: :login_url
  get "/register",          to: "register#load",     as: :register_url
  get "/posts/:id/comment/:comment_id/edit",   to: "posts#edit_comment", as: :edit_comment
  #----------------------------------------------------------------------------
  
  #POST requests
  post "/posts/new",        to: "posts#create"
  post "/posts/:id/comment",to: "posts#create_comment"
  post "/login",            to: "login#validate"
  post "/logout",           to: "login#logout",      as: :logout_url
  post "/register",         to: "register#register"
  post "/posts/search",     to: "posts#give_results"
  #----------------------------------------------------------------------------

  #PATCH requests
  patch "/posts/:id/edit",  to: "posts#update"
  patch "/posts/:id/comment/:comment_id/edit", to: "posts#update_comment"
  #----------------------------------------------------------------------------

  #DELETE requests
  delete "/posts/:id",      to: "posts#destroy"
  delete "/posts/:id/comment/:comment_id",     to:"posts#destroy_comment", as: :delete_comment
  #----------------------------------------------------------------------------
end
