#==============================================================================
#
# Language File System - Core Script
# Version 1.4.2
# Last Update: February 4th, 2019
# Author: DerTraveler (dertraveler [at] gmail.com)
#
#==============================================================================

$imported = {} if $imported.nil?
$imported[:LanguageFileSystem_Core] = true

#==============================================================================
#
# Contents:
#
#   1. Description
#   2. File formats
#     2.1. Dialogues.rvtext
#       2.1.1. Examples
#       2.1.2. How to include the text
#       2.1.3. Additional Details
#     2.2. DatabaseText.rvtext
#       2.2.1. Examples
#       2.2.2. Changing custom scripts
#   3. More Features
#     3.1. Changing the names of actors
#     3.2. Changing the language
#     3.3. Encrypting your text files
#     3.4. Extracting all your text content
#     3.5. Language-dependent pictures
#   4. Common issues
#   5. Changelog
#   6. Terms of use
#
#==============================================================================

#==============================================================================
# 1. Description:
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
# This script enables you to load any of the game's text content from external
# files. This includes messages, choices, and any database text.
# With this script it is much easier to manage your in-game text content, since
# all of your dialogue is at one central place instead of being spread over
# hundreds and thousands of events.
# Another major use is the ability to translate your game, without the need to
# create a new project for each language and edit every field in the database.
#
#==============================================================================
# 2. File formats
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
# This script uses two text files with a special (but very simple) format. The
# structure of those files is described in this section. Language names can be
# defined in the option section below.
#
# NOTE: The file names in the section headers are used in case you only use one
#       language file in your game. If you use more than one language file, the
#       names will have the language name as suffix.
#
#       Example: Suppose, in the options below you have defined :German and
#                :English as languages for your game. Thus the filenames would
#                be DialoguesGerman.rvtext and DialoguesEnglish.rvtxt and
#                respectively DatabaseTextGerman.rvtext and
#                DatabaseTextEnglish.rvtext.
#
#------------------------------------------------------------------------------
# 2.1. Dialogues.rvtext
#------------------------------------------------------------------------------
#
# In this file you can define text blocks that can be used in "Show Text",
# "Show Choices" and "Show Scrolling Text" commands. They can also be displayed
# via a script call.
#
# NOTE: Please don't edit the first line, since it contains important
#       information for the script.
#
# A text block is defined in this way:
#
#   <<[Text ID]>>
#   <<[Option Tag 1]>>
#   <<[Option Tag 2]>>
#   ...
#   [Your Text]
#
# [Text ID]
#   This should be an unique string that will be used in the RPG Maker to load
#   your text block.
#
# [Option Tag]
#   Here you can specify message options like face, position and background.
#   This information is used, if you call the message via script call or if you
#   use the text viewer add-on to display the message.
#   If you just use the message code in a normal "Show Text..." it will be
#   ignored.
#
#   Available tags for messages:
#
#     <<face:[Filename],[Index]>>
#       [Filename]
#         The name of the Faceset file, eg. Actor1
#       [Index]
#         The index in the Faceset of the face that should be used.
#         Ranges from 0-7.
#
#       If you omit this tag, the message won't have a face.
#
#     <<position:[Place]>>
#       [Place]
#         Specifies the position of the message window.
#         Can be either: top, middle or bottom (default).
#
#     <<background:[Style]>>
#       [Style]
#         Specifies the style of the message window.
#         Can be: normal (default), dim or transparent.
#
#   Available tags for scrolling texts:
#
#     <<scroll_speed: [Speed]>>
#       [Speed]
#         Scrolling speed of the message. Ranges from 1-8
#
#     <<no_fast>>
#       If this tag is added, fast forwarding by pressing the OK button is
#       disabled.
#
# [Your Text]
#   This is the text that will be shown in the message or choice. This can of
#   course cover multiple lines. Everything until the next <<...>> tag will
#   belong to that [Text ID]. But excessive empty lines at the end will be
#   stripped away.
#
#------------------------------------------------------------------------------
# 2.1.1. Examples
#------------------------------------------------------------------------------
#
# Just to get an idea how the file content actually will look like. See the demo
# for more examples.
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# <<Introduction>>
# <<scroll_speed: 4>>
# Once upon a time there was a kingdom which was
# rules by a wise king...
# Blablablablabla...
#
# <<Soldier Greeting>>
# <<face: People4, 6>>
# \C[6]Soldier:\C[0]
# Greetings! Don't make any trouble!
#
# <<Find Dragonball>>
# <<position: middle>>
# Congratulations!
# You have found one of the seven dragonballs!
#
# <<Evil Sorcerer Speech>>
# <<position: middle>>
# <<background: transparent>>
# So you finally made it into my lair?
# Prepare to die a slow and horrible death!
# HAHAHAHAHAHAHAHAHA!
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
#------------------------------------------------------------------------------
# 2.1.2. How to include the text
#------------------------------------------------------------------------------
#
# Messages:
#
#   There are two ways to include your predefined textblocks:
#
#   1. You can enter the following message code into a "Show Text..."-command:
#
#        \dialogue[Text ID]        (NOTE: You have to enter the [] characters!)
#
#      If the Text ID exists, the content of the message will be replaced with
#      your text block.
#      The Option Tag information from your text file will be ignored and
#      instead the settings of your event command will be used.
#
#   2. Instead of using the "Show Text..."-command you can call the message via
#      script command. Just use a "Script..." event command and enter following
#      function:
#
#        show_dialogue("Text ID")
#
#      This is fully equivalent to a normal "Show Text..." command. Thus
#      directly following Choices or Number Inputs will be displayed correctly.
#      It uses the Option Tag information specified in the text file.
#
# Scrolling Text:
#
#   You can either enter the \dialogue[...] message code into the text field
#   of the "Show Scrolling Text..." event command.
#   Alternatively you can use an script call, similar to the one for normal
#   messages:
#
#     show_scrolling("Text ID")
#
# Choices:
#
#   Works the same way as Method 1 for messages.
#   Just enter the \dialogue[...] message code instead of a choice option.
#
#   Please note that a choice option has a maximal length of 50 characters.
#   So you Text IDs for choices can be at most 39 characters long (50 minus
#   11 for the \dialogue[])
#
#------------------------------------------------------------------------------
# 2.1.3. Additional details
#------------------------------------------------------------------------------
#
# - If you define a multiline string for a choice option, everything after the
#   first line will be ignored.
#
# - Your Dialogue File can be encoded in UTF-8 (e.g. if you want to create a
#   Japanese version of your game).
#
# - Please note that the "Script..." event command textbox has a maximum line
#   length of 44 characters. If you have very long Text IDs, you will have to
#   divide and concatenate the argument with +.
#
#   Extreme Example:
#
#     show_message("this_is_a_extremely_extraor" +
#     "dinary_long_text_id_which_has_to_be_divi" +
#     "ded_several_times")
#
#------------------------------------------------------------------------------
# 2.2. DatabaseText.rvtext
#------------------------------------------------------------------------------
#
# In this file you can define literally every text property, that can be entered
# into the database of the RPG Maker.
# Any property not defined in this file will just use the value from the
# database.
#
# NOTE: Don't use multiline text properties, when the original field in RPG
#       Maker didn't allow to enter several lines of text. Otherwise these line
#       breaks will be shown as strange symbols in-game.
#
# The format of this file is similar to the Dialogue textfiles but instead of a
# freely assigned unique ID, you use predefined IDs for every element.
#
#   <<[group]/[id]/[variable]>>
#     This format is used for all the base item classes.
#
#     [group]
#       Specifies the group of database objects.
#
#       Available groups are
#         - actors       - classes      - skills
#         - items        - weapons      - armors
#         - enemies      - states       - maps
#
#     [id]
#       The id of your object in the RPG Maker database.
#
#     [variable]
#       The name of the text property you want to change.
#
#       Following variables are accessible for every group except maps. They
#       should be self-explanatory:
#         - name         - description  - note
#
#       In addition to these, following groups have additional variables.
#       Unless specified otherwise, they should be self-explanatory:
#
#         actors:
#           - nickname
#
#         classes
#           - learnings:[id] (note text field of the learned skill at position
#                             [id])
#
#         skills
#           - message1     - message2   (two-lined message when using)
#
#         states
#           - message1    (message when an actor falls into the state)
#           - message2    (message when an enemy falls into the state)
#           - message3    (message when somebody retains the state)
#           - message4    (message when an actor loses the state)
#
#       The group maps has following variables:
#         - display_name  (The name that is displayed when entering the map)
#         - note
#
# Following predefined IDs change the properties in the System and Terms tab of
# the database.
#
#   <<system/game_title>>
#     The game title that is printed on title screen.
#
#   <<system/currency_unit>>
#     The name of the in-game currency.
#
#   <<types/elements:[id]>>
#     The name of the element with the given [id].
#
#   <<types/skill_types/[id]>>
#     The name of the skill type with the given [id].
#
#   <<types/weapon_types/[id]>>
#     The name of the weapon type with the given [id].
#
#   <<types/armor_types/[id]>>
#     The name of the armor type with the given [id].
#
#   <<terms/basic/[id]>>
#     See RPG::System::Term in the RPG Maker help file for details.
#
#   <<terms/params/[id]>>
#     See RPG::System::Term in the RPG Maker help file for details.
#
#   <<terms/etypes/[id]>>
#     See RPG::System::Term in the RPG Maker help file for details.
#
#   <<terms/commands/[id]>>
#     See RPG::System::Term in the RPG Maker help file for details.
#
# Finally you can also change the values of the constants in the Vocab-Script
# with following tag.
#
#   <<constants/Vocab/[constant name]>>
#
#------------------------------------------------------------------------------
# 2.2.1. Examples
#------------------------------------------------------------------------------
#
# Just to get an idea how the file content actually will look like. See the demo
# for more examples.
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# <<actors/3/name>>
# Bob
#
# <<states/11/message4>>
#  is no longer confused. (The first character is a space)
#
# <<class/1/learnings/3>>
# <special learning notetag: some-property>
#
# <<constants/Vocab/ShopBuy>>
# Buy some stuff
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
#------------------------------------------------------------------------------
# 2.2.2. Changing custom scripts
#------------------------------------------------------------------------------
#
# With the DatabaseText.rvtext you can change custom scripts in three ways:
#
#   1. Changing module constants
#
#     This works just exactly the same way like changing the constants in the
#     Vocab module of the RPG Maker VX Ace.
#     The ID has following format:
#
#       <<constants/[module name]/[constant name]>>
#
#     EXAMPLE:
#
#     Let's assume you are using Yanfly's Battle Engine Ace and want to
#     translate the constant YEA::BATTLE::HELP_TEXT_ALL_FOES.
#     The corresponding entry in the DatabaseText.rvtext looks like this:
#
#       <<constants/YEA::BATTLE/HELP_TEXT_ALL_FOES>>
#       All foes, yeah!
#
#
#   2. Changing variable assignments
#
#     The method described above only works for constants. But there are also
#     many custom script options that are not saved in constants, either because
#     you can change them at runtime, or because many similar options are saved
#     in a hash. Any string variable (and only strings) you can assign via the
#     = operator can be changed with this method. This should become clearer
#     when you look at the example.
#
#     EXAMPLE:
#
#     We're in YEA's Battle Engine again. This time we want to change the popup
#     that appears when someone misses with their attack.
#
#     The entry in the DatabaseText.rvtext looks like this:
#
#       <<variables/YEA::BATTLE::POPUP_SETTINGS[:missed]>>
#       NOPE!
#
#
#   3. Running arbitrary Ruby code
#
#     If any of the translations you need to do is not possible with the change
#     of a variable or constant, but perhaps only with a method call, you can
#     also run arbitrary Ruby code and replace some part of the code with the
#     value from the language file. The position that is to be translated is
#     marked by %s. %s will be replaced with your value.
#
#     EXAMPLE:
#
#     Let's imagine, you have English and Japanese translations of your game,
#     but the Japanese characters in your custom menu script are hard to read
#     when your font style is bold. For some reason the creator of the menu
#     script has only provided a set_font_style method to change the font style
#     of the menu.
#
#     The entry in the Japanese DatabaseText.rvtext would look like this:
#
#       <<eval/CustomMenuScript::set_font_style(%s)>>
#       :normal
#
#     Whereas the entry in the English file would be this one:
#
#       <<eval/CustomMenuScript::set_font_style(%s)>>
#       :bold
#
#     NOTE: If your script call needs any quotation marks you have to insert
#           them either in the ID or in the value. They are not added
#           automatically.
#
#==============================================================================
# 3. More Features
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#------------------------------------------------------------------------------
# 3.1. Changing the names of actors
#------------------------------------------------------------------------------
#
# If you use the "Change Name..." or "Change Nickname..." event command to
# change the name of one of the actors, you can also define those names in the
# DatabaseText.rvtxt file and use them with the \name message code.
#
# EXAMPLE:
#
#   Let's suppose you want to change the name of Gandalf to "Gandalf, the White"
#   or "Gandalf, der Wei�e" depending on the language of your game.
#
#   In your DatabaseTextEnglish.rvtext and DatabaseTextGerman.rvtext you create
#   an entry that looks like this:
#
#     English:                               German:
#     <<names/gandalf_newname>>              <<names/gandalf_newname>>
#     Gandalf, the White                     Gandalf, der Wei�e
#
#   Afterwards you can just use the normal "Change name..." event command, but
#   instead of your name you just enter "\name[gandalf_newname]" into the text
#   field. And the name will be changed according to your language.
#
#------------------------------------------------------------------------------
# 3.2. Changing the language
#------------------------------------------------------------------------------
#
# If you want to change the language in-game just call following function via
# script call:
#
#   LanguageFileSystem::set_language(language_name)
#
# The change will be effective until the language is changed again even when
# the game is closed.
# The last active language will be saved in the "Game.ini" in the project
# directory. The entry is called "Language". If there is no entry the language
# specified in DEFAULT_LANGUAGE will be used.
#
# The current language can be retrieved with a script call to:
#
#   LanguageFileSystem::language
#
#------------------------------------------------------------------------------
# 3.3. Encrypting your text files
#------------------------------------------------------------------------------
#
# If you want to distribute your game, most probably you don't want anyone to
# spy on your game's texts.
# In order to prevent this you can encrypt your text files into RPG Maker style
# rvdata2-files in your Data-directory. If you create an compressed game
# archive after that, these files will also be included and will be rendered
# unreadable for your players consequently.
#
# When you want to distribute your game, just call following script command
# while the game is running (e.g. with by a temporary created debug event).
#
#   LanguageFileSystem::encrypt
#
# After that the encrypted files were created in the Data-directory. Now you can
# undo all the changes made to the game to call the command and move the .rvtext
# files out of your project directory (I guess you shouldn't delete them ;) -
# we don't want your hard translation work to be wasted, right?) to some other
# place.
# The last thing you have to do before compressing your game, is setting the
# ENABLE_ENCRYPTION option to true, so that the game won't search for the
# .rvtext files anymore and uses the encrypted data files instead. Of course you
# should playtest the game at least once more to make sure that the encryption
# and the related changes were successful.
#
#------------------------------------------------------------------------------
# 3.4. Extracting all your text content
#------------------------------------------------------------------------------
#
# If you already have a lot of in-game text content, this script allows you to
# extract ALL of this content (all messages, choices, scrolling texts, name
# changes in all of your map and common events as well as every text field in
# in the database) with one script call.
#
#   LanguageFileSystem::extract_all_data
#
# This creates a subfolder in your project directory called "Extracted". In this
# folder contains both the "Dialogues.rvtext" and the "DatabaseText.rvtext"
# files with all of your text content. In addition to that there is a copy of
# the Data-Folder of your project, which includes an updated version of your
# maps and common events, that use all the corresponding script calls.
#
# IMPORTANT: Please make a backup copy of your original Data-Folder in a safe
#            place in case you want to revert the conversion later!
#
# After you hopefully made this backup copy, you should close the RPG Maker VX
# Ace and move the contents of the "Extracted/Data" folder into your original
# data folder. Next time you open your project in the RPG Maker, every event
# should now use script alls instead of messages and have replaced every
# choice and name change text with the corresponding message codes.
#
# Don't forget to replace or merge the "DatabaseText.rvtext" and
# "Dialogues.rvtext" in your project folder with the ones from the
# Extracted-Folder, so the text content can be found by the script.
#
# EXTRACTING A SECOND TIME:
#   If you extract an already extracted game again, you need to ADD the
#   generated entries of your Dialogues.rvtext to your old Dialogues.rvtext.
#
#   There is not yet a smart re-extraction mechanism for the database,
#   therefore it's probably easier to add new entries manually to your first
#   extracted DatabaseText.rvtext than pick out the new ones from the newly
#   extracted file.
#
#------------------------------------------------------------------------------
# 3.5. Language-dependent pictures
#------------------------------------------------------------------------------
#
# If you use pictures that show text, like interface elements for custom menus
# or screenshots for tutorials, you might want to have translated versions for
# each of your languages.
#
# To make a picture multilingual, you need to create a translated copy for each
# language and rename it, so it ends with the respective language name. The
# names must be written exactly as specified in the LANGUAGES option (though
# without the : character).
# The picture you use in the RPG Make must be the version of the default
# language specified in the DEFAULT_LANGUAGE option.
#
# NOTE: This also works for titlescreens, battle backgrounds and every other
#       kind of bitmap.
#
# EXAMPLE:
#
#   You have a picture for the world map in English and in Japanese. So you
#   should create two files named somehow like that:
#
#     WorldMap English.png
#     WorldMap Japanese.png
#
#   And in the RPG Maker you always use the "WorldMap English.png" since English
#   is your default language.
#
#==============================================================================
# 4. Common issues
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#------------------------------------------------------------------------------
# Your script doesn't work with Custom Message System "X"
#------------------------------------------------------------------------------
# Fix:
# If the message system in question reuses the methods of the standard RPG Maker
# message system, there is a good chance that it can still work.
# Just paste my script ABOVE the message system script and try out again if that
# helped.
#
# Known scripts where this fix is necessary:
#  - Advanced Text System: Choice Options
#
#==============================================================================
# 5. Changelog
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#   1.4.2:
#     - Bugfix: Fixed a bug that encrypted language data would not be loaded if
#               the corresponding rvtext does not exist at the same time (which
#               defeated the purpose of encrypting though you still could put
#               an empty rvtext file to make it work without exposing your
#               text.
#   1.4.1:
#     - Bugfix: Fixed invalid id creation for map display_name and note
#               extraction and learnings.
#     - Bugfix: Extracting a game a second time does not destroy choice
#               commands anymore.
#     - Bugfix: Fixed learnings (they were broken all the time).
#     - Bugfix: Extracting map notes and display names now works properly.
#     - Don't extract empty names anymore
#   1.4:
#     - Added detailed error log for database file errors
#   1.3.1:
#     - Bugfix: Battle Events are now extracted too (Thanks to masterdragonson
#               for pointing it out)
#     - Bugfix: Fixed bad unsafe array accesses which forced the database file
#               to have an entry if you don't want your game to crash when that
#               particular text is accessed.
#     - Bugfix: Extracting all data now produces database files with the current
#               version number.
#     - Removed the useless USE_XXXX flags. All the features now just work
#       depending on whether the respective files exist and/or there is an
#       entry or not in that file.
#     - Added alert dialogues to the extraction.
#   1.3:
#     - Bugfix: Encryption of data now really encrypts each of the languages
#               into the correct file.
#     - Bugfix: Encryption of the up-to-date language files now also works,
#               when the ENABLE_ENCRYPTION flag is set.
#     - Fixed the Game.ini writing method that produced excessive newlines
#     - Updated the file format for the DatabaseText.rvdata. It now uses '/'
#       as separator and puts constants in its own group. Old files are updated
#       automatically
#     - New Feature: Added the possibility of language-dependent variable
#                    assignments and (for Ruby-experienced advanced users) to
#                    evaluate any Ruby command with the %s placeholder
#     - New Feature: Language-dependent pictures
#   1.2:
#     - Added support for in-game name changes
#     - Added support for class skill learning notes
#     - Major overhaul of the documentation
#     - New Feature: Added the possibility to define all message options in the
#                    language file and thus to call the whole message via script
#                    call. This works both for normal messages as well as for
#                    scrolling texts.
#     - New Feature: Now you can extract ALL of your in-game text into the
#                    corresponding language files with one script call. At the
#                    same time alternative versions of all your maps and common
#                    events are created that use these text files, so you don't
#                    have to change all your events manually.
#   1.1:
#     - Rewriting of some logic to increase compatibility
#     - New Feature: Last used language is now saved in Game.ini instead of a
#                    separate file
#     - Bugfix: USE_DIALOGUE_FILES and USE_DATABASE_FILES now also work
#               when setting a new language
#     - Bugfix: Nonexisting text IDs in choice options are now ignored (just as
#               with normal messages)
#     - Bugfix: Accessing an base item that isn't included in the database text
#               file now doesn't result in a crash anymore.
#     - Bugfix: Included some Exception handling for erroneous database text
#               file IDs
#
#==============================================================================
# 6. Terms of use:
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
# - Free to use in any non-commercial project.
#   For use in commercial projects please mail me.
# - Please mail me if you find bugs so I can fix them.
# - If you have feature requests, please also mail me, but I can't guarantee
#   that I will add every requested feature.
# - Credit DerTraveler in your project and please notify me if you publish a
#   game that uses one of my scripts.
#
#==============================================================================

###############################################################################
# OPTIONS
###############################################################################
module LanguageFileSystem

  #---------------------------------------------------------------------------
  # LANGUAGES
  # This is a list of all the languages in your game.
  # Use [] if your game has only one language.
  #
  # Example: LANGUAGES = [:German, :English]
  #---------------------------------------------------------------------------
  LANGUAGES = []
  #---------------------------------------------------------------------------
  # DEFAULT_LANGUAGE
  # Set this to the name of your default language of the game when first
  # starting.
  # If your game has only one language, set this to nil.
  #
  # Example: DEFAULT_LANGUAGE = :German
  #---------------------------------------------------------------------------
  DEFAULT_LANGUAGE = nil
  #---------------------------------------------------------------------------
  # ENABLE_ENCRYPTION
  # Set this to true, if you want to read your language files from the encrypted
  # Data-Directory. These files have to be created with a call to the
  # LanguageFileSystem::encrypt (see Feature Description above) beforehand.
  #---------------------------------------------------------------------------
  ENABLE_ENCRYPTION = false

###############################################################################
#
# Do not edit past this point, if you have no idea, what you're doing ;)
#
###############################################################################

  CURRENT_VERSION = 13

  DIALOGUE_FILE_PREFIX = 'Dialogues'

  DATABASE_FILE_PREFIX = 'DatabaseText'

  FILE_EXTENSION = 'rvtext'

  DIALOGUE_CODE = /\\dialogue\[([^\]]+)\]/

  NAME_CODE = /\\name\[([^\]]+)\]/

  STRING_ID = /^<<([^>]+)>>$/

  DB_HEADER = /# LFS DATABASE VERSION (\d+)/

  EXTRACTED_DIR_NAME = 'Extracted'

  EVENT_PREFIX = '%s:%.9s/'

  COMMON_EVENT_PREFIX = 'Common Events/'

  BATTLE_EVENT_PREFIX = 'Battle Events/'

  @dialogues = {}

  @database = {}

  @language = DEFAULT_LANGUAGE

  class << self
    #--------------------------------------------------------------------------
    # * Current game language
    #--------------------------------------------------------------------------
    attr_reader :language

    #--------------------------------------------------------------------------
    # * Load language files of current language
    #--------------------------------------------------------------------------
    def initialize
      load_language

      if FileTest.exist?(dialogue_file)
        @dialogues = ENABLE_ENCRYPTION ? load_data(dialogue_file) : load_dialogues(language)
      end
      if FileTest.exist?(database_file)
        @database = ENABLE_ENCRYPTION ? load_data(database_file) : load_database(language)
        redefine_constants
        redefine_assignments
      end
    end

    #===========================================================================
    # ** LanguageFileSystem (private methods)
    #---------------------------------------------------------------------------
    # These methods are used internally and should not be used directly unless
    # you know what you do ;)
    #
    # Methods: dialogue_file, database_file
    #===========================================================================
    private

    def dialogue_file(lang = language)
      if ENABLE_ENCRYPTION
        "Data/#{DIALOGUE_FILE_PREFIX}#{lang}.rvdata2"
      else
        "#{DIALOGUE_FILE_PREFIX}#{lang}.#{FILE_EXTENSION}"
      end
    end

    def database_file(lang = language)
      if ENABLE_ENCRYPTION
        "Data/#{DATABASE_FILE_PREFIX}#{lang}.rvdata2"
      else
        "#{DATABASE_FILE_PREFIX}#{lang}.#{FILE_EXTENSION}"
      end
    end
  end
  #--------------------------------------------------------------------------
  # * Set the game language
  #--------------------------------------------------------------------------
  def self.set_language(language)
    @language = language.to_sym
    save_language
    initialize
  end

  #--------------------------------------------------------------------------
  # * Extract all text content from the game and create copies of all maps
  #   and common events in a predefined directory
  #--------------------------------------------------------------------------
  def self.extract_all_data
    if Dir.exists?(EXTRACTED_DIR_NAME)
      msgbox "The '#{EXTRACTED_DIR_NAME}' directory already exists, so it seems your game text\n" +
             'has already been extracted. Please delete or move it to be able to execute the extraction.'
    else
      Dir.mkdir(EXTRACTED_DIR_NAME)
      Dir.mkdir(EXTRACTED_DIR_NAME + "/Data")

      # Event extraction and conversion
      extract_events
      # Database extraction and conversion
      extract_database

      msgbox "All game text has been extracted and modified game files\n" +
             "have been created. They are in the '#{EXTRACTED_DIR_NAME}' directory.\n" +
             'MAKE SURE TO BACKUP YOUR OLD FILES BEFORE USING THE GENERATED ONES!'
    end
  end

  #--------------------------------------------------------------------------
  # * Encrypt language files into .rvdata2 format
  #--------------------------------------------------------------------------
  def self.encrypt
    if DEFAULT_LANGUAGE
      LANGUAGES.each { |l|
        save_data(load_dialogues(l), "Data/#{DIALOGUE_FILE_PREFIX}#{l}.rvdata2")
        save_data(load_database(l), "Data/#{DATABASE_FILE_PREFIX}#{l}.rvdata2")
      }
    else
      save_data(load_dialogues, "Data/#{DIALOGUE_FILE_PREFIX}.rvdata2")
      save_data(load_database, "Data/#{DATABASE_FILE_PREFIX}.rvdata2")
    end
  end

  #--------------------------------------------------------------------------
  # * Current dialogue hash
  #--------------------------------------------------------------------------
  def self.dialogues
    @dialogues
  end

  #--------------------------------------------------------------------------
  # * Get text content defined in the dialogue text file
  #--------------------------------------------------------------------------
  def self.get_dialogue(id)
    @dialogues[id] ? @dialogues[id][:text] : nil
  end

  #--------------------------------------------------------------------------
  # * Show a message defined in the dialogue text file
  #--------------------------------------------------------------------------
  def self.show_dialogue(id)
    data = LanguageFileSystem::dialogues[id]
    return unless data
    if data.has_key?(:face)
      $game_message.face_name = data[:face].split(',')[0].strip
      $game_message.face_index = data[:face].split(',')[1].strip.to_i
    end
    if data.has_key?(:position)
      case data[:position].strip.downcase
        when 'top'
          $game_message.position = 0
        when 'middle'
          $game_message.position = 1
        when 'bottom'
          $game_message.position = 2
      end
    end
    if data.has_key?(:background)
      case data[:background].strip.downcase
        when 'normal'
          $game_message.background = 0
        when 'dim'
          $game_message.background = 1
        when 'transparent'
          $game_message.background = 2
      end
    end
    $game_message.add("\\dialogue[#{id}]")
  end

  #--------------------------------------------------------------------------
  # * Show a scrolling text defined in the dialoue text file
  #--------------------------------------------------------------------------
  def self.show_scrolling(id)
    data = LanguageFileSystem::dialogues[id]
    return unless data
    if data.has_key?(:scroll_speed)
      $game_message.scroll_speed = data[:scroll_speed].strip.to_i
    end
    if data.has_key?(:no_fast)
      $game_message.scroll_no_fast = true
    end
    $game_message.scroll_mode = true
    $game_message.add("\\dialogue[#{id}]")
  end

  #--------------------------------------------------------------------------
  # * Active database hash
  #--------------------------------------------------------------------------
  def self.database
    @database
  end

  #--------------------------------------------------------------------------
  # * Load and return dialogue hash for the given language
  #--------------------------------------------------------------------------
  def self.load_dialogues(language = nil)
    load_dialogue_file("#{DIALOGUE_FILE_PREFIX}#{language}.#{FILE_EXTENSION}")
  end

  #--------------------------------------------------------------------------
  # * Load and return database hash for the given language
  #--------------------------------------------------------------------------
  def self.load_database(language = nil)
    filename = "#{DATABASE_FILE_PREFIX}#{language}.#{FILE_EXTENSION}"
    versioncheck_database_file(filename)
    load_database_file(filename)
  end

  def self.save(hash, filename)
    save_database_file(hash, filename)
  end

#==============================================================================
# ** LanguageFileSystem (private methods)
#------------------------------------------------------------------------------
# These methods are used internally and should not be used directly unless you
# know what you do ;)
#
# Methods: load_language, save_language, new_database_hash, check_database_id,
#          put_database_entry, redefine_constants, extract_events, extract_page,
#          extract_database
#==============================================================================
  class << self

    private
    GAME_INI_ENTRY = /^Language=(.+)$/
  #--------------------------------------------------------------------------
  # * Load language from Game.ini if an entry exists
  #--------------------------------------------------------------------------
    def load_language
      saved_lang = nil
      open('Game.ini') { |f|
        f.each_line { |l|
          GAME_INI_ENTRY.match(l) { |m|
            saved_lang = m[1].to_sym
            break
          }
        }
      }
      @language = saved_lang if saved_lang
    end

  #--------------------------------------------------------------------------
  # * Save current language into Game.ini
  #--------------------------------------------------------------------------
    def save_language
      content = nil
      open('Game.ini', 'r') { |f|
        content = f.read
      }
      if content =~ GAME_INI_ENTRY
        content[GAME_INI_ENTRY] = "Language=#{@language}"
      else
        content += "Language=#{@language}"
      end
      open('Game.ini', 'w') { |f|
        f.write(content)
      }
    end

  #--------------------------------------------------------------------------
  # * Create and prepare an empty database hash
  #--------------------------------------------------------------------------
    def new_database_hash
      result = {:actors    => {:name => {}, :description => {}, :note => {},
                                  :nickname => {}},
                :classes   => {:name => {}, :description => {}, :note => {}},
                :skills    => {:name => {}, :description => {}, :note => {},
                               :message1 => {}, :message2 => {}},
                :items     => {:name => {}, :description => {}, :note => {}},
                :weapons   => {:name => {}, :description => {}, :note => {}},
                :armors    => {:name => {}, :description => {}, :note => {}},
                :enemies   => {:name => {}, :description => {}, :note => {}},
                :states    => {:name => {}, :description => {}, :note => {},
                               :message1 => {}, :message2 => {},
                               :message3 => {}, :message4 => {}},
                :system    => {},
                :types     => {:elements => {}, :skill_types => {},
                               :weapon_types => {}, :armor_types => {}},
                :terms     => {:basic => {}, :params => {}, :etypes => {},
                               :commands => {}},
                :maps      => {:display_name => {}, :note => {}},
                :constants => {},
                :variables => {},
                :eval      => {},
                :names     => {}}
      result[:types].keys.each { |k|
        result[:types][k] = copy_instance_array($data_system, k)
      }
      result[:terms].keys.each { |k|
        result[:terms][k] = copy_instance_array($data_system.terms, k)
      }
      result
    end

  #--------------------------------------------------------------------------
  # * Load and return dialogue hash from a language file
  #--------------------------------------------------------------------------
    def load_dialogue_file(filename)
      result = {}
      open(filename) { |f|
        id = nil
        text_started = true
        dialogue_data = {}
        text = ''
        f.each_line { |l|
          if m = STRING_ID.match(l)
            if text_started
              if id
                # Save last textblock
                dialogue_data[:text] = text.rstrip
                result[id] = dialogue_data
              end

              # Read id and reset textblock
              dialogue_data = {}
              id = m[1]
              text_started = false
              text = ''
            else
              # Read meta tag
              tag_data = m[1].split(':')
              dialogue_data[tag_data[0].strip.to_sym] =
                tag_data[1] ? tag_data[1].strip : nil
            end
          else
            # Read text line
            text_started = true
            text += l
          end
        }
        if id && text_started
          dialogue_data[:text] = text.rstrip
          result[id] = dialogue_data
        end
      }
      result
    end

  #--------------------------------------------------------------------------
  # * Save dialogue hash to file
  #--------------------------------------------------------------------------
    def save_dialogue_file(hash, filename)
      open(filename, 'w') { |f|
        f.write("# LFS DIALOGUES VERSION #{CURRENT_VERSION}\n")
        hash.each { |id, content|
          f.write("<<#{id}>>\n")
          content.each { |param, value|
            next if param == :text
            f.write("<<#{param}: #{value}>>\n")
          }
          f.write("#{content[:text]}\n\n")
        }
      }
    end

  #--------------------------------------------------------------------------
  # * Performs a version check on the database file
  #--------------------------------------------------------------------------
    def versioncheck_database_file(filename)
      version = nil
      header = nil
      content = nil
      open(filename) { |f|
        header, _, content = f.read.partition("\n")
        if m = DB_HEADER.match(header)
          version = m[1].to_i
        else
          version = 10
        end
      }

      unless version == CURRENT_VERSION
        # Backup old file
        open(filename + '_backup', 'w') { |backup|
          backup.write(header + "\n")
          backup.write(content)
        }
        content = convert_database_file(version, content)
        # Convert to current version
        open(filename, 'w') { |f|
          f.write("# LFS DATABASE VERSION #{CURRENT_VERSION}\n")
          f.write(content)
        }
        msgbox "Databasefile has been updated to current file format.\n" +
               "The original file was renamed to '#{filename}_backup'"
      end
    end

    def convert_database_file(version, content)
      result = nil
      case version
        when 10
          result = content.gsub(STRING_ID) { |s|
            tag = $1
            if tag =~ /^[A-Z]/
              # New format for constants
              mod, var = tag.split(':')
              "<<constants/#{mod}/#{var}>>"
            else
              # / as new separator character
              s.gsub(':', '/')
            end
          }
      end
      result
    end
  #--------------------------------------------------------------------------
  # * Load and return database hash from a language file
  #--------------------------------------------------------------------------
    def load_database_file(filename)
      result = new_database_hash

      line_number = 0
      error_line = 0
      errors = ''

      open(filename) { |f|
        line_name = nil
        line = ''

        f.each_line { |l|
          line_number += 1
          if m = STRING_ID.match(l)
            begin
              put_database_entry(result, line_name, line.rstrip) if line_name
            rescue Exception => e
              errors << "\n  #{filename}:#{error_line} - #{e.message}"
            end
            line_name = m[1]
            error_line = line_number
            line = ''
          else
            line += l
          end
        }
        begin
          put_database_entry(result, line_name, line.rstrip) if line_name
        rescue Exception => e
          errors << "\n  #{filename}:#{error_line} - #{e.message}"
        end
      }

      msgbox "There were errors in #{filename}:" + errors unless errors.empty?

      result
    end

  #--------------------------------------------------------------------------
  # * Save database hash to file
  #--------------------------------------------------------------------------
    def save_database_file(hash, filename)
      open(filename, 'w') { |f|
        f.write("# LFS DATABASE VERSION #{CURRENT_VERSION}\n")
        hash.each { |group, content|
          case group
          when :system, :names, :variables, :eval
            content.each { |var, value|
              f.write("<<#{group}/#{var}>>\n")
              f.write("#{value}\n\n")
            }
          when :types, :terms
            content.each { |var, list|
              list.each_with_index { |value, index|
                if value.length > 0
                  f.write("<<#{group}/#{var}/#{index}>>\n")
                  f.write("#{value}\n\n")
                end
              }
            }
          when :constants
            content.each { |mod, list|
              list.each { |var, value|
                f.write("<<#{group}/#{mod}/#{var}>>\n")
                f.write("#{value}\n\n")
              }
            }
          else
            content.each { |var, list|
              list.each { |index, value|
                f.write("<<#{group}/#{index}/#{var}>>\n")
                f.write("#{value}\n\n")
              }
            }
          end
        }
      }
    end

    MISSING_PARAM_MSG = 'Missing parameter(s) for %s'
    INVALID_ID_MSG = "Invalid ID '%s' - must be number!"

  #--------------------------------------------------------------------------
  # * Put read data into the database hash
  #--------------------------------------------------------------------------
    def put_database_entry(db, line_name, line)
      group, param1, param2, param3 = line_name.split('/')
      case group
        when 'system', 'names', 'variables', 'eval'
          raise MISSING_PARAM_MSG % group unless param1
          db[group.to_sym][param1.to_sym] = line
        when 'types', 'terms'
          raise MISSING_PARAM_MSG % group unless param1 && param2
          raise INVALID_ID_MSG % param2 unless /\d+/ =~ param2
          db[group.to_sym][param1.to_sym][param2.to_i] = line
        when 'constants'
          raise MISSING_PARAM_MSG % group unless param1 && param2
          db[:constants][param1.to_sym] ||= {}
          db[:constants][param1.to_sym][param2.to_sym] = line
        else
          if group == 'classes' && param2 == 'learnings'
            raise MISSING_PARAM_MSG % "#{group}/#{param1}/#{param2}" unless param3
            raise INVALID_ID_MSG % param1 unless /\d+/ =~ param1
            raise INVALID_ID_MSG % param3 unless /\d+/ =~ param3
            $data_classes[param1.to_i].learnings[param3.to_i].note = line
          else
            raise MISSING_PARAM_MSG % group unless param1 && param2
            raise INVALID_ID_MSG % param1 unless /\d+/ =~ param1
            raise "Unknown database group '#{group}'" unless db[group.to_sym]
            raise "Unknown parameter '#{param2}' for database group '#{group}'" unless db[group.to_sym][param2.to_sym]
            db[group.to_sym][param2.to_sym][param1.to_i] = line
          end
      end
    end

    def copy_instance_array(object, array_name)
      Array.new(object.instance_variable_get("@#{array_name}"))
    end

  #--------------------------------------------------------------------------
  # * Redefine module constants
  #--------------------------------------------------------------------------
    def redefine_constants
      @database[:constants].keys.each { |m|
        @database[:constants][m].each { |const, value|
          # Constant redefintion ninjutsu :D
          chain = m.to_s.split('::')
          mod = chain.inject(Object) { |current, c| current.const_get(c) }
          mod = mod.is_a?(Module) ? mod : mod.class
          mod.send(:remove_const, const) if mod.const_defined?(const)
          mod.const_set(const, value)
        }
      }
    end

  #--------------------------------------------------------------------------
  # * Redefine variables and run language dependent expressions
  #--------------------------------------------------------------------------
    def redefine_assignments
      @database[:variables].each { |var, value|
        eval("#{var} = \"#{value}\"")
      }

      @database[:eval].each { |exp, value|
        eval(exp.to_s % value)
      }
    end

  #--------------------------------------------------------------------------
  # * Extracting the text content of all maps and map events
  #--------------------------------------------------------------------------
    def extract_events
      dl_file = open(EXTRACTED_DIR_NAME + '/Dialogues.rvtext', 'w')
      db_file = open(EXTRACTED_DIR_NAME + '/DatabaseText.rvtext', 'w')
      begin
        db_file.write("# LFS DATABASE VERSION #{CURRENT_VERSION}\n")
        # Extract and convert all map events
        Dir.glob('Data/Map???.rvdata2').each { |m|
          map_id = m[8..10]
          map = load_data(m)
          [:display_name, :note].each do |attribute|
            unless map.instance_variable_get("@#{attribute}").empty?
              db_file.write("\n")
              db_file.write("<<maps/%d/#{attribute}>>\n" % map_id.to_i)
              db_file.write(map.instance_variable_get("@#{attribute}").gsub("\r", '') + "\n")
            end
          end
          map.events.values.each { |ev|
            ev.pages.each_with_index { |page, page_id|
              extract_page(EVENT_PREFIX %
                           [map_id, $data_mapinfos[map_id.to_i].name],
                           ev.id, ev.name, page, page_id, dl_file, db_file)
            }
          }
          save_data(map, EXTRACTED_DIR_NAME + "/Data/Map#{map_id}.rvdata2")
        }
        # Extract and convert all common events
        common_events = load_data('Data/CommonEvents.rvdata2')
        common_events.each { |ce|
          extract_page(COMMON_EVENT_PREFIX,
                       ce.id, ce.name, ce, 0, dl_file, db_file) if ce
        }
        save_data(common_events, EXTRACTED_DIR_NAME +
                                 '/Data/CommonEvents.rvdata2')

        # Extract and convert all battle events
        troops = load_data('Data/Troops.rvdata2')
        troops.each do |t|
          next unless t
          t.pages.each_with_index do |page, page_id|
            extract_page(BATTLE_EVENT_PREFIX, t.id, t.name, page, page_id,
                         dl_file, db_file)
          end
        end
        save_data(troops, EXTRACTED_DIR_NAME + '/Data/Troops.rvdata2')
      ensure
        dl_file.close
        db_file.close
      end
    end

    # Text ID format string
    ID_FORMAT = '%03d:%.9s/Page %02d/%03d'
    # Convert between parameter values and tag arguments
    BG_HASH = { 1 => 'dim', 2 => 'transparent' }
    POS_HASH = { 0 => 'top', 1 => 'middle' }

  #--------------------------------------------------------------------------
  # * Extracting the event page text content
  #--------------------------------------------------------------------------
    def extract_page(text_id_prefix, event_id, event_name, page, page_id,
                     dialogue_file, database_file)
      new_list = []
      cmd_id = 1
      page.list.each { |cmd|
        case cmd.code
          when 101 # Show Text...
            # Generate Text ID (max 39 chars)
            text_id = text_id_prefix + ID_FORMAT %
                      [event_id, event_name, page_id + 1, cmd_id]
            # Replace with Script command
            new_list << RPG::EventCommand.new(355,
                                              cmd.indent,
                                              ['show_dialogue('])
            new_list << RPG::EventCommand.new(655,
                                              cmd.indent,
                                              ["\"#{text_id}\")"])
            # Write the dialogue file
            dialogue_file.write("\n")
            dialogue_file.write("<<#{text_id}>>\n")
            dialogue_file.write("<<face: %s, %d>>\n" % cmd.parameters) unless
              cmd.parameters[0].empty?
            dialogue_file.write("<<background: %s>>\n" %
                                BG_HASH[cmd.parameters[2]]) unless
              cmd.parameters[2] == 0
            dialogue_file.write("<<position: %s>>\n" %
                                POS_HASH[cmd.parameters[3]]) unless
              cmd.parameters[3] == 2
            cmd_id += 1
          when 401 # Show Text...
            dialogue_file.write(cmd.parameters[0] + "\n")
          when 102 # Show Choices...
            # Ignore if already converted
            if cmd.parameters[0].any? { |c| DIALOGUE_CODE =~ c }
              new_list << cmd
              next
            end
            new_choices = []
            cmd.parameters[0].each { |choice|
              # Generate Text ID (max 39 chars)
              text_id = text_id_prefix + ID_FORMAT %
                        [event_id, event_name, page_id + 1, cmd_id]
              new_choices << "\\dialogue[#{text_id}]"
              dialogue_file.write("\n")
              dialogue_file.write("<<#{text_id}>>\n")
              dialogue_file.write(choice + "\n")
              cmd_id += 1
            }
            # Replace choices with message codes
            new_list << RPG::EventCommand.new(102, cmd.indent,
                        [new_choices] + cmd.parameters[1..-1])
          when 105 # Show Scrolling Text...
            # Generate Text ID (max 39 chars)
            text_id = text_id_prefix + ID_FORMAT %
                      [event_id, event_name, page_id + 1, cmd_id]
            # Replace with Script command
            new_list << RPG::EventCommand.new(355,
                                              cmd.indent,
                                              ['show_scrolling('])
            new_list << RPG::EventCommand.new(655,
                                              cmd.indent,
                                              ["\"#{text_id}\")"])
            # Write the dialogue file
            dialogue_file.write("\n")
            dialogue_file.write("<<#{text_id}>>\n")
            dialogue_file.write("<<scroll_speed: %d>>\n" % cmd.parameters) unless
              cmd.parameters[0] == 2
            dialogue_file.write("<<no_fast>>\n") if cmd.parameters[1]
            cmd_id += 1
          when 405 # Show Scrolling Text...
            dialogue_file.write(cmd.parameters[0] + "\n")
          when 320, 324 # Change Name... / Change Nickname...
            unless NAME_CODE =~ cmd.parameters[1] || cmd.parameters[1].empty?
              name_id = cmd.parameters[1].gsub(' ', '_').downcase
              new_list << RPG::EventCommand.new(320, cmd.indent,
                          [cmd.parameters[0]] + ["\\name[#{name_id}]"])
              database_file.write("\n")
              database_file.write("<<names/#{name_id}>>\n")
              database_file.write(cmd.parameters[1] + "\n")
            end
          else
            new_list << cmd
        end
      }
      page.list = new_list
    end

  #--------------------------------------------------------------------------
  # * Extracting the database text content
  #--------------------------------------------------------------------------
    def extract_database
      f = open(EXTRACTED_DIR_NAME + '/DatabaseText.rvtext', 'a')
      example_db = new_database_hash

      begin
        # Extract Base Items
        [:actors, :classes, :skills, :items, :weapons, :armors, :enemies,
         :states].each { |group_name|
          group = eval("$data_#{group_name}")
          group.each { |obj|
            obj.instance_variables.each { |iv|
              key = iv[1..-1].to_sym
              if key == :learnings
                learnings = obj.instance_variable_get(iv)
                learnings.each_with_index { |l, i|
                  unless l.note.empty?
                    f.write("\n")
                    f.write("<<classes/%d/learnings/%d>>\n" % [obj.id, i])
                    f.write(l.note.gsub("\r", '') + "\n")
                  end
                }
              elsif example_db[group_name].has_key?(key) &&
                 !obj.instance_variable_get(iv).empty?
                f.write("\n")
                f.write("<<%s/%d/%s>>\n" % [group_name, obj.id, key])
                f.write(obj.instance_variable_get(iv).gsub("\r", '') + "\n")
              end
            }
          }
        }

        # Extract System
        f.write("\n")
        f.write("<<system/game_title>>\n")
        f.write($data_system.instance_variable_get('@game_title') + "\n")
        f.write("\n")
        f.write("<<system/currency_unit>>\n")
        f.write($data_system.instance_variable_get('@currency_unit') + "\n")

        # Extract Types
        [:elements, :skill_types, :weapon_types, :armor_types].each { |group|
          $data_system.instance_variable_get("@#{group}").
            each_with_index { |t, i|
            unless t.empty?
              f.write("\n")
              f.write("<<types/%s/%d>>\n" % [group, i])
              f.write(t + "\n")
            end
          }
        }

        # Extract Terms
        [:basic, :params, :etypes, :commands].each { |group|
          $data_system.terms.instance_variable_get("@#{group}").
            each_with_index { |t, i|
            unless t.empty?
              f.write("\n")
              f.write("<<terms/%s/%d>>\n" % [group, i])
              f.write(t + "\n")
            end
          }
        }

        # Extract Vocab
        Vocab.constants.each { |c|
          f.write("\n")
          f.write("<<constants/Vocab/#{c}>>\n")
          f.write(Vocab.const_get(c) + "\n")
        }
      ensure
        f.close
      end
    end

  end

end

#==============================================================================
# ** DataManager
#------------------------------------------------------------------------------
# After loading the database load the language files.
#
# Changes:
#   alias: load_database
#==============================================================================
module DataManager

  #--------------------------------------------------------------------------
  # * Loading the language files
  #--------------------------------------------------------------------------
  class << self
    alias lfs_load_database load_database
  end
  def self.load_database
    lfs_load_database
    LanguageFileSystem::initialize
  end

end

#==============================================================================
# ** Game_Message
#------------------------------------------------------------------------------
# Add support for the \dialogues message code.
#
# Changes:
#   alias: clear, add
#==============================================================================
class Game_Message

  #--------------------------------------------------------------------------
  # * Parse for \dialogues and replace message content if found.
  #--------------------------------------------------------------------------
  alias lfs_add add
  def add(text)
    if m = LanguageFileSystem::DIALOGUE_CODE.match(text)
      line = LanguageFileSystem::get_dialogue(m[1])
      if line
        @texts = []
        line.split("\n").each { |l|
          lfs_add(l)
        }
        @replaced = true
      end
    end
    lfs_add(text) unless @replaced
  end

  #--------------------------------------------------------------------------
  # * Clear the replaced flag.
  #--------------------------------------------------------------------------
  alias lfs_clear clear
  def clear
    lfs_clear
    @replaced = false
  end

end

#==============================================================================
# ** Game_Interpreter
#------------------------------------------------------------------------------
# Add support for the \dialogues message code in choices and the show_dialogue
# and show_scrolling script command in "Script..." event commands.
#
# Changes:
#   new: show_dialogue, show_scrolling
#   alias: setup_choices
#==============================================================================
class Game_Interpreter

  #--------------------------------------------------------------------------
  # * Parse for \dialogues and replace choice content if found.
  #--------------------------------------------------------------------------
  alias lfs_setup_choices setup_choices
  def setup_choices(params)
    choices = Array.new(params[0])
    (0...choices.length).each { |i|
      if m = LanguageFileSystem::DIALOGUE_CODE.match(choices[i])
        line = LanguageFileSystem::get_dialogue(m[1])
        choices[i] = line.split("\n")[0] if line
      end
    }
    lfs_setup_choices([choices] + params[1..-1])
  end

  #--------------------------------------------------------------------------
  # * Shows a message with predefined text content
  #--------------------------------------------------------------------------
  def show_dialogue(id)
    LanguageFileSystem::show_dialogue(id)
    case next_event_code
    when 102  # Show Choices
      @index += 1
      setup_choices(@list[@index].parameters)
    when 103  # Input Number
      @index += 1
      setup_num_input(@list[@index].parameters)
    when 104  # Select Item
      @index += 1
      setup_item_choice(@list[@index].parameters)
    end
    wait_for_message
  end

  #--------------------------------------------------------------------------
  # * Shows a scrolling message with predefined text content
  #--------------------------------------------------------------------------
  def show_scrolling(id)
    LanguageFileSystem::show_scrolling(id)
    wait_for_message
  end

end

#==============================================================================
# ** Cache
#------------------------------------------------------------------------------
# Adds support for language-dependent bitmaps.
#
# Changes:
#   alias: load_bitmap
#==============================================================================
module Cache

  class << self
    alias lfs_load_bitmap load_bitmap
  end
  def self.load_bitmap(folder_name, filename, hue = 0)
    def_lang = LanguageFileSystem::DEFAULT_LANGUAGE
    lang = LanguageFileSystem::language
    # Checks if the Picture is language dependent (has DefaultLanguageName as
    # suffix and if the current language is different
    if lang != def_lang && filename.end_with?(def_lang.to_s)
      filename[def_lang.to_s] = lang.to_s
    end

    lfs_load_bitmap(folder_name, filename, hue)
  end

end

#==============================================================================
# ** Game_Actor
#------------------------------------------------------------------------------
# Reads the name and nickname of the actors directly from the database object if
# the name was not changed ingame.
#
# Changes:
#   alias: setup
#   overwrite: getter for @name, @nickname
#==============================================================================
class Game_Actor

  #--------------------------------------------------------------------------
  # * Reset name variables to enable reading from the database
  #--------------------------------------------------------------------------
  alias lfs_setup setup
  def setup(actor_id)
    lfs_setup(actor_id)
    @name = nil
    @nickname = nil
  end

  #--------------------------------------------------------------------------
  # * If no name change occurred, read name from database object.
  #--------------------------------------------------------------------------
  def name
    return actor.name unless @name
    if m = LanguageFileSystem::NAME_CODE.match(@name)
      result = LanguageFileSystem::database[:names][m[1].to_sym]
    end
    result ||= @name
  end

  #--------------------------------------------------------------------------
  # * If no nickname change occurred, read nickname from database object.
  #--------------------------------------------------------------------------
  def nickname
    return actor.nickname unless @nickname
    if m = LanguageFileSystem::NAME_CODE.match(@nickname)
      result = LanguageFileSystem::database[:names][m[1].to_sym]
    end
    result ||= @nickname
  end

end

#==============================================================================
# ** RPG::BaseItem
#------------------------------------------------------------------------------
# Reads name, description and note from language file hash instead of using the
# instance variable if a corresponding entry exists.
#
# Changes:
#   overwrite: getter for @name, @description, @note
#==============================================================================
class RPG::BaseItem

  #--------------------------------------------------------------------------
  # * Maps database object class to the corresponding key in the language
  #   file hash to improve polymorphism of the implementation
  #--------------------------------------------------------------------------
  SUBCLASS_KEYS = {RPG::Actor => :actors, RPG::Class => :classes,
                   RPG::Skill => :skills, RPG::Item => :items,
                   RPG::Weapon => :weapons, RPG::Armor => :armors,
                   RPG::Enemy => :enemies, RPG::State => :states}

  #--------------------------------------------------------------------------
  # * Read attribute from language file hash (Metaprogramming ninjutsu :D)
  #--------------------------------------------------------------------------
  ['name', 'description', 'note'].each do |var|
    alias_method "lfs_#{var}".to_sym, "#{var}".to_sym
    define_method("#{var}") do
      result = LanguageFileSystem::database[SUBCLASS_KEYS[self.class]]
      result = result[var.to_sym] if result
      result = result[@id] if result

      result ||= instance_variable_get("@#{var}")
    end
  end

end

#==============================================================================
# ** RPG::Actor
#------------------------------------------------------------------------------
# Reads nickname from language file hash instead of using the instance variable
# if a corresponding entry exists.
#
# Changes:
#   overwrite: getter for @nickname
#==============================================================================
class RPG::Actor < RPG::BaseItem

  #--------------------------------------------------------------------------
  # * Read attribute from language file hash (Metaprogramming ninjutsu :D)
  #--------------------------------------------------------------------------
  ['nickname'].each do |var|
    alias_method "lfs_#{var}".to_sym, "#{var}".to_sym
    define_method("#{var}") do
      result = LanguageFileSystem::database[:actors]
      result = result[var.to_sym] if result
      result = result[@id] if result

      result ||= instance_variable_get("@#{var}")
    end
  end

end

#==============================================================================
# ** RPG::Skill
#------------------------------------------------------------------------------
# Reads usage messages from language file hash instead of using the instance
# variable if a corresponding entry exists.
#
# Changes:
#   overwrite: getter for @message1, @message2
#==============================================================================
class RPG::Skill < RPG::UsableItem

  #--------------------------------------------------------------------------
  # * Read attribute from language file hash (Metaprogramming ninjutsu :D)
  #--------------------------------------------------------------------------
  ['message1', 'message2'].each do |var|
    alias_method "lfs_#{var}".to_sym, "#{var}".to_sym
    define_method("#{var}") do
      result = LanguageFileSystem::database[:skills]
      result = result[var.to_sym] if result
      result = result[@id] if result

      result ||= instance_variable_get("@#{var}")
    end
  end

end

#==============================================================================
# ** RPG::State
#------------------------------------------------------------------------------
# Reads state messages from language file hash instead of using the instance
# variable if a corresponding entry exists.
#
# Changes:
#   overwrite: getter for @message1, @message2, @message3, @message4
#==============================================================================
class RPG::State < RPG::BaseItem

  #--------------------------------------------------------------------------
  # * Read attribute from language file hash (Metaprogramming ninjutsu :D)
  #--------------------------------------------------------------------------
  ['message1', 'message2', 'message3', 'message4'].each do |var|
    alias_method "lfs_#{var}".to_sym, "#{var}".to_sym
    define_method("#{var}") do
      result = LanguageFileSystem::database[:states]
      result = result[var.to_sym] if result
      result = result[@id] if result

      result ||= instance_variable_get("@#{var}")
    end
  end

end

#==============================================================================
# ** RPG::System
#------------------------------------------------------------------------------
# Reads game title, currency unit, weapon, armor and skill types as well as
# elements from language file hash instead of using the instance variable if a
# corresponding entry exists.
#
# Changes:
#   overwrite: getter for @game_title, @currency_unit, @elements, @skill_types,
#                         @weapon_types, @armor_types
#==============================================================================
class RPG::System

  #--------------------------------------------------------------------------
  # * Read attribute from language file hash (Metaprogramming ninjutsu :D)
  #--------------------------------------------------------------------------
  ['game_title', 'currency_unit'].each do |var|
    alias_method "lfs_#{var}".to_sym, "#{var}".to_sym
    define_method("#{var}") do
      result = LanguageFileSystem::database[:system]
      result = result[var.to_sym] if result

      result ||= instance_variable_get("@#{var}")
    end
  end

  #--------------------------------------------------------------------------
  # * Read attribute from language file hash (Metaprogramming ninjutsu :D)
  #--------------------------------------------------------------------------
  ['elements', 'skill_types', 'weapon_types', 'armor_types'].each do |var|
    alias_method "lfs_#{var}".to_sym, "#{var}".to_sym
    define_method("#{var}") do
      result = LanguageFileSystem::database[:types]
      return result[var.to_sym] if result

      instance_variable_get("@#{var}")
    end
  end

end

#==============================================================================
# ** RPG::System::Terms
#------------------------------------------------------------------------------
# Reads parameter names, equip types and commands from language file hash
# instead of using the instance variable if a corresponding entry exists.
#
# Changes:
#   overwrite: getter for @basic, @params, @etypes, @commands
#==============================================================================
class RPG::System::Terms

  #--------------------------------------------------------------------------
  # * Read attribute from language file hash (Metaprogramming ninjutsu :D)
  #--------------------------------------------------------------------------
  ['basic', 'params', 'etypes', 'commands'].each do |var|
    alias_method "lfs_#{var}".to_sym, "#{var}".to_sym
    define_method("#{var}") do
      result = LanguageFileSystem::database[:terms]
      return result[var.to_sym] if result

      instance_variable_get("@#{var}")
    end
  end

end

#==============================================================================
# ** RPG::Map
#------------------------------------------------------------------------------
# Reads display name and note from language file hash instead of using the
# instance variable if a corresponding entry exists.
#
# Changes:
#   overwrite: getter for @display_name, @note
#==============================================================================
class RPG::Map

  #--------------------------------------------------------------------------
  # * Read attribute from language file hash (Metaprogramming ninjutsu :D)
  #--------------------------------------------------------------------------
  ['display_name', 'note'].each do |var|
    alias_method "lfs_#{var}".to_sym, "#{var}".to_sym
    define_method("#{var}") do
      result = LanguageFileSystem::database[:maps]
      result = result[var.to_sym] if result
      result = result[$game_map.map_id] if result

      result ||= instance_variable_get("@#{var}")
    end
  end

end
