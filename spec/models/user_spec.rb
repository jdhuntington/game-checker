require 'spec_helper'

describe User do
  describe 'creating' do
    it 'should encrypt the password' do
      u = User.create!({ :username => 'jd', :password => 'password' })
      User.find(u.id).password.should_not == 'password'
    end
  end

  describe 'authentication' do
    it 'should properly look up a user' do
      u = User.create!({ :username => 'jd', :password => 'password' })
      User.lookup('jd', 'password').should == u
    end
  end
end
