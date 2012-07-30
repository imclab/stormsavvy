module ReportsHeaderMethods
  def full_report_header_block
    project_name_and_address
    contractor_name_and_address
  end

  def simple_report_header_block
    project_name_and_address
    contract_number
  end

  def project_name_and_address
    formatted_text_box(
      [
        { text: "#{@report.site.name}\n" },
        { text: "#{@report.site.address_1}\n" },
        { text: "#{@report.site.address_2}\n" },
        { text: "#{@report.site.city}, #{@report.site.state}" }
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

  def contract_number
    formatted_text_box(
      [{ text: "#{@report.contract_number}\n" }],
      width: 200,
      at: [270, 675],
      size: 10
    )
  end

  def project_id_number
    formatted_text_box(
      [{ text: "#{@report.project_identifier_number}\n" }],
      width: 200,
      at: [270, 675],
      size: 10
    )
  end
end