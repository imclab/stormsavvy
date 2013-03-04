#!/bin/bash
rails g migration AddFieldsToSamplingEventWorkflow \
  hours_before_rain:integer \
  cem2051:boolean \
  cem2052:boolean \
  ph_sample:boolean \
  turbidity:boolean \
  report_sent:boolean \
  report_received:boolean \
  chance_of_rain:integer \
  amount_of_rain:float \
  forecast_rain:float \
  sampling_event:boolean
