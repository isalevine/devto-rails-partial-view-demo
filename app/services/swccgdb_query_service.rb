class SWCCGDBQueryService
    def get_json(url)
        response = RestClient.get(url)
        json = JSON.parse(response)
    end
    
    def parse_cards(json, img_array)
        data_array = json   # api returns all cards in a single array at top level of json
        data_array.each do |card_hash|
            if card_hash["type_code"] == "character"
                img_hash = {
                    "image" => card_hash["image_url"],
                    "name" => card_hash["name"],
                    "artist" => "Lucasfilm / Decipher / Wizards of the Coast / SWCCG Player's Committee"
                }
                img_array << img_hash
            end
        end
    end
    
    def get_swccgdb_images
        api_url = "https://swccgdb.com/api/public/cards/"
        img_array = []
        set_search_array = ["pr", "hoth", "cc"]     # premiere, hoth, and cloud city sets

        set_search_array.each do |set_str|
            search_url = api_url + set_str + ".json?_format=json"
            json = self.get_json(search_url)
            self.parse_cards(json, img_array)
        end

        img_array.sample(9)
    end 
end