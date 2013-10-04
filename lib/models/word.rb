class Word
  
  attr_accessor :name

  class << self
    
    def file_name
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

    def with_letter_count(count)
      @grouped_by_letter_count ||= all.group_by(&:letter_count)
      @grouped_by_letter_count[count]
    end

    private
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

  def made_of_sub_words?
    !sub_words.empty?
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
    Word.short.each do |word|
      if name.match(/^#{word.name}/)
        second_word = name.sub(/^#{word.name}/, '')
        words = Word.with_letter_count(second_word.length)
        if words && words.include?(second_word)
          return [word, Word.new(:name => second_word)]
        end
      end
    end
    []
  end

end

Word::MAX_LETTERS = 6