pdf.move_down 90
pdf.text @report.site_information_name
pdf.text @report.site_address_1
pdf.text @report.site_address_2
pdf.text @report.contractor_city
pdf.text @report.contractor_state
# pdf.text @report.contractor_zipcode

address_string = ["#{@report.site_information_name}\n",
				 "#{@report.site_address_1}\n",
				 "#{@report.site_address_2}\n",
				 "#{@report.contractor_city}\n",
				 "#{@report.contractor_state}"].join
# address_string = "asdffoobarbaz \n asdf foo bar baz \n asdf foo bar baz"

pdf.stroke_color('FF0000')
pdf.stroke_bounds
pdf.fill_color "ffff00"
pdf.fill_rectangle([0, 850], 200, 75)
pdf.fill_color(100,0,0,0)
options = {:size => 20, :width => 350, :height => 150, :at => [0, 800]}
pdf.text_box(address_string, options) 

pdf.move_down 90
pdf.text @report.contract_number
pdf.text @report.project_identifier_number
pdf.text @report.wdid_number
pdf.text @report.status

# pdf.text @report.submitted_by_contractor
# pdf.text @report.submitted_by_date

pdf.text @report.wpc_manager
pdf.text @report.wpc_phone
pdf.text @report.wpc_emergency_phone

pdf.text @report.inspector_name
# pdf.text @report.inspection_date

pdf.text @report.weather_condition
pdf.text @report.precipitation_condition 
pdf.text @report.wind_condition
pdf.text @report.construction_phase
# pdf.text @report.total_area
# pdf.text @report.total_DSA 
# pdf.text @report.current_DSA
# pdf.text @report.inactive_DSA
pdf.text @report.inspection_type
  
# pdf.text @report.time_elapsed_last_storm
# pdf.text @report.precipitation_received 
# pdf.text @report.time_storm_expected
# pdf.text @report.expected_precipitation_amount

# pdf.text @report.time_elapsed_during_storm 
# pdf.text @report.gauge_reading_during_storm
# pdf.text @report.time_elapsed_post_storm 
# pdf.text @report.gauge_reading_post_storm