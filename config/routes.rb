Rails.application.routes.draw do
  root to: 'homes#top'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  get 'account', to: 'dashboards#account'
  patch 'account', to: 'dashboards#update'

  get 'questions' => 'questions#index'
  get 'questions/search', to: 'questions#search'
  get 'answers' => 'answers#index'

  # 退会確認画面
  get '/unsubscribe', to: 'dashboards#unsubscribe', as: 'unsubscribe'

  # 論理削除用のルーティング
  patch '/withdrawal', to: 'dashboards#withdrawal', as: 'withdrawal'

  resources :questions, shallow: true do
    resources :answers, shallow: true do
      resources :reactions
    end
  end
end

  # get '/users', to: 'users/registrations#new'
# get 'user/:id',               to: 'user#show'
