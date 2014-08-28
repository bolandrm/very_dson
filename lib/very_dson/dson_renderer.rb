module VeryDSON
  Mime::Type.register_alias "text/html", :dson

  ActionController::Renderers.add :dson do |dson, options|
    self.content_type ||= Mime::DSON
    DSON.such_serialize_wow(dson)
  end
end
