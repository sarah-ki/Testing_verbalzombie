require 'colorize'

class Minitests
  def read_files
    puts "\n\nReading logs:\n"
    Dir.chdir('logs') do
      recent_file = Dir.glob('*').max_by { |f| File.mtime(f) }
      file = File.open(recent_file)
      log_data = file.read
      analyze(log_data)
    end

  end

  def analyze(data)
    count_complete = 0
    count_failed = 0
    lines = data.split("\n")
    lines.each do |line|
      if line['COMPLETE']
        puts line.to_s.colorize(:green)
        count_complete += 1
      elsif line['FAILED']
        puts line.to_s.colorize(:red)
        puts 'Screenshot has been saved'.colorize(:yellow)
        count_failed += 1
      end end
    puts "\n\n#{count_complete} of #{count_failed + count_complete} passed, #{count_failed} failed!"
                        end
  end

