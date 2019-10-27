class PagesController < ApplicationController
  def index
    if !session[:all_img_array]
      session[:all_img_array] = get_scryfall_images
    end

    session[:sample_img_array] = session[:sample_img_array] || []

    if session[:sample_img_array].empty? || params["button_action"] == "refresh"
      session[:sample_img_array] = session[:all_img_array].sample(9)
    end
  end


  private

  def get_json(url)
    response = RestClient.get(url)
    json = JSON.parse(response)
  end
  
  def parse_cards(json, all_img_array)
    data_array = json["data"]
    data_array.each do |card_hash|
      if card_hash["image_uris"]
        img_hash = {
          "image" => card_hash["image_uris"]["art_crop"],
          "name" => card_hash["name"],
          "artist" => card_hash["artist"]
        }
        all_img_array << img_hash
      end
    end

    if json["next_page"]
      json = get_json(json["next_page"])
      parse_cards(json, all_img_array)
    end
  end
  
  def get_scryfall_images
    api_url = "https://api.scryfall.com/cards/search?q="
    all_img_array = []
    creature_search_array = ["merfolk", "goblin", "angel", "sliver"]

    creature_search_array.each do |creature_str|
      search_url = api_url + "t%3Alegend+t%3A" + creature_str
      json = get_json(search_url)
      parse_cards(json, all_img_array)

      sleep(0.1)  # per the API documentation: https://scryfall.com/docs/api
    end

    all_img_array
  end
end
