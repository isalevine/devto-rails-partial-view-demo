class PagesController < ApplicationController
  def index
  end


  private

  def get_json(url)
    response = RestClient.get(url)
    json = JSON.parse(response)
  end
  
  def parse_cards(json, img_array)
    data_array = json["data"]
    data_array.each do |card_hash|
      if card_hash["image_uris"]
        img_hash = {}
        img_hash["name"] = card_hash["name"]
        img_hash["small"] = card_hash["image_uris"]["small"] 
        img_hash["art_crop"] = card_hash["image_uris"]["art_crop"]
        img_hash["artist"] = card_hash["artist"]
        img_array << img_hash
      end
    end

    if json["next_page"]
      get_json(json["next_page"])
      parse_cards(json, img_array)
    end
  end
  
  def get_scryfall_images
    api_url = "https://api.scryfall.com/cards/search?q="
    img_array = []
    creature_search_array = ["merfolk", "goblin", "sliver", "angel"]

    creature_search_array.each do |creature_str|
      search_url = api_url + "t%3Alegend+t%3A" + creature_str
      json = get_json(search_url)
      parse_cards(json, img_array)

      sleep(0.1)  # per the API documentation: https://scryfall.com/docs/api
    end

    img_array.sample(9)
  end
end
