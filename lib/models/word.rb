class Word
  
  attr_accessor :name

  class << self
    
    def words_file_name
      File.expand_path('../WordList.txt', File.dirname(__FILE__))
    end
    
    def all
      @all ||= words_from_file
    end
    
    def long
      @long ||= all.select(&:long?)
    end
    
    def short
      @short ||= all.select(&:short?)
    end
    
    def with_sub_words
      @with_sub_words ||= all.select(&:made_of_sub_words?)
    end

    private
    def words_from_file
      word_array = []
      File.open(words_file_name, "r").each_line do |line|
        if line.strip! != '' && line.length <= Word::MAX_LETTERS
          word_array << Word.new(:name => line)
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

  def made_of_sub_words?
    return false if sub_words.empty?
    name.gsub(/#{sub_words.collect(&:name).join('|')}/, '') == ''
  end

  def letter_count
    name.to_s.length
  end

  def long?
    letter_count == Word::MAX_LETTERS
  end
  
  def short?
    letter_count < Word::MAX_LETTERS
  end

  def sub_words
    return [] if short?
    @sub_words ||= find_sub_words
  end

  def to_s
    return name if short?
    "#{name} (#{sub_words.collect(&:name).join(' + ')})"
  end

  private
  def find_sub_words
    sub_words = []
    Word.short.each do |short_word|
      if name.match(short_word.name)
        sub_words << short_word
      end
      break if sub_words.length == 2
    end
    sub_words
  end

end

Word::MAX_LETTERS = 6