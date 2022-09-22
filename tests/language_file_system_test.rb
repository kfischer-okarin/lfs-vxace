require 'minitest/autorun'

require_relative './test_helper'
require_relative './rgss3_mock'
require_relative '../src/language_file_system'

class TestLanguageFileSystem < LanguageFileSystemTest
  def setup
    add_file 'Game.ini',
             "[Game]\n" \
             "RTP=RPGVXAce\n" \
             "Library=System\\RGSS301.dll\n" \
             "Scripts=Data\\Scripts.rvdata2\n" \
             "Title=Fantasy Game\n"

    add_file 'DialoguesEnglish.rvtext',
             "# LFS DIALOGUES VERSION 13\n" \
             "<<soldier_greeting>>\n" \
             "<<face: People4, 6>>\n" \
             "\\C[6]Soldier:\\C[0]\n" \
             "Greetings! Don't make any trouble!\n"

    init_lfs languages: [:English, :German], default_language: :English
  end

  def test_show_text
    show_text '\\dialogue[soldier_greeting]'

    expected_displayed_text = "\\C[6]Soldier:\\C[0]\n" \
                              "Greetings! Don't make any trouble!"
    assert_equal expected_displayed_text, displayed_text
  end
end
