class TeiToEs

  def override_xpaths
    {
      "spatial" => "//keywords[@n='places']/term"
    }
  end

  def preprocessing
    file_location = File.join(@options["collection_dir"], "source/authority/locations.csv")
    @locations = CSV.read(file_location, {
      encoding: "utf-8",
      headers: true,
      return_headers: true
    })
  end

  def title
    # TODO this is temporary until there are actually <title> elements
    @id
  end

  def spatial
    all_places = get_list(@xpaths["spatial"])
    all_places.map do |place|
      row = @locations.find { |row| row["title"] == place }
      next if !row || !row["latitude"] || !row["longitude"]

      {
        "title" => row["title"],
        "coordinates" => {
          "lat" => row["latitude"],
          "lon" => row["longitude"]
        },
        "place_name" => row["place_name"],
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
