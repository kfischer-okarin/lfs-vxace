# rubocop:disable Style/Documentation
module DataManager
  def self.load_database
    $data_system = RPG::System.new
  end
end

class Game_Message
  attr_reader :texts
  attr_accessor :choices

  def initialize
    clear
  end

  def add(text)
    @texts << text
  end

  def clear
    @texts = []
    @choices = []
  end

  def all_text
    @texts.reduce('') { |a, e| a + e + "\n" }
  end
end

class Game_Interpreter
  def initialize(game_message)
    @game_message = game_message
  end

  def setup_choices(params)
    @game_message.choices = params[0]
  end
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

    def initialize(id)
      @id = id
    end
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
    attr_reader :game_title, :currency_unit, :elements, :skill_types, :weapon_types, :armor_types, :terms

    def initialize
      @elements = []
      @skill_types = []
      @weapon_types = []
      @armor_types = []
      @terms = Terms.new
    end

    class Terms
      attr_reader :basic, :params, :etypes, :commands

      def initialize
        @basic = []
        @params = []
        @etypes = []
        @commands = []
      end
    end
  end

  class Map
    attr_reader :display_name, :note
  end
end
# rubocop:enable Style/Documentation
