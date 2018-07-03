class application
  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      find_price_return = find_price(item_name)

      if find_price_return.class == String
        resp.write find_price_return
      else
        resp.write "Item not found"
        resp.status = find_price_return
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end

  def find_price(item_name)
    the_found_item = @@items.find do |e|
      e.name == item_name
    end

    if the_found_item
      return "#{the_found_item.price}"
    else
      return 400
    end
  end
end
