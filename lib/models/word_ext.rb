module WordExt
  
  def self.included(base)
    base.send(:attr_accessor, :name)
    base.extend ClassMethods
  end

  module ClassMethods
    
    def all
      @all ||= words_from_file
    end
    
    def concatenated_words
      @concatenated_words ||= long_words.select(&:concatenated_word?)
    end

    def long_words
      @long_words ||= all.select(&:long?)
    end
    
    def max_length
      6
    end
    
    def sub_words
      @sub_words ||= all.select(&:sub_word?)
    end

    def with_length(length)
      @grouped_by_length ||= sub_words.group_by(&:length)
      @grouped_by_length[length] || []
    end

    def print_words
      puts "Found #{concatenated_words.count} concatenated words:"
      puts ''
      concatenated_words.each do |word|
        puts word.print
      end
    end

    private
    def file_name
      File.expand_path('../WordList.txt', File.dirname(__FILE__))
    end

    def words_from_file
      word_array = []
      File.open(file_name, "r").each_line do |line|
        if line.strip! != '' && line.length <= max_length
          word_array << new(:name => line)
        end
      end
      word_array.compact
    end
    
  end

  def initialize(attrs = {})
    attrs.each do |attr, value|
      send("#{attr}=", value)
    end
  end

  def ==(value)
    name == value
  end

  def concatenated_word?
    !sub_words.empty?
  end

  def length
    name.to_s.length
  end

  def long?
    length == self.class.max_length
  end
  
  def sub_word?
    length < self.class.max_length
  end

  def starts_with?(word)
    name.match(/^#{word}/)
  end

  def sub_words
    return [] if sub_word?
    @sub_words ||= find_sub_words
  end

  def to_s
    name
  end

  def print
    return name if sub_words.nil?
    "#{name} (#{sub_words.collect(&:name).join(' + ')})"
  end

  private
  def find_sub_words
    self.class.sub_words.each do |sub_word|
      if self.starts_with?(sub_word)
        suffix = name[sub_word.length..self.length-1]
        if self.class.with_length(suffix.length).include?(suffix)
          return [sub_word, self.class.new(:name => suffix)]
        end
      end
    end
    []
  end

end