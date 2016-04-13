
require 'api_constraints'

Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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

  	devise_for :users
	#Api definition
	#Creamos el namespace Api para que ejecute los controladores que estén en esta carpeta de controllers 
	#vez de los del raiz; además le diremos que por defecto trabajaremos con un JSON

	namespace :api, defaults: { format: :json} do
	                             #constraints: {subdomain: 'api' }, path: '/' do  <-DESCOMENTAR ANTES DE SUBIR
	#Añadimos control de versiones
	    scope module: :v1,
	    			constraints: ApiConstraints.new(version: 1, default: true) do

	    	#Hacemos que la aplicación sea multi-idioma. Por defecto en inglés y que sólo 
	    	#como otro idioma el español
	    	scope '(:locale)', defaults: { locale: 'en'}, constraints: {locale: /en|es/} do

		    	#El controlador de usuarios sólo podrá ser accedido con las funciones
		    	#show

		    	resources :users, :only => [:create] do
		    		collection do
		    			post 'create'
		    		end
		    	end

		    	#El controlador de sessiones sólo podrá ser accedio para crear y borrar una sesion
		    	#por eso idicamos que los métodos válidos de invocación son create y destroy
		    	resources :sessions, :only => [:create, :destroy, :forgotPassword] do
		    		collection do
		    			post 'create'
		    			post 'destroy'
		    			post 'forgotPassword'
		    		end
		    	end

		    	resources :companies, :only =>[:create, :show, :showByUser, :showByCompany, :update, :destroy, :types] do
		    		collection do
		    			post 'create'
		    			get 'types'
		    			get 'show' => 'companies#show' 
		    			get 'showByUser/:id' => 'companies#showByUser'
		    			get  'showByCompany/:id' => 'companies#showByCompany'
		    			post 'update'
		    			post 'destroy' 

		    		end
		    	end

		    	resources :branchoffices, :only =>[:create, :show, :showByUser, :showByCompany, :showByActiviyType, :update, :destroy] do
		    		collection do
		    			post 'create'
		    			get  'show' => 'branchoffices#show'
		    			get  'showByUser/:id' => 'branchoffices#showByUser'
		    			get  'showByCompany/:id' => 'branchoffices#showByCompany'
		    			get  'showByActivityType/:id' => 'branchoffices#showByUser'
		    			post 'update'
		    			post 'destroy'
		    		end
		    	end

		    	resources :rooms, :only =>[:create, :show, :showByBranch, :update, :destroy,:disableroom] do
			    	collection do
			    		post 'create'
		    			get  'show/:id' => 'rooms#show'
		    			get  'showByBranch/:id' => 'rooms#showByBranch'
		    			post 'update'
		    			post 'destroy'
		    			get 'disableroom' =>'rooms#disableroom'
		    		end
		    	end

		    	resources :activities, :only =>[:create, :showByRoom, :showByBranch, :update, :destroy] do
			    	collection do
			    		post 'create'
		    			get  'showByRoom/:id' => 'activities#showByRoom'
		    			get  'showByBranch/:id' => 'activities#showByBranch'
		    			post 'update'
		    			post 'destroy'
		    		end
		    	end

		    	resources :scheduleheaders, :only => [:crete, :show, :addBody] do
		    		collection do
		    			post 'create'
		    			get 'show/:id' => 'scheduleheaders#show'
		    			post 'addBody' => 'scheduleheaders#addBody'
		    		end
		    	end

		    	resources :resourcetypes, :only => [:show] do
		    		collection do
		    			get 'show' => 'resourcetypes#show'
		    		end
		    	end

		    end
	    end 
	end

	root :to =>'login#principal'
	#root :to =>'login#show'
end

