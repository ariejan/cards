require 'rubygems'
require 'spreadsheet'
require 'prawn'
require 'htmlentities'

# Setup Spreadsheet
Spreadsheet.client_encoding = 'UTF-8'

puts " - Parsing XLS"
# Open export
book = Spreadsheet.open('data.xls')

# Create stories
stories = []
book.worksheet('Stories').each(1) do |row|
  stories << {
    :title => row[1],
    :points => row[2],
    :labels => row[5],
    :description => row[6]
  }
end

puts " - Found #{stories.size} stories"

puts " - Generating story cards"

prawn_options = {
  :page_size => 'A4', # 595.28 x 841.89
  :page_layout => :landscape
}

Prawn::Document.generate('stories.pdf', prawn_options) do |pdf|

  stories.each do |story|
    # Draw points
    pdf.font "#{Prawn::BASEDIR}/data/fonts/DejaVuSans.ttf", :style => :bold
    pdf.font_size 64
    pdf.text "%d" % story[:points]
    pdf.horizontal_rule

    # Draw story
    pdf.font "#{Prawn::BASEDIR}/data/fonts/DejaVuSans.ttf"
    pdf.font_size 48
    pdf.text story[:title]


    pdf.font "#{Prawn::BASEDIR}/data/fonts/DejaVuSans.ttf"
    pdf.font_size 24
    if story[:description]
      pdf.text HTMLEntities.new.decode(story[:description].gsub(/<\/?[^>]*>/, ""))
    end

    # New page
    pdf.start_new_page
  end
end

puts " - Done generating story cards"
`open stories.pdf`
puts
puts "Thank you, good night!"
