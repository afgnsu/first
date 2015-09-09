namespace :db do
  desc "Generate users"
  task populate: :environment do
    # Generate fixed users Yitao and Ed
    afgnsu = User.create(name: "Patrick Su", email: "afgnsu@gmail.com", password: "mandrake", password_confirmation: "mandrake")
  	yitao = User.create(name: "Yitao", email: "yitao@example.com", password: "secret", password_confirmation: "secret")
  	ed = User.create(name: "Ed", email: "ed@example.com", password: "secret", password_confirmation: "secret")

    # Generate 98 additional random users
  	users = [ afgnsu, yitao, ed ]
    users += 97.times.collect do |i|
      name = "#{Faker::Name.first_name}#{i}"
      #email = i < 10 ? name.split.join : "#{name.split.join}@example.com"
      email = "#{name}@example.com"
      password = Faker::Internet.password
      user = User.create(name: name, email: email, password: password, password_confirmation: password)
    end

    # Randomize user created_at timestamp
    users.each { |user| user.update(created_at: Date.today - rand(30)) }


    #Generate posts
    posts = (10*users.count).times.collect do
      users.sample.posts.create!(content: Faker::Lorem.sentence)
    end

  end
end
