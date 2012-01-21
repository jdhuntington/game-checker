namespace :game_checker do
  desc "Enqueue jobs to check all unfinished games"
  task :check => [:environment] do
    Game.all.unfinished.each do |g|
      g.refresh_status
    end
  end
end
