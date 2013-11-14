#!/usr/bin/env ruby

require 'pp'
$:.unshift File.expand_path('../lib/', __FILE__)
require 'filesize'

puts "> 10.MB.toB"
pp 10.MB.toB

puts "> 10000000.B"
pp 10000000.toB

puts "> 10000000.toB"
pp 10000000.toB

puts "> 10000000.kiB"
pp 10000000.kiB.pretty

puts "> 10000000.to_kiB"
pp 10000000.to_kiB

puts "> 10000000.toMiB"
pp 10000000.toMiB

puts "> 1.GB.toMB"
pp 1.GB.toMB

puts "> 1.GiB.toMB"
pp 1.GiB.toMB

puts "> 1.GB.toMiB"
pp 1.GB.toMiB

puts "> 1.GiB.toMiB"
pp 1.GiB.toMiB

