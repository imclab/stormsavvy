pdf.move_down 90
pdf.text @report.site_information_name
pdf.text @report.site_address_1
pdf.text @report.site_address_2
pdf.text @report.contractor_city
pdf.text @report.contractor_state


pdf.move_right 250
pdf.text @report.contract_number
pdf.text @report.project_identifier_number
pdf.text @report.wdid_number
pdf.text @report.status

pdf.text @report.submitted_by_contractor
pdf.text @report.submitted_by_date

pdf.text @report.wpc_manager
pdf.text @report.wpc_phone
pdf.text @report.wpc_emergency_phone

pdf.text @report.inspector_name
pdf.text @report.inspection_date

pdf.text @report.weather_condition
pdf.text @report.precipitation_condition 
pdf.text @report.wind_condition
pdf.text @report.construction_phase
pdf.text @report.total_area
pdf.text @report.total_DSA 
pdf.text @report.current_DSA
pdf.text @report.inactive_DSA
pdf.text @report.inspection_type
  
pdf.text @report.time_elapsed
pdf.text @report.precipitation_received 
pdf.text @report.time_storm_expected
pdf.text @report.expected_precipitation_amount

pdf.text @report.time_elapsed 
pdf.text @report.gauge_reading
pdf.text @report.time_elapsed_began 
pdf.text @report.gauge_reading_began 