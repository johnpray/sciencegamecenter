PLATFORM_MAPPINGS = {
  "and iPad Pro" => "iOS",
  "Amazon App Store" => "Android",
  "Android" => "Android",
  "Android Tablet" => "Android",
  "App Store" => "iOS",
  "Board Game" => "Tabletop",
  "Browser (still in development)" => "Web",
  "Card Game" => "Tabletop",
  "Google Play" => "Android",
  "i phone" => "iOS",
  "iOS" => "iOS",
  "iPad" => "iOS",
  "iPad Air" => "iOS",
  "iPad/iPod" => "iOS",
  "iPad Mini 2+" => "iOS",
  "iPhone" => "iOS",
  "iPhone/iPod" => "iOS",
  "Live Action Game" => "Tabletop",
  "Mac" => "Mac",
  "Mac OS" => "Mac",
  "Microsoft Windows" => "Windows",
  "Microsoft Window" => "Windows",
  "PC" => "Windows",
  "Web" => "Web",
  "Web (PC/Mac)" => "Web"
}


class CategoryMapper
  def perform
    # category_types = [:subject, :platform, :cost, :intended_for, :developer_type]

    games = Game.all
    
    puts "Processing #{games.size} games in 5 seconds..."
    sleep 5

    games.each do |game|
      
      puts "Processing #{game.title}..."

      categories = game.platforms
      
      puts "  -- Old list: #{categories.map(&:name).join(", ")}"
      
      new_category_names = []
      
      categories.each do |category|
        new_category_name = PLATFORM_MAPPINGS[category.name]
        
        if new_category_name.present?
          new_category_names << new_category_name
          puts "  #{category.name} becomes #{new_category_name}."
          
        else
          puts "  No mapping for #{category.name}. SKIPPING ===="
        end
      end
      
      new_category_names.uniq!
      new_category_names.sort_by! { |name| GAME_PLATFORMS.index(name) }
      
      puts "  -- New list: #{new_category_names.join(", ")}"
      
      game.platform_list = new_category_names.join(", ")
      game.save
    end
  end
end

namespace :categories do
  task :convert => :environment do
    CategoryMapper.new.perform
  end
end
