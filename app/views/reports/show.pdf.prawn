filename = "#{Prawn::DATADIR}/images/reports/CEM2030_production_v1.pdf"
pdf = Prawn::Document.new(:background => filename)
# pdf = Prawn::Document.new(:background => "#{Prawn::DATADIR}/images/CEM2030-2012_Page_01.png") 

# page1 = "#{Rails.root}/app/assets/images/CEM2030-2012_Page_01.png"
# pdf.image page1

# pdf.fill_color "FF0000"
# pdf.text_box "#{@report.site_information_name}", :size => 10, :at => [20,670]
# pdf.text_box "#{@report.site_address_1}", :size => 10, :at => [20,660]
# pdf.text_box "#{@report.site_address_2}", :size => 10, :at => [20,650]
# pdf.text_box "#{@report.site_city}, #{@report.site_state}", :size => 10, :at => [20,630]
# pdf.text_box "#{@report.site_zipcode}", :size => 10, :at => [20,620]

# pdf.move_down 90

# pdf.text_box "#{@report.contract_number}", :size => 10, :at => [200, 650]
# pdf.text_box "#{@report.project_identifier_number}", :size => 10, :at => [0,200]
# pdf.text_box "#{@report.wdid_number}", :size => 10, :at => [0,400]
# pdf.text_box "#{@report.status}", :size => 10, :at => [0,800]

# Coordinate markers

pdf.fill_color "ffff00"
pdf.fill_rectangle([-20, 850], 20, 900)
pdf.fill_color(100,0,0,0)

marker1 = ["850\n"].join
options1 = {:size => 12, :width => 30, :at => [-20, 850]}

marker2 = ["800\n"].join
options2 = {:size => 12, :width => 30, :at => [-20, 800]}

marker3 = ["750\n"].join
options3 = {:size => 12, :width => 30, :at => [-20, 750]}

marker4 = ["700\n"].join
options4 = {:size => 12, :width => 30, :at => [-20, 700]}

marker5 = ["650\n"].join
options5 = {:size => 12, :width => 30, :at => [-20, 650]}

marker6 = ["600\n"].join
options6 = {:size => 12, :width => 30, :at => [-20, 600]}

marker7 = ["550\n"].join
options7 = {:size => 12, :width => 30, :at => [-20, 550]}

marker8 = ["500\n"].join
options8 = {:size => 12, :width => 30, :at => [-20, 500]}

marker9 = ["450\n"].join
options9 = {:size => 12, :width => 30, :at => [-20, 450]}

marker10 = ["400\n"].join
options10 = {:size => 12, :width => 30, :at => [-20, 400]}

# Boundary border
pdf.stroke_color('FF0000')
pdf.stroke_bounds

pdf.text_box(marker1, options1) 
pdf.text_box(marker2, options2)
pdf.text_box(marker3, options3)
pdf.text_box(marker4, options4)
pdf.text_box(marker5, options5)
pdf.text_box(marker6, options6)
pdf.text_box(marker7, options7)
pdf.text_box(marker8, options8)
pdf.text_box(marker9, options9)
pdf.text_box(marker10, options10)

# Prawn::Document.generate("#{Rails.root}/app/views/reports/#{@report.id}.pdf") do

# 	pdf.fill_color "FF0000"

#   pdf.text "My report caption", :size => 18, :align => :right

#   pdf.move_down font.height * 2

#   pdf.text "Here is my text explaining this report. " * 20,
#     :size => 12, :align => :left, :leading => 2

#   pdf.move_down font.height

#   pdf.text "I'm using a soft background. " * 40,
#     :size => 12, :align => :left, :leading => 2
	
# end

# Start new page in view per prawn manual instruction

# pdf.start_new_page

# page2 = "#{Rails.root}/app/assets/images/CEM2030-2012_Page_02.png"

# pdf.image page2 
# pdf.text "This is pdf with background image ready to fill in"
