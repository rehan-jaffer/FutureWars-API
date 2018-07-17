def authenticate_user(username, password)
  post '/api/sessions', params: { username: username, password: password }
  JSON.parse(response.body)
end
