require 'minitest/autorun'

require_relative './test_helper'
require_relative './rgss3_mock'
require_relative '../src/language_file_system'

class TestLanguageFileSystem < LanguageFileSystemTest
  def test_show_text
    add_file 'DialoguesEnglish.rvtext',
             "# LFS DIALOGUES VERSION 13\n" \
             "<<soldier_greeting>>\n" \
             "\\C[6]Soldier:\\C[0]\n" \
             "Greetings! Don't make any trouble!\n"
    init_lfs languages: [:English, :German], default_language: :English

    show_text '\\dialogue[soldier_greeting]'

    expected_displayed_text = "\\C[6]Soldier:\\C[0]\n" \
                              "Greetings! Don't make any trouble!\n"
    assert_equal expected_displayed_text, game_message.all_text
  end

  def test_show_text_encrypted
    add_file 'DialoguesEnglish.rvtext',
             "# LFS DIALOGUES VERSION 13\n" \
             "<<soldier_greeting>>\n" \
             "\\C[6]Soldier:\\C[0]\n" \
             "Greetings! Don't make any trouble!\n"
    add_file 'DialoguesGerman.rvtext', a_valid_dialogues_file
    add_file 'DatabaseTextEnglish.rvtext', a_valid_database_text_file
    add_file 'DatabaseTextGerman.rvtext', a_valid_database_text_file

    init_lfs languages: [:English, :German], default_language: :English
    LanguageFileSystem.encrypt
    init_lfs languages: [:English, :German], default_language: :English, enable_encryption: true

    show_text '\\dialogue[soldier_greeting]'

    expected_displayed_text = "\\C[6]Soldier:\\C[0]\n" \
                              "Greetings! Don't make any trouble!\n"
    assert_equal expected_displayed_text, game_message.all_text
  end

  def test_show_choices
    add_file 'DialoguesGerman.rvtext',
             "# LFS DIALOGUES VERSION 13\n" \
             "<<yes>>\n" \
             "Ja\n" \
             "<<no>>\n" \
             "Nein\n"
    init_lfs languages: [:English, :German], default_language: :German

    show_choices ['\\dialogue[yes]', '\\dialogue[no]']

    assert_equal %w(Ja Nein), game_message.choices
  end

  def test_database_translation
    add_file 'DatabaseTextGerman.rvtext',
             "# LFS DATABASE VERSION 13\n" \
             "<<actors/1/name>>\n" \
             "Conan, der Barbar\n"
    init_lfs languages: [:English, :German], default_language: :German

    actor = RPG::Actor.new(1)

    assert_equal 'Conan, der Barbar', actor.name
  end

  def test_database_translation_encrypted
    add_file 'DatabaseTextGerman.rvtext',
             "# LFS DATABASE VERSION 13\n" \
             "<<actors/1/name>>\n" \
             "Conan, der Barbar\n"
    add_file 'DatabaseTextEnglish.rvtext', a_valid_database_text_file
    add_file 'DialoguesGerman.rvtext', a_valid_dialogues_file
    add_file 'DialoguesEnglish.rvtext', a_valid_dialogues_file

    init_lfs languages: [:English, :German], default_language: :German
    LanguageFileSystem.encrypt
    init_lfs languages: [:English, :German], default_language: :German, enable_encryption: true

    actor = RPG::Actor.new(1)

    assert_equal 'Conan, der Barbar', actor.name
  end
end
