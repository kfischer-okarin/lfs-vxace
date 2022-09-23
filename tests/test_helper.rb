require 'minitest/test'

# Allow stubbing methods by passing an implementation block.
# Minitest 5.9.1 does not properly handle blocks passed to stubs so this is re-implemented here.
module Stubs
  def before_setup
    super
    @stubs = {}
  end

  def after_teardown
    super
    @stubs.each do |object, methods|
      methods.each do |method|
        object.send :alias_method, method, :"__original_#{method}"
        object.send :remove_method, :"__original_#{method}"
      end
    end
  end

  def stub(obj, method, options = nil, &block)
    target = obj
    target = obj.singleton_class if options && options[:class_method]
    target.send :alias_method, :"__original_#{method}", method
    target.send :define_method, method, &block
    @stubs[target] ||= []
    @stubs[target] << method
  end
end

# Stubbing the file system.
module FileSystemStub
  include Stubs

  def before_setup
    super
    @files = {}

    stub_open
    stub_filetest
  end

  def add_file(path, content)
    @files[path] = StringIO.new content
  end

  private

  def stub_open
    files = @files

    stub Object, :open do |path, &block|
      fail "Unexpected path: #{path}" unless files.key? path

      block.call files[path] if block

      files[path]
    end
  end

  def stub_filetest
    files = @files

    stub FileTest, :exist?, class_method: true do |path|
      files.key? path
    end
  end
end

# Base class for all tests.
class LanguageFileSystemTest < Minitest::Test
  include FileSystemStub

  attr_reader :game_message

  def before_setup
    super
    @default_languages = LanguageFileSystem::LANGUAGES
    @default_default_language = LanguageFileSystem::DEFAULT_LANGUAGE
    @default_enable_encryption = LanguageFileSystem::ENABLE_ENCRYPTION
    LanguageFileSystem.instance_variable_set(:@dialogues, {})
    LanguageFileSystem.instance_variable_set(:@database, {})
  end

  def after_teardown
    super
    LanguageFileSystem.send(:remove_const, :LANGUAGES)
    LanguageFileSystem.const_set(:LANGUAGES, @default_languages)
    LanguageFileSystem.send(:remove_const, :DEFAULT_LANGUAGE)
    LanguageFileSystem.const_set(:DEFAULT_LANGUAGE, @default_default_language)
    LanguageFileSystem.instance_variable_set(:@language, @default_default_language)
    LanguageFileSystem.send(:remove_const, :ENABLE_ENCRYPTION)
    LanguageFileSystem.const_set(:ENABLE_ENCRYPTION, @default_enable_encryption)
  end

  def init_lfs(values)
    LanguageFileSystem.send(:remove_const, :LANGUAGES)
    LanguageFileSystem.const_set(:LANGUAGES, values.fetch(:languages, @default_languages))
    LanguageFileSystem.send(:remove_const, :DEFAULT_LANGUAGE)
    default_language = values.fetch(:default_language, @default_default_language)
    LanguageFileSystem.const_set(:DEFAULT_LANGUAGE, default_language)
    LanguageFileSystem.instance_variable_set(:@language, default_language)
    LanguageFileSystem.send(:remove_const, :ENABLE_ENCRYPTION)
    LanguageFileSystem.const_set(:ENABLE_ENCRYPTION, values.fetch(:enable_encryption, @default_enable_encryption))

    add_default_game_ini unless FileTest.exist? 'Game.ini'

    DataManager.load_database
  end

  def show_text(text)
    @game_message ||= Game_Message.new
    @game_message.clear
    @game_message.add text
  end

  private

  def add_default_game_ini
    add_file 'Game.ini',
             "[Game]\n" \
             "RTP=RPGVXAce\n" \
             "Library=System\\RGSS301.dll\n" \
             "Scripts=Data\\Scripts.rvdata2\n" \
             "Title=Fantasy Game\n"
  end
end
