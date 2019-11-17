class ScryfallService
    
    def get_json(url)
        response = RestClient.get(url)
        json = JSON.parse(response)
    end
    
    def parse_cards(json, img_array)
        data_array = json["data"]
        data_array.each do |card_hash|
        if card_hash["image_uris"]
            img_hash = {
            "image" => card_hash["image_uris"]["art_crop"],
            "name" => card_hash["name"],
            "artist" => card_hash["artist"]
            }
            img_array << img_hash
        end
        end

        if json["next_page"]
        json = self.get_json(json["next_page"])
        self.parse_cards(json, img_array)
        end
    end
    
    def get_images    # add optional args w/ (creatures*) ?
        api_url = "https://api.scryfall.com/cards/search?q="
        img_array = []
        creature_search_array = ["merfolk", "goblin", "angel", "sliver"]

        creature_search_array.each do |creature_str|
        search_url = api_url + "t%3Alegend+t%3A" + creature_str
        json = self.get_json(search_url)
        self.parse_cards(json, img_array)

        sleep(0.1)  # per the API documentation: https://scryfall.com/docs/api
        end

        img_array.sample(9)
    end

end