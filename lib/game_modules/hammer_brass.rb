module HammerBrass
  def self.nickname
    'brass'
  end

  def self.my_turn?(doc, username)
    to_move_phrase = doc.css('p').detect { |x| x.content =~ /to move/ }.content
    !! to_move_phrase["(#{username})"]
  end

  def self.icon
    'http://farm4.staticflickr.com/3209/3044965125_3b988ed585_s.jpg'
  end
end
