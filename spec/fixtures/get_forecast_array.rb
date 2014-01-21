pop = [90,78,16,8,7,0,14,12,14,14,14,24,50,59,65,49,11,11,5,5,4,4,5,5,6,6,8,8,11]
qpf = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
forecast_array = [
  { :date => ProjectLocalTime::format(Date.today + 0.hours), :weather => pop[0], :rainfall => qpf[0] },
  { :date => ProjectLocalTime::format(Date.today + 6.hours), :weather => pop[1], :rainfall => qpf[1] },
  { :date => ProjectLocalTime::format(Date.today + 12.hours), :weather => pop[2], :rainfall => qpf[2] },
  { :date => ProjectLocalTime::format(Date.today + 18.hours), :weather => pop[3], :rainfall => qpf[3] },
  { :date => ProjectLocalTime::format(Date.today + 24.hours), :weather => pop[4], :rainfall => qpf[4] },
  { :date => ProjectLocalTime::format(Date.today + 30.hours), :weather => pop[5], :rainfall => qpf[5] },
  { :date => ProjectLocalTime::format(Date.today + 36.hours), :weather => pop[6], :rainfall => qpf[6] },
  { :date => ProjectLocalTime::format(Date.today + 42.hours), :weather => pop[7], :rainfall => qpf[7] },
  { :date => ProjectLocalTime::format(Date.today + 48.hours), :weather => pop[8], :rainfall => qpf[8] },
  { :date => ProjectLocalTime::format(Date.today + 54.hours), :weather => pop[9], :rainfall => qpf[9] },
  { :date => ProjectLocalTime::format(Date.today + 60.hours), :weather => pop[10], :rainfall => qpf[10] },
  { :date => ProjectLocalTime::format(Date.today + 66.hours), :weather => pop[11], :rainfall => qpf[11] },
  { :date => ProjectLocalTime::format(Date.today + 72.hours), :weather => pop[12], :rainfall => qpf[12] },
  { :date => ProjectLocalTime::format(Date.today + 78.hours), :weather => pop[13], :rainfall => qpf[13] },
  { :date => ProjectLocalTime::format(Date.today + 84.hours), :weather => pop[14], :rainfall => qpf[14] },
  { :date => ProjectLocalTime::format(Date.today + 90.hours), :weather => pop[15], :rainfall => qpf[15] },
  { :date => ProjectLocalTime::format(Date.today + 96.hours), :weather => pop[16], :rainfall => qpf[16] },
  { :date => ProjectLocalTime::format(Date.today + 102.hours), :weather => pop[17], :rainfall => qpf[17] },
  { :date => ProjectLocalTime::format(Date.today + 108.hours), :weather => pop[18], :rainfall => qpf[18] },
  { :date => ProjectLocalTime::format(Date.today + 114.hours), :weather => pop[19], :rainfall => qpf[19] },
  { :date => ProjectLocalTime::format(Date.today + 120.hours), :weather => pop[20], :rainfall => qpf[20] },
  { :date => ProjectLocalTime::format(Date.today + 126.hours), :weather => pop[21], :rainfall => qpf[21] },
  { :date => ProjectLocalTime::format(Date.today + 132.hours), :weather => pop[22], :rainfall => qpf[22] },
  { :date => ProjectLocalTime::format(Date.today + 138.hours), :weather => pop[23], :rainfall => qpf[23] },
  { :date => ProjectLocalTime::format(Date.today + 144.hours), :weather => pop[24], :rainfall => qpf[24] },
  { :date => ProjectLocalTime::format(Date.today + 150.hours), :weather => pop[25], :rainfall => qpf[25] },
  { :date => ProjectLocalTime::format(Date.today + 156.hours), :weather => pop[26], :rainfall => qpf[26] },
  { :date => ProjectLocalTime::format(Date.today + 162.hours), :weather => pop[27], :rainfall => qpf[27] },
  { :date => ProjectLocalTime::format(Date.today + 168.hours), :weather => pop[28], :rainfall => qpf[28] }
]
return forecast_array
