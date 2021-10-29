module ImageDecoder
  def self.attach_image(article)
    image_params = params[:article][:image]
    return true unless image_params

    image = decode_base64_string(image_params)
    return false if image.nil?

    decoded_data = Base64.decode64(image[:data])
    io = StringIO.new
    io << decoded_data
    io.rewind
    article.image.attach(io: io, filename: "#{article.title}.#{image[:extension]}", content_type: image[:type])
  end

  def self.decode_base64_string(image_params)
    if image_params =~ /^data:(.*?);(.*?),(.*)$/
      object = {}
      object[:type] = Regexp.last_match(1)
      object[:encoder] = Regexp.last_match(2)
      object[:extension] = Regexp.last_match(1).split('/')[1]
      object[:data] = Regexp.last_match(3)
      object
    end
  end
end
