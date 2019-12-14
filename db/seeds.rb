if User.exists?(:username => "Harry Potter")

  u = User.find_by_username('Harry Potter')
  u.emotions.each do |emotion|
    emotion.destroy
  end
  u.players.each do |player|
    player.destroy
  end
  u.destroy
  system "clear"
  puts "User Harry Potter has been deleted."
  puts ""
  puts "Run rake db:seed again to recreate User Harry Potter."
  puts ""

else

  user = User.create!(
    username: 'Harry Potter',
    email: 'chosen_one@hogwarts.com',
    password: 'magic'
  )

  emotions = Emotion.create!([{ name: 'Joy'}, { name: 'Trust' }, { name: 'Fear' }, { name: 'Surprise' }, 
      { name: 'Sadness' }, { name: 'Disgust' }, { name: 'Anger' }, { name: 'Anticipation' }, 
      { name: 'Love' }, { name: 'Remorse' }])
    
    10.times do |n|
      title       = Faker::Movies::HarryPotter.unique.spell
      content     = Faker::Lorem.paragraph(sentence_count: 10)
      user_id     = User.find_by_username('Harry Potter').id
  
      memory = Memory.create!(
        title:        title,
        content:      content,
        user_id:      user_id
      )
  
      players = Player.create!([
        {name:     Faker::Movies::HarryPotter.unique.character},
        {name:     Faker::Movies::HarryPotter.unique.character},
        {name:     Faker::Movies::HarryPotter.unique.character}
      ])
  
      memory.emotions << emotions.pop
      memory.players << players
    end
    
  system "clear"  
  puts "After seeding the database: "
  puts " - There are #{Memory.count} Memories."
  puts " - There are #{Emotion.count} Emotions."
  puts " - There are #{Player.count} People and/or Pets."
  puts " - Created a new User named Harry Potter with a password of magic."
  puts ""
  puts " - run 'rake db:seed' again to delete User Harry Potter. Repeat as many times as you wish."
  puts ""
end