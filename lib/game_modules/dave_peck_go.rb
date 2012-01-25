module DavePeckGo
  def self.nickname
    'go'
  end
  
  def self.my_turn?(doc, username)
    msg = doc.css('#turn_message')[0].content
    !(msg =~ /waiting/)
  end

  def self.icon
    'http://farm2.staticflickr.com/1140/547944930_8d911f4027_s.jpg'
  end
end
