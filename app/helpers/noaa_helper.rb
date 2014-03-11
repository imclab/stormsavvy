module NoaaHelper
  def get_pop_table_hash(zipcode)
    # called by NOAAForecast
    pop_table_hash = [
      time_pop_hash[0].update(new_qpf_array[0]),
      time_pop_hash[1].update(new_qpf_array[1]),
      time_pop_hash[2].update(new_qpf_array[2]),
      time_pop_hash[3].update(new_qpf_array[3]),
      time_pop_hash[4].update(new_qpf_array[4]),
      time_pop_hash[5].update(new_qpf_array[5]),
      time_pop_hash[6].update(new_qpf_array[6]),
      time_pop_hash[7].update(new_qpf_array[7]),
      time_pop_hash[8].update(new_qpf_array[8]),
      time_pop_hash[9].update(new_qpf_array[9]),
      time_pop_hash[10].update(new_qpf_array[10]),
      time_pop_hash[11].update(new_qpf_array[11]),
      time_pop_hash[12].update(new_qpf_array[12]),
      time_pop_hash[13].update(new_qpf_array[13]),
      time_pop_hash[14].update(new_qpf_array[14]),
      time_pop_hash[15].update(new_qpf_array[15]),
      time_pop_hash[16].update(new_qpf_array[16]),
      time_pop_hash[17].update(new_qpf_array[17]),
      time_pop_hash[18].update(new_qpf_array[18]),
      time_pop_hash[19].update(new_qpf_array[19]),
      time_pop_hash[20].update(new_qpf_array[20]),
      time_pop_hash[21].update(new_qpf_array[21]),
      time_pop_hash[22].update(new_qpf_array[22]),
      time_pop_hash[23].update(new_qpf_array[23]),
      time_pop_hash[24].update(new_qpf_array[24]),
      time_pop_hash[25].update(new_qpf_array[25]),
      time_pop_hash[26].update(new_qpf_array[26]),
      time_pop_hash[27].update(new_qpf_array[27])
    ]
    return pop_table_hash
  end

  def get_forecast_array(zipcode)
    # called by NOAAForecast
    forecast_array = [
      { :date => ProjectLocalTime::format(Date.today + 0.hours), :weather => pop[0][0], :rainfall => pop[1][0] },
      { :date => ProjectLocalTime::format(Date.today + 6.hours), :weather => pop[0][1], :rainfall => pop[1][1] },
      { :date => ProjectLocalTime::format(Date.today + 12.hours), :weather => pop[0][2], :rainfall => pop[1][2] },
      { :date => ProjectLocalTime::format(Date.today + 18.hours), :weather => pop[0][3], :rainfall => pop[1][3] },
      { :date => ProjectLocalTime::format(Date.today + 24.hours), :weather => pop[0][4], :rainfall => pop[1][4] },
      { :date => ProjectLocalTime::format(Date.today + 30.hours), :weather => pop[0][5], :rainfall => pop[1][5] },
      { :date => ProjectLocalTime::format(Date.today + 36.hours), :weather => pop[0][6], :rainfall => pop[1][6] },
      { :date => ProjectLocalTime::format(Date.today + 42.hours), :weather => pop[0][7], :rainfall => pop[1][7] },
      { :date => ProjectLocalTime::format(Date.today + 48.hours), :weather => pop[0][8], :rainfall => pop[1][8] },
      { :date => ProjectLocalTime::format(Date.today + 54.hours), :weather => pop[0][9], :rainfall => pop[1][9] },
      { :date => ProjectLocalTime::format(Date.today + 60.hours), :weather => pop[0][10], :rainfall => pop[1][10] },
      { :date => ProjectLocalTime::format(Date.today + 66.hours), :weather => pop[0][11], :rainfall => pop[1][11] },
      { :date => ProjectLocalTime::format(Date.today + 72.hours), :weather => pop[0][12], :rainfall => pop[1][12] },
      { :date => ProjectLocalTime::format(Date.today + 78.hours), :weather => pop[0][13], :rainfall => pop[1][13] },
      { :date => ProjectLocalTime::format(Date.today + 84.hours), :weather => pop[0][14], :rainfall => pop[1][14] },
      { :date => ProjectLocalTime::format(Date.today + 90.hours), :weather => pop[0][15], :rainfall => pop[1][15] },
      { :date => ProjectLocalTime::format(Date.today + 96.hours), :weather => pop[0][16], :rainfall => pop[1][16] },
      { :date => ProjectLocalTime::format(Date.today + 102.hours), :weather => pop[0][17], :rainfall => pop[1][17] },
      { :date => ProjectLocalTime::format(Date.today + 108.hours), :weather => pop[0][18], :rainfall => pop[1][18] },
      { :date => ProjectLocalTime::format(Date.today + 114.hours), :weather => pop[0][19], :rainfall => pop[1][19] },
      { :date => ProjectLocalTime::format(Date.today + 120.hours), :weather => pop[0][20], :rainfall => pop[1][20] },
      { :date => ProjectLocalTime::format(Date.today + 126.hours), :weather => pop[0][21], :rainfall => pop[1][21] },
      { :date => ProjectLocalTime::format(Date.today + 132.hours), :weather => pop[0][22], :rainfall => pop[1][22] },
      { :date => ProjectLocalTime::format(Date.today + 138.hours), :weather => pop[0][23], :rainfall => pop[1][23] },
      { :date => ProjectLocalTime::format(Date.today + 144.hours), :weather => pop[0][24], :rainfall => pop[1][24] },
      { :date => ProjectLocalTime::format(Date.today + 150.hours), :weather => pop[0][25], :rainfall => pop[1][25] },
      { :date => ProjectLocalTime::format(Date.today + 156.hours), :weather => pop[0][26], :rainfall => pop[1][26] },
      { :date => ProjectLocalTime::format(Date.today + 162.hours), :weather => pop[0][27], :rainfall => pop[1][27] }
    ]
    return forecast_array
  end

  def forecast_by_zipcode(zipcode)
    # called by NOAAForecast
    forecast_array = [
      { :date => ProjectLocalTime::format(Date.today), :weather => pop[0][0], :rainfall => pop[1][0] },
      { :date => ProjectLocalTime::format(Date.today + 6.hours), :weather => pop[0][1], :rainfall => pop[1][1] },
      { :date => ProjectLocalTime::format(Date.today + 12.hours), :weather => pop[0][2], :rainfall => pop[1][2] },
      { :date => ProjectLocalTime::format(Date.today + 18.hours), :weather => pop[0][3], :rainfall => pop[1][3] },
      { :date => ProjectLocalTime::format(Date.today + 24.hours), :weather => pop[0][4], :rainfall => pop[1][4] },
      { :date => ProjectLocalTime::format(Date.today + 30.hours), :weather => pop[0][5], :rainfall => pop[1][5] },
      { :date => ProjectLocalTime::format(Date.today + 36.hours), :weather => pop[0][6], :rainfall => pop[1][6] },
      { :date => ProjectLocalTime::format(Date.today + 42.hours), :weather => pop[0][7], :rainfall => pop[1][7] },
      { :date => ProjectLocalTime::format(Date.today + 48.hours), :weather => pop[0][8], :rainfall => pop[1][8] },
      { :date => ProjectLocalTime::format(Date.today + 54.hours), :weather => pop[0][9], :rainfall => pop[1][9] },
      { :date => ProjectLocalTime::format(Date.today + 60.hours), :weather => pop[0][10], :rainfall => pop[1][10] },
      { :date => ProjectLocalTime::format(Date.today + 66.hours), :weather => pop[0][11], :rainfall => pop[1][11] },
      { :date => ProjectLocalTime::format(Date.today + 72.hours), :weather => pop[0][12], :rainfall => pop[1][12] },
      { :date => ProjectLocalTime::format(Date.today + 78.hours), :weather => pop[0][13], :rainfall => pop[1][13] },
      { :date => ProjectLocalTime::format(Date.today + 84.hours), :weather => pop[0][14], :rainfall => pop[1][14] },
      { :date => ProjectLocalTime::format(Date.today + 90.hours), :weather => pop[0][15], :rainfall => pop[1][15] },
      { :date => ProjectLocalTime::format(Date.today + 96.hours), :weather => pop[0][16], :rainfall => pop[1][16] },
      { :date => ProjectLocalTime::format(Date.today + 102.hours), :weather => pop[0][17], :rainfall => pop[1][17] },
      { :date => ProjectLocalTime::format(Date.today + 108.hours), :weather => pop[0][18], :rainfall => pop[1][18] },
      { :date => ProjectLocalTime::format(Date.today + 114.hours), :weather => pop[0][19], :rainfall => pop[1][19] },
      { :date => ProjectLocalTime::format(Date.today + 120.hours), :weather => pop[0][20], :rainfall => pop[1][20] },
      { :date => ProjectLocalTime::format(Date.today + 126.hours), :weather => pop[0][21], :rainfall => pop[1][21] },
      { :date => ProjectLocalTime::format(Date.today + 132.hours), :weather => pop[0][22], :rainfall => pop[1][22] },
      { :date => ProjectLocalTime::format(Date.today + 138.hours), :weather => pop[0][23], :rainfall => pop[1][23] },
      { :date => ProjectLocalTime::format(Date.today + 144.hours), :weather => pop[0][24], :rainfall => pop[1][24] },
      { :date => ProjectLocalTime::format(Date.today + 150.hours), :weather => pop[0][25], :rainfall => pop[1][25] },
      { :date => ProjectLocalTime::format(Date.today + 156.hours), :weather => pop[0][26], :rainfall => pop[1][26] },
      { :date => ProjectLocalTime::format(Date.today + 162.hours), :weather => pop[0][27], :rainfall => pop[1][27] },
      { :date => ProjectLocalTime::format(Date.today + 168.hours), :weather => pop[0][28], :rainfall => pop[1][28] }
    ]
    return forecast_array
  end
end
