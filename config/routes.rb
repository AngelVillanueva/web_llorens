WebLlorens::Application.routes.draw do

  mount Rich::Engine => '/rich', :as => 'rich'

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :usuarios

  root to: 'web_pages#home'
  match '/contacto' => 'web_pages#contact', as: :contact
  match '/download' => 'web_pages#download', as: :download
  match '/condiciones' => 'web_pages#condiciones', as: :condiciones
  match '/privacidad' => 'web_pages#privacidad', as: :privacidad
  match '/politica_cookies' => 'web_pages#cookies_policy', as: :cookies_policy

  namespace :online do
    root to: 'static_pages#home'

    resources :avisos do
      get :index
      get :show
      post :change_shown_status
    end

    resources :informes do
      member do
        get 'download'
      end
    end
    
    resources :justificantes do
      member do
        get 'download'
      end
    end

    resources :documentos do
      member do
        get 'download'
      end
    end

    resources :documentos do
      member do
        get 'downdoc'
      end
    end

    resources :documentos do
      member do
        get 'view_observaciones'
      end
    end

    resources :drivers do
      member do
        get 'view_observaciones'
      end
    end

    resources :drivers do
      member do
        get 'download'
      end
    end

    resources :mandatos do
      member do
        get 'download'
      end
    end

    resources :mandatos do
      member do
        get 'view_validator'
      end
    end

    resources :mandatos do
      member do
        put 'set_code'
      end
    end

    resources :mandatos do
      member do
        get 'gen_mandato'
      end
    end

    resources :mandatos do
      member do
        get 'send_sms'
      end
    end

    resources :expedientes
    resources :matriculaciones, :controller => "expedientes", :type => "Matriculacion" do
      member do
        get 'matricula'
      end
    end
    resources :transferencias, :controller => "expedientes", :type => "Transferencia"
    resources :clientes do
      #member do
        resources :stock_vehicles
      #end
    end
  end

  namespace :api do
    namespace :v1 do
      resources :expedientes
      match '/batch' => 'expedientes#create_batch'
      match '/single' => 'expedientes#create_or_update_single'
      resources :matriculaciones, :controller => "expedientes", :type => "Matriculacion"
       
     # match '/matriculas' => 'expedientes#matriculaciones'
      #match '/matricula' => 'expedientes#matricula'
      resources :documentos
      resources :drivers
      #resource :expediente
      #match '/matriculas' => 'expedientes#matriculas'
    end
  end
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
