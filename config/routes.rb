Diag::Engine.routes.draw do
  get '', to: 'diag#index', as: 'diag_index'

  get 'network', to: 'diag#network'
  get 'network_update', to: 'diag#network_update'

  get 'ping', to: 'diag#ping'
  post 'ping', to: 'diag#ping_do'

  get 'traceroute', to: 'diag#traceroute'
  post 'traceroute', to: 'diag#traceroute_do'

  get 'dig', to: 'diag#dig'
  post 'dig', to: 'diag#dig_do'

  get 'connection', to: 'diag#connection'
  post 'connection', to: 'diag#connection_do'
end
