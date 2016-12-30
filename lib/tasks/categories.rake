# encoding: UTF-8

INTENDED_FOR_MAPPINGS = {
  "5 and up" => "elementary school",
  "10+" => "middle school",
  "10-13" => "middle school",
  "10-15" => "middle school, high school",
  "10 - 16" => "middle school, high school",
  "13-16" => "high school",
  "14" => "high school",
  "15" => "high school",
  "16" => "high school",
  "17" => "high school",
  "16-18" => "high school",
  "16-19" => "high school",
  "18+" => "university",
  "8-10" => "elementary school",
  "everyone" => "elementary school, middle school, high school, university",
  "all ages" => "elementary school, middle school, high school, university",
  "High School" => "high school",
  "Middle School" => "middle school"
}


class CategoryMapper
  def perform
    # category_types = [:subject, :platform, :cost, :intended_for, :developer_type]

    games = Game.reorder("updated_at ASC").all
    
    puts "Processing #{games.size} games in 5 seconds..."
    sleep 5

    games.each do |game|
      
      puts "Processing #{game.title}..."

      categories = game.intended_fors
      
      puts "  -- Old list: #{categories.map(&:name).join(", ")}"
      
      new_category_names = []
      
      categories.each do |category|
        new_category_name = INTENDED_FOR_MAPPINGS[category.name]
        
        if new_category_name.present?
          new_category_names << new_category_name
          puts "  #{category.name} becomes #{new_category_name}."
          
        else
          puts "  No mapping for #{category.name}. SKIPPING ===="
        end
      end
      
      new_category_names = new_category_names.join(",").split(",").map(&:strip)
      new_category_names.uniq!
      new_category_names.sort_by! { |name| GAME_INTENDED_FORS.index(name) }
      
      puts "  -- New list: #{new_category_names.join(", ")}"
      
      game.intended_for_list = ""
      game.save
      game.intended_for_list = new_category_names.join(", ")
      game.save
    end
    
    # downcase all tags
    GAME_INTENDED_FORS.each do |subject|
      ActsAsTaggableOn::Tag.where("name ILIKE '#{subject}'").first.update_attribute(:name, subject)
    end
  end
end

namespace :categories do
  task :convert => :environment do
    CategoryMapper.new.perform
  end
end
