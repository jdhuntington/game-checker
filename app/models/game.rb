require 'nokogiri'
require 'open-uri'

class Game < ActiveRecord::Base
  belongs_to :user

  def refresh_status
    doc = Nokogiri::HTML(open(url))
    msg = doc.css('#turn_message')[0].content
    my_turn! unless msg =~ /waiting/
  end

  def my_turn!
    self.my_turn = true
    save!
  end
end
