emotions = Emotion.create!([{ name: 'Joy'}, { name: 'Trust' }, { name: 'Fear' }, { name: 'Surprise' }, 
    { name: 'Sadness' }, { name: 'Disgust' }, { name: 'Anger' }, { name: 'Anticipation' }, 
    { name: 'Love' }, { name: 'Remorse' }])
  
  10.times do |n|
    title       = Faker::Movies::HarryPotter.unique.spell
    content     = Faker::Lorem.paragraph(sentence_count: 10)
    user_id     = "1"
  
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
  
  puts "After seeding the database: "
  puts " - There are #{Memory.count} memories."
  puts " - There are #{Emotion.count} emotions."
  puts " - There are #{Player.count} people and/or pets."