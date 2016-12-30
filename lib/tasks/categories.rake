# encoding: UTF-8

SUBJECT_MAPPINGS = {
  "astrophysics" => "astrophysics",
  "Biodiversity" => "biodiversity",
  "biology" => "biology",
  "body systems" => "body systems",
  "botany" => "botany",
  "careers in science" => "careers in science",
  "Cell Biology" => "cells",
  "Cells" => "cells",
  "cellular automata" => "cells",
  "Chemistry" => "chemistry",
  "Computer Science" => "computer science",
  "Design and Development of Technology" => "technology development",
  "Disease" => "disease",
  "Drugs" => "drugs",
  "ecology" => "ecology",
  "Entertainment" => "",
  "Evolution" => "evolution",
  "Experimental Design" => "experimental design",
  "Experimental Methods" => "experimental methods",
  "Fittness" => "fitness",
  "Fungal microbiology" => "biology",
  "Game Development Tool" => "game development",
  "Genetics" => "genetics",
  "Geography" => "geography",
  "Geology" => "geology",
  "High School" => "",
  "History" => "history",
  "Math" => "math",
  "mathematics" => "math",
  "Medicine" => "medicine",
  "Middle School" => "",
  "Molecular Science" => "molecular science",
  "physics" => "physics",
  "plants" => "plants",
  "Pokémon battling" => "",
  "Programming" => "programming",
  "Science" => "science",
  "technology development" => "technology development",
  "zoology" => "zoology"
}


class CategoryMapper
  def perform
    # category_types = [:subject, :platform, :cost, :intended_for, :developer_type]

    games = Game.reorder("updated_at ASC").all
    
    puts "Processing #{games.size} games in 5 seconds..."
    sleep 5

    games.each do |game|
      
      puts "Processing #{game.title}..."

      categories = game.subjects
      
      puts "  -- Old list: #{categories.map(&:name).join(", ")}"
      
      new_category_names = []
      
      categories.each do |category|
        new_category_name = SUBJECT_MAPPINGS[category.name]
        
        if new_category_name.present?
          new_category_names << new_category_name
          puts "  #{category.name} becomes #{new_category_name}."
          
        else
          puts "  No mapping for #{category.name}. SKIPPING ===="
        end
      end
      
      new_category_names.uniq!
      new_category_names.sort_by! { |name| GAME_SUBJECTS.index(name) }
      
      puts "  -- New list: #{new_category_names.join(", ")}"
      
      game.subject_list = ""
      game.save
      game.subject_list = new_category_names.join(", ")
      game.save
    end
    
    # downcase all tags
    GAME_SUBJECTS.each do |subject|
      ActsAsTaggableOn::Tag.where("name ILIKE '#{subject}'").first.update_attribute(:name, subject)
    end
  end
end

namespace :categories do
  task :convert => :environment do
    CategoryMapper.new.perform
  end
end
