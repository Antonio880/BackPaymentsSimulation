Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'  # Pode substituir '*' por um domínio específico, como 'https://example.com'
    
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: false  # Defina como true se você precisar enviar cookies ou cabeçalhos de autenticação
  end
end