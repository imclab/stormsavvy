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

# Boundary border
# pdf.stroke_color('FF0000')
# pdf.stroke_bounds

# Using pdf.text_box method
pdf.fill_color "FF0000"
pdf.text_box "#{@report.site_information_name}", :size => 12, :at => [0,850]
pdf.text_box "#{@report.site_address_1}", :size => 12, :at => [0,835]
pdf.text_box "#{@report.site_address_2}", :size => 12, :at => [0,820]
pdf.text_box "#{@report.site_city}, #{@report.site_state}", :size => 12, :at => [0,805]
pdf.text_box "#{@report.site_zipcode}", :size => 12, :at => [0,790]

pdf.move_down 90
pdf.text @report.contract_number
pdf.text @report.project_identifier_number
pdf.text @report.wdid_number
# pdf.text @report.status

# pdf.text @report.submitted_by_contractor
# pdf.text @report.submitted_by_date

# pdf.text @report.wpc_manager
# pdf.text @report.wpc_phone
# pdf.text @report.wpc_emergency_phone

# pdf.text @report.inspector_name
# pdf.text @report.inspection_date

# pdf.text @report.weather_condition
# pdf.text @report.precipitation_condition 
# pdf.text @report.wind_condition
# pdf.text @report.construction_phase
# pdf.text @report.total_area
# pdf.text @report.total_DSA 
# pdf.text @report.current_DSA
# pdf.text @report.inactive_DSA
# pdf.text @report.inspection_type
  
# pdf.text @report.time_elapsed_last_storm
# pdf.text @report.precipitation_received 
# pdf.text @report.time_storm_expected
# pdf.text @report.expected_precipitation_amount

# pdf.text @report.time_elapsed_during_storm 
# pdf.text @report.gauge_reading_during_storm
# pdf.text @report.time_elapsed_post_storm 
# pdf.text @report.gauge_reading_post_storm