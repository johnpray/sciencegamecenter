namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "John Pray",
                 email: "jpray@fas.org",
                 password: "pikachu",
                 birth_date: Date.new(1989, 01, 30),
                 disabled: false)
    admin.toggle!(:is_admin)
    User.create!(name: "Melanie Stegman",
                 email: "mstegman@fas.org",
                 password: "fas@20036",
                 birth_date: Date.new(1989, 01, 30),
                 disabled: false)
    User.create!(name: "Mickey Mouse",
                 email: "jpray+mickey@fas.org",
                 password: "pikachu",
                 birth_date: Date.new(1989, 01, 30),
                 disabled: false)
    User.create!(name: "Bugs Bunny",
                 email: "jpray+bugs@fas.org",
                 password: "pikachu",
                 birth_date: Date.new(1989, 01, 30),
                 disabled: false)
    end
    Game.create(
      title: "Immune Attack",
      description: "Immune Attack is funded by the National Science Foundation and jointly developed by the Federation of American Scientists, the University of Southern California, Brown University, and Escape Hatch Entertainment. It teaches immunology in a fun and engaging way that is different from the traditional classroom setting, making use of the “challenge and reward” paradigm found in most video games.

Immune Attack is a supplemental teaching tool, designed to be used in addition to middle school and high school biology textbooks.  Immune Attack introduces molecular biology and cellular biology in detail that is usually reserved for college students.  However, it uses the familiar and motivational video game format to introduce the strange and new world of cells and molecules.  Teachers are encouraged to refer to Immune Attack as an example of biological processes, and to give FAS feedback on how you have used Immune Attack in your classroom."
      website_url: "http://www.immuneattack.org/"
      )
    Game.create(
      title: "Science Pirates: The Curse of Brownbeard",
      description: "_From the official website:_

Science Pirates: The Curse of Brownbeard is a 3D educational computer game that communicates food safety knowledge in an environment of scientific exploration.

The USDA awarded NMSU a grant to develop interactive games that help mid-school youth learn about food safety procedures, such as hand washing, cooking food to the proper temperature, keeping raw meat and cooked food separate, and washing surfaces. NMSU's Media Productions unit has a strong history in developing food safety materials, including an effective games site for younger children in 3rd — 5th grades, "The Food Detectives Fight BAC!®".

Original game design called for online gaming simulations through which youth would design their own experiments, draw conclusions and make recommendations in all areas of food safety. However, early testing of prototypes revealed the lack of experience youth have in conducting experiment design, and the instructional challenge of preparing students to adequately perform this important science process.

Thus, the educational goal of Pirate Science shifted from one of understanding food safety issues through science processes, to one of understanding science processes to better change food safety behavior. That meant the educational focus became more centered on scientific understanding and processes, with the end result being a game that leads students through science processes as recommended through national science standards, while giving gamers a culminating activity of experiment design to lead them to better understanding of hand washing.

Specifically, learners will

- observe hand washing behavior on the Isle of Misfortune
- predict possible solutions
- understand hypothesis formation, and how it differs from research questions
- engage in testing one variable at a time in experiments
- participate in a new approach to independent and dependent variable identification
- draft a hypothesis
- design an experiment
- draw conclusions
- publish findings
- make recommendations for hand washing behavior"
      website_url: "http://sciencepirates.com/"
      )
    Game.all.each do |game|
      game.player_reviews.create(
        title: "An absolute must for learning the immune system effectively"
        content: "You must navigate a nanobot through a 3D environment of blood vessels and connective tissue in an attempt to save an ailing patient by retraining her non-functional immune cells.  Along the way, you will learn about the biological processes that enable macrophages and neutrophils – white blood cells – to detect and fight infections.

The crowd at the USA Science and Engineering expo was curious and eager to hear about real science!  Some high school kids wanted to talk about careers in science.  FAS is a science policy think tank, so we had plenty to talk about!  Additionally, video game production requires many different types of scientific, mathematical and engineering related skills.   Someone needs to design the game and designing means testing to find out whether the game is fun.  Testing means experimental design!  Which audience finds your game fun?  And what is your control game?  Then someone will program the game.  Someone else is an expert at drawing three-dimensional objects using software like Maya, Studio Max, or Cinema4D.  Then still another artist uses other software to create all of the backgrounds.  Then another artist uses more technology to create the characters.  And if you are making a realistic video game, then someone serves as a subject matter expert and makes sure the historical context is correct, or that the science in the Microbot is accurate…  I could go on and on.   See below for links to art and biological science in particular.

I enjoyed meeting all of you.  Please support technology in our schools!  Why?  Because you can’t see viruses, you can see bacteria.  You can’t see proteins.  But you can see them in a video game!   Imagine learning soccer, but never being shown the field.  Previously, we did not have ways to see bacteria and proteins, but now we do!   And the new data is being used by many people in the Medical Illustration Field to create videos and diagrams that explain the molecular science that affects our everyday lives."
        user_id: 1
        game_id: game.id
        )
      game.player_reviews.create(
        title: "Well, golly."
        content: "Mickey: Come on, Goofy, it's a beautiful day! Let's go out and shoot some golf!
Goofy: Golf? Are they in season?
Mickey: That's just an expression! You don't really shoot anything! You use clubs!
Goofy: And beat thuh little rascals to death? That's not fair!
Mickey: Never mind! I'll explain it when we get there!
Goofy: Where are we goin'?
Mickey: We'll go out to Seaside Golf Course! There won't be many people out there today!
Goofy: That's good! I'd hate tuh have anybody see me hittin' those poor little golfs!
Mickey: Goofy, are you all right?
Goofy: I'm all right, but muh chewin' gum got all salty!"
        user_id: 3
        game_id: game.id
        )
      game.player_reviews.create(
        title: "What's up, doc?"
        content: "He don't know me very well, do he?
Duck Season!
Hey, Laughing Boy!
I knew I shoulda make that left toin at Albaquerque
I wish my brotha George was here! (as Liberace)
Well, now, I wouldn't say that!
(as an old woman) Help! Help! Usher! Usher! That man's annoying me!
I'm mutiplying, see? I'm multiplying.
[speaking in drag] Did I hurt you with my naughty gun?
[speaking in drag] I would just LOVE a duck dinner.
I'll do it, but I'll probably hate myself in the morning!
Mmm, rabbits. That sounds delicious. [Does a double-take.] Rabbits!
Of course you know (realize) this means war!
Poor little nimrod.
Well what didja expect in an opera, a HAPPY ending?
Hey, wait a cotton-pickin minute!
What a gulli-bull! What a nin-cow-poop!
Whatta maroon! Whatta ignoranimus!
Gee, ain't I a stinker?
[with Daffy Duck] Shhh! Be very, very quiet: we're hunting Elmers!
Now cut dat out!
What's all the hubbub, bub?
Which way did he go, George, which way did he go?
You know, sometimes me conscience kinda bothers me... But not this time!
Poor little maroon. So trusting. So naive.

Ain't I a stinker?"
        user_id: 4
        game_id: game.id
        )
    end
  end
end