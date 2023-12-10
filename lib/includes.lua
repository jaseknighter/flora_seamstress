-- required and included files

MusicUtil = require "musicutil"
tabutil = require "tabutil"
UI = require "ui"
kc = require("keycodes")
-- s = require('sequins')

instructions = include("lib/instructions")

Lattice = require 'lattice'
cs = require 'controlspec'
include("lib/midi_helper")
vector = include("lib/vector")
globals = include("lib/globals")
parameters = include("lib/parameters")
encoders_and_keys = include("lib/encoders_and_keys")
flora_pages = include("lib/flora_pages")
plant = include("lib/plant")
modify = include("lib/modify")
plant_sounds = include("lib/plant_sounds") 

garden = include("lib/gardens/garden")
garden_catalog = include("lib/gardens/garden_catalog_default")
l_system = include("lib/l_system")
turtle_class = include("lib/turtle")
matrix_stack = include("lib/matrix_stack")
rule = include("lib/rule")
plant_sounds_externals = include("lib/plant_sounds_externals") 
s = include('lib/sequins')
tl = include('lib/timeline')
envelope = include("lib/envelope")
water = include("lib/water")
fields = include("lib/fields") 
decimal_to_fraction = include("lib/decimal_to_fraction") 
field_irrigation = include("lib/field_irrigation") 
field_layout = include("lib/field_layout") 
crop = include "lib/field_crop"

p_gen_seq = include "lib/plant_gen_sequencer"
pset_seq = include "lib/pset_sequencer"

ArbGraph = include("lib/ArbitraryGraph")
tt = include "lib/tinta"