class TeiToEs

  def override_xpaths
    {
      "spatial" => "//keywords[@n='places']/term",
      "date" => "//keywords[@n='treatydate']/term[1]",
      "date_display" => "//keywords[@n='treatydate']/term[1]",
      "subjects" => "//keywords[@n='ethnic_group']/term[1]",
      "keywords" => "//keywords[@n='ships']/term[1]",
      "creator" => "//particDesc/listPerson/person[@role='signatory']/persName"
    }
  end

  def preprocessing
    file_location = File.join(@options["collection_dir"], "source/authority/locations.csv")
    @locations = CSV.read(file_location, **{
      encoding: "utf-8",
      headers: true,
      return_headers: true
    })
  end

  #def title
    # TODO this is temporary until there are actually <title> elements
    #@id
  #end

  def spatial
    all_places = get_list(@xpaths["spatial"])
    all_places.map do |place|
      row = @locations.find { |row| row["title"] == place }
      next if !row || !row["latitude"] || !row["longitude"]

      {
        "name" => row["title"],
        "coordinates" => [row["longitude"].to_f, row["latitude"].to_f],
        "short_name" => row["place_name"],
        "street" => row["street"],
        "city" => row["city"],
        "county" => row["county"],
        "state" => row["state"],
        "country" => row["country"],
        "region" => row["region"],
        "postal_code" => row["postal_code"]
      }
    end
  end

end
