class Word
  
  attr_accessor :name

  class << self
    
    def file_name
      File.expand_path('../WordList.txt', File.dirname(__FILE__))
    end
    
    def all
      @all ||= words_from_file
    end
    
    def long_words
      @long_words ||= all.select(&:long?)
    end
    
    def sub_words
      @sub_words ||= all.select(&:sub_word?)
    end
    
    def concatenated_words
      words = []
      sub_words.each do |sub_word|
        words_that_start_with(sub_word).each do |word|
          suffix = word.name[sub_word.length..word.name.length-1]
          if Word.sub_words.include?(suffix)
            word.sub_words = [sub_word, Word.new(:name => suffix)]
            words << word
          end
        end
      end
      words
    end

    def with_letter_count(count)
      @grouped_by_letter_count ||= all.group_by(&:letter_count)
      @grouped_by_letter_count[count]
    end

    private
    def words_that_start_with(sub_word)
      long_words.select {|w| w.starts_with?(sub_word)}
    end

    def words_from_file
      word_array = []
      File.open(file_name, "r").each_line do |line|
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

  def ==(value)
    name == value
  end

  def length
    name.to_s.length
  end

  def long?
    length == Word::MAX_LETTERS
  end
  
  def sub_word?
    length < Word::MAX_LETTERS
  end

  def starts_with?(word)
    name[0..word.length-1] == word.name
  end

  def to_s
    return name if sub_words.nil?
    "#{name} (#{sub_words.collect(&:name).join(' + ')})"
  end

  private
  def find_sub_words
    Word.short.each do |word|
      if starts_with?(word)
        suffix = name[word.letter_count..name.length-1]
        words = Word.with_letter_count(suffix.length)
        if words && words.include?(suffix)
          return [word, Word.new(:name => suffix)]
        end
      end
    end
    []
  end

end

Word::MAX_LETTERS = 6