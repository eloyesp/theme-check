# frozen_string_literal: true

module ThemeCheck
  class Printer
    def print(theme, offenses)
      offenses.each do |offense|
        print_offense(offense)
        puts
      end

      puts "#{theme.all.size} files inspected, #{red(offenses.size.to_s + ' offenses')} detected"
    end

    def print_offense(offense)
      puts blue(offense.location) + ": " +
        colorized_severity(offense.severity) + ": " +
        yellow(offense.check_name) + ": " +
        offense.message + "."
      if offense.source_excerpt
        puts "\t#{offense.source_excerpt}"
        if offense.markup_start_in_excerpt
          puts "\t" + (" " * offense.markup_start_in_excerpt) + ("^" * offense.markup.size)
        end
      end
    end

    private

    def colorize(str, color_code)
      "\e[#{color_code}m#{str}\e[0m"
    end

    def colorized_severity(severity)
      case severity
      when :error
        red(severity)
      when :suggestion
        pink(severity)
      when :style
        light_blue(severity)
      end
    end

    def red(str)
      colorize(str, 31)
    end

    def green(str)
      colorize(str, 32)
    end

    def yellow(str)
      colorize(str, 33)
    end

    def blue(str)
      colorize(str, 34)
    end

    def pink(str)
      colorize(str, 35)
    end

    def light_blue(str)
      colorize(str, 36)
    end
  end
end
