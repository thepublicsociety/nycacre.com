DevelopmentMetatroidCom::Application.routes.draw do
  resources :job_postings


  resources :tool_specialty_options


  


  resources :advisors


  resources :news_site_specialty_options


  resources :contact_specialty_options


  resources :provider_specialty_options


  resources :funding_status_options


  resources :resume_specialty_options


  resources :statements


  match "/administration/dashboard" => "administration#dashboard", :as => "administration_root"
  match "/administration/cms" => "administration#cms_index"
  match "/delete-user" => "administration#delete_user"
  match "/access-control" => "administration#access_control"
  match "/auth/:provider/callback" => "administration#external_auth"
  match "/calendar-select" => "administration#calendar_select"
  match "administration/resources" => "administration#resources"
  match "administration/news" => "administration#news"
  match "administration/contact" => "administration#contact"
  match "/resource-search" => "administration#resource_search"
  match "/filter-resources" => "administration#filter_resources"
  match "/administration/unapproved-resources" => "administration#unapproved_resources"
  match "/administration/resource-display" => "administration#resource_display"
  match "/administration/save-memo" => "administration#save_memo"
  match "/administration/applicants" => "administration#applicants"
  match "/administration/remove-announcement" => "administration#remove_announcement"
  match "/administration/display-announcement" => "administration#display_announcement"
  match "/administration/calendar" => "administration#calendar"
  match "/add-calendar-event" => "administration#add_calendar_event"
  match "/administration/create-alert" => "administration#create_alert"
  match "/administration/remove-alert" => "administration#remove_alert"
  match "/dashboard-news-filter" => "administration#dashboard_filter"
  match '/mail' => 'administration#send_email', :as => :admin_email_form, :via => :post
  match "/delete-image" => "administration#delete_image"
  
  scope 'administration' do
    resources :posts
    resources :articles
    resources :events
    resources :snippets
    resources :acres
    resources :challenges do
      resources :challenge_stats
    end
    resources :tenants do
      resources :tenant_stats
    end
    resources :graduates
    resources :providers
    resources :grants
    resources :tools
    resources :contacts
    resources :resumes
    resources :news_sites
    resources :announcements
    resources :backgrounds
    resources :tenant_backgrounds
    resources :news_sources
    resources :alerts
  end
  resources :news_photos
  resources :tenant_applications
  resources :abouts
  resources :companies
  resources :sectors
  resources :questions do
    resources :answers
  end
  resources :subscriptions
  resources :memos

  devise_for :users, :path => 'accounts', :controllers => {:registrations => "registrations", :invitations => "invitations"}
  devise_scope :user do
    get "login", :to => "devise/sessions#new"
    get "logout", :to => "devise/sessions#destroy"
    get "register", :to => "registrations#new"
    get "/user/settings" => "registrations#edit"
  end
  resources :users do
    resources :user_events
  end
  
  match "/checkin" => "internals#checkin"
  match "/acceptanswer" => "questions#acceptanswer"
  
  match "/events/:id" => "pages#event_display"
  match "/event/:id" => "pages#google_event_display"
  match "/grants/:id" => "pages#grant_display"
  match "/calendar/events/:id" => "pages#cal_event_display"
  match "/calendar/event/:id" => "pages#cal_google_event_display"
  match "/calendar/grants/:id" => "pages#cal_grant_display"
  match "/announcement/:id" => "pages#announcement"
  match "/map" => "pages#map"
  match "/challenge" => "pages#challenge"
  match "/about" => "pages#about"
  match "/about/:tenant" => "pages#about_tenant"
  match "/graduate/:graduate" => "pages#graduate"
  match "/news" => "pages#news"
  match "/news/:title" => "pages#news_article"
  match "/article/:title" => "pages#article"
  match "/contact" => "pages#contact"
  match "/calendar" => "pages#calendar"
  match "/internal_error.html" => "internal_error#index"
  match '/email' => 'pages#send_email_form', :as => :email_form, :via => :post
  match "/search" => "pages#search", :via => :post
  root :to => "pages#index"
end
