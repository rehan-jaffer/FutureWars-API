def authenticate_user(username, password)
  post '/api/auth', params: { username: username, password: password }
  JSON.parse(response.body)
end
