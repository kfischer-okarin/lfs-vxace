# rubocop:disable Style/Documentation
module DataManager
  def self.load_database; end
end

class Game_Message
  attr_reader :texts
  def initialize
    clear
  end

  def add(text)
    @texts << text
  end

  def clear
    @texts = []
  end
end

class Game_Interpreter
  def setup_choices(_params); end
end

module Cache
  def self.load_bitmap(_folder_name, _filename, _hue = 0); end
end

class Game_Actor
  def setup(_actor_id); end
end

module RPG
  class BaseItem
    attr_reader :name, :description, :note
  end

  class Actor < BaseItem
    attr_reader :nickname
  end

  class Class; end

  class UsableItem; end

  class Skill < UsableItem
    attr_reader :message1, :message2
  end

  class Item; end
  class Weapon; end
  class Armor; end
  class Enemy; end

  class State < BaseItem
    attr_reader :message1, :message2, :message3, :message4
  end

  class System
    attr_reader :game_title, :currency_unit, :elements, :skill_types, :weapon_types, :armor_types

    class Terms
      attr_reader :basic, :params, :etypes, :commands
    end
  end

  class Map
    attr_reader :display_name, :note
  end
end
# rubocop:enable Style/Documentation
