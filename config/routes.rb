Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  root to:'events#index' #par défaut quand j'arrive sur le server je veux afficher tous les index
  resources :attendances, :events, :users #Pour créer automatiquement l'ensemble des routes

end
