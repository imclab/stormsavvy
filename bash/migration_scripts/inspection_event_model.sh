#!/bin/bash
rails g model InspectionEventWorkflow \
  hours_before_rain:integer \
  reap:boolean \
  cem2023:boolean \
  cem2024:boolean \
  cem2034:boolean \
  cem2035:boolean \
  cem2040:boolean \
  pre_storm_inspection:boolean \
  during_storm_inspection:boolean \
  post_storm_inspection:boolean \
  report_sent:boolean \
  report_received:boolean \
  ph_sample:boolean \
  turbidity:boolean \
  notice_of_discharge:boolean \
  chance_of_rain:integer \
  amount_of_rain:float \
  forecast_rain:float \
  inspection_event:boolean
