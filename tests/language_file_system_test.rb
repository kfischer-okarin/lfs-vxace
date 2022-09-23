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
end
