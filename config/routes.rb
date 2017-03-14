Rails.application.routes.draw do
  root 'root#index'
  get 'counter', to: 'root#counter'
  get 'gauge', to: 'root#gauge'
  get 'histogram', to: 'root#histogram'
  get 'summary', to: 'root#summary'
  get 'error', to: 'root#error'
  get 'fnf', to: 'root#fnf'
  get 'prometheus', to: 'root#prometheus'
  get 'grafana', to: 'root#grafana'
  get 'alert_manager', to: 'root#alert_manager'
  get 'kubernetes_dashboard', to: 'root#kubernetes_dashboard'
end
