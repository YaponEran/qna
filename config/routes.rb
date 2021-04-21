Rails.application.routes.draw do
<<<<<<< HEAD

  devise_for :users
  root to: "questions#index"
=======
>>>>>>> 13c0805273e520b39b3768c822b825e9c97d5578
  
  resources :questions do
    resources :answers, shallow: true
  end

end
