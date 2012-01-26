module BGGTigris
  def self.nickname
    'tigris'
  end

  def self.my_turn?(doc, username)
    current = doc.css('img[alt="Current Player"]').first.parent.css('.t_medtitle').first.content
    username == current
  end

  def self.icon
    'http://farm1.staticflickr.com/129/344808931_e82e768a14_s.jpg'
  end
end
