module AbstractScore
  attr_accessor :lilypond_output, :exit_status, :filename, :image_files

  def set_input_to_example_input_if_empty
    unless self.input
      example_input = <<-END_OF_EXAMPLE_INPUT
        \\version "2.12.3"

        \\relative c'' { c d e f }
      END_OF_EXAMPLE_INPUT
      self.input = example_input.sub(/^\ */, '') #remove spaces at start of each line
    end
  end

  def generate_output
    self.filename = Time.now.hash.abs
    File.open "#{filename}.ly", 'w' do |f|
      f.write input
    end

    raw_lilypond_output = `lilypond --png --pdf '#{filename}.ly' 2>&1; echo $?`
    self.exit_status = raw_lilypond_output.split("\n").last.to_i
    self.lilypond_output = raw_lilypond_output.sub(/..\z/m, '')
      # \z matches end of string, 'm' option lets dots match newlines
    `mv #{filename}*.png #{Rails.root.to_s}/public/images/`
    @empty = `mv #{filename}.pdf  #{Rails.root.to_s}/public/pdf/; echo $?` =~ /1/
    @midi = `[ -f  #{filename}.midi ] && mv #{filename}.midi #{Rails.root.to_s}/public/midi/; echo $?` =~ /0/
    raw_image_files = `ls #{Rails.root.to_s}/public/images | grep #{filename}`.split("\n")
    self.image_files = raw_image_files.map do |f| 'images/' + f end
    `rm *.ps *.ly`
  end

  def midi?;  @midi  end
  def empty?; @empty end

end
