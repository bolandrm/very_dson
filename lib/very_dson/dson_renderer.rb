module VeryDSON
  ActionController::Renderers.add :dson do |dson, options|
    self.content_type ||= Mime::TEXT
    DSON.stringify(dson)
  end
end
