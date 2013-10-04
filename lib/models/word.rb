class Word
  
  attr_accessor :name

  class << self
    
    def words_file_name
      File.expand_path('../WordList.txt', File.dirname(__FILE__))
    end
    
    def all
      @all_words ||= words_from_file.collect {|w| Word.new(:name => w)}
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
      File.open(words_file_name, "r").each_line do |word|
        if word.strip! != '' && word.length <= Word::MAX_LETTERS
          word_array << word
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
    name_dup = name.dup
    sub_words_arr = []
    Word.short.each do |short_word|
      if name_dup.match(short_word.name)
        sub_words_arr << short_word
        name_dup.gsub!(short_word.name, '')
      end
      break if name_dup == ''
    end
    sub_words_arr
  end

end

Word::MAX_LETTERS = 6