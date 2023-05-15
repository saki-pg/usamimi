Rails.application.routes.draw do
  namespace :dashboard do
    get 'users/withdrawal'
  end
  root to: 'homes#top'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  get '/account', to: 'dashboards#account'
  post '/account', to: 'dashboards#update'
  get 'update', to: 'dashboards#update'

  get 'questions' => 'questions#index'
  get 'questions/search', to: 'questions#search'
  get 'answers' => 'answers#index'

  # 退会確認画面
  get '/users/:id/unsubscribe' => 'dashboards/users#unsubscribe', as: 'unsubscribe'

  # 論理削除用のルーティング
  patch '/users/:id/withdrawal' => 'dashboards/users#withdrawal', as: 'withdrawal'

  resources :dashboards, only: %i[index update] do
    get :account, on: :collection
  end

  resources :questions, shallow: true do
    resources :answers, shallow: true do
      resources :reactions
    end
  end
end
