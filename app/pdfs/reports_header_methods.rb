module ReportsHeaderMethods
  def report_header_block
    project_name_and_address
    contractor_name_and_address
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

  end
end