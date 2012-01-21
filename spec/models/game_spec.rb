require 'spec_helper'

describe Game do
  describe '.unfinished' do
    it 'should return games that have not ended' do
      u = User.create!({ :username => 'jd', :password => 'jd' })
      2.times { Game.create!({ :user => u }) }
      3.times { Game.create!({ :user => u, :ended_at => Time.new }) }

      u.games.length.should == 5
      u.games.unfinished.length.should == 2
    end
  end
end
