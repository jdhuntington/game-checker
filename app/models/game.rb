require 'nokogiri'
require 'open-uri'

Dir[File.join(Rails.root, 'lib', 'game_modules', '*.rb')].each do |f|
  require File.expand_path(f)
end

class Game < ActiveRecord::Base
  belongs_to :user

  scope :unfinished, where(:ended_at => nil)
  scope :others_turn, where(:my_turn => false)
  scope :my_turn, where(:my_turn => true)

  def refresh_status
    Resque.enqueue(UpdateGame, self.id)
  end

  def refresh_status!
    my_turn! if game_module.my_turn?(doc, username)
  end

  def doc
    Nokogiri::HTML(open(url))
  end

  def username
    user.username
  end

  def nickname
    game_module.nickname
  end

  def game_module
    case url
    when /boardgamegeek.com\/tigris/
      BGGTigris
    when /go.davepeck.org\/play/
      DavePeckGo
    when /brass.orderofthehammer.com/
      HammerBrass
    else
      nil
    end
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
