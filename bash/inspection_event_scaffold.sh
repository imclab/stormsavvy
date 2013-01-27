#!/bin/bash

rails g scaffold InspectionEvent site_id:integer inspection_type:string\
  inspection_description:text inspection_date:datetime submitted_by:string\
  inspected_by:string
