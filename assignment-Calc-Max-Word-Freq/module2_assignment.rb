class LineAnalyzer
  attr_accessor :highest_wf_count, :highest_wf_words, :content, :line_number
  def initialize (content , line_number)
    @content = content
    @line_number = line_number
    self.calculate_word_frequency
  end
  def calculate_word_frequency
      words_found = Hash.new (0)
      @content.split(' ').each do |word|
        words_found[word.downcase]+=1
      end
      @highest_wf_count = words_found.values.max
      @highest_wf_words = []
      words_found.select{|k,v| v === @highest_wf_count }.each do |k,v|
        @highest_wf_words << k
      end
  end
end
class Solution
  attr_reader :analyzers,:highest_count_across_lines,:highest_count_words_across_lines
  def initialize()
    @analyzers = []
  end
  def analyze_file()
    n = 0
    File.foreach('test.txt') do |line|
      @analyzers << LineAnalyzer.new(line, n+=1)
    end
    @analyzers
  end
  def calculate_line_with_highest_frequency()
    @highest_count_across_lines = []
    @analyzers.each do |line_analyzer|
      @highest_count_across_lines << line_analyzer.highest_wf_count
    end
    @highest_count_across_lines = @highest_count_across_lines.max
    @highest_count_words_across_lines = @analyzers.select do |line_analyzer|
    line_analyzer.highest_wf_count == @highest_count_across_lines
    end
    @highest_count_words_across_lines
  end
  def print_highest_word_frequency_across_lines()
    puts "The following words have the highest word frequency per line:"
    @highest_count_words_across_lines.each do |line_analyzer|
    puts "#{line_analyzer.highest_wf_words} (appears in line #{line_analyzer.line_number})"
    end
  end
end
