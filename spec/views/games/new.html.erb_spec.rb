require 'spec_helper'

describe "games/new.html.erb" do
  before(:each) do
    assign(:game, stub_model(Game,
      :user_id => 1,
      :url => "MyString",
      :my_turn => false
    ).as_new_record)
  end

  it "renders new game form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => games_path, :method => "post" do
      assert_select "input#game_user_id", :name => "game[user_id]"
      assert_select "input#game_url", :name => "game[url]"
      assert_select "input#game_my_turn", :name => "game[my_turn]"
    end
  end
end
