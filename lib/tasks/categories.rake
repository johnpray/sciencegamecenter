# encoding: UTF-8

DEVELOPER_TYPE_MAPPINGS = {
  "Academic" => "academic developer",
  "Academic Developer" => "academic developer",
  "Open Access Community" => "open source community",
  "Professional" => "professional developer",
  "Professional Developer" => "professional developer",
  "scientist" => "academic developer",
  "Student" => "academic developer",
  "Teacher" => "academic developer"
}


class CategoryMapper
  def perform
    # category_types = [:subject, :platform, :cost, :intended_for, :developer_type]

    games = Game.reorder("updated_at ASC").all
    
    puts "Processing #{games.size} games in 5 seconds..."
    sleep 5

    games.each do |game|
      
      puts "Processing #{game.title}..."

      categories = game.developer_types
      
      puts "  -- Old list: #{categories.map(&:name).join(", ")}"
      
      new_category_names = []
      
      categories.each do |category|
        new_category_name = DEVELOPER_TYPE_MAPPINGS[category.name]
        
        if new_category_name.present?
          new_category_names << new_category_name
          puts "  #{category.name} becomes #{new_category_name}."
          
        else
          puts "  No mapping for #{category.name}. SKIPPING ===="
        end
      end
      
      new_category_names = new_category_names.join(",").split(",").map(&:strip)
      new_category_names.uniq!
      new_category_names.sort_by! { |name| GAME_DEVELOPER_TYPES.index(name) }
      
      puts "  -- New list: #{new_category_names.join(", ")}"
      
      game.developer_type_list = ""
      game.save
      game.developer_type_list = new_category_names.join(", ")
      game.save
    end
    
    # downcase all tags
    GAME_DEVELOPER_TYPES.each do |subject|
      ActsAsTaggableOn::Tag.where("name ILIKE '#{subject}'").first.update_attribute(:name, subject)
    end
  end
end

namespace :categories do
  task :convert => :environment do
    CategoryMapper.new.perform
  end
end
