#!/bin/bash
rails g migration AddFieldsToInspectionEventWorkflow \
  hours_after_rain:integer \
  cem2030:boolean \
