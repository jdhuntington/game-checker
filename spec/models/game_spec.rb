require 'spec_helper'

describe Game do
  before do
    @u = User.create!({ :username => 'jd', :password => 'jd' })
  end

  describe '.unfinished' do
    it 'should return games that have not ended' do
      2.times { Game.create!({ :user => @u }) }
      3.times { Game.create!({ :user => @u, :ended_at => Time.new }) }

      @u.games.length.should == 5
      @u.games.unfinished.length.should == 2
    end
  end

  describe '.others_turn' do
    it 'should return games that are not my turn' do
  
      2.times { Game.create!({ :user => @u }) }
      3.times { Game.create!({ :user => @u, :my_turn => true }) }

      @u.games.length.should == 5
      @u.games.others_turn.length.should == 2
    end
  end

  describe '#game_module' do
    it 'should recognize BGGTigris' do
      Game.new(:url => 'http://www.boardgamegeek.com/tigris/view/game/000').game_module.should == BGGTigris
    end

    it 'should recognize DavePeckGo' do
      Game.new(:url => 'http://go.davepeck.org/play/ABCDEF/').game_module.should == DavePeckGo
    end
  end
end
