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

  def stub(obj, method, &block)
    obj.send :alias_method, :"__original_#{method}", method
    obj.send :define_method, method, &block
    @stubs[obj] ||= []
    @stubs[obj] << method
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

    stub FileTest, :exist? do |path|
      files.key? path
    end
  end
end

# Base class for all tests.
class LanguageFileSystemTest < Minitest::Test
  include FileSystemStub
end
