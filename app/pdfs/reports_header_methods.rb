module ReportsHeaderMethods
  def full_report_header_block
    project_name_and_address
    contractor_name_and_address
    submittal_information
    wpc_name_and_company
    contract_number
    weather_conditions
    inspector_name_and_date
    site_information
    storm_information
  end

  def simple_report_header_block
    project_name_and_address
    contract_number
  end

  def project_name_and_address
    formatted_text_box(
      [
        { text: "#{@report.site_information_name}\n" }, 
        { text: "#{@report.site_address_1}\n" },
        { text: "#{@report.site_address_2}\n" },
        { text: "#{@report.site_city} #{@report.site_state}, #{@report.site_zipcode}\n" }
      ],
      width: 200,
      at: [-18, 670],
      size: 10
    )
  end

  def contractor_name_and_address
    formatted_text_box(
      [
        { text: "#{@report.contractor_name}\n" },
        { text: "#{@report.contractor_address_1}\n" },
        { text: "#{@report.contractor_address_2}\n" },
        { text: "#{@report.contractor_city}, #{@report.contractor_state}" }
      ],
      width: 200,
      at: [-18, 603],
      size: 10
    )
  end

  def submittal_information
    formatted_text_box(
      [
        { text: "#{@report.submitted_by_contractor}\n" },
      ],
      width: 200,
      at: [-18, 542],
      size: 10
    )
    formatted_text_box(
      [
        { text: "#{@report.submitted_by_date}\n" },
      ],
      width: 200,
      at: [450, 542],
      size: 10
    )
  end

  def wpc_name_and_company
    formatted_text_box(
      [
        { text: "#{@report.wpc_manager }\n" },
      ],
      width: 200,
      at: [-18, 520],
      size: 10
    )
    formatted_text_box(
      [
        { text: "#{@report.wpc_phone}\n" },
      ],
      width: 200,
      at: [270, 520],
      size: 10
    )
    formatted_text_box(
      [
        { text: "#{@report.wpc_emergency_phone}\n" }
      ],
      width: 200,
      at: [270, 496],
      size: 10
    )
  end

  def contract_number
    formatted_text_box(
      [
        { text: "#{@report.contract_number}\n" },

        # Field needs conversion to checkbox.
        # { text: "#{@report.status}\n" }
      ],
      width: 200,
      at: [270, 675],
      size: 10
    )
    formatted_text_box(
      [
        { text: "#{@report.project_identifier_number}\n"},

        # Field needs conversion to checkbox.
        # { text: "#{@report.status}\n" }
      ],
      width: 200,
      at: [270, 650],
      size: 10
    )
    formatted_text_box(
      [
        { text: "#{@report.wdid_number}\n" },

        # Field needs conversion to checkbox.
        # { text: "#{@report.status}\n" }
      ],
      width: 200,
      at: [270, 625],
      size: 10
    )
  end

  def inspector_name_and_date
    formatted_text_box(
      [
        { text: "#{@report.inspector_name }\n" },
      ],
      width: 200,
      at: [-18, 450],
      size: 10
    )
    formatted_text_box(
      [
        { text: "#{@report.inspection_date }\n" },
      ],
      width: 200,
      at: [450, 450],
      size: 10
    )
  end  

  def weather_conditions
    formatted_text_box(
      [
        # Find correct method for radiobutton
        # { checked: "#{@report.weather_condition }\n" },
      ],
      width: 200,
      at: [-18, 470],
      size: 10
    )
  end

  def site_information
    formatted_text_box(
      [
        { text: "#{@report.total_area }\n" },
      ],
      width: 200,
      at: [270, 360],
      size: 10
    )
    formatted_text_box(
      [
        { text: "#{@report.total_DSA }\n" },
      ],
      width: 200,
      at: [270, 345],
      size: 10
    )
    formatted_text_box(
      [
        { text: "#{@report.current_DSA }\n" },
      ],
      width: 200,
      at: [270, 330],
      size: 10
    )
    formatted_text_box(
      [
        { text: "#{@report.inactive_DSA }\n" },
      ],
      width: 200,
      at: [270, 315],
      size: 10
    )    
  end  

  def storm_information
    formatted_text_box(
      [
        { text: "#{@report.time_elapsed_last_storm }\n" },
      ],
      width: 200,
      at: [140, 260],
      size: 10
    )
    formatted_text_box(
      [
        { text: "#{@report.precipitation_received }\n" },
      ],
      width: 200,
      at: [355, 260],
      size: 10
    )
    formatted_text_box(
      [
        { text: "#{@report.time_storm_expected }\n" },
      ],
      width: 200,
      at: [140, 227],
      size: 10
    )
    formatted_text_box(
      [
        { text: "#{@report.expected_precipitation_amount }\n" },
      ],
      width: 200,
      at: [355, 227],
      size: 10
    )
    formatted_text_box(
      [
        { text: "#{@report.time_elapsed_during_storm }\n" },
      ],
      width: 200,
      at: [140, 182],
      size: 10
    )
    formatted_text_box(
      [
        { text: "#{@report.gauge_reading_during_storm }\n" },
      ],
      width: 200,
      at: [355, 182],
      size: 10
    )
    formatted_text_box(
      [
        { text: "#{@report.time_elapsed_post_storm }\n" },
      ],
      width: 200,
      at: [140, 150],
      size: 10
    )
    formatted_text_box(
      [
        { text: "#{@report.gauge_reading_post_storm }\n" },
      ],
      width: 200,
      at: [355, 150],
      size: 10
    )                    
  end  
end