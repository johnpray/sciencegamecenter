namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "John Pray",
                 email: "jpray@example.com",
                 password: "pikachu",
                 birth_date: Date.new(1989, 01, 30),
                 disabled: false)
    admin.toggle!(:is_admin)
    melanie = User.create!(name: "Melanie Stegman",
                 email: "mstegman@example.com",
                 password: "fas@20036",
                 birth_date: Date.new(1989, 01, 30),
                 disabled: false,
                 is_admin: true)
    User.create!(name: "Mickey Mouse",
                 email: "jpray+mickey@example.com",
                 password: "pikachu",
                 birth_date: Date.new(1989, 01, 30),
                 disabled: false)
    User.create!(name: "Bugs Bunny",
                 email: "jpray+bugs@example.com",
                 password: "pikachu",
                 birth_date: Date.new(1989, 01, 30),
                 disabled: false)
    Game.create(
      title: "Immune Attack",
      description: "Immune Attack is funded by the National Science Foundation and jointly developed by the Federation of American Scientists, the University of Southern California, Brown University, and Escape Hatch Entertainment. It teaches immunology in a fun and engaging way that is different from the traditional classroom setting, making use of the challenge and reward paradigm found in most video games.",
      website_url: "http://www.immuneattack.org/",
      developer: "[Learning Technologies at FAS](http://www.fas.org/blog/learningtech/)"
      )
    Game.create(
      title: "Science Pirates: The Curse of Brownbeard",
      description: "Science Pirates: The Curse of Brownbeard is a 3D educational computer game that communicates food safety knowledge in an environment of scientific exploration. The USDA awarded NMSU a grant to develop interactive games that help mid-school youth learn about food safety procedures, such as hand washing, cooking food to the proper temperature, keeping raw meat and cooked food separate, and washing surfaces. NMSU's Media Productions unit has a strong history in developing food safety materials, including an effective games site for younger children in 3rd - 5th grades, The Food Detectives Fight BAC!.",
      website_url: "http://sciencepirates.com/",
      developer: "[NMSU Learning Games Lab](http://learninggames.nmsu.edu/)"
      )
    Game.all.each do |game|
      game.player_reviews.create(
        title: "An absolute must for learning the immune system effectively",
        content: "You must navigate a nanobot through a 3D environment of blood vessels and connective tissue in an attempt to save an ailing patient by retraining her non-functional immune cells.  Along the way, you will learn about the biological processes that enable macrophages and neutrophils -- white blood cells -- to detect and fight infections.",
        user_id: 1,
        game_id: game.id,
        fun_rating: 5,
        accuracy_rating: 3,
        effectiveness_rating: 1,
        status: "Approved"
        )
      game.player_reviews.create(
        title: "Well, golly.",
        content: "Mickey: Come on, Goofy, it's a beautiful day! Let's go out and shoot some golf! Goofy: Golf? Are they in season? Mickey: That's just an expression! You don't really shoot anything! You use clubs! Goofy: And beat thuh little rascals to death? That's not fair! Mickey: Never mind! I'll explain it when we get there! Goofy: Where are we goin'? Mickey: We'll go out to Seaside Golf Course! There won't be many people out there today! Goofy: That's good! I'd hate tuh have anybody see me hittin' those poor little golfs! Mickey: Goofy, are you all right? Goofy: I'm all right, but muh chewin' gum got all salty!",
        user_id: 3,
        game_id: game.id,
        fun_rating: 5,
        accuracy_rating: 4,
        effectiveness_rating: 2,
        status: "Approved"
        )
      game.player_reviews.create(
        title: "What's up, doc?",
        content: "He don't know me very well, do he? Duck Season! Hey, Laughing Boy! I knew I shoulda make that left toin at Albaquerque I wish my brotha George was here! (as Liberace) Well, now, I wouldn't say that! (as an old woman) Help! Help! Usher! Usher! That man's annoying me! I'm mutiplying, see? I'm multiplying. Ain't I a stinker?",
        user_id: 4,
        game_id: game.id,
        fun_rating: 2,
        accuracy_rating: 3,
        effectiveness_rating: 5,
        status: "Approved"
        )
    end
  end
end