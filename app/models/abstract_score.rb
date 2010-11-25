module AbstractScore
  attr_accessor :lilypond_output, :exit_status, :filename, :image_files


  EXAMPLE_INPUT = <<-END_OF_EXAMPLE_INPUT
\\version "2.12.3"

\\relative c'' { c d e f }
END_OF_EXAMPLE_INPUT



  def generate_output
    self.filename = Time.now.hash.abs
    File.open "#{filename}.ly", 'w' do |f|
      f.write input
    end

    raw_lilypond_output = `lilypond --png --pdf '#{filename}.ly' 2>&1; echo $?`
    self.exit_status = raw_lilypond_output.split("\n").last.to_i
    self.lilypond_output = raw_lilypond_output.gsub(/#{exit_status.to_s + "\n$"}/, '')
    `mv #{filename}*.png #{Rails.root.to_s}/public/images/`
    `mv #{filename}.pdf #{Rails.root.to_s}/public/pdf/`
    raw_image_files = `ls #{Rails.root.to_s}/public/images | grep #{filename}`.split("\n")
    self.image_files = raw_image_files.map do |f| 'images/' + f end
    `rm *.ps *.ly`
  end
end
