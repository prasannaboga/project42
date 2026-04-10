class Image
  def initialize(filename)
    @filename = filename
  end

  def display
    puts "Displaying #{@filename}"
  end
end

class ProxyImage < Image
  def display
    puts "Displaying ProxyImage"
  end
end

class OriginalImage < Image
  def display
    proxy_image = ProxyImage.new(@filename)
    proxy_image.display
    2.times do
      sleep 1
      puts "laoding OriginalImage - #{@filename}"
    end
    puts "Displaying OriginalImage - #{@filename}"
  end
end

class ImageProxy < Image
  attr_reader :filename

  def display
    @real_image ||= OriginalImage.new(@filename)
    @real_image.display
  end
end

image_proxy = ImageProxy.new("sampleimage.jpg")
image_proxy.display
