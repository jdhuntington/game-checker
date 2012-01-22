require 'nokogiri'
require 'open-uri'

class Game < ActiveRecord::Base
  belongs_to :user

  scope :unfinished, where(:ended_at => nil)
  scope :others_turn, where(:my_turn => false)
  scope :my_turn, where(:my_turn => true)

  def refresh_status
    Resque.enqueue(UpdateGame, self.id)
  end

  def refresh_status!
    doc = Nokogiri::HTML(open(url))
    my_turn = case url
    when /boardgamegeek.com\/tigris/
                bgg_tigris_my_turn?(doc)
              when /go.davepeck.org\/play/
                davepeck_go_my_turn?(doc)
              else
                false
              end
    my_turn! if my_turn
  end

  def davepeck_go_my_turn?(doc)
    msg = doc.css('#turn_message')[0].content
    !(msg =~ /waiting/)
  end

  def bgg_tigris_my_turn?(doc)
    current = doc.css('img[alt="Current Player"]').first.parent.css('.t_medtitle').first.content
    user.username == current
  end

  def played!
    self.my_turn = false
    save!
  end

  private
  def my_turn!
    self.my_turn = true
    save!
  end
end
