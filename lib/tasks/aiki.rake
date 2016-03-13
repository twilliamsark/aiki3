namespace :aiki do

  task dump_to_seed_fu: :environment do
    klasses = %w(AikiFormat Attack AttackHeight Direction Entrance HandAppliedTo Kaiten Kata Level MakaKomi Rank Role Sensei Stance Style Sword Technique User UserRememberToken Video Waza)
    klasses.each do |klass|
      klass.constantize.to_seed_fu
    end
  end

end