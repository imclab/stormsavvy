module ReportsHeaderMethods
  def full_report_header_block
    project_name_and_address
    contractor_name_and_address
    wpc_name_and_company
    contract_number
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
end