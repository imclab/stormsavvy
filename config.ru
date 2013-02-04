# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
run Stormsavvy::Application

# Unicorn self-process killer
require ::File.expand_path('../lib/unicorn/unicorn_killer',  __FILE__)
use UnicornKiller::MaxRequests, 10240 + Random.rand(10240)
use UnicornKiller::Oom, 96 * 1024 + Random.rand(32) * 1024

# Out-Of-Band GC
require 'unicorn/oob_gc'
use Unicorn::OobGC