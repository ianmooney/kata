class Word
  
  attr_accessor :name, :sub_words

  class << self
    
    def file_name
      File.expand_path('../WordList-sample.txt', File.dirname(__FILE__))
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
    
    # fast
    # def concatenated_words
    #   words = []
    #   long_words.each do |word|
    #     Word.sub_words.each do |sub_word|
    #       if word.starts_with?(sub_word)
    #         suffix = word.name[sub_word.length..word.length-1]
    #         if Word.with_length(suffix.length).include?(suffix)
    #           word.sub_words = [sub_word, Word.new(:name => suffix)]
    #           words << word
    #         end
    #       end
    #     end
    #   end
    #   words
    # end

    # readable
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

    def with_length(length)
      @grouped_by_length ||= all.group_by(&:length)
      @grouped_by_length[length] || []
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

  def concatenated_word?
    !sub_words.empty?
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

  def sub_words
    @sub_words || []
  end

  def to_s
    name
  end

  def print
    return name if sub_words.nil?
    "#{name} (#{sub_words.collect(&:name).join(' + ')})"
  end

end

Word::MAX_LETTERS = 6