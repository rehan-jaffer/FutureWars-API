json.player do
  json.username @current_user.username
  json.turns @current_user.turns
  json.rank @current_user.rank
  json.exp @current_user.exp
  json.current_sector @current_user.current_sector
  json.credits @current_user.credits
  json.ship do 
    json.name @current_user.ship_name
    json.model @current_user.ship_type.to_s
  end
end
