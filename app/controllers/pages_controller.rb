class PagesController < ApplicationController
  def index
    session[:img_array] = session[:img_array] || []

    if session[:img_array].empty? || params["button_action"] == "refresh"
      scryfall_service = ScryfallService.new
      session[:img_array] = scryfall_service.get_images
    end


    session[:refresh_counter] = session[:refresh_counter] || 0

    if params["button_action"] == "refresh"
      session[:refresh_counter] += 1
    end
    
    @refresh_counter = session[:refresh_counter]
  end
end



#     example of session[:img_array] after navigating to localhost:3000
#     [
#      {"image"=>"https://img.scryfall.com/cards/art_crop/front/b/c/bc4c0d5b-6424-44bd-8445-833e01bb6af4.jpg?1562275603", "name"=>"Tuktuk the Explorer", "artist"=>"Volkan Baǵa"}, 
#      {"image"=>"https://img.scryfall.com/cards/art_crop/front/9/a/9a8aea2f-1e1d-4e0d-8370-207b6cae76e3.jpg?1562740084", "name"=>"Tiana, Ship's Caretaker", "artist"=>"Eric Deschamps"}, 
#      {"image"=>"https://img.scryfall.com/cards/art_crop/front/3/7/37ed04d3-cfa1-4778-aea6-b4c2c29e6e0a.jpg?1559959382", "name"=>"Krenko, Tin Street Kingpin", "artist"=>"Mark Behm"}, 
#      {"image"=>"https://img.scryfall.com/cards/art_crop/front/4/2/4256dcc1-0eee-4385-9a5c-70abb212bf49.jpg?1562397424", "name"=>"Slobad, Goblin Tinkerer", "artist"=>"Kev Walker"}, 
#      {"image"=>"https://img.scryfall.com/cards/art_crop/front/2/7/27907985-b5f6-4098-ab43-15a0c2bf94d5.jpg?1562728142", "name"=>"Bruna, the Fading Light", "artist"=>"Clint Cearley"}, 
#      {"image"=>"https://img.scryfall.com/cards/art_crop/front/7/2/722b1e02-2268-4e02-8d09-9b337da2a844.jpg?1562405249", "name"=>"Vial Smasher the Fierce", "artist"=>"Deruchenko Alexander"}, 
#      {"image"=>"https://img.scryfall.com/cards/art_crop/front/8/b/8bd37a04-87b1-42ad-b3e2-f17cd8998f9d.jpg?1562923246", "name"=>"Sliver Legion", "artist"=>"Ron Spears"}, 
#      {"image"=>"https://img.scryfall.com/cards/art_crop/front/d/d/dd199a48-5ac8-4ab9-a33c-bbce6f7c9d1b.jpg?1559959197", "name"=>"Zegana, Utopian Speaker", "artist"=>"Slawomir Maniak"}, 
#      {"image"=>"https://img.scryfall.com/cards/art_crop/front/d/d/ddb92ef6-0ef8-4b1d-8a45-3064fea23926.jpg?1562854687", "name"=>"Avacyn, Angel of Hope", "artist"=>"Jason Chan"}
#     ]