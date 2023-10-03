INFO 5

# Driveline file

ATTRIBUTE spc:location1d real F64 double
ATTRIBUTE spc:velocity1d real F64 double
ATTRIBUTE sim:force1d real F64 double
ATTRIBUTE sim:index I32 int integer
ATTRIBUTE sim:prevVelocity1d real F64 double
ATTRIBUTE sim:prevLocation1d real F64 double
ATTRIBUTE sim:externalForce1d real F64 double
ATTRIBUTE sim:mass real F64 double
ATTRIBUTE name string
ATTRIBUTE bnd:radius real F64 double "=0.1"
ATTRIBUTE sim:color color "=1 1 1 1"
ATTRIBUTE bdy:length real F64 double "=0.0"
ATTRIBUTE lsf:spring voidstar

ATTRIBUTE contents group

ATTRIBUTE clutch:slip_factor real F64 double "=1.0"
ATTRIBUTE clutch:torque real F64 double "=1000.0"
ATTRIBUTE clutch:play real F64 double "=0.0"
ATTRIBUTE clutch:visc_drag real F64 double "=0.0"
ATTRIBUTE clutch:control string "=clutch"

ATTRIBUTE clutch:rpm vector2 "=3500.0 4000.0"

# Electric Motor power take off shaft
ATTRIBUTE pto WeakRecord

ATTRIBUTE engine:pto WeakRecord

# pair:left and pair:right are the endpoints for springs, as well
# as the output shafts for the diff
ATTRIBUTE pair:left WeakRecord
ATTRIBUTE pair:right WeakRecord

# stiffness of spring or diff
ATTRIBUTE mat:stiffness real F64 double "=1.0e7"

# spring damping (not used by diff)
ATTRIBUTE mat:damping real F64 double "=0.0"

# not used
ATTRIBUTE mat:flags I32 int integer

ATTRIBUTE dl:ratio string "=baseline"
ATTRIBUTE dl:minhz real "=600.0"

ATTRIBUTE dl:active string "=true"

#################################################################
# AMALGAM DIFF PARAMETERS

# input shaft
ATTRIBUTE diff:shaft WeakRecord

# planet gear
ATTRIBUTE diff:planet WeakRecord

# pair:left -- left output

# pair:right -- right output

# Drag
#  0: bearing drag
#  1: shaft/output gear to gear drag
#  2: planet/output gear to gear drag
ATTRIBUTE diff:drag vector3 "=0.0 0.0 0.0"

# Diff model version
# Can be set per diff
#
# 1: Baseline
# 2: Add viscous LSD locking force calculation improvement
# 3: Add clutch LSD ramp force calculation improvement (needs diff setup)
ATTRIBUTE diff:model_version real F64 double "=1"


#-----------------------------------------------------
# Torsen LSD
ATTRIBUTE diff:gear_lsd string "=false"

# Bias Ratio
#  0: power
#  1: coast
ATTRIBUTE diff:bias_ratio vv2 "=1.0 1.0"

# Assymetric Ratio
#   expressed in term of ratio to "right" shaft
ATTRIBUTE diff:right_ratio string =0.5


# softness in the velocity sensitivity of the metal...
# (yeah, just words)
# Bottom line:  more of this to deal with Torsen
# vibration and stickness.   But too much will reduce
# effective bias from settings
ATTRIBUTE diff:gear_softness real =10.0

# Notes on setting up a Torsen diff:
# Since this is modeled pretty low level, and work a lot like
# a real Torsen, it also has some of the headaches.  Setting
# up a real one involves dealing with tuning friction, materials
# etc.  While we get to just set the bias direct, we still have
# to deal with those other things to dial efficiency, vibration,
# and clunkiness (or not).  The complication for us vs real is
# that at 600hz, some the real buzz and vibration gets mutated
# to fit in the 600hz.


#-----------------------------------------------------
# Salisbury LSD
ATTRIBUTE diff:clutch_lsd string "=false"

# DEPRECATED attribute!
#
# Incorrect legacy calculation used until 2021 Nov
# Opt-in if must for now
#
# Can be removed from AmalgamDiff code later if not used
ATTRIBUTE diff:clutch_legacy_calc string "=false"

# Clutch static friction coefficient boost ratio
# This is basically the static/dynamic friction ratio
ATTRIBUTE diff:clutch_lars_ratio real F64 double =1.1

# Preload
ATTRIBUTE diff:preload string =0.0

# Ramp angle in degree (as this is common unit for this)
#  0: power
#  1: coast
ATTRIBUTE diff:ramp_angle vv2 "=85.0 15.0"

# Clutch effectiveness
#  epressed in term of "lock" per clutch
ATTRIBUTE diff:lock_per_clutch real F64 double =0.01

# Clutch Count
ATTRIBUTE diff:clutches string =1

# Clutch slip factor
#  This is part of the stick/slip of the clutch.
#  This is basically the dynamic/static friction ratio
ATTRIBUTE diff:clutch_slip_factor real F64 double =1.0

#-----------------------------------------------------
# Viscous LSD
ATTRIBUTE diff:visc_lsd string "=false"

# Base viscous locking, in Nm/RPM
ATTRIBUTE diff:visc_locking string =125.0

# Viscous Hump, sharp increase in locking above a temp
#  0: cooefficient of increase in locking
#  1: temperature above which hump starts
ATTRIBUTE diff:visc_hump vector2 "=0.0 0.0"

# Viscosity breakdown
#  This is transient breakdown (temp comes back down,
#  viscosity goes back up)
#  0: coefficient of breakdown
#  1: temperature above which breakdown starts
ATTRIBUTE diff:visc_degrade vector2 "=0.0 0.0"

# VLSD Failure Temperature
#  This is permanent failure, due to expansion breaking parts
ATTRIBUTE diff:visc_fail real F64 double =1000.0

# Fluid heat model
#  0: heating cooefficient (wrt velocity differential)
#  1: cooling cooefficient (wrt temperature differential to air)
ATTRIBUTE diff:visc_heating vector2 "=0.0 0.0"

#-----------------------------------------------------
# Ratchet Locking
ATTRIBUTE diff:ratchet_lsd string "=false"

#################################################################
# BRAKE PARAMETERS

# 
ATTRIBUTE brake:disc WeakRecord

#
ATTRIBUTE brake:slip_factor real F64 double =1.0

#
ATTRIBUTE brake:wheel string "=RR"

#################################################################
# BEARING PARAMETERS
#
ATTRIBUTE bearing:shaft WeakRecord
ATTRIBUTE bearing:visc real F64 double "=0.0"
ATTRIBUTE bearing:friction real F64 double "=0.0"

#################################################################
# GEARBOX PARAMETERS

# pair:left -- clutch side mass

# pair:right -- drive side mass

# mat:stiffness -- general stiffness (gears, etc)

# mat:damping -- general damping (gears, etc)

# gear:ratio -- gear ratio string label
ATTRIBUTE gear:ratio string "=baseline"

# Synchromesh
# a shift is currently modeled as a linear increase in pressure on gear
# lever, or from actuator, on mesh, starting from zero.
# this is very simple, and there is even already more sophisticated code
# on standby to get even fancier on modeling shift pressure.  But lets start here.
#  0: Pressure factor (P = factor*time_since_shift_started)
#  1: time limit on a gear change to synch, after which gears jam together
#  2: velocity difference at which synchromesh allows gears to engage
ATTRIBUTE gb:synchro vector3 "=0.0 0.0 1.0"

# Wear
# "gears" are ratios, and wear is tracked per.
#  wear accumulates when torque on a gear is above a threshold, and
#  is quadratic.
#  Going into gear is discretized in time, so the timestep is used.
#  Going out of gear is currently modeled instantaneously, so the amount
#  of time this takes for wear purposes is a parameter.
#  0: threshold in Nm
#  1: wear rate factor
#  2: quasi time for ungearing
ATTRIBUTE gb:wear_rate vector3 "=0.0 0.0 0.0"

LAYOUT l_bearing
	bearing:shaft
	bearing:visc
	bearing:friction
LAYOUT shaft
	spc:location1d
	spc:velocity1d
	sim:force1d
	sim:index
	sim:prevVelocity1d
	sim:prevLocation1d
	sim:externalForce1d
	sim:mass
	name
	dl:active
	bnd:radius
	sim:color
LAYOUT amalgam_diff
	pair:left
	pair:right
	mat:stiffness
	diff:drag
	mat:flags
	diff:model_version
	diff:shaft
	diff:planet
	diff:gear_lsd
	diff:bias_ratio
	diff:right_ratio
	diff:gear_softness
	diff:clutch_lsd
	diff:clutch_legacy_calc
	diff:clutch_lars_ratio
	#diff:stick_stiffness
	diff:preload
	diff:ramp_angle
	diff:lock_per_clutch
	diff:clutches
	diff:clutch_slip_factor
	diff:visc_lsd
	diff:visc_locking
	diff:visc_hump
	diff:visc_degrade
	diff:visc_fail
	diff:visc_heating
	diff:ratchet_lsd
	dl:ratio
LAYOUT electricmotor
	pto
LAYOUT l_pistonmotor
	engine:pto
LAYOUT l_spring
	pair:left
	pair:right
	mat:stiffness
	mat:damping
	mat:flags
	bdy:length
	lsf:spring
	name
	dl:active
LAYOUT l_brake
	brake:disc
	brake:slip_factor
	brake:wheel
LAYOUT l_clutch
	pair:left
	pair:right
	mat:stiffness
	mat:damping
	clutch:visc_drag
	clutch:slip_factor
	clutch:torque
	clutch:play
	clutch:control
	dl:ratio
LAYOUT l_centrifugal_clutch
	pair:left
	pair:right
	mat:stiffness
	mat:damping
	clutch:visc_drag
	clutch:slip_factor
	clutch:torque
	clutch:play
	clutch:rpm
	dl:ratio
LAYOUT l_gearbox
	pair:left
	pair:right
	mat:stiffness
	mat:damping
	gear:ratio
	gb:synchro
	gb:wear_rate
LAYOUT l_driveline
	name
	contents
	dl:minhz
	

DEFAULTGROUP 1

#############################################################################
# The following is the simplest possible RWD topology
# It is straightforward to add components for AWD
# FWD is super simply just changing wheel_RL/wheel_RR to wheel_FL/wheel_FR in diff
# adding other complexity, like extra shafts to model vibration is possible too

#############################################################################

RECORDGROUP Basic_RWD
	wheel_FR
	wheel_FL
	wheel_RR
	wheel_RL
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR
	strain_FL
	strain_RR
	strain_RL
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	crankshaft
	driveshaft
	rear_diff
	planet_gear
	clutch

RECORDGROUP Basic_RWD_offline
	wheel_FR
	wheel_FL
	wheel_RR
	wheel_RL
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR
	strain_FL
	strain_RR
	strain_RL
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	crankshaft
	clutchshaft
	driveshaft
	rear_diff
	planet_gear
	electricmotor
	pistonmotor
	clutch
	#crank_bearings
	#drive_bearings
	gearbox

RECORD crank_bearings l_bearing
	bearing:shaft crankshaft
	bearing:friction 1.0e2
	bearing:visc 1.0e1

RECORD drive_bearings l_bearing
	bearing:shaft driveshaft
	bearing:friction 1.0e2
	bearing:visc 1.0e1

# These wheel shafts are where the STM torques are applied
# This is also the mass that is integrated by the driveline as the
# whole wheel (rim+tire)
RECORD wheel_FR shaft
	name "wheel_FR"
	sim:mass 1.6
RECORD wheel_FL shaft
	name "wheel_FL"
	sim:mass 1.6
RECORD wheel_RR shaft
	name "wheel_RR"
	sim:mass 1.6
RECORD wheel_RL shaft
	name "wheel_RL"
	sim:mass 1.6

RECORD strain_FR l_spring
	name "strain_FR"
	pair:left wheel_FR_internal
	pair:right wheel_FR

RECORD strain_FL l_spring
	name "strain_FL"
	pair:left wheel_FL_internal
	pair:right wheel_FL

RECORD strain_RR l_spring
	name "strain_RR"
	pair:left wheel_RR_internal
	pair:right wheel_RR

RECORD strain_RL l_spring
	name "strain_RL"
	pair:left wheel_RL_internal
	pair:right wheel_RL

RECORD brake_FR l_brake
	brake:disc			wheel_FR_internal
	brake:slip_factor	0.9
	brake:wheel			"FR"

RECORD brake_FL l_brake
	brake:disc			wheel_FL_internal
	brake:slip_factor	0.9
	brake:wheel			"FL"

RECORD brake_RR l_brake
	brake:disc			wheel_RR_internal
	brake:slip_factor	0.9
	brake:wheel			"RR"

RECORD brake_RL l_brake
	brake:disc			wheel_RL_internal
	brake:slip_factor	0.9
	brake:wheel			"RL"


# The shaft named "driveshaft" is where the wrapped engine/clutch/gearbox
# torque is applied.
RECORD crankshaft shaft
	name "crankshaft"
	#sim:mass 0.1
	sim:mass 0.27

RECORD clutchshaft shaft
	name "clutchshaft"
	sim:mass 0.1

RECORD driveshaft shaft
	name "driveshaft"
	sim:mass 0.1

RECORD rear_diff amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft
	diff:planet planet_gear
	mat:stiffness 1.0e6
	diff:drag "0.0 0.0 0.0"
	mat:flags 0
	# Torsen
	diff:gear_lsd false
	diff:bias_ratio "4.0 4.0"
	diff:right_ratio 0.5
	# Salisbury
	diff:clutch_lsd  false
	diff:preload 0.0
	diff:ramp_angle "45 45"
	diff:lock_per_clutch 0.005
	diff:clutches 2
	diff:clutch_slip_factor 1.5
	# VLSD
	diff:visc_lsd false
	diff:visc_locking 125.0
	diff:visc_hump "0.0 390.0"
	diff:visc_degrade "0.0 300.0"
	diff:visc_fail 1000.0
	diff:visc_heating "0.0 0.0"
	# Ratchet
	diff:ratchet_lsd false

	# final drive
	dl:ratio "drive"

RECORD electricmotor electricmotor
	pto crankshaft

RECORD pistonmotor l_pistonmotor
	engine:pto crankshaft

RECORD clutch l_clutch
	pair:left crankshaft
	pair:right driveshaft
	mat:stiffness 1.0e6
	clutch:torque 2200
	mat:damping 0.0e2
	clutch:visc_drag 1.0e2
	clutch:slip_factor 1.0
	dl:ratio "gear"

RECORD gearbox l_gearbox
	pair:left clutchshaft
	pair:right driveshaft
	mat:stiffness 1.0e6
	mat:damping 0.0
	gear:ratio "gear"
	gb:synchro "1.0e6 0.0 0.1"
	gb:wear_rate "1.0e4 0.0 0.01"

###############
# Hewland LD200
#   RWD
#   Open Diff
###############

RECORD RWD_L51 l_driveline
	name "LOTUS_51"
	contents RWD_L51
	dl:minhz	6000.0

RECORDGROUP RWD_L51
	wheel_FR
	wheel_FL
	wheel_RR
	wheel_RL
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR
	strain_FL
	strain_RR
	strain_RL
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	crankshaft_L51
	clutchshaft_L51
	clutchshaft_L51_bearing
	crankshaft_L51_bearing
	driveshaft_L51
	driveshaft_L51_POST
	strain_trainsmission
	rear_diff_L51
	planet_gear_L51
	clutch_L51
	gearbox_L51
	#small_wheel_bearing_FR
	#small_wheel_bearing_FL
	#small_wheel_bearing_RR
	#small_wheel_bearing_RL
	#electric_L51
	#spool

RECORD strain_trainsmission l_spring
	name "strain_transmission"
	pair:left driveshaft_L51
	pair:right driveshaft_L51_POST

RECORD clutchshaft_L51_bearing l_bearing
	bearing:shaft clutchshaft_L51
	bearing:friction 1.0e0
	bearing:visc 1.0e-2

RECORD crankshaft_L51_bearing l_bearing
	bearing:shaft crankshaft_L51
	bearing:friction 1.0e0
	bearing:visc 1.0e-2

RECORD small_wheel_bearing_FR l_bearing
	bearing:shaft wheel_FR_internal
	bearing:friction 1.0e1
	bearing:visc 0.9e-1

RECORD small_wheel_bearing_FL l_bearing
	bearing:shaft wheel_FL_internal
	bearing:friction 1.0e1
	bearing:visc 0.9e-1

RECORD small_wheel_bearing_RR l_bearing
	bearing:shaft wheel_RR_internal
	bearing:friction 1.0e1
	bearing:visc 0.9e-1

RECORD small_wheel_bearing_RL l_bearing
	bearing:shaft wheel_RL_internal
	bearing:friction 1.0e1
	bearing:visc 0.9e-1


RECORD electric_L51 electricmotor
	pto crankshaft_L51

# The shaft named "driveshaft" is where the wrapped engine/clutch/gearbox
# torque is applied.
RECORD crankshaft_L51 shaft
	name "crankshaft"
	sim:mass 0.15

RECORD clutchshaft_L51 shaft
	name "clutchshaft"
	sim:mass 0.05

RECORD driveshaft_L51 shaft
	name "driveshaft"
	sim:mass 0.025

RECORD driveshaft_L51_POST shaft
	name "driveshaft_post"
	sim:mass 0.025

RECORD rear_diff_L51 amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft_L51_POST
	diff:planet planet_gear_L51
	mat:stiffness 1.0e6
	diff:drag "0.0e-3 0.0e-3 1.0e-2"
	mat:flags 0
	# Torsen
	diff:gear_lsd false
	diff:bias_ratio "4.0 4.0"
	diff:right_ratio 0.5
	# Salisbury
	diff:clutch_lsd  false
	diff:preload 0.0
	diff:ramp_angle "45 45"
	diff:lock_per_clutch 0.01
	diff:clutches 1
	diff:clutch_slip_factor 1.5
	# VLSD
	diff:visc_lsd false
	diff:visc_locking 125.0
    diff:visc_hump "0.001 390"
    diff:visc_degrade "0.001 300"
    diff:visc_fail 10000  #high temp here to avoid failure mode
    diff:visc_heating "0.03 0.1"
	# Ratchet
	diff:ratchet_lsd false

	# final drive
	dl:ratio "drive"

# tuning of the planet gear mass can make a difference to Torsen
RECORD planet_gear_L51 shaft
	name "planet_gear"
	sim:mass 0.01

RECORD clutch_L51 l_clutch
	pair:left crankshaft_L51
	pair:right clutchshaft_L51
	mat:stiffness 2.0e4
	clutch:torque 1000.0
	clutch:play 0.0
	mat:damping 1.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 1.0

RECORD gearbox_L51 l_gearbox
	pair:left clutchshaft_L51
	pair:right driveshaft_L51
	mat:stiffness 2.0e4
	mat:damping 0.0e2
	gb:synchro "1.0e4 0.0 0.1"
	gb:wear_rate "1.0e4 0.0 0.0"
	gear:ratio "gear"

	
###############################################
# Collection of parts to use for assemblies
###############################################

###############
# Torque shaft, when present, gets used to apply crankshaft torque
###############

RECORD torqueshaft shaft
	name "torqueshaft"
	sim:mass 0.01

RECORD torqueshaft_strain_KART l_spring
	name "torqueshaft_strain"
	pair:left torqueshaft
	pair:right crankshaft_KART
	mat:stiffness 1.0e6

RECORD torqueshaft_strain_F1_80s l_spring
	name "torqueshaft_strain"
	pair:left torqueshaft
	pair:right crankshaft_F1_80s
	mat:stiffness 1.0e6

RECORD torqueshaft_strain_F1_90s l_spring
	name "torqueshaft_strain"
	pair:left torqueshaft
	pair:right crankshaft_F1_90s
	mat:stiffness 1.0e6

RECORD torqueshaft_strain_F1 l_spring
	name "torqueshaft_strain"
	pair:left torqueshaft
	pair:right crankshaft_F1
	mat:stiffness 1.0e6

RECORD torqueshaft_strain_F1_ERS l_spring
	name "torqueshaft_strain"
	pair:left torqueshaft
	pair:right crankshaft_F1_ERS
	mat:stiffness 1.0e6

RECORD torqueshaft_strain_CART_90s l_spring
	name "torqueshaft_strain"
	pair:left torqueshaft
	pair:right crankshaft_CART_90s
	mat:stiffness 1.0e6

RECORD torqueshaft_strain_TCR l_spring
	name "torqueshaft_strain"
	pair:left torqueshaft
	pair:right crankshaft_TCR
	mat:stiffness 1.0e6

RECORD torqueshaft_strain_GT3 l_spring
	name "torqueshaft_strain"
	pair:left torqueshaft
	pair:right crankshaft_GT3
	mat:stiffness 1.0e6

RECORD torqueshaft_strain_ROAD l_spring
	name "torqueshaft_strain"
	pair:left torqueshaft
	pair:right crankshaft_ROAD
	mat:stiffness 1.0e6

RECORD torqueshaft_strain_ROAD_LIGHT l_spring
	name "torqueshaft_strain"
	pair:left torqueshaft
	pair:right crankshaft_ROAD_LIGHT
	mat:stiffness 1.0e6

RECORD torqueshaft_strain_ROAD_MED_LIGHT l_spring
	name "torqueshaft_strain"
	pair:left torqueshaft
	pair:right crankshaft_ROAD_MED_LIGHT
	mat:stiffness 1.0e6

RECORD torqueshaft_strain_ROAD_MED l_spring
	name "torqueshaft_strain"
	pair:left torqueshaft
	pair:right crankshaft_ROAD_MED
	mat:stiffness 1.0e6

RECORD torqueshaft_strain_ROAD_HEAVY l_spring
	name "torqueshaft_strain"
	pair:left torqueshaft
	pair:right crankshaft_ROAD_HEAVY
	mat:stiffness 1.0e6

RECORD torqueshaft_strain_TRUCK l_spring
	name "torqueshaft_strain"
	pair:left torqueshaft
	pair:right crankshaft_TRUCK
	mat:stiffness 1.0e6

###############
# The shaft named "crankhaft" is where the wrapped engine/clutch/gearbox torque is applied
# Total rotating inertia for the engine & flywheel is set here
###############

RECORD crankshaft_KART shaft
	name "crankshaft"
	sim:mass 0.0025

RECORD crankshaft_F1_80s shaft
	name "crankshaft"
	sim:mass 0.095

RECORD crankshaft_F1_90s shaft
	name "crankshaft"
	sim:mass 0.06

RECORD crankshaft_F1 shaft
	name "crankshaft"
	sim:mass 0.04

RECORD crankshaft_F1_ERS shaft
	name "crankshaft"
	sim:mass 0.045

RECORD crankshaft_CART_90s shaft
	name "crankshaft"
	sim:mass 0.05

RECORD crankshaft_TCR shaft
	name "crankshaft"
	sim:mass 0.085

RECORD crankshaft_GT3 shaft
	name "crankshaft"
	sim:mass 0.10

RECORD crankshaft_ROAD shaft
	name "crankshaft"
	sim:mass 0.20

RECORD crankshaft_ROAD_LIGHT shaft
	name "crankshaft"
	sim:mass 0.04

RECORD crankshaft_ROAD_MED_LIGHT shaft
	name "crankshaft"
	sim:mass 0.065

RECORD crankshaft_ROAD_MED shaft
	name "crankshaft"
	sim:mass 0.15

RECORD crankshaft_ROAD_HEAVY shaft
	name "crankshaft"
	sim:mass 0.25

RECORD crankshaft_TRUCK shaft
	name "crankshaft"
	sim:mass 1.14

###############
# Clutches of varying strength
# Be sure the left 'input' matches the crankshaft used in a given model
###############

## F1 & CART
RECORD clutch_CART_1000Nm_90s l_clutch
	pair:left crankshaft_CART_90s
	pair:right clutchshaft_F1
	mat:stiffness 1.0e6
	clutch:torque 1000
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.9
	clutch:play 0.05

RECORD clutch_F1_750Nm_90s l_clutch
	pair:left crankshaft_F1_90s
	pair:right clutchshaft_F1
	mat:stiffness 1.0e6
	clutch:torque 750
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.9
	clutch:play 0.05

RECORD clutch_F1_1000Nm_80s l_clutch
	pair:left crankshaft_F1_80s
	pair:right clutchshaft_F1
	mat:stiffness 1.0e6
	clutch:torque 1200
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.9
	clutch:play 0.05

RECORD clutch_F1_1500Nm_80s l_clutch
	pair:left crankshaft_F1_80s
	pair:right clutchshaft_F1
	mat:stiffness 1.0e6
	clutch:torque 1500
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 4.0
	clutch:play 0.05

RECORD clutch_F1_750Nm l_clutch
	pair:left crankshaft_F1
	pair:right clutchshaft_F1
	mat:stiffness 1.0e6
	clutch:torque 750
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.9
	clutch:play 0.05

RECORD clutch_F1_1000Nm l_clutch
	pair:left crankshaft_F1_ERS
	pair:right clutchshaft_F1
	mat:stiffness 1.0e6
	clutch:torque 1000
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.9
	clutch:play 0.05

## TCR
RECORD clutch_TCR_ARC l_clutch
	pair:left crankshaft_F1
	pair:right clutchshaft_GT3
	mat:stiffness 5.0e3
	clutch:torque 250
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.9
	clutch:play 0.05

RECORD clutch_TCR_300Nm l_clutch
	pair:left crankshaft_TCR
	pair:right clutchshaft_GT3
	mat:stiffness 1.0e6
	clutch:torque 300
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.8
	clutch:play 0.05

RECORD clutch_TCR_350Nm l_clutch
	pair:left crankshaft_GT3
	pair:right clutchshaft_GT3
	mat:stiffness 1.0e6
	clutch:torque 350
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.9
	clutch:play 0.05

RECORD clutch_TCR_450Nm l_clutch
	pair:left crankshaft_TCR
	pair:right clutchshaft_GT3
	mat:stiffness 1.0e6
	clutch:torque 450
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.9
	clutch:play 0.05

RECORD clutch_TCR_550Nm l_clutch
	pair:left crankshaft_TCR
	pair:right clutchshaft_GT3
	mat:stiffness 1.0e6
	clutch:torque 550
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.9
	clutch:play 0.05

RECORD clutch_TCR_600Nm l_clutch
	pair:left crankshaft_TCR
	pair:right clutchshaft_GT3
	mat:stiffness 1.0e6
	clutch:torque 600
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.9
	clutch:play 0.05

RECORD clutch_TCR_800Nm l_clutch
	pair:left crankshaft_TCR
	pair:right clutchshaft_GT3
	mat:stiffness 1.0e6
	clutch:torque 800
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.9
	clutch:play 0.05

RECORD clutch_TCR_1000Nm l_clutch
	pair:left crankshaft_TCR
	pair:right clutchshaft_GT3
	mat:stiffness 1.0e6
	clutch:torque 1000
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.95
	clutch:play 0.05

## GT3
RECORD clutch_GT3_650Nm l_clutch
	pair:left crankshaft_GT3
	pair:right clutchshaft_GT3
	mat:stiffness 1.0e6
	clutch:torque 650
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.9
	clutch:play 0.05

RECORD clutch_GT3_700Nm l_clutch
	pair:left crankshaft_GT3
	pair:right clutchshaft_GT3
	mat:stiffness 1.0e6
	clutch:torque 700
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.9
	clutch:play 0.05

RECORD clutch_GT3_750Nm l_clutch
	pair:left crankshaft_GT3
	pair:right clutchshaft_GT3
	mat:stiffness 1.0e6
	clutch:torque 750
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.9
	clutch:play 0.05

RECORD clutch_GT3_900Nm l_clutch
	pair:left crankshaft_GT3
	pair:right clutchshaft_GT3
	mat:stiffness 1.0e6
	clutch:torque 980
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.9
	clutch:play 0.05

RECORD clutch_GT3_1000Nm l_clutch
	pair:left crankshaft_GT3
	pair:right clutchshaft_GT3
	mat:stiffness 1.0e6
	clutch:torque 1000
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.9
	clutch:play 0.05

RECORD clutch_GT3_1200Nm l_clutch
	pair:left crankshaft_GT3
	pair:right clutchshaft_GT3
	mat:stiffness 1.0e6
	clutch:torque 1200
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.9
	clutch:play 0.05

RECORD clutch_GT3_1500Nm l_clutch
	pair:left crankshaft_GT3
	pair:right clutchshaft_GT3
	mat:stiffness 1.0e6
	clutch:torque 1500
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 4.0
	clutch:play 0.05
	
RECORD clutch_Truck_4000Nm l_clutch
	pair:left crankshaft_TRUCK
	pair:right clutchshaft_ROAD
	mat:stiffness 1.0e6
	clutch:torque 4400
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.9
	clutch:play 0.05	

RECORD clutch_GT3 l_clutch
	pair:left crankshaft_GT3
	pair:right clutchshaft_GT3
	mat:stiffness 1.0e6
	clutch:torque 800
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 2.0
	clutch:play 0.05

## ROAD
RECORD clutch_ROAD_250Nm l_clutch
	pair:left crankshaft_ROAD_MED_LIGHT
	pair:right clutchshaft_ROAD
	mat:stiffness 1.0e6
	clutch:torque 250
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.9
	clutch:play 0.05

RECORD clutch_ROAD_350Nm l_clutch
	pair:left crankshaft_ROAD_MED_LIGHT
	pair:right clutchshaft_ROAD
	mat:stiffness 1.0e6
	clutch:torque 350
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.95
	clutch:play 0.05

RECORD clutch_ROAD_450Nm l_clutch
	pair:left crankshaft_ROAD_MED
	pair:right clutchshaft_ROAD
	mat:stiffness 1.0e6
	clutch:torque 450
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.9
	clutch:play 0.05

RECORD clutch_ROAD_500Nm l_clutch
	pair:left crankshaft_ROAD
	pair:right clutchshaft_ROAD
	mat:stiffness 1.0e6
	clutch:torque 550
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.9
	clutch:play 0.05

RECORD clutch_ROAD_550Nm l_clutch
	pair:left crankshaft_ROAD_HEAVY
	pair:right clutchshaft_ROAD
	mat:stiffness 1.0e6
	clutch:torque 550
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.9
	clutch:play 0.05

RECORD clutch_ROAD_600Nm l_clutch
	pair:left crankshaft_ROAD_MED
	pair:right clutchshaft_ROAD
	mat:stiffness 1.0e6
	clutch:torque 600
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.9
	clutch:play 0.05

RECORD clutch_ROAD_700Nm l_clutch
	pair:left crankshaft_ROAD
	pair:right clutchshaft_ROAD
	mat:stiffness 1.0e6
	clutch:torque 700
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.9
	clutch:play 0.05

RECORD clutch_ROAD_900Nm l_clutch
	pair:left crankshaft_ROAD
	pair:right clutchshaft_ROAD
	mat:stiffness 1.0e6
	clutch:torque 900
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.9
	clutch:play 0.05

RECORD clutch_ROAD_1000Nm l_clutch
	pair:left crankshaft_ROAD
	pair:right clutchshaft_ROAD
	mat:stiffness 1.0e6
	clutch:torque 1000
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 6.0
	clutch:play 0.05

## Specific clutches for clutchshaft mass configs
RECORD clutch_MODERN-GT l_clutch
	pair:left crankshaft_GT3
	pair:right clutchshaft_MODERN-GT
	mat:stiffness 1.0e6
	clutch:torque 600
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.9
	clutch:play 0.05

RECORD clutch_MODERN-GT_1200Nm l_clutch
	pair:left crankshaft_GT3
	pair:right clutchshaft_MODERN-GT
	mat:stiffness 1.0e6
	clutch:torque 1200
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.9
	clutch:play 0.05

## Special cases connecting ROAD crank to GT3 clutchshaft
RECORD clutch_ROAD_GT3_200Nm l_clutch
	pair:left crankshaft_ROAD_MED_LIGHT
	pair:right clutchshaft_GT3
	mat:stiffness 1.0e6
	clutch:torque 200
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.9
	clutch:play 0.05

RECORD clutch_ROAD_GT3_300Nm l_clutch
	pair:left crankshaft_ROAD_LIGHT
	pair:right clutchshaft_GT3
	mat:stiffness 1.0e6
	clutch:torque 300
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.9
	clutch:play 0.05





###############
# Centrifugal Clutches
###############

RECORD clutch_KART l_centrifugal_clutch
	pair:left crankshaft_KART
	pair:right clutchshaft_KART
	mat:stiffness 1.0e5
	clutch:torque 25
	mat:damping 0.0
	clutch:visc_drag 1.0e3
	clutch:slip_factor 1.0
	clutch:rpm "3800 6000"

RECORD clutch_RENTALKART l_centrifugal_clutch
	pair:left crankshaft_KART
	pair:right clutchshaft_KART
	mat:stiffness 1.0e5
	clutch:torque 30
	mat:damping 0.0
	clutch:visc_drag 1.0e3
	clutch:slip_factor 1.0
	clutch:rpm "750 2000"
	
RECORD clutch_SUPERKART l_centrifugal_clutch
	pair:left crankshaft_KART
	pair:right clutchshaft_KART
	mat:stiffness 1.0e5
	clutch:torque 90
	mat:damping 0.0
	clutch:visc_drag 1.0e3
	clutch:slip_factor 1.0
	clutch:rpm "3800 6000"	

RECORD AWD_LOTUS_56_clutch l_centrifugal_clutch
	pair:left crankshaft_TCR
	pair:right clutchshaft_GT3
	mat:stiffness 1.0e6
	clutch:torque 300
	mat:damping 0.0
	clutch:visc_drag 0.0e-1
	clutch:slip_factor 1.0
	clutch:rpm "15000 55000"

RECORD clutch_GT3_SEMI-AUTO l_centrifugal_clutch
	pair:left crankshaft_GT3
	pair:right clutchshaft_GT3
	mat:stiffness 1.0e6
	clutch:torque 1200
	mat:damping 0.0
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.9
	clutch:rpm "750 2000"

RECORD RWD_AUTOGEARBOX_clutch l_centrifugal_clutch
	pair:left crankshaft_ROAD
	pair:right clutchshaft_GT3
	mat:stiffness 1.0e6
	clutch:torque 1200
	mat:damping 0.0
	clutch:visc_drag 0.0e0
	clutch:slip_factor 1.0
	clutch:rpm "750 2000"

RECORD clutch_TH400_AUTO l_centrifugal_clutch
	pair:left crankshaft_TRUCK
	pair:right clutchshaft_ROAD
	mat:stiffness 1.0e6
	clutch:torque 1000
	mat:damping 0.0
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.9
	clutch:rpm "750 2600"

###############
# Special use Clutches
###############

# Handbrake clutch on rear axle for rallycross
RECORD clutch_RX_rear l_clutch
	pair:left driveshaft_GT3_POST
	pair:right driveshaft_AWD_rear_clutch
	mat:stiffness 1.0e6
	clutch:torque 8000
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.6
	clutch:control "handbrake"
	clutch:play 0.05

# Handbrake clutch on rear axle for AWD cars
RECORD AWD_clutch_rear l_clutch
	pair:left driveshaft_AWD_rear
	pair:right driveshaft_AWD_rear_clutch
	mat:stiffness 1.0e6
	clutch:torque 8000
	mat:damping 0.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.6
	clutch:control "handbrake"
	clutch:play 0.05

# Handbrake clutch/Torque converter fake for F150 Fun Haver
RECORD clutch_F150_rear l_clutch
	pair:left driveshaft_GT3_POST
	pair:right driveshaft_AWD_rear_clutch
	mat:stiffness 1.0e6
	clutch:torque 8000
	mat:damping 1.0e2
	clutch:visc_drag 1.0e3
	clutch:slip_factor 0.6
	clutch:control "handbrake"
	clutch:play 0.05

# Combination foot clutch and centrifugal clutch to help prevent jump starts but disable the foot clutch once rolling
RECORD clutch_SEMI-AUTO_launch_rear l_clutch
	pair:left driveshaft_GT3_POST
	pair:right driveshaft_AWD_rear_clutch
	mat:stiffness 1.0e6
	clutch:torque 8000
	mat:damping 0.0
	clutch:visc_drag 1.0e2
	clutch:slip_factor 1.0

RECORD clutch_SEMI-AUTO_launch_rear_2 l_centrifugal_clutch
	pair:left driveshaft_AWD_rear_clutch
	pair:right driveshaft_GT3_POST
	mat:stiffness 1.0e6
	clutch:torque 2000
	mat:damping 0.0
	clutch:visc_drag 1.0e2
	clutch:slip_factor 1.0
	clutch:rpm "1000 3500"

RECORD clutch_SEMI-AUTO_launch_rear_huayra l_centrifugal_clutch
	pair:left driveshaft_AWD_rear_clutch
	pair:right driveshaft_GT3_POST
	mat:stiffness 1.0e6
	clutch:torque 2000
	mat:damping 0.0
	clutch:visc_drag 1.0e2
	clutch:slip_factor 1.0
	clutch:rpm "1000 5000"

RECORD clutch_SEMI-AUTO_launch_rear_laferrari l_centrifugal_clutch
	pair:left driveshaft_AWD_rear_clutch
	pair:right driveshaft_GT3_POST
	mat:stiffness 1.0e6
	clutch:torque 3000
	mat:damping 0.0
	clutch:visc_drag 1.0e2
	clutch:slip_factor 1.0
	clutch:rpm "1000 6500"

RECORD clutch_SEMI-AUTO_launch_rear_db11 l_centrifugal_clutch
	pair:left driveshaft_AWD_rear_clutch
	pair:right driveshaft_GT3_POST
	mat:stiffness 1.0e6
	clutch:torque 6000
	mat:damping 0.0
	clutch:visc_drag 1.0e2
	clutch:slip_factor 1.0
	clutch:rpm "1000 3500"

# Combination foot clutch and centrifugal clutch to help prevent jump starts but disable the foot clutch once rolling
# On center diff for AWD cars
RECORD clutch_SEMI-AUTO_launch_center l_clutch
	pair:left driveshaft_GT3_POST
	pair:right driveshaft_AWD_center_clutch
	mat:stiffness 1.0e6
	clutch:torque 8000
	mat:damping 0.0
	clutch:visc_drag 1.0e2
	clutch:slip_factor 1.0

RECORD clutch_SEMI-AUTO_launch_center_huracan l_centrifugal_clutch
	pair:left driveshaft_AWD_center_clutch
	pair:right driveshaft_GT3_POST
	mat:stiffness 1.0e6
	clutch:torque 2500
	mat:damping 0.0
	clutch:visc_drag 1.0e2
	clutch:slip_factor 1.0
	clutch:rpm "1500 6500"

RECORD clutch_SEMI-AUTO_launch_center_f-type l_centrifugal_clutch
	pair:left driveshaft_AWD_center_clutch
	pair:right driveshaft_GT3_POST
	mat:stiffness 1.0e6
	clutch:torque 5000
	mat:damping 0.0
	clutch:visc_drag 1.0e2
	clutch:slip_factor 1.0
	clutch:rpm "1000 3700"

# Centrifugal clutch to mimic the active center clutches in the 959 center
RECORD clutch_AWD_PORSCHE_959 l_centrifugal_clutch
	pair:left driveshaft_AWD_front
	pair:right driveshaft_GT3_POST
	mat:stiffness 1.0e6
	clutch:torque 200
	mat:damping 0
	clutch:visc_drag 1.0e2
	clutch:slip_factor 1.0
	clutch:rpm "600 1800"

###############
# Clutch output shaft / Gearbox input shaft
# Bearing adds a bit of drag so it doesn't spin forever when clutch is engaged
# Adding a _POST adds mass on purpose. Added "heft" comes from _POST so 1-part
# clutchshafts maintain original inertia.
###############

## F1
RECORD clutchshaft_F1 shaft
	name "clutchshaft"
	sim:mass 0.005

RECORD clutchshaft_F1_POST shaft
	name "clutchshaft_post"
	sim:mass 0.005

RECORD clutchshaft_strain_F1_flex_ultrastiff l_spring
	pair:left clutchshaft_F1
	pair:right clutchshaft_F1_POST
	mat:stiffness 1.2e4

RECORD clutchshaft_strain_F1_flex l_spring
	pair:left clutchshaft_F1
	pair:right clutchshaft_F1_POST
	mat:stiffness 0.6e4

RECORD clutchshaft_strain_F1_flex_soft l_spring
    pair:left clutchshaft_F1
    pair:right clutchshaft_F1_POST
    mat:stiffness 0.2e4

RECORD clutchshaft_F1_bearing l_bearing
	bearing:shaft clutchshaft_F1
	bearing:friction 3.0e0
	bearing:visc 0
#

## GT3
RECORD clutchshaft_GT3 shaft
	name "clutchshaft"
	sim:mass 0.005

RECORD clutchshaft_GT3_POST shaft
	name "clutchshaft_post"
	sim:mass 0.015

RECORD clutchshaft_strain_GT3_flex l_spring
	pair:left clutchshaft_GT3
	pair:right clutchshaft_GT3_POST
	mat:stiffness 0.6e4

RECORD clutchshaft_strain_GT3_flex_stiff l_spring
	pair:left clutchshaft_GT3
	pair:right clutchshaft_GT3_POST
	mat:stiffness 0.8e4

RECORD clutchshaft_strain_GT3_flex_ultrastiff l_spring
	pair:left clutchshaft_GT3
	pair:right clutchshaft_GT3_POST
	mat:stiffness 1.2e4
	mat:damping 0.1e2

RECORD clutchshaft_strain_GT3_flex_soft l_spring
	pair:left clutchshaft_GT3
	pair:right clutchshaft_GT3_POST
	mat:stiffness 0.4e4

RECORD clutchshaft_strain_GT3_flex_ultrasoft l_spring
	pair:left clutchshaft_GT3
	pair:right clutchshaft_GT3_POST
	mat:stiffness 0.2e4

RECORD clutchshaft_GT3_bearing l_bearing
	bearing:shaft clutchshaft_GT3
	bearing:friction 3.0e0
	bearing:visc 0	
#

## Modern GT, generic mass and flex for GTE/GT3. GT3_POST for compatibility.
RECORD clutchshaft_MODERN-GT shaft
	name "clutchshaft"
	sim:mass 0.025

RECORD clutchshaft_strain_MODERN-GT_flex l_spring
	pair:left clutchshaft_MODERN-GT
	pair:right clutchshaft_GT3_POST
	mat:stiffness 0.8e4

RECORD clutchshaft_strain_MODERN-GT_flex_proto l_spring
	pair:left clutchshaft_MODERN-GT
	pair:right clutchshaft_GT3_POST
	mat:stiffness 0.6e4

RECORD clutchshaft_strain_MODERN-GT_flex_soft l_spring
	pair:left clutchshaft_MODERN-GT
	pair:right clutchshaft_GT3_POST
	mat:stiffness 0.3e4

RECORD clutchshaft_MODERN-GT_bearing l_bearing
	bearing:shaft clutchshaft_MODERN-GT
	bearing:friction 3.0e0
	bearing:visc 0
#

## ROAD
RECORD clutchshaft_ROAD shaft
	name "clutchshaft"
	sim:mass 0.01

RECORD clutchshaft_ROAD_POST shaft
	name "clutchshaft_post"
	sim:mass 0.025

RECORD clutchshaft_strain_ROAD_flex l_spring
	pair:left clutchshaft_ROAD
	pair:right clutchshaft_ROAD_POST
	mat:stiffness 0.3e4

RECORD clutchshaft_strain_ROAD_flex_stiff l_spring
	pair:left clutchshaft_ROAD
	pair:right clutchshaft_ROAD_POST
	mat:stiffness 0.5e4

RECORD clutchshaft_strain_ROAD_flex_ultrastiff l_spring
	pair:left clutchshaft_ROAD
	pair:right clutchshaft_ROAD_POST
	mat:stiffness 1.4e4

RECORD clutchshaft_strain_ROAD_flex_ftruck l_spring
	pair:left clutchshaft_ROAD
	pair:right clutchshaft_ROAD_POST
	mat:stiffness 2.0e4

RECORD clutchshaft_ROAD_bearing l_bearing
	bearing:shaft clutchshaft_ROAD
	bearing:friction 3.0e0
	bearing:visc 0
#

## TRUCK
RECORD clutchshaft_TRUCK shaft
	name "clutchshaft"
	sim:mass 0.01	

RECORD clutchshaft_TRUCK_bearing l_bearing
	bearing:shaft clutchshaft_TRUCK
	bearing:friction 5.0e0
	bearing:visc 0
#

## KART
RECORD clutchshaft_KART shaft
	name "clutchshaft"
	sim:mass 0.005

RECORD clutchshaft_KART_bearing l_bearing
	bearing:shaft clutchshaft_KART
	bearing:friction 5.0e-1
	bearing:visc 0
#





###############
# Gearboxes
###############

# GT3 gearbox will be calibrated to act like a modern sequential.  Should work as a common unit for most modern race cars.
RECORD gearbox_GT3 l_gearbox
	pair:left clutchshaft_GT3
	pair:right driveshaft_GT3
	mat:stiffness 8.0e5
	mat:damping 0.0e2
	gb:synchro "2.0e1 0.15 250"
	gb:wear_rate "0.0e4 0.0 0.0"
	gear:ratio "gear"

RECORD gearbox_GT3_POST_GT-FR_flex l_gearbox
	pair:left clutchshaft_GT3_POST
	pair:right driveshaft_GT-FR
	mat:stiffness 4.0e4
	mat:damping 0.0e2
	gb:synchro "2.0e1 1.0e-7 1000" # No synchro phase
	gb:wear_rate "0.0e4 0.0 0.0"
	gear:ratio "gear"

RECORD gearbox_GT3_POST_GT-MR_flex l_gearbox
	pair:left clutchshaft_GT3_POST
	pair:right driveshaft_GT-MR
	mat:stiffness 1.0e4
	mat:damping 0.0e2
	gb:synchro "2.0e1 1.0e-7 1000" # No synchro phase
	gb:wear_rate "0.0e4 0.0 0.0"
	gear:ratio "gear"

# Notice the no clutchshaft_POST
RECORD gearbox_GT3_GT-MR_flex l_gearbox
	pair:left clutchshaft_GT3
	pair:right driveshaft_GT-MR
	mat:stiffness 1.0e4
	mat:damping 0.0e2
	gb:synchro "2.0e1 1.0e-7 1000" # No synchro phase
	gb:wear_rate "0.0e4 0.0 0.0"
	gear:ratio "gear"

RECORD gearbox_GT3_POST_LIGHT_flex l_gearbox
	pair:left clutchshaft_GT3_POST
	pair:right driveshaft_LIGHT
	# Stiffness baseline is 4.0e4
	mat:stiffness 4.0e4
	mat:damping 0.0e2
	gb:synchro "2.0e1 0.15 250"
	gb:wear_rate "0.0e4 0.0 0.0"
	gear:ratio "gear"

RECORD gearbox_GT3_POST_LIGHT_instant_flex l_gearbox
	pair:left clutchshaft_GT3_POST
	pair:right driveshaft_LIGHT
	# Stiffness baseline is 4.0e4
	mat:stiffness 4.0e4
	mat:damping 0.0e2
	gb:synchro "2.0e1 1.0e-7 1000" # No synchro phase
	gb:wear_rate "0.0e4 0.0 0.0"
	gear:ratio "gear"

RECORD gearbox_F1_POST_F1_flex l_gearbox
	pair:left clutchshaft_F1_POST
	pair:right driveshaft_F1
	# Stiffness baseline is 4.0e4
	mat:stiffness 1.5e4
	mat:damping 0.0e2
	gb:synchro "2.0e1 1.0e-7 1000" # No synchro phase
	gb:wear_rate "0.0e4 0.0 0.0"
	gear:ratio "gear"

RECORD gearbox_F1_POST_F1_flex_soft l_gearbox
	pair:left clutchshaft_F1_POST
	pair:right driveshaft_F1
	# Stiffness baseline is 4.0e4
	mat:stiffness 1.0e4
	mat:damping 0.0e2
	gb:synchro "2.0e1 1.0e-7 1000" # No synchro phase
	gb:wear_rate "0.0e4 0.0 0.0"
	gear:ratio "gear"

RECORD gearbox_GT3_POST_MEDIUM-LIGHT_flex l_gearbox
	pair:left clutchshaft_GT3_POST
	pair:right driveshaft_MEDIUM-LIGHT
	# Stiffness baseline is 4.0e4
	mat:stiffness 4.0e4
	mat:damping 0.0e2
	gb:synchro "2.0e1 0.15 250"
	gb:wear_rate "0.0e4 0.0 0.0"
	gear:ratio "gear"

RECORD gearbox_GT3_POST_MEDIUM-LIGHT_flex_soft l_gearbox
	pair:left clutchshaft_GT3_POST
	pair:right driveshaft_MEDIUM-LIGHT
	# Stiffness baseline is 4.0e4
	mat:stiffness 1.0e4
	mat:damping 0.0e2
	gb:synchro "2.0e1 0.15 250"
	gb:wear_rate "0.0e4 0.0 0.0"
	gear:ratio "gear"
#

# Basic Hewland-type gearbox for older race cars.  Maybe no synchro effect at all but large tolerance range for the dog faces to engage.
RECORD gearbox_Hewland l_gearbox
	pair:left clutchshaft_GT3
	pair:right driveshaft_GT3
	mat:stiffness 8.0e5
	mat:damping 0.0e2
	gb:synchro "2.0e1 0.15 250"
	gb:wear_rate "0.0e4 0.0 0.0"
	gear:ratio "gear"

RECORD gearbox_Hewland_F1_POST_GT-MR_flex l_gearbox
	pair:left clutchshaft_F1_POST
	pair:right driveshaft_GT-MR
	mat:stiffness 1.0e4
	mat:damping 0.0e2
	gb:synchro "2.0e1 1.0e-7 1000" # No synchro phase
	gb:wear_rate "0.0e4 0.0 0.0"
	gear:ratio "gear"

RECORD gearbox_Hewland_GT3_POST_F1_flex l_gearbox
	pair:left clutchshaft_GT3_POST
	pair:right driveshaft_F1
	mat:stiffness 1.0e4
	mat:damping 0.0e2
	gb:synchro "2.0e1 0.15 250"
	gb:wear_rate "0.0e4 0.0 0.0"
	gear:ratio "gear"

RECORD gearbox_Hewland_F1_POST_F1_flex l_gearbox
	pair:left clutchshaft_F1_POST
	pair:right driveshaft_F1
	mat:stiffness 1.0e4
	mat:damping 0.0e2
	gb:synchro "2.0e1 1.0e-7 1000" # No synchro phase
	gb:wear_rate "0.0e4 0.0 0.0"
	gear:ratio "gear"
	
RECORD gearbox_TRUCK l_gearbox
	pair:left clutchshaft_TRUCK
	pair:right driveshaft_TRUCK
	mat:stiffness 12.0e5
	mat:damping 0.0e2
	gb:synchro "1.0e2 0.50 175"
	gb:wear_rate "0.0e4 0.0 0.0"
	gear:ratio "gear"	

RECORD gearbox_DBR1 l_gearbox
	pair:left clutchshaft_GT3
	pair:right driveshaft_GT3
	mat:stiffness 0.8e4
	mat:damping 0.0
	gear:ratio "gear"
	gb:synchro "1.0e3 0.50 5"
	gb:wear_rate "0.0e4 0.0 0.0"
#

# Full synchro H-pattern box, mostly for road cars
# Pairs with ROAD parts with exceptions
RECORD gearbox_H-pattern_synchro l_gearbox
	pair:left clutchshaft_ROAD
	pair:right driveshaft_ROAD
	mat:stiffness 8.0e5
	mat:damping 0.0e2
	gb:synchro "1.0e2 0.50 175"
	gb:wear_rate "0.0e4 0.0 0.0"
	gear:ratio "gear"

RECORD gearbox_H-pattern_synchro_GT3_POST_LIGHT_flex l_gearbox
    pair:left clutchshaft_GT3_POST
    pair:right driveshaft_LIGHT
    # Stiffness baseline is 4.0e4
    mat:stiffness 1.0e4
    mat:damping 0.0e2
    gb:synchro "1.0e2 0.50 175"
    gb:wear_rate "0.0e4 0.0 0.0"
    gear:ratio "gear"

RECORD gearbox_H-pattern_synchro_POST_GT-FR_flex l_gearbox
    pair:left clutchshaft_GT3_POST
    pair:right driveshaft_GT-FR
    # Stiffness baseline is 4.0e4
    mat:stiffness 1.0e4
    mat:damping 0.0e2
    gb:synchro "1.0e2 0.50 175"
    gb:wear_rate "0.0e4 0.0 0.0"
    gear:ratio "gear"

RECORD gearbox_H-pattern_synchro_POST_ROAD-FR_flex l_gearbox
    pair:left clutchshaft_ROAD_POST
    pair:right driveshaft_ROAD-FR
    # Stiffness baseline is 4.0e4
    mat:stiffness 1.0e4
    mat:damping 0.0e2
    gb:synchro "1.0e2 0.50 175"
    gb:wear_rate "0.0e4 0.0 0.0"
    gear:ratio "gear"

RECORD gearbox_H-pattern_synchro_POST_ROAD-MR_flex l_gearbox
    pair:left clutchshaft_ROAD_POST
    pair:right driveshaft_ROAD-MR
    # Stiffness baseline is 4.0e4
    mat:stiffness 1.0e4
    mat:damping 0.0e2
    gb:synchro "1.0e2 0.50 175"
    gb:wear_rate "0.0e4 0.0 0.0"
    gear:ratio "gear"

RECORD gearbox_H-pattern_synchro_POST_MEDIUM-ROAD_flex l_gearbox
    pair:left clutchshaft_ROAD_POST
    pair:right driveshaft_MEDIUM-ROAD
    # Stiffness baseline is 4.0e4
    mat:stiffness 4.0e4
    mat:damping 0.0e2
    gb:synchro "1.0e2 0.50 175"
    gb:wear_rate "0.0e4 0.0 0.0"
    gear:ratio "gear"

RECORD gearbox_H-pattern_synchro_POST_HEAVY_flex l_gearbox
	pair:left clutchshaft_ROAD_POST
	pair:right driveshaft_HEAVY
	mat:stiffness 2.0e4
	mat:damping 0.0e2
	gb:synchro "1.0e2 0.50 175"
	gb:wear_rate "0.0e4 0.0 0.0"
	gear:ratio "gear"

RECORD gearbox_H-pattern_synchro_POST_TRUCK_flex l_gearbox
	pair:left clutchshaft_ROAD_POST
	pair:right driveshaft_TRUCK
	mat:stiffness 8.0e4
	mat:damping 0.0e2
	gb:synchro "1.0e2 0.50 175"
	gb:wear_rate "0.0e4 0.0 0.0"
	gear:ratio "gear"
#

# Full-synchro, automated manual box, mostly for road cars
RECORD gearbox_AMT_synchro l_gearbox
	pair:left clutchshaft_GT3
	pair:right driveshaft_GT3
	mat:stiffness 1.0e6
	mat:damping 0.0e2
	gb:synchro "1.0e3 0.50 5"
	gb:wear_rate "0.0e4 0.0 0.0"
	gear:ratio "gear"

RECORD gearbox_AMT_synchro_MEDIUM-LIGHT_flex_stiff l_gearbox
	pair:left clutchshaft_GT3
	pair:right driveshaft_MEDIUM-LIGHT
	# Stiffness baseline is 4.0e4
	mat:stiffness 8.0e4
	mat:damping 0.0e2
	gb:synchro "1.0e3 0.50 5"
	gb:wear_rate "0.0e4 0.0 0.0"
	gear:ratio "gear"

RECORD gearbox_KART l_gearbox
	pair:left clutchshaft_KART
	pair:right driveshaft_KART
	mat:stiffness 1.0e4
	mat:damping 0.0e2
	gb:synchro "2.0e1 0.50 150"
	gb:wear_rate "0.0e4 0.0 0.0"
	gear:ratio "gear"





###############
# Driveshafts, output from gearbox
###############

##
## Original driveshafts for compatibility
##
RECORD driveshaft_GT3 shaft
	name "driveshaft"
	sim:mass 0.05

RECORD driveshaft_ROAD shaft
	name "driveshaft"
	sim:mass 0.1
	
RECORD driveshaft_TRUCK shaft
	name "driveshaft"
	sim:mass 0.3

#
# New driveshafts for different inertias.
#
# Unfortunately these need a new gearbox and strain gauge to match.
#

## GT3
RECORD driveshaft_F1 shaft
	name "driveshaft"
	sim:mass 0.01

RECORD driveshaft_GT-FR shaft
	name "driveshaft"
	sim:mass 0.015

RECORD driveshaft_GT-MR shaft
	name "driveshaft"
	sim:mass 0.01

RECORD driveshaft_LIGHT shaft
	name "driveshaft"
	sim:mass 0.01

RECORD driveshaft_MEDIUM-LIGHT shaft
	name "driveshaft"
	sim:mass 0.075
#	

## ROAD
RECORD driveshaft_ROAD-FR shaft
	name "driveshaft"
	sim:mass 0.025

RECORD driveshaft_ROAD-MR shaft
	name "driveshaft"
	sim:mass 0.015

RECORD driveshaft_HEAVY shaft
	name "driveshaft"
	sim:mass 0.040

RECORD driveshaft_MEDIUM-ROAD shaft
	name "driveshaft"
	sim:mass 0.025
#


# Driveshaft strain gauge
#
# Naming scheme:
# driveshaft_strain_gauge
# _TYPE (optional)
# _flex (optional)
# _softness (optional)
#
# Note that all strain gauges right pair to either GT3 or ROAD type POST.
# There's really little need to control the weight of that seperately.
# Adding new POST shafts would also require new diffs.
#

## GT3 strain gauge, off pattern naming for historical reasons
RECORD driveshaft_strain_gauge l_spring
	name "strain_transmission"
	pair:left driveshaft_GT3
	pair:right driveshaft_GT3_POST

RECORD driveshaft_strain_gauge_flex_stiff l_spring
	name "strain_transmission"
	pair:left driveshaft_GT3
	pair:right driveshaft_GT3_POST
	# Baseline stiffness is between 1.0e3 and 3.0e3, slightly softer
	mat:stiffness 3.0e3
	# Also dampened for cars that otherwise vibrate the shaft
	mat:damping 0.1e2
	
RECORD driveshaft_strain_gauge_flex_soft l_spring
	name "strain_transmission"
	pair:left driveshaft_GT3
	pair:right driveshaft_GT3_POST
	# Baseline stiffness is between 1.0e3 and 3.0e3, slightly softer
	mat:stiffness 2.0e3
#

## ROAD strain gauges
RECORD driveshaft_strain_gauge_ROAD l_spring
	name "strain_transmission"
	pair:left driveshaft_ROAD
	pair:right driveshaft_ROAD_POST
#

## F1, to GT3_POST
RECORD driveshaft_strain_gauge_F1_flex_waxle_soft l_spring
	name "strain_transmission"
	pair:left driveshaft_F1
	pair:right driveshaft_GT3_POST
	mat:stiffness 2.0e3

RECORD driveshaft_strain_gauge_F1_flex_waxle l_spring
	name "strain_transmission"
	pair:left driveshaft_F1
	pair:right driveshaft_GT3_POST
	mat:stiffness 3.5e3

RECORD driveshaft_strain_gauge_F1_flex_waxle_stiff l_spring
	name "strain_transmission"
	pair:left driveshaft_F1
	pair:right driveshaft_GT3_POST
	mat:stiffness 6.0e3

## GT-FR/GT-MR, to GT3_POST
RECORD driveshaft_strain_gauge_GT-FR_flex l_spring
	name "strain_transmission"
	pair:left driveshaft_GT-FR
	pair:right driveshaft_GT3_POST
	mat:stiffness 4.0e3

RECORD driveshaft_strain_gauge_GT-FR_flex_waxle l_spring
	name "strain_transmission"
	pair:left driveshaft_GT-FR
	pair:right driveshaft_GT3_POST
	mat:stiffness 7.5e3

RECORD driveshaft_strain_gauge_GT-FR_flex_waxle_soft l_spring
	name "strain_transmission"
	pair:left driveshaft_GT-FR
	pair:right driveshaft_GT3_POST
	mat:stiffness 5.0e3

RECORD driveshaft_strain_gauge_GT-FR_flex_waxle_ultrasoft l_spring
	name "strain_transmission"
	pair:left driveshaft_GT-FR
	pair:right driveshaft_GT3_POST
	mat:stiffness 3.5e3

RECORD driveshaft_strain_gauge_GT-MR_flex l_spring
	name "strain_transmission"
	pair:left driveshaft_GT-MR
	pair:right driveshaft_GT3_POST
	mat:stiffness 1.3e4

RECORD driveshaft_strain_gauge_GT-MR_flex_soft l_spring
	name "strain_transmission"
	pair:left driveshaft_GT-MR
	pair:right driveshaft_GT3_POST
	mat:stiffness 7.5e3

RECORD driveshaft_strain_gauge_GT-MR_flex_ultrasoft l_spring
	name "strain_transmission"
	pair:left driveshaft_GT-MR
	pair:right driveshaft_GT3_POST
	mat:stiffness 3.5e3

## LIGHT, to GT3_POST
RECORD driveshaft_strain_gauge_LIGHT_flex l_spring
	name "strain_transmission"
	pair:left driveshaft_LIGHT
	pair:right driveshaft_GT3_POST
	mat:stiffness 1.25e3

RECORD driveshaft_strain_gauge_LIGHT_flex_stiff l_spring
	name "strain_transmission"
	pair:left driveshaft_LIGHT
	pair:right driveshaft_GT3_POST
	mat:stiffness 1.75e3

RECORD driveshaft_strain_gauge_LIGHT_flex_ultrastiff l_spring
	name "strain_transmission"
	pair:left driveshaft_LIGHT
	pair:right driveshaft_GT3_POST
	mat:stiffness 4.00e3

RECORD driveshaft_strain_gauge_LIGHT_flex_waxle l_spring
	name "strain_transmission"
	pair:left driveshaft_LIGHT
	pair:right driveshaft_GT3_POST
	mat:stiffness 4.00e3

RECORD driveshaft_strain_gauge_LIGHT_flex_ultraultrastiff l_spring
	name "strain_transmission"
	pair:left driveshaft_LIGHT
	pair:right driveshaft_GT3_POST
	mat:stiffness 7.50e3

RECORD driveshaft_strain_gauge_LIGHT_flex_soft l_spring
	name "strain_transmission"
	pair:left driveshaft_LIGHT
	pair:right driveshaft_GT3_POST
	mat:stiffness 1.00e3
#

## MEDIUM-LIGHT, to GT3_POST
RECORD driveshaft_strain_gauge_MEDIUM-LIGHT_flex_soft l_spring
	name "strain_transmission"
	pair:left driveshaft_MEDIUM-LIGHT
	pair:right driveshaft_GT3_POST
	mat:stiffness 2.0e3

RECORD driveshaft_strain_gauge_MEDIUM-LIGHT_flex l_spring
	name "strain_transmission"
	pair:left driveshaft_MEDIUM-LIGHT
	pair:right driveshaft_GT3_POST
	mat:stiffness 2.5e3

RECORD driveshaft_strain_gauge_MEDIUM-LIGHT_flex_stiff l_spring
	name "strain_transmission"
	pair:left driveshaft_MEDIUM-LIGHT
	pair:right driveshaft_GT3_POST
	mat:stiffness 2.75e3

RECORD driveshaft_strain_gauge_MEDIUM-LIGHT_flex_ultrastiff l_spring
	name "strain_transmission"
	pair:left driveshaft_MEDIUM-LIGHT
	pair:right driveshaft_GT3_POST
	mat:stiffness 3.0e3
#

## ROAD-FR/MR, to ROAD_POST
RECORD driveshaft_strain_gauge_ROAD-FR_flex l_spring
	name "strain_transmission"
	pair:left driveshaft_ROAD-FR
	pair:right driveshaft_ROAD_POST
	mat:stiffness 6.0e3

RECORD driveshaft_strain_gauge_ROAD-FR_flex_soft l_spring
	name "strain_transmission"
	pair:left driveshaft_ROAD-FR
	pair:right driveshaft_ROAD_POST
	mat:stiffness 4.0e3

RECORD driveshaft_strain_gauge_ROAD-MR_flex l_spring
	name "strain_transmission"
	pair:left driveshaft_ROAD-MR
	pair:right driveshaft_ROAD_POST
	mat:stiffness 7.0e3

## MEDIUM_ROAD, to ROAD_POST
RECORD driveshaft_strain_gauge_MEDIUM-ROAD_flex l_spring
	name "strain_transmission"
	pair:left driveshaft_MEDIUM-ROAD
	pair:right driveshaft_ROAD_POST
	mat:stiffness 1.5e3

RECORD driveshaft_strain_gauge_MEDIUM-ROAD_flex_stiff l_spring
	name "strain_transmission"
	pair:left driveshaft_MEDIUM-ROAD
	pair:right driveshaft_ROAD_POST
	mat:stiffness 2.0e3

RECORD driveshaft_strain_gauge_MEDIUM-ROAD_flex_ultrastiff l_spring
	name "strain_transmission"
	pair:left driveshaft_MEDIUM-ROAD
	pair:right driveshaft_ROAD_POST
	mat:stiffness 3.0e3
#

## HEAVY, from HEAVY to ROAD_POST.
RECORD driveshaft_strain_gauge_HEAVY_flex_waxle l_spring
	name "strain_transmission"
	pair:left driveshaft_HEAVY
	pair:right driveshaft_ROAD_POST
	mat:stiffness 7.5e3

RECORD driveshaft_strain_gauge_HEAVY_flex_waxle_soft l_spring
	name "strain_transmission"
	pair:left driveshaft_HEAVY
	pair:right driveshaft_ROAD_POST
	mat:stiffness 5.0e3

## TRUCK, from TRUCK to ROAD_POST.
RECORD driveshaft_strain_gauge_TRUCK_flex_ultrastiff l_spring
	name "strain_transmission"
	pair:left driveshaft_TRUCK
	pair:right driveshaft_ROAD_POST
	mat:stiffness 2.25e4
#


## Driveshaft POSTs. These are reused as much as possible to prevent needing
## new diffs. Strain gauges can be created to connect different type of
## driveshaft and POST.
RECORD driveshaft_GT3_POST shaft
	name "driveshaft_post"
	sim:mass 0.05

RECORD driveshaft_ROAD_POST shaft
	name "driveshaft_post"
	sim:mass 0.05

RECORD driveshaft_TRUCK_POST shaft
	name "driveshaft_post"
	sim:mass 0.20
#

## Special shafts
RECORD driveshaft_AWD_front shaft
	name "driveshaft_AWD_front"
	sim:mass 0.1

RECORD driveshaft_AWD_rear shaft
	name "driveshaft_AWD_rear"
	sim:mass 0.1

RECORD driveshaft_AWD_RX_rear shaft
	name "driveshaft_AWD_RX_rear"
	sim:mass 0.05

RECORD driveshaft_AWD_rear_clutch shaft
	name "driveshaft_AWD_rear_clutch"
	sim:mass 0.05

RECORD driveshaft_AWD_center_clutch shaft
	name "driveshaft_AWD_center_clutch"
	sim:mass 0.05

RECORD driveshaft_KART shaft
	name "driveshaft"
	sim:mass 0.005

# Gearbox strain gauge
RECORD driveshaft_KART_strain_gauge l_spring
	name "strain_transmission"
	pair:left driveshaft_KART
	pair:right driveshaft_KART_POST
	mat:stiffness 1.0e6

RECORD driveshaft_KART_POST shaft
	name "driveshaft_post"
	sim:mass 0.005
#




###############
# Differentials
###############

RECORD AWD_front_diff amalgam_diff
	pair:left wheel_FL_internal
	pair:right wheel_FR_internal
	diff:shaft driveshaft_AWD_front
	diff:planet planet_gear_front
	mat:stiffness 1.0e6
	diff:drag "0.0 0.0 0.0"
	mat:flags 0
	# Torsen
	diff:gear_lsd "F_gear_lsd"
	diff:bias_ratio "F_bias_power F_bias_coast"
	diff:right_ratio 0.5
	# Salisbury
	diff:clutch_lsd  "F_clutch_lsd"
	diff:preload "F_preload"
	diff:ramp_angle "F_ramp_angle_power F_ramp_angle_coast"
	diff:lock_per_clutch 0.030
	diff:clutches "F_clutches"
	diff:clutch_slip_factor 1.5
	# VLSD
	diff:visc_lsd "F_viscous_lsd"
	diff:visc_locking "F_viscous_locking"
	diff:visc_hump "0.0 390.0"
	diff:visc_degrade "0.0 300.0"
	diff:visc_fail 1000.0
	diff:visc_heating "0.0 0.0"
	# Ratchet
	diff:ratchet_lsd "F_ratchet"
	# final drive
	dl:ratio "drive"

RECORD AWD_center_diff amalgam_diff
	pair:left driveshaft_AWD_front
	pair:right driveshaft_AWD_rear
	diff:shaft driveshaft_GT3_POST
	diff:planet planet_gear_center
	mat:stiffness 1.0e6
	diff:drag "0.0 0.0 0.0"
	mat:flags 0
	# Torsen
	diff:gear_lsd "C_gear_lsd"
	diff:bias_ratio "C_bias_power C_bias_coast"
	diff:right_ratio "C_right_ratio"
	# Salisbury
	diff:clutch_lsd  "C_clutch_lsd"
	diff:preload "C_preload"
	diff:ramp_angle "C_ramp_angle_power C_ramp_angle_coast"
	diff:lock_per_clutch 0.030
	diff:clutches "C_clutches"
	diff:clutch_slip_factor 1.5
	# VLSD
	diff:visc_lsd "C_viscous_lsd"
	diff:visc_locking "C_viscous_locking"
	diff:visc_hump "0.0 390.0"
	diff:visc_degrade "0.0 300.0"
	diff:visc_fail 1000.0
	diff:visc_heating "0.0 0.0"
	# Ratchet
	diff:ratchet_lsd "C_ratchet"

RECORD AWD_center_SEMI-AUTO_diff amalgam_diff
	pair:left driveshaft_AWD_front
	pair:right driveshaft_AWD_rear
	diff:shaft driveshaft_AWD_center_clutch
	diff:planet planet_gear_center
	mat:stiffness 1.0e6
	diff:drag "0.0 0.0 0.0"
	mat:flags 0
	# Torsen
	diff:gear_lsd "C_gear_lsd"
	diff:bias_ratio "C_bias_power C_bias_coast"
	diff:right_ratio "C_right_ratio"
	# Salisbury
	diff:clutch_lsd  "C_clutch_lsd"
	diff:preload "C_preload"
	diff:ramp_angle "C_ramp_angle_power C_ramp_angle_coast"
	diff:lock_per_clutch 0.030
	diff:clutches "C_clutches"
	diff:clutch_slip_factor 1.5
	# VLSD
	diff:visc_lsd "C_viscous_lsd"
	diff:visc_locking "C_viscous_locking"
	diff:visc_hump "0.0 390.0"
	diff:visc_degrade "0.0 300.0"
	diff:visc_fail 1000.0
	diff:visc_heating "0.0 0.0"
	# Ratchet
	diff:ratchet_lsd "C_ratchet"

RECORD AWD_rear_diff amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft_AWD_rear_clutch
	diff:planet planet_gear_rear
	mat:stiffness 1.0e6
	diff:drag "0.0 0.0 0.0"
	mat:flags 0
	# Torsen
	diff:gear_lsd "R_gear_lsd"
	diff:bias_ratio "R_bias_power R_bias_coast"
	diff:right_ratio 0.5
	# Salisbury
	diff:clutch_lsd  "R_clutch_lsd"
	diff:preload "R_preload"
	diff:ramp_angle "R_ramp_angle_power R_ramp_angle_coast"
	diff:lock_per_clutch 0.030
	diff:clutches "R_clutches"
	diff:clutch_slip_factor 1.5
	# VLSD
	diff:visc_lsd "R_viscous_lsd"
	diff:visc_locking "R_viscous_locking"
	diff:visc_hump "0.0 390.0"
	diff:visc_degrade "0.0 300.0"
	diff:visc_fail 1000.0
	diff:visc_heating "0.0 0.0"
	# Ratchet
	diff:ratchet_lsd "R_ratchet"
	# final drive
	dl:ratio "drive"

RECORD AWD_front_diff_v3 amalgam_diff
	pair:left wheel_FL_internal
	pair:right wheel_FR_internal
	diff:shaft driveshaft_AWD_front
	diff:planet planet_gear_front
	mat:stiffness 1.0e6
	diff:drag "0.0 0.0 0.0"
	mat:flags 0
	diff:model_version 3.0	
	# Torsen
	diff:gear_lsd "F_gear_lsd"
	diff:bias_ratio "F_bias_power F_bias_coast"
	diff:right_ratio 0.5
	# Salisbury
	diff:clutch_lsd  "F_clutch_lsd"
	diff:preload "F_preload"
	diff:ramp_angle "F_ramp_angle_power F_ramp_angle_coast"
	diff:lock_per_clutch 0.040
	diff:clutches "F_clutches"
	diff:clutch_slip_factor 1.5
	# VLSD
	diff:visc_lsd "F_viscous_lsd"
	diff:visc_locking "F_viscous_locking"
	diff:visc_hump "0.0 390.0"
	diff:visc_degrade "0.0 300.0"
	diff:visc_fail 1000.0
	diff:visc_heating "0.0 0.0"
	# Ratchet
	diff:ratchet_lsd "F_ratchet"
	# final drive
	dl:ratio "drive"
	
RECORD AWD_center_diff_v3 amalgam_diff
	pair:left driveshaft_AWD_front
	pair:right driveshaft_AWD_rear
	diff:shaft driveshaft_GT3_POST
	diff:planet planet_gear_center
	mat:stiffness 1.0e6
	diff:drag "0.0 0.0 0.0"
	mat:flags 0
	diff:model_version 3.0	
	# Torsen
	diff:gear_lsd "C_gear_lsd"
	diff:bias_ratio "C_bias_power C_bias_coast"
	diff:right_ratio "C_right_ratio"
	# Salisbury
	diff:clutch_lsd  "C_clutch_lsd"
	diff:preload "C_preload"
	diff:ramp_angle "C_ramp_angle_power C_ramp_angle_coast"
	diff:lock_per_clutch 0.040
	diff:clutches "C_clutches"
	diff:clutch_slip_factor 1.5
	# VLSD
	diff:visc_lsd "C_viscous_lsd"
	diff:visc_locking "C_viscous_locking"
	diff:visc_hump "0.0 390.0"
	diff:visc_degrade "0.0 300.0"
	diff:visc_fail 1000.0
	diff:visc_heating "0.0 0.0"
	# Ratchet
	diff:ratchet_lsd "C_ratchet"	

RECORD AWD_rear_diff_v3 amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft_AWD_rear_clutch
	diff:planet planet_gear_rear
	mat:stiffness 1.0e6
	diff:drag "0.0 0.0 0.0"
	mat:flags 0
	diff:model_version 3.0	
	# Torsen
	diff:gear_lsd "R_gear_lsd"
	diff:bias_ratio "R_bias_power R_bias_coast"
	diff:right_ratio 0.5
	# Salisbury
	diff:clutch_lsd  "R_clutch_lsd"
	diff:preload "R_preload"
	diff:ramp_angle "R_ramp_angle_power R_ramp_angle_coast"
	diff:lock_per_clutch 0.040
	diff:clutches "R_clutches"
	diff:clutch_slip_factor 1.5
	# VLSD
	diff:visc_lsd "R_viscous_lsd"
	diff:visc_locking "R_viscous_locking"
	diff:visc_hump "0.0 390.0"
	diff:visc_degrade "0.0 300.0"
	diff:visc_fail 1000.0
	diff:visc_heating "0.0 0.0"
	# Ratchet
	diff:ratchet_lsd "R_ratchet"
	# final drive
	dl:ratio "drive"

RECORD FWD_front_diff amalgam_diff
	pair:left wheel_FL_internal
	pair:right wheel_FR_internal
	diff:shaft driveshaft_GT3_POST
	diff:planet planet_gear_front
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	# Salisbury
	diff:clutch_lsd  "F_clutch_lsd"
	diff:preload "F_preload"
	diff:ramp_angle "F_ramp_angle_power F_ramp_angle_coast"
	diff:lock_per_clutch 0.030
	diff:clutches "F_clutches"
	diff:clutch_slip_factor 1.2
	# final drive
	dl:ratio "drive"
	
RECORD FWD_front_diff_v3 amalgam_diff
	pair:left wheel_FL_internal
	pair:right wheel_FR_internal
	diff:shaft driveshaft_GT3_POST
	diff:planet planet_gear_front
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	diff:model_version 3.0
	# Salisbury
	diff:clutch_lsd  "F_clutch_lsd"
	diff:preload "F_preload"
	diff:ramp_angle "F_ramp_angle_power F_ramp_angle_coast"
	diff:lock_per_clutch 0.070
	diff:clutches "F_clutches"
	diff:clutch_slip_factor 1.5
	# final drive
	dl:ratio "drive"	

RECORD RWD_rear_diff amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft_GT3_POST
	diff:planet planet_gear_rear
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	# Salisbury
	diff:clutch_lsd  "R_clutch_lsd"
	diff:preload "R_preload"
	diff:ramp_angle "R_ramp_angle_power R_ramp_angle_coast"
	diff:lock_per_clutch 0.035
	diff:clutches "R_clutches"
	diff:clutch_slip_factor 1.5
	# final drive
	dl:ratio "drive"
	
RECORD RWD_rear_diff_v3 amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft_GT3_POST
	diff:planet planet_gear_rear
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	diff:model_version 3.0
	# Salisbury
	diff:clutch_lsd  "R_clutch_lsd"
	diff:preload "R_preload"
	diff:ramp_angle "R_ramp_angle_power R_ramp_angle_coast"
	diff:lock_per_clutch 0.030
	diff:clutches "R_clutches"
	diff:clutch_slip_factor 1.5
	# final drive
	dl:ratio "drive"	

RECORD RWD_light_rear_diff amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft_GT3_POST
	diff:planet planet_gear_rear
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	# Salisbury
	diff:clutch_lsd  "R_clutch_lsd"
	diff:preload "R_preload"
	diff:ramp_angle "R_ramp_angle_power R_ramp_angle_coast"
	diff:lock_per_clutch 0.030
	diff:clutches "R_clutches"
	diff:clutch_slip_factor 1.5
	# final drive
	dl:ratio "drive"

RECORD RWD_light_rear_diff_v3 amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft_GT3_POST
	diff:planet planet_gear_rear
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	diff:model_version 3.0
	# Salisbury
	diff:clutch_lsd  "R_clutch_lsd"
	diff:preload "R_preload"
	diff:ramp_angle "R_ramp_angle_power R_ramp_angle_coast"
	diff:lock_per_clutch 0.040
	diff:clutches "R_clutches"
	diff:clutch_slip_factor 1.5
	# final drive
	dl:ratio "drive"

RECORD RWD_CART_rear_diff_v3 amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft_GT3_POST
	diff:planet planet_gear_rear
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	diff:model_version 3.0
	# Salisbury
	diff:clutch_lsd  "R_clutch_lsd"
	diff:preload "R_preload"
	diff:ramp_angle "R_ramp_angle_power R_ramp_angle_coast"
	diff:lock_per_clutch 0.030
	diff:clutches "R_clutches"
	diff:clutch_slip_factor 1.5
	# final drive
	dl:ratio "drive"

RECORD RWD_FUSA_rear_diff_v3 amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft_GT3_POST
	diff:planet planet_gear_rear
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	diff:model_version 3.0
	# Salisbury
	diff:clutch_lsd  "R_clutch_lsd"
	diff:preload "R_preload"
	diff:ramp_angle "R_ramp_angle_power R_ramp_angle_coast"
	diff:lock_per_clutch 0.030
	diff:clutches "R_clutches"
	diff:clutch_slip_factor 1.5
	# final drive
	dl:ratio "drive"

RECORD RWD_VLSD_rear_diff amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft_GT3_POST
	diff:planet planet_gear_rear
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	# Salisbury
	diff:clutch_lsd  "R_clutch_lsd"
	diff:preload "R_preload"
	diff:ramp_angle "R_ramp_angle_power R_ramp_angle_coast"
	diff:lock_per_clutch 0.030
	diff:clutches "R_clutches"
	diff:clutch_slip_factor 1.5
	# VLSD
	diff:visc_lsd "R_viscous_lsd"
	diff:visc_locking "R_viscous_locking"
	diff:visc_hump "0.0 390.0"
	diff:visc_degrade "0.0 300.0"
	diff:visc_fail 1000.0
	diff:visc_heating "0.0 0.0"
	# Ratchet
	diff:ratchet_lsd "R_ratchet"
	# final drive
	dl:ratio "drive"
	
RECORD RWD_VLSD_rear_diff_v3 amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft_GT3_POST
	diff:planet planet_gear_rear
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	diff:model_version 3.0
	# Salisbury
	diff:clutch_lsd  "R_clutch_lsd"
	diff:preload "R_preload"
	diff:ramp_angle "R_ramp_angle_power R_ramp_angle_coast"
	diff:lock_per_clutch 0.030
	diff:clutches "R_clutches"
	diff:clutch_slip_factor 1.5
	# VLSD
	diff:visc_lsd "R_viscous_lsd"
	diff:visc_locking "R_viscous_locking"
	diff:visc_hump "0.0 390.0"
	diff:visc_degrade "0.0 300.0"
	diff:visc_fail 1000.0
	diff:visc_heating "0.0 0.0"
	# Ratchet
	diff:ratchet_lsd "R_ratchet"
	# final drive
	dl:ratio "drive"

RECORD RWD_P1_rear_diff_v3 amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft_GT3_POST
	diff:planet planet_gear_rear
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	diff:model_version 3.0
	# Salisbury
	diff:clutch_lsd  "R_clutch_lsd"
	diff:preload "R_preload"
	diff:ramp_angle "R_ramp_angle_power R_ramp_angle_coast"
	diff:lock_per_clutch 0.040
	diff:clutches "R_clutches"
	diff:clutch_slip_factor 1.5
	# VLSD
	diff:visc_lsd "R_viscous_lsd"
	diff:visc_locking "R_viscous_locking"
	diff:visc_hump "0.0 390.0"
	diff:visc_degrade "0.0 300.0"
	diff:visc_fail 1000.0
	diff:visc_heating "0.0 0.0"
	# Ratchet
	diff:ratchet_lsd "R_ratchet"
	# final drive
	dl:ratio "drive"
	
RECORD RWD_P2_rear_diff_v3 amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft_GT3_POST
	diff:planet planet_gear_rear
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	diff:model_version 3.0
	# Salisbury
	diff:clutch_lsd  "R_clutch_lsd"
	diff:preload "R_preload"
	diff:ramp_angle "R_ramp_angle_power R_ramp_angle_coast"
	diff:lock_per_clutch 0.040
	diff:clutches "R_clutches"
	diff:clutch_slip_factor 1.5
	# VLSD
	diff:visc_lsd "R_viscous_lsd"
	diff:visc_locking "R_viscous_locking"
	diff:visc_hump "0.0 390.0"
	diff:visc_degrade "0.0 300.0"
	diff:visc_fail 1000.0
	diff:visc_heating "0.0 0.0"
	# Ratchet
	diff:ratchet_lsd "R_ratchet"
	# final drive
	dl:ratio "drive"	

RECORD RWD_GT1_rear_diff_v3 amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft_GT3_POST
	diff:planet planet_gear_rear
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	diff:model_version 3.0
	# Salisbury
	diff:clutch_lsd  "R_clutch_lsd"
	diff:preload "R_preload"
	diff:ramp_angle "R_ramp_angle_power R_ramp_angle_coast"
	diff:lock_per_clutch 0.040
	diff:clutches "R_clutches"
	diff:clutch_slip_factor 1.5
	# VLSD
	diff:visc_lsd false
	diff:visc_locking 0.0
	diff:visc_hump "0.0 390.0"
	diff:visc_degrade "0.0 300.0"
	diff:visc_fail 1000.0
	diff:visc_heating "0.0 0.0"
	# Ratchet
	diff:ratchet_lsd "R_ratchet"
	# final drive
	dl:ratio "drive"

RECORD RWD_GT3_rear_diff_v3 amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft_GT3_POST
	diff:planet planet_gear_rear
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	diff:model_version 3.0
	# Salisbury
	diff:clutch_lsd  "R_clutch_lsd"
	diff:preload "R_preload"
	diff:ramp_angle "R_ramp_angle_power R_ramp_angle_coast"
	diff:lock_per_clutch 0.050
	diff:clutches "R_clutches"
	diff:clutch_slip_factor 1.5
	# VLSD
	diff:visc_lsd false
	diff:visc_locking 0.0
	diff:visc_hump "0.0 390.0"
	diff:visc_degrade "0.0 300.0"
	diff:visc_fail 1000.0
	diff:visc_heating "0.0 0.0"
	# Ratchet
	diff:ratchet_lsd "R_ratchet"
	# final drive
	dl:ratio "drive"

RECORD RWD_GT4_rear_diff_v3 amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft_GT3_POST
	diff:planet planet_gear_rear
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	diff:model_version 3.0
	# Salisbury
	diff:clutch_lsd  "R_clutch_lsd"
	diff:preload "R_preload"
	diff:ramp_angle "R_ramp_angle_power R_ramp_angle_coast"
	diff:lock_per_clutch 0.040
	diff:clutches "R_clutches"
	diff:clutch_slip_factor 1.5
	# VLSD
	diff:visc_lsd false
	diff:visc_locking 0.0
	diff:visc_hump "0.0 390.0"
	diff:visc_degrade "0.0 300.0"
	diff:visc_fail 1000.0
	diff:visc_heating "0.0 0.0"
	# Ratchet
	diff:ratchet_lsd "R_ratchet"
	# final drive
	dl:ratio "drive"

RECORD RWD_VLSD_rear_manual_diff amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft_ROAD_POST
	diff:planet planet_gear_rear
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	# Salisbury
	diff:clutch_lsd  "R_clutch_lsd"
	diff:preload "R_preload"
	diff:ramp_angle "R_ramp_angle_power R_ramp_angle_coast"
	diff:lock_per_clutch 0.030
	diff:clutches "R_clutches"
	diff:clutch_slip_factor 1.5
	# VLSD
	diff:visc_hump "0.0 390.0"
	diff:visc_degrade "0.0 300.0"
	diff:visc_fail 1000.0
	diff:visc_heating "0.0 0.0"
	# Ratchet
	diff:ratchet_lsd "R_ratchet"
	# final drive
	dl:ratio "drive"

RECORD RWD_F1LSD_rear_diff amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft_GT3_POST
	diff:planet planet_gear_rear
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	# Salisbury
	diff:clutch_lsd  "R_clutch_lsd"
	diff:preload "R_preload"
	diff:ramp_angle "R_ramp_angle_power R_ramp_angle_coast"
	diff:lock_per_clutch 0.030
	diff:clutches "R_clutches"
	diff:clutch_slip_factor 1.1
	# VLSD
	diff:visc_lsd "R_viscous_lsd"
	diff:visc_locking "R_viscous_locking"
	diff:visc_hump "0.0 390.0"
	diff:visc_degrade "0.0 300.0"
	diff:visc_fail 1000.0
	diff:visc_heating "0.0 0.0"
	# Ratchet
	diff:ratchet_lsd "R_ratchet"
	# final drive
	dl:ratio "drive"

RECORD RWD_F1LSD_rear_diff_v3 amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft_GT3_POST
	diff:planet planet_gear_rear
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	diff:model_version 3.0
	# Salisbury
	diff:clutch_lsd  "R_clutch_lsd"
	diff:preload "R_preload"
	diff:ramp_angle "R_ramp_angle_power R_ramp_angle_coast"
	diff:lock_per_clutch 0.065
	diff:clutches "R_clutches"
	diff:clutch_slip_factor 1.5
	# VLSD
	diff:visc_lsd "R_viscous_lsd"
	diff:visc_locking "R_viscous_locking"
	diff:visc_hump "0.0 390.0"
	diff:visc_degrade "0.0 300.0"
	diff:visc_fail 1000.0
	diff:visc_heating "0.0 0.0"
	# Ratchet
	diff:ratchet_lsd "R_ratchet"
	# final drive
	dl:ratio "drive"	

RECORD RWD_F1LSD_rear_manual_diff amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft_ROAD_POST
	diff:planet planet_gear_rear
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	# Salisbury
	diff:clutch_lsd  "R_clutch_lsd"
	diff:preload "R_preload"
	diff:ramp_angle "R_ramp_angle_power R_ramp_angle_coast"
	diff:lock_per_clutch 0.030
	diff:clutches "R_clutches"
	diff:clutch_slip_factor 1.1
	# VLSD
	diff:visc_hump "0.0 390.0"
	diff:visc_degrade "0.0 300.0"
	diff:visc_fail 1000.0
	diff:visc_heating "0.0 0.0"
	# Ratchet
	diff:ratchet_lsd "R_ratchet"
	# final drive
	dl:ratio "drive"

RECORD RWD_rear_manual_diff amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft_ROAD_POST
	diff:planet planet_gear_rear
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	# Salisbury
	diff:clutch_lsd  "R_clutch_lsd"
	diff:preload "R_preload"
	diff:ramp_angle "R_ramp_angle_power R_ramp_angle_coast"
	diff:lock_per_clutch 0.030
	diff:clutches "R_clutches"
	diff:clutch_slip_factor 1.6
	# final drive
	dl:ratio "drive"
	
RECORD RWD_rear_manual_diff_v3 amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft_ROAD_POST
	diff:planet planet_gear_rear
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	diff:model_version 3.0
	# Salisbury
	diff:clutch_lsd  "R_clutch_lsd"
	diff:preload "R_preload"
	diff:ramp_angle "R_ramp_angle_power R_ramp_angle_coast"
	diff:lock_per_clutch 0.030
	diff:clutches "R_clutches"
	diff:clutch_slip_factor 1.6
	# final drive
	dl:ratio "drive"	

RECORD RWD_rear_GRC_manual_diff_v3 amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft_GT3_POST
	diff:planet planet_gear_rear
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	diff:model_version 3.0
	# Salisbury
	diff:clutch_lsd  "R_clutch_lsd"
	diff:preload "R_preload"
	diff:ramp_angle "R_ramp_angle_power R_ramp_angle_coast"
	diff:lock_per_clutch 0.040
	diff:clutches "R_clutches"
	diff:clutch_slip_factor 1.5
	# final drive
	dl:ratio "drive"

RECORD RWD_rear_F1_manual_diff amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft_GT3_POST
	diff:planet planet_gear_rear
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	# Salisbury
	diff:clutch_lsd  "R_clutch_lsd"
	diff:preload "R_preload"
	diff:ramp_angle "R_ramp_angle_power R_ramp_angle_coast"
	diff:lock_per_clutch 0.030
	diff:clutches "R_clutches"
	diff:clutch_slip_factor 1.5
	# final drive
	dl:ratio "drive"

RECORD RWD_rear_F1_manual_diff_v3 amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft_GT3_POST
	diff:planet planet_gear_rear
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	diff:model_version 3.0
	# Salisbury
	diff:clutch_lsd  "R_clutch_lsd"
	diff:preload "R_preload"
	diff:ramp_angle "R_ramp_angle_power R_ramp_angle_coast"
	diff:lock_per_clutch 0.030
	diff:clutches "R_clutches"
	diff:clutch_slip_factor 1.5
	# final drive
	dl:ratio "drive"
	
RECORD FWD_open_rear_diff amalgam_diff
	pair:left wheel_FL_internal
	pair:right wheel_FR_internal
	diff:shaft driveshaft_ROAD_POST
	diff:planet planet_gear_front
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	# Salisbury
	diff:clutch_lsd false
	diff:preload 0
	diff:ramp_angle "90 90"
	diff:lock_per_clutch 0.005
	diff:clutches 1
	diff:clutch_slip_factor 1.5
	# final drive
	dl:ratio "drive"

RECORD RWD_open_rear_diff amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft_ROAD_POST
	diff:planet planet_gear_rear
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	# Salisbury
	diff:clutch_lsd false
	diff:preload 0
	diff:ramp_angle "90 90"
	diff:lock_per_clutch 0.005
	diff:clutches 1
	diff:clutch_slip_factor 1.5
	# final drive
	dl:ratio "drive"	
	
RECORD RWD_geared_rear_diff amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft_GT3_POST
	diff:planet planet_gear_rear
	mat:stiffness 1.0e6
	diff:drag "0.0 0.0 0.0"
	mat:flags 0
	# Torsen
	diff:gear_lsd "R_gear_lsd"
	diff:bias_ratio "R_bias_power R_bias_coast"
	diff:clutch_slip_factor 1.8
	diff:right_ratio 0.5
	# final drive
	dl:ratio "drive"		

RECORD KART_rear_diff amalgam_diff
	pair:left wheel_RL_KART_internal
	pair:right wheel_RR_KART_internal
	diff:shaft driveshaft_KART_POST
	diff:planet planet_gear_rear
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	# final drive
	dl:ratio "drive"

# Front diff for hybrids, not driven by the engine
RECORD HYBRID_front_diff amalgam_diff
	pair:left wheel_FL_internal
	pair:right wheel_FR_internal
	diff:shaft shaft_dummy
	diff:planet planet_gear_front
	mat:stiffness 1.0e6
	diff:drag "0.0 0.0 0.0"
	mat:flags 0
	# Torsen
	diff:gear_lsd "F_gear_lsd"
	diff:bias_ratio "F_bias_power F_bias_coast"
	diff:right_ratio 0.5
	# Salisbury
	diff:clutch_lsd  "F_clutch_lsd"
	diff:preload "F_preload"
	diff:ramp_angle "F_ramp_angle_power F_ramp_angle_coast"
	diff:lock_per_clutch 0.02
	diff:clutches "F_clutches"
	diff:clutch_slip_factor 1.5
	# VLSD
	diff:visc_lsd "F_viscous_lsd"
	diff:visc_locking "F_viscous_locking"
	diff:visc_hump "0.0 390.0"
	diff:visc_degrade "0.001 300.0"
	diff:visc_fail 1000.0
	diff:visc_heating "0.0 0.0"
	# Ratchet
	diff:ratchet_lsd "F_ratchet"
	# final drive
	dl:ratio "drive"

##
# Open diff v2
#
# These open diffs utilise clutch and visc LSD to add in some friction and drag
# as well as using different inertia planet gears.
#
# Lock per clutch and number of clutches is set up so that the math is simple.
# It's better to have clutch pack locking at 0.1 than 1.0, because at 1.0 even
# 1 degree of ramp amounts to huge locking. This also means that multiplying
# preload by 0.1 gives the final preload figure.
#
# Preload is used as a way to simulate friction in the gears.
#
# Viscous LSD is used to simulate the tiny amount of viscous drag from the oil bath
# as well as how gears push against the housing when there is torque on the planet gears.
##

# RWD
RECORD RWD_open_rear_diff_MED amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft_ROAD_POST
	diff:planet planet_gear_rear_MED
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	diff:model_version 3.0
	# Tiny preload from mechanical friction
	diff:clutch_lsd true
	diff:preload 50 # About 5Nm constant locking
	diff:ramp_angle "90 90"
	diff:lock_per_clutch 0.05
	diff:clutches 2
	diff:clutch_slip_factor 2.0
	# Viscous drag from oil bath
	diff:visc_lsd true
	diff:visc_locking 1.5 # 7.5Nm per 50rpm 
	diff:visc_hump "0.0 390.0"
	diff:visc_degrade "0.0 300.0"
	diff:visc_fail 1000.0
	diff:visc_heating "0.0 0.0"
	# final drive
	dl:ratio "drive"

RECORD RWD_open_rear_diff_HEAVY amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft_ROAD_POST
	diff:planet planet_gear_rear_HEAVY
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	diff:model_version 3.0
	# Tiny preload from mechanical friction
	diff:clutch_lsd true
	diff:preload 100 # About 10Nm constant locking
	diff:ramp_angle "90 90"
	diff:lock_per_clutch 0.05
	diff:clutches 2
	diff:clutch_slip_factor 2.0
	# Viscous drag from oil bath
	diff:visc_lsd true
	diff:visc_locking 2.0 # 10Nm per 50rpm
	diff:visc_hump "0.0 390.0"
	diff:visc_degrade "0.0 300.0"
	diff:visc_fail 1000.0
	diff:visc_heating "0.0 0.0"
	# final drive
	dl:ratio "drive"

RECORD RWD_trainer_open_rear_diff amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft_GT3_POST
	diff:planet planet_gear_rear_LIGHT
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	diff:model_version 3.0
	# Tiny preload from mechanical friction
	diff:clutch_lsd true
	diff:preload 20 # About 2Nm constant locking
	diff:ramp_angle "90 90"
	diff:lock_per_clutch 0.05
	diff:clutches 2
	diff:clutch_slip_factor 2.0
	# Viscous drag from oil bath
	diff:visc_lsd true
	diff:visc_locking 1.5 # 7.5Nm per 50rpm 
	diff:visc_hump "0.0 390.0"
	diff:visc_degrade "0.0 300.0"
	diff:visc_fail 1000.0
	diff:visc_heating "0.0 0.0"
	# final drive
	dl:ratio "drive"

RECORD RWD_proto_open_rear_diff amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft_GT3_POST
	diff:planet planet_gear_rear_MED
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	diff:model_version 3.0
	# Tiny preload from mechanical friction
	diff:clutch_lsd true
	diff:preload 50 # About 5Nm constant locking
	diff:ramp_angle "90 90"
	diff:lock_per_clutch 0.05
	diff:clutches 2
	diff:clutch_slip_factor 2.0
	# Viscous drag from oil bath
	diff:visc_lsd true
	diff:visc_locking 1.5 # 7.5Nm per 50rpm 
	diff:visc_hump "0.0 390.0"
	diff:visc_degrade "0.0 300.0"
	diff:visc_fail 1000.0
	diff:visc_heating "0.0 0.0"
	# final drive
	dl:ratio "drive"

RECORD RWD_vintage_open_rear_diff amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft_GT3_POST
	diff:planet planet_gear_rear_LIGHT
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	diff:model_version 3.0
	# Tiny preload from mechanical friction
	diff:clutch_lsd true
	diff:preload 25 # About 2.5Nm constant locking
	diff:ramp_angle "90 90"
	diff:lock_per_clutch 0.05
	diff:clutches 2
	diff:clutch_slip_factor 2.0
	# Viscous drag from oil bath
	diff:visc_lsd true
	diff:visc_locking 1.5 # 7.5Nm per 50rpm
	diff:visc_hump "0.0 390.0"
	diff:visc_degrade "0.0 300.0"
	diff:visc_fail 1000.0
	diff:visc_heating "0.0 0.0"
	# final drive
	dl:ratio "drive"

# FWD, same logic as RWD, just copied for front planet gear
RECORD FWD_open_front_diff_MED amalgam_diff
	pair:left wheel_FL_internal
	pair:right wheel_FR_internal
	diff:shaft driveshaft_ROAD_POST
	diff:planet planet_gear_front_MED
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	diff:model_version 3.0
	# Tiny preload from mechanical friction
	diff:clutch_lsd true
	diff:preload 50 # About 5Nm constant locking
	diff:ramp_angle "90 90"
	diff:lock_per_clutch 0.05
	diff:clutches 2
	diff:clutch_slip_factor 2.0
	# Viscous drag from oil bath
	diff:visc_lsd true
	diff:visc_locking 1.5 # 7.5Nm per 50rpm 
	diff:visc_hump "0.0 390.0"
	diff:visc_degrade "0.0 300.0"
	diff:visc_fail 1000.0
	diff:visc_heating "0.0 0.0"
	# final drive
	dl:ratio "drive"

RECORD FWD_vintage_open_front_diff amalgam_diff
	pair:left wheel_FL_internal
	pair:right wheel_FR_internal
	diff:shaft driveshaft_ROAD_POST
	diff:planet planet_gear_front_LIGHT
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	diff:model_version 3.0
	# Tiny preload from mechanical friction
	diff:clutch_lsd true
	diff:preload 25 # About 2.5Nm constant locking
	diff:ramp_angle "90 90"
	diff:lock_per_clutch 0.05
	diff:clutches 2
	diff:clutch_slip_factor 2.0
	# Viscous drag from oil bath
	diff:visc_lsd true
	diff:visc_locking 1.5 # 7.5Nm per 50rpm 
	diff:visc_hump "0.0 390.0"
	diff:visc_degrade "0.0 300.0"
	diff:visc_fail 1000.0
	diff:visc_heating "0.0 0.0"
	# final drive
	dl:ratio "drive"

##
# E-Diffs
#
# These are open diffs, but separated just in case. Paired with e-diff enabled
# in chassis.
##

RECORD RWD_GT4_rear_ediff_v3 amalgam_diff
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	diff:shaft driveshaft_GT3_POST
	diff:planet planet_gear_rear
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	diff:model_version 3.0
	# Salisbury ONLY as sensible open diff for e-diff
	# Tiny preload from mechanical friction
	diff:clutch_lsd true
	diff:preload 50 # About 5Nm constant locking
	diff:ramp_angle "80 90"
	diff:lock_per_clutch 0.05
	diff:clutches 2
	diff:clutch_slip_factor 2.0
	# Viscous drag from oil bath
	diff:visc_lsd true
	diff:visc_locking 1.5 # 7.5Nm per 50rpm 
	diff:visc_hump "0.0 390.0"
	diff:visc_degrade "0.0 300.0"
	diff:visc_fail 1000.0
	diff:visc_heating "0.0 0.0"
	# final drive
	dl:ratio "drive"

RECORD FWD_front_ediff_v3 amalgam_diff
	pair:left wheel_FL_internal
	pair:right wheel_FR_internal
	diff:shaft driveshaft_GT3_POST
	diff:planet planet_gear_front
	mat:stiffness 1.0e6
	diff:drag "0.0e-2 0.0e-2 0.0e-2"
	mat:flags 0
	diff:model_version 3.0
	# Salisbury ONLY as sensible open diff for e-diff
	# Tiny preload from mechanical friction
	diff:clutch_lsd true
	diff:preload 50 # About 5Nm constant locking
	diff:ramp_angle "90 90"
	diff:lock_per_clutch 0.05
	diff:clutches 2
	diff:clutch_slip_factor 2.0
	# Viscous drag from oil bath
	diff:visc_lsd true
	diff:visc_locking 1.5 # 7.5Nm per 50rpm 
	diff:visc_hump "0.0 390.0"
	diff:visc_degrade "0.0 300.0"
	diff:visc_fail 1000.0
	diff:visc_heating "0.0 0.0"
	# final drive
	dl:ratio "drive"





###############
# Planet gears to use inside differentials
# Tuning of the planet gear mass can make a difference to Torsen
###############

RECORD planet_gear shaft
	name "planet_gear"
	sim:mass 0.005

RECORD planet_gear1 shaft
	name "planet_gear1"
	sim:mass 0.005

RECORD planet_gear_front shaft
	name "planet_gear_front"
	sim:mass 0.005

RECORD planet_gear_center shaft
	name "planet_gear_center"
	sim:mass 0.005

RECORD planet_gear_rear shaft
	name "planet_gear_rear"
	sim:mass 0.005

# New planet inertias for new diffs
# FWD
RECORD planet_gear_front_LIGHT shaft
	name "planet_gear_front"
	sim:mass 0.005

RECORD planet_gear_front_MED shaft
	name "planet_gear_front"
	sim:mass 0.0125

RECORD planet_gear_front_HEAVY shaft
	name "planet_gear_front"
	sim:mass 0.0175

# RWD
RECORD planet_gear_rear_LIGHT shaft
	name "planet_gear_rear"
	sim:mass 0.005

RECORD planet_gear_rear_MED shaft
	name "planet_gear_rear"
	sim:mass 0.0125

RECORD planet_gear_rear_HEAVY shaft
	name "planet_gear_rear"
	sim:mass 0.0175

###############
# Optional spool to lock each differential individually
###############

RECORD FWD_spool l_spring
	name "spool_front"
	pair:left wheel_FL_internal
	pair:right wheel_FR_internal
	mat:stiffness 1.0e8
	mat:damping 0.0
	bdy:length 0.0
	dl:active "F_spool"

RECORD RWD_spool l_spring
	name "spool_rear"
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	mat:stiffness 1.0e8
	mat:damping 0.0
	bdy:length 0.0
	dl:active "R_spool"

RECORD AWD_center_spool l_spring
	name "spool_center"
	pair:left driveshaft_AWD_front
	pair:right driveshaft_AWD_rear
	mat:stiffness 1.0e8
	mat:damping 0.0
	bdy:length 0.0
	dl:active "C_spool"

RECORD KART_spool l_spring
	name "spool_rear"
	pair:left wheel_RL_KART_internal
	pair:right wheel_RR_KART_internal
	mat:stiffness 1.0e6
	mat:damping 0.0
	bdy:length 0.0
	dl:active "R_spool"

RECORD spool l_spring
	name "spool"
	pair:left wheel_RL_internal
	pair:right wheel_RR_internal
	mat:stiffness 1.0e7
	mat:damping 0.0
	bdy:length 0.0

RECORD BROCKY_spool l_spring
	name "spool_brocky"
	pair:left driveshaft_AWD_front
	pair:right driveshaft_GT3_POST
	mat:stiffness 1.0e8
	mat:damping 0.0
	bdy:length 0.0
	dl:active "C_spool"

###############
# Miscellaneous parts
###############

# Rear-to-Front viscous coupling for older Skylines. Works like a center diff
RECORD AWD_SKYLINE_R32_front_coupling l_spring
	name "AWD_SKYLINE_R32_front_coupling"
	pair:left driveshaft_GT3_POST
	pair:right driveshaft_AWD_front
	mat:stiffness 0.0e8
	mat:damping 10.0
	bdy:length 0.0	

# Rear-to-Front viscous coupling. Works like a center diff
RECORD AWD_viscous_front_coupling l_spring
	name "AWD_viscous_front_coupling"
	pair:left driveshaft_GT3_POST
	pair:right driveshaft_AWD_front
	mat:stiffness 0.0e8
	mat:damping 50
	bdy:length 0.0	

# Front-to-Rear viscous coupling for FWD-biased AWD cars like A1 and A45. Works like a center diff
RECORD AUDI_A1_viscous_rear_coupling l_spring
	name "AUDI_A1_viscous_rear_coupling"
	pair:left driveshaft_GT3_POST
	pair:right driveshaft_AWD_rear
	mat:stiffness 0.0e8
	mat:damping 7.0
	bdy:length 0.0

# Lock together driveshaft_AWD_rear and driveshaft_AWD_rear_clutch if not using the handbrake clutch
RECORD driveshaft_AWD_rear_coupling l_spring
	name "driveshaft_AWD_rear_coupling"
	pair:left driveshaft_AWD_rear
	pair:right driveshaft_AWD_rear_clutch
	mat:stiffness 1.0e8
	mat:damping 0.0
	bdy:length 0.0

# Sorta-kinda doing torque converter resistance for the F150 when on handbrake only
RECORD F150_torque_converter_resistance l_spring
	name "F150_torque_converter_resistance"
	pair:left driveshaft_GT3_POST
	pair:right driveshaft_AWD_rear_clutch
	mat:stiffness 0.0e8
	mat:damping 3.5
	bdy:length 0.0

RECORD shaft_dummy shaft
	name "shaft_dummy"
	sim:mass 0.1

RECORD shaft_dummy_2 shaft
	name "shaft_dummy_2"
	sim:mass 0.1
	
###############
# Axle shafts from the front/rear diff to the wheel
###############

RECORD wheel_FR_internal shaft
	name "wheel_FR_internal"
	sim:mass 0.05
RECORD wheel_FL_internal shaft
	name "wheel_FL_internal"
	sim:mass 0.05
RECORD wheel_RR_internal shaft
	name "wheel_RR_internal"
	sim:mass 0.05
RECORD wheel_RL_internal shaft
	name "wheel_RL_internal"
	sim:mass 0.05

RECORD wheel_FR_KART_internal shaft
	name "wheel_FR_internal"
	sim:mass 0.01
RECORD wheel_FL_KART_internal shaft
	name "wheel_FL_internal"
	sim:mass 0.01
RECORD wheel_RR_KART_internal shaft
	name "wheel_RR_internal"
	sim:mass 0.01
RECORD wheel_RL_KART_internal shaft
	name "wheel_RL_internal"
	sim:mass 0.01
	
###############
# Wheel Bearings for driveline loss modeling
###############
	
# Basic wheel bearing losses for non-driven wheels. Only just over 1hp loss each at 150mph
RECORD wheel_bearing_FR l_bearing
	bearing:shaft wheel_FR_internal
	bearing:friction 0
	bearing:visc 0

RECORD wheel_bearing_FL l_bearing
	bearing:shaft wheel_FL_internal
	bearing:friction 0
	bearing:visc 0

RECORD wheel_bearing_RR l_bearing
	bearing:shaft wheel_RR_internal
	bearing:friction 0
	bearing:visc 0

RECORD wheel_bearing_RL l_bearing
	bearing:shaft wheel_RL_internal
	bearing:friction 0
	bearing:visc 0

# RWD bearing friction on drive wheels adds up to about 30hp at 150mph
RECORD RWD_15hp_wheel_bearing_RR l_bearing
	bearing:shaft wheel_RR_internal
	bearing:friction 0
	bearing:visc 0

RECORD RWD_15hp_wheel_bearing_RL l_bearing
	bearing:shaft wheel_RL_internal
	bearing:friction 0
	bearing:visc 0

RECORD RWD_30hp_wheel_bearing_RR l_bearing
	bearing:shaft wheel_RR_internal
	bearing:friction 0
	bearing:visc 0

RECORD RWD_30hp_wheel_bearing_RL l_bearing
	bearing:shaft wheel_RL_internal
	bearing:friction 0
	bearing:visc 0

# RWD bearing friction on drive wheels adds up to about 60hp at 150mph
RECORD RWD_20hp_wheel_bearing_RR l_bearing
	bearing:shaft wheel_RR_internal
	bearing:friction 3.0e0
	bearing:visc 1.5e-2

RECORD RWD_20hp_wheel_bearing_RL l_bearing
	bearing:shaft wheel_RL_internal
	bearing:friction 3.0e0
	bearing:visc 1.5e-2

RECORD RWD_50hp_wheel_bearing_RR l_bearing
	bearing:shaft wheel_RR_internal
	bearing:friction 1.5e1
	bearing:visc 1.5e-1

RECORD RWD_50hp_wheel_bearing_RL l_bearing
	bearing:shaft wheel_RL_internal
	bearing:friction 1.5e1
	bearing:visc 1.5e-1

# FWD bearing friction on drive wheels adds up to about 30hp at 150mph
RECORD FWD_15hp_wheel_bearing_FR l_bearing
	bearing:shaft wheel_FR_internal
	bearing:friction 3.0e0
	bearing:visc 1.5e-2

RECORD FWD_15hp_wheel_bearing_FL l_bearing
	bearing:shaft wheel_FL_internal
	bearing:friction 3.0e0
	bearing:visc 1.5e-2

###############
# Wheel groups of varying rotational inertia
# 'Strain' springs connect internal axle shaft to the wheel
###############

# Big, heavy wheels for the F150	
RECORD wheel_FR_F150 shaft
	name "wheel_FR"
	sim:mass 14.4
RECORD wheel_FL_F150 shaft
	name "wheel_FL"
	sim:mass 14.4
RECORD wheel_RR_F150 shaft
	name "wheel_RR"
	sim:mass 28.8
RECORD wheel_RL_F150 shaft
	name "wheel_RL"
	sim:mass 28.8

RECORD strain_FR_F150 l_spring
	name "strain_FR"
	pair:left wheel_FR_internal
	pair:right wheel_FR_F150

RECORD strain_FL_F150 l_spring
	name "strain_FL"
	pair:left wheel_FL_internal
	pair:right wheel_FL_F150

RECORD strain_RR_F150 l_spring
	name "strain_RR"
	pair:left wheel_RR_internal
	pair:right wheel_RR_F150

RECORD strain_RL_F150 l_spring
	name "strain_RL"
	pair:left wheel_RL_internal
	pair:right wheel_RL_F150


# Medium-sized road car wheels. 245/45-18(ish)
RECORD wheel_FR_ROAD_medium shaft
	name "wheel_FR"
	sim:mass 2.0
RECORD wheel_FL_ROAD_medium shaft
	name "wheel_FL"
	sim:mass 2.0
RECORD wheel_RR_ROAD_medium shaft
	name "wheel_RR"
	sim:mass 2.2
RECORD wheel_RL_ROAD_medium shaft
	name "wheel_RL"
	sim:mass 2.2

RECORD strain_FR_ROAD_medium l_spring
	name "strain_FR"
	pair:left wheel_FR_internal
	pair:right wheel_FR_ROAD_medium

RECORD strain_FL_ROAD_medium l_spring
	name "strain_FL"
	pair:left wheel_FL_internal
	pair:right wheel_FL_ROAD_medium

RECORD strain_RR_ROAD_medium l_spring
	name "strain_RR"
	pair:left wheel_RR_internal
	pair:right wheel_RR_ROAD_medium

RECORD strain_RL_ROAD_medium l_spring
	name "strain_RL"
	pair:left wheel_RL_internal
	pair:right wheel_RL_ROAD_medium

	
# GT3 wheel inertia
RECORD wheel_FR_GT3 shaft
	name "wheel_FR"
	sim:mass 1.6
RECORD wheel_FL_GT3 shaft
	name "wheel_FL"
	sim:mass 1.6
RECORD wheel_RR_GT3 shaft
	name "wheel_RR"
	sim:mass 1.7
RECORD wheel_RL_GT3 shaft
	name "wheel_RL"
	sim:mass 1.7

RECORD strain_FR_GT3 l_spring
	name "strain_FR"
	pair:left wheel_FR_internal
	pair:right wheel_FR_GT3

RECORD strain_FL_GT3 l_spring
	name "strain_FL"
	pair:left wheel_FL_internal
	pair:right wheel_FL_GT3

RECORD strain_RR_GT3 l_spring
	name "strain_RR"
	pair:left wheel_RR_internal
	pair:right wheel_RR_GT3

RECORD strain_RL_GT3 l_spring
	name "strain_RL"
	pair:left wheel_RL_internal
	pair:right wheel_RL_GT3


# TCR/small formula car wheel inertia
RECORD wheel_FR_TCR shaft
	name "wheel_FR"
	sim:mass 1.20
RECORD wheel_FL_TCR shaft
	name "wheel_FL"
	sim:mass 1.20
RECORD wheel_RR_TCR shaft
	name "wheel_RR"
	sim:mass 1.25
RECORD wheel_RL_TCR shaft
	name "wheel_RL"
	sim:mass 1.25

RECORD strain_FR_TCR l_spring
	name "strain_FR"
	pair:left wheel_FR_internal
	pair:right wheel_FR_TCR

RECORD strain_FL_TCR l_spring
	name "strain_FL"
	pair:left wheel_FL_internal
	pair:right wheel_FL_TCR

RECORD strain_RR_TCR l_spring
	name "strain_RR"
	pair:left wheel_RR_internal
	pair:right wheel_RR_TCR

RECORD strain_RL_TCR l_spring
	name "strain_RL"
	pair:left wheel_RL_internal
	pair:right wheel_RL_TCR



###############
# Half shafts (axle), axle strains, and compatible wheel strains.
#
# Axle shaft and axle strain are new. Compatible wheel strains are needed to
# fit the new components in between wheel_xx_internal and wheel_xx, replacing
# the usual wheel strains in driveline groups.
###############

# Axle shafts, minimal rotational mass added, wheel internals are the main mass

## Generic
RECORD axle_RR shaft
	name "axle_RR"
	sim:mass 0.02
RECORD axle_RL shaft
	name "axle_RL"
	sim:mass 0.02

# Higher inertia for ARC, because it has such low inertias that the usual 0.01
# causes occasional instability in the driveline (jolts when shifting etc)
RECORD axle_RR_ARC shaft
	name "axle_RR"
	sim:mass 0.05
RECORD axle_RL_ARC shaft
	name "axle_RL"
	sim:mass 0.05

RECORD axle_FR shaft
	name "axle_FR"
	sim:mass 0.02
RECORD axle_FL shaft
	name "axle_FL"
	sim:mass 0.02

# Axle strains

## Stiff OEM type, 450Nm/deg
RECORD axle_strain_RR_OEM l_spring
	name "flex_axle_RR"
	pair:left wheel_RR_internal
	pair:right axle_RR
	mat:stiffness 2.5e4
RECORD axle_strain_RL_OEM l_spring
	name "flex_axle_RL"
	pair:left wheel_RL_internal
	pair:right axle_RL
	mat:stiffness 2.5e4

## Super V8, 350Nm/deg
RECORD axle_strain_RR_SV8 l_spring
	name "flex_axle_RR"
	pair:left wheel_RR_internal
	pair:right axle_RR
	mat:stiffness 1.96e4
RECORD axle_strain_RL_SV8 l_spring
	name "flex_axle_RL"
	pair:left wheel_RL_internal
	pair:right axle_RL
	mat:stiffness 1.96e4

## GT3, 250Nm/deg
RECORD axle_strain_RR_GT3 l_spring
	name "flex_axle_RR"
	pair:left wheel_RR_internal
	pair:right axle_RR
	mat:stiffness 1.4e4
RECORD axle_strain_RL_GT3 l_spring
	name "flex_axle_RL"
	pair:left wheel_RL_internal
	pair:right axle_RL
	mat:stiffness 1.4e4

## Light OEM type, 200Nm/deg
RECORD axle_strain_RR_LOEM l_spring
	name "flex_axle_RR"
	pair:left wheel_RR_internal
	pair:right axle_RR
	mat:stiffness 1.0e4
RECORD axle_strain_RL_LOEM l_spring
	name "flex_axle_RL"
	pair:left wheel_RL_internal
	pair:right axle_RL
	mat:stiffness 1.0e4

## Prototype, 160Nm/deg
RECORD axle_strain_RR_PROTO l_spring
	name "flex_axle_RR"
	pair:left wheel_RR_internal
	pair:right axle_RR
	mat:stiffness 9.0e3
RECORD axle_strain_RL_PROTO l_spring
	name "flex_axle_RL"
	pair:left wheel_RL_internal
	pair:right axle_RL
	mat:stiffness 9.0e3

## TCR, 125Nm/deg
RECORD axle_strain_RR_TCR l_spring
	name "flex_axle_RR"
	pair:left wheel_RR_internal
	pair:right axle_RR
	mat:stiffness 7.0e3
RECORD axle_strain_RL_TCR l_spring
	name "flex_axle_RL"
	pair:left wheel_RL_internal
	pair:right axle_RL
	mat:stiffness 7.0e3

RECORD axle_strain_FR_TCR l_spring
	name "flex_axle_FR"
	pair:left wheel_FR_internal
	pair:right axle_FR
	mat:stiffness 1.0e4
RECORD axle_strain_FL_TCR l_spring
	name "flex_axle_FL"
	pair:left wheel_FL_internal
	pair:right axle_FL
	mat:stiffness 1.0e4

## F1, 80Nm/deg
RECORD axle_strain_RR_F1 l_spring
	name "flex_axle_RR"
	pair:left wheel_RR_internal
	pair:right axle_RR
	mat:stiffness 4.5e3
RECORD axle_strain_RL_F1 l_spring
	name "flex_axle_RL"
	pair:left wheel_RL_internal
	pair:right axle_RL
	mat:stiffness 4.5e3

## Light F1, 60Nm/deg
RECORD axle_strain_RR_F1L l_spring
	name "flex_axle_RR"
	pair:left wheel_RR_internal
	pair:right axle_RR
	mat:stiffness 3.4e3
RECORD axle_strain_RL_F1L l_spring
	name "flex_axle_RL"
	pair:left wheel_RL_internal
	pair:right axle_RL
	mat:stiffness 3.4e3

## Light Proto, 60Nm/deg
RECORD axle_strain_RR_LPROTO l_spring
	name "flex_axle_RR"
	pair:left wheel_RR_internal
	pair:right axle_RR
	mat:stiffness 3.4e3
RECORD axle_strain_RL_LPROTO l_spring
	name "flex_axle_RL"
	pair:left wheel_RL_internal
	pair:right axle_RL
	mat:stiffness 3.4e3

## CART, 60Nm/deg
RECORD axle_strain_RR_CART l_spring
	name "flex_axle_RR"
	pair:left wheel_RR_internal
	pair:right axle_RR
	mat:stiffness 3.4e3
RECORD axle_strain_RL_CART l_spring
	name "flex_axle_RL"
	pair:left wheel_RL_internal
	pair:right axle_RL
	mat:stiffness 3.4e3

## Trainer, 30Nm/deg
RECORD axle_strain_RR_TRAINER l_spring
	name "flex_axle_RR"
	pair:left wheel_RR_internal
	pair:right axle_RR
	mat:stiffness 1.6e3
RECORD axle_strain_RL_TRAINER l_spring
	name "flex_axle_RL"
	pair:left wheel_RL_internal
	pair:right axle_RL
	mat:stiffness 1.6e3

## ARC, 30Nm/deg, for special ARC axle
RECORD axle_strain_RR_ARC l_spring
	name "flex_axle_RR"
	pair:left wheel_RR_internal
	pair:right axle_RR_ARC
	mat:stiffness 1.6e3
RECORD axle_strain_RL_ARC l_spring
	name "flex_axle_RL"
	pair:left wheel_RL_internal
	pair:right axle_RL_ARC
	mat:stiffness 1.6e3

	
# Wheel Strains to replace usual ones when halfshafts are used
## GT3
RECORD strain_RR_GT3_AXLE l_spring
	name "strain_RR"
	pair:left axle_RR
	pair:right wheel_RR_GT3
RECORD strain_RL_GT3_AXLE l_spring
	name "strain_RL"
	pair:left axle_RL
	pair:right wheel_RL_GT3

## ROAD
RECORD strain_RR_ROAD_medium_AXLE l_spring
	name "strain_RR"
	pair:left axle_RR
	pair:right wheel_RR_ROAD_medium
RECORD strain_RL_ROAD_medium_AXLE l_spring
	name "strain_RL"
	pair:left axle_RL
	pair:right wheel_RL_ROAD_medium

## TCR
RECORD strain_RR_TCR_AXLE l_spring
	name "strain_RR"
	pair:left axle_RR
	pair:right wheel_RR_TCR
RECORD strain_RL_TCR_AXLE l_spring
	name "strain_RL"
	pair:left axle_RL
	pair:right wheel_RL_TCR

RECORD strain_RR_TCR_AXLE_ARC l_spring
	name "strain_RR"
	pair:left axle_RR_ARC
	pair:right wheel_RR_TCR
RECORD strain_RL_TCR_AXLE_ARC l_spring
	name "strain_RL"
	pair:left axle_RL_ARC
	pair:right wheel_RL_TCR

RECORD strain_FR_TCR_AXLE l_spring
	name "strain_FR"
	pair:left axle_FR
	pair:right wheel_FR_TCR
RECORD strain_FL_TCR_AXLE l_spring
	name "strain_FL"
	pair:left axle_FL
	pair:right wheel_FL_TCR





###############
#
#
#
# DRIVELINE GROUPS
#
#
#
###############



###############
# Truck specifics for Copa Truck.
###############
RECORDGROUP RWD_FTRUCK_FLEX
	wheel_FR_F150
	wheel_FL_F150
	wheel_RR_F150
	wheel_RL_F150
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR_F150
	strain_FL_F150
	strain_RR_F150
	strain_RL_F150
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	crankshaft_TRUCK
	clutch_Truck_4000Nm
	clutchshaft_ROAD
	clutchshaft_ROAD_bearing
	clutchshaft_strain_ROAD_flex_ftruck
	clutchshaft_ROAD_POST
	gearbox_H-pattern_synchro_POST_TRUCK_flex
	driveshaft_TRUCK
	driveshaft_strain_gauge_TRUCK_flex_ultrastiff
	driveshaft_ROAD_POST
	RWD_rear_manual_diff
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_50hp_wheel_bearing_RR
	RWD_50hp_wheel_bearing_RL

RECORD RWD_FTRUCK_IVECO l_driveline
	name "FTRUCK_IVECO"
	contents RWD_FTRUCK_FLEX
	dl:minhz	3000

RECORD RWD_FTRUCK_MERC l_driveline
	name "FTRUCK_MERC"
	contents RWD_FTRUCK_FLEX
	dl:minhz	3000

RECORD RWD_FTRUCK_MAN l_driveline
	name "FTRUCK_MAN"
	contents RWD_FTRUCK_FLEX
	dl:minhz	3000	

RECORD RWD_FTRUCK_VULKAN l_driveline
	name "FTRUCK_VULKAN"
	contents RWD_FTRUCK_FLEX
	dl:minhz	3000	
	
RECORD RWD_FTRUCK_VW l_driveline
	name "FTRUCK_VW"
	contents RWD_FTRUCK_FLEX
	dl:minhz	3000
##



###############
# Truck specifics for the F150 Fun Haver.  Mostly the increased wheel inertia.  
###############
RECORDGROUP RWD_FORD_F150
	wheel_FR_F150
	wheel_FL_F150
	wheel_RR_F150
	wheel_RL_F150
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR_F150
	strain_FL_F150
	strain_RR_F150
	strain_RL_F150
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	crankshaft_TRUCK
	clutch_Truck_4000Nm
	clutchshaft_ROAD
	clutchshaft_ROAD_bearing
	gearbox_H-pattern_synchro
	driveshaft_ROAD
	driveshaft_strain_gauge_ROAD
	driveshaft_ROAD_POST
	RWD_rear_manual_diff
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_50hp_wheel_bearing_RR
	RWD_50hp_wheel_bearing_RL
	
RECORD RWD_SUPERTRUCK l_driveline
	name "SUPERTRUCK"
	contents RWD_FORD_F150
	dl:minhz	3000	
##



###############
# RWD, modern, sequential gearbox racecars with wheel inertia in the GT3 ballpark
# No flex
###############
RECORDGROUP RWD_MODERN_SEQUENTIAL
	wheel_FR_GT3
	wheel_FL_GT3
	wheel_RR_GT3
	wheel_RL_GT3
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR_GT3
	strain_FL_GT3
	strain_RR_GT3
	strain_RL_GT3
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	crankshaft_GT3
	clutch_GT3_900Nm
	clutchshaft_GT3
	clutchshaft_GT3_bearing
	gearbox_GT3
	driveshaft_GT3
	driveshaft_strain_gauge
	driveshaft_GT3_POST
	RWD_VLSD_rear_diff
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_30hp_wheel_bearing_RR
	RWD_30hp_wheel_bearing_RL

## LM P2
RECORD RWD_LMP2_01 l_driveline
	name "LIGIER_JSP2"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000

RECORD RWD_LMP2_06 l_driveline
	name "LIGIER_JSP2-JUDD"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000

RECORD RWD_LMP2_05 l_driveline
	name "LIGIER_JSP2-HONDA"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000

RECORD RWD_LMP2_02 l_driveline
	name "MAREK_RP219D"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000
	
RECORD RWD_LMP2_04 l_driveline
	name "ORECA_03_NISSAN"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000

RECORD RWD_LMP2_03 l_driveline
	name "RWD_P20_LMP2"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000
##

## LMP3	
RECORD RWD_LMP3_01 l_driveline
	name "GINETTA_LMP3"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000

RECORD RWD_LMP3_02 l_driveline
	name "LIGIER_JSP3"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000
##

## LMGTE
RECORD RWD_LMGTE_01 l_driveline
	name "ASTON_MARTIN_VANTAGE_GTE"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000

RECORD RWD_LMGTE_02 l_driveline
	name "BMW_M6_GTLM"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000

RECORD RWD_LMGTE_03 l_driveline
	name "CHEVROLET_CORVETTE_C7R"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000

RECORD RWD_LMGT3_04 l_driveline
	name "FERRARI_488_GTE"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000

RECORD RWD_LMGTE_05 l_driveline
	name "FORD_GTLM"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000

RECORD RWD_LMGTE_06 l_driveline
	name "PORSCHE_991_RSR"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000
##

## GT3
RECORD RWD_GT3_01 l_driveline
	name "ACURA_NSX_GT3"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000

RECORD RWD_GT3_03 l_driveline
	name "AUDI_R8_LMS"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000

RECORD RWD_GT3_05 l_driveline
	name "BMW_Z4_GT3"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000

RECORD RWD_GT3_06 l_driveline
	name "BENTLEY_CONTINENTAL_GT3"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000

RECORD RWD_GT3_07 l_driveline
	name "CADILLAC_ATS-VR"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000

RECORD RWD_GT3_08 l_driveline
	name "FERRARI_488_GT3"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000

# RWD_GT3_09 missing

RECORD RWD_GT3_10 l_driveline
	name "LAMBORGHINI_HURACAN_GT3"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000

RECORD RWD_GT3_11 l_driveline
	name "LAMBORGHINI_HURACAN_SUPERTROFEO"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000

RECORD RWD_GT3_14 l_driveline
	name "MERCEDES_SLS_GT3"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000

RECORD RWD_GT3_16 l_driveline
	name "RENAULT_RS01"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000
##

## GT4
RECORD RWD_GT4_01 l_driveline
	name "KTM_X-BOW_GT4"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000
##

## Track day cars that are basically GT3
RECORD RWD_TRACK_DAY_SEQUENTIAL_01 l_driveline
	name "ASTON_MARTIN_VULCAN"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000

RECORD RWD_TRACK_DAY_SEQUENTIAL_03 l_driveline
	name "RADICAL_RXC_TURBO"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000

RECORD RWD_TRACK_DAY_SEQUENTIAL_04 l_driveline
	name "BMW_1M_SW"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000

## LMP900, LM-GTP, FIA GT1 1997-1998
RECORD RWD_LMP900_01 l_driveline
	name "AUDI_R8_LMP900"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000

RECORD RWD_LMP900_02 l_driveline
	name "BENTLEY_SPEED_8"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000

RECORD RWD_LMP900_03 l_driveline
	name "BMW_V12_LMR"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000

RECORD RWD_LMP900_04 l_driveline
	name "FERRARI_333SP"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000

RECORD RWD_LMP900_05 l_driveline
	name "TOYOTA_GT-ONE"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000

RECORD RWD_FIAGT1_01 l_driveline
	name "FERRARI_F50_GT"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000

RECORD RWD_FIAGT1_06 l_driveline
	name "TOYOTA_GT-ONE98"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000

RECORD RWD_FIAGT1_07 l_driveline
	name "PANOZ_ESPERANTE_GTR1"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000



###############
# RWD, modern, sequential gearbox racecars with wheel inertia in the GT3 ballpark
# FR layout mass/flex
###############
RECORDGROUP RWD_MODERN_SEQUENTIAL_FLEX_FR
	wheel_FR_GT3
	wheel_FL_GT3
	wheel_RR_GT3
	wheel_RL_GT3
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_GT3
	axle_strain_RL_GT3
	strain_FR_GT3
	strain_FL_GT3
	strain_RR_GT3_AXLE
	strain_RL_GT3_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_GT3
	crankshaft_GT3
	clutch_MODERN-GT_1200Nm
	clutchshaft_MODERN-GT
	clutchshaft_MODERN-GT_bearing
	clutchshaft_strain_MODERN-GT_flex
	clutchshaft_GT3_POST
	gearbox_GT3_POST_GT-FR_flex
	driveshaft_GT-FR
	driveshaft_strain_gauge_GT-FR_flex_waxle
	driveshaft_GT3_POST
	RWD_GT3_rear_diff_v3
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_30hp_wheel_bearing_RR
	RWD_30hp_wheel_bearing_RL

## LM GTE/GTLM	
RECORD RWD_LMGTE_09 l_driveline
	name "BMW_M8_GTE"
	contents RWD_MODERN_SEQUENTIAL_FLEX_FR
	dl:minhz	3000	
##

## GT3
RECORD RWD_GT3_02 l_driveline
	name "ASTON_MARTIN_VANTAGE_GT3"
	contents RWD_MODERN_SEQUENTIAL_FLEX_FR
	dl:minhz	3000

RECORD RWD_GT3_04 l_driveline
	name "BMW_M6_GT3"
	contents RWD_MODERN_SEQUENTIAL_FLEX_FR
	dl:minhz	3000

RECORD RWD_GT3_13 l_driveline
	name "MERCEDES_AMG_GT3"
	contents RWD_MODERN_SEQUENTIAL_FLEX_FR
	dl:minhz	3000

RECORD RWD_GT3_17 l_driveline
	name "GINETTA_G55_GT3"
	contents RWD_MODERN_SEQUENTIAL_FLEX_FR
	dl:minhz	3000

## Nissan GT-R GT3 in RWD_MODERN_SEQUENTIAL_FLEX_SOFT_FR_GT3v3
##

###############
# RWD, modern, sequential, IDENTICAL except softer flex for fr - for GT3 diffed
# FLEX ADDED! DIFF v3 ADDED!
###############
RECORDGROUP RWD_MODERN_SEQUENTIAL_FLEX_SOFT_FR_GT3v3
	wheel_FR_GT3
	wheel_FL_GT3
	wheel_RR_GT3
	wheel_RL_GT3
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_PROTO
	axle_strain_RL_PROTO
	strain_FR_GT3
	strain_FL_GT3
	strain_RR_GT3_AXLE
	strain_RL_GT3_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_GT3
	crankshaft_GT3
	clutch_MODERN-GT_1200Nm
	clutchshaft_MODERN-GT
	clutchshaft_MODERN-GT_bearing
	clutchshaft_strain_MODERN-GT_flex
	clutchshaft_GT3_POST
	gearbox_GT3_POST_GT-FR_flex
	driveshaft_GT-FR
	driveshaft_strain_gauge_GT-FR_flex_waxle_ultrasoft
	driveshaft_GT3_POST
	RWD_GT3_rear_diff_v3
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_30hp_wheel_bearing_RR
	RWD_30hp_wheel_bearing_RL

## Soft flex GT cars with modern sequential driveline
RECORD RWD_GT3_15 l_driveline
	name "NISSAN_GT-R_GT3"
	contents RWD_MODERN_SEQUENTIAL_FLEX_SOFT_FR_GT3v3
	dl:minhz	3000
##



###############
# RWD, modern, sequential gearbox racecars with wheel inertia in the GT3 ballpark
# MR/RR layout mass/flex
###############
RECORDGROUP RWD_MODERN_SEQUENTIAL_FLEX_MR-RR
	wheel_FR_GT3
	wheel_FL_GT3
	wheel_RR_GT3
	wheel_RL_GT3
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_GT3
	axle_strain_RL_GT3
	strain_FR_GT3
	strain_FL_GT3
	strain_RR_GT3_AXLE
	strain_RL_GT3_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_GT3
	crankshaft_GT3
	clutch_MODERN-GT_1200Nm
	clutchshaft_MODERN-GT
	clutchshaft_MODERN-GT_bearing
	clutchshaft_strain_MODERN-GT_flex
	clutchshaft_GT3_POST
	gearbox_GT3_POST_GT-MR_flex
	driveshaft_GT-MR
	driveshaft_strain_gauge_GT-MR_flex
	driveshaft_GT3_POST
	RWD_GT3_rear_diff_v3
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_30hp_wheel_bearing_RR
	RWD_30hp_wheel_bearing_RL

## LM GTE/GTLM
RECORD RWD_LMGTE_07 l_driveline
	name "PORSCHE_911_GTE"
	contents RWD_MODERN_SEQUENTIAL_FLEX_MR-RR
	dl:minhz	3000	
	
RECORD RWD_LMGTE_08 l_driveline
	name "CHEVROLET_CORVETTE_C8R"
	contents RWD_MODERN_SEQUENTIAL_FLEX_MR-RR
	dl:minhz	3000			
	
RECORD RWD_LMGTE_04 l_driveline
	name "CHEVROLET_CORVETTE_C8"
	contents RWD_MODERN_SEQUENTIAL_FLEX_MR-RR
	dl:minhz	3000			
	
RECORD RWD_LMGTE_10 l_driveline
	name "Brabham_BT62"
	contents RWD_MODERN_SEQUENTIAL_FLEX_MR-RR
	dl:minhz	3000			

##

## GT3
RECORD RWD_GT3_12 l_driveline
	name "MCLAREN_720S_GT3"
	contents RWD_MODERN_SEQUENTIAL_FLEX_MR-RR
	dl:minhz	3000

RECORD RWD_GT3R_1 l_driveline
	name "PORSCHE_991_GT3R"
	contents RWD_MODERN_SEQUENTIAL_FLEX_MR-RR
	dl:minhz	3000
##



###############
# RWD, modern, sequential, IDENTICAL except stiffer flex
# MR/RR layout flex/mass for prototype performance
###############
RECORDGROUP RWD_MODERN_SEQUENTIAL_GTPROTO_FLEX_MR
	wheel_FR_GT3
	wheel_FL_GT3
	wheel_RR_GT3
	wheel_RL_GT3
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_PROTO
	axle_strain_RL_PROTO
	strain_FR_GT3
	strain_FL_GT3
	strain_RR_GT3_AXLE
	strain_RL_GT3_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_GT3
	crankshaft_GT3
	clutch_MODERN-GT_1200Nm
	clutchshaft_MODERN-GT
	clutchshaft_MODERN-GT_bearing
	clutchshaft_strain_MODERN-GT_flex_proto
	clutchshaft_GT3_POST
	gearbox_GT3_POST_GT-MR_flex
	driveshaft_GT-MR
	driveshaft_strain_gauge_GT-MR_flex
	driveshaft_GT3_POST
	RWD_GT1_rear_diff_v3
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_30hp_wheel_bearing_RR
	RWD_30hp_wheel_bearing_RL

## GT1
RECORD RWD_FIAGT1_02 l_driveline
	name "MCLAREN_F1_GTR"
	contents RWD_MODERN_SEQUENTIAL_GTPROTO_FLEX_MR
	dl:minhz	3000

RECORD RWD_FIAGT1_03 l_driveline
	name "MERCEDES_CLK-LM"
	contents RWD_MODERN_SEQUENTIAL_GTPROTO_FLEX_MR
	dl:minhz	3000

RECORD RWD_FIAGT1_04 l_driveline
	name "NISSAN_R390_GT1"
	contents RWD_MODERN_SEQUENTIAL_GTPROTO_FLEX_MR
	dl:minhz	3000

RECORD RWD_FIAGT1_05 l_driveline
	name "PORSCHE_911_GT1_98"
	contents RWD_MODERN_SEQUENTIAL_GTPROTO_FLEX_MR
	dl:minhz	3000

RECORD RWD_FIAGT1_08 l_driveline
	name "MCLAREN_F1_GTR_LD"
	contents RWD_MODERN_SEQUENTIAL_GTPROTO_FLEX_MR
	dl:minhz	3000

RECORD RWD_FIAGT1_09 l_driveline
	name "MERCEDES_CLK-LM_LD"
	contents RWD_MODERN_SEQUENTIAL_GTPROTO_FLEX_MR
	dl:minhz	3000

RECORD RWD_FIAGT1_10 l_driveline
	name "NISSAN_R390_GT1_LD"
	contents RWD_MODERN_SEQUENTIAL_GTPROTO_FLEX_MR
	dl:minhz	3000

RECORD RWD_FIAGT1_11 l_driveline
	name "PORSCHE_911_GT1_98_LD"
	contents RWD_MODERN_SEQUENTIAL_GTPROTO_FLEX_MR
	dl:minhz	3000
##



###############
# RWD, modern, sequential, IDENTICAL except stiffer flex
# MR/RR layout flex/mass for prototype performance
# DIFF v3 ADDED!
###############
RECORDGROUP RWD_MODERN_SEQUENTIAL_GTPROTO2_FLEX_MR_v3
	wheel_FR_GT3
	wheel_FL_GT3
	wheel_RR_GT3
	wheel_RL_GT3
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_PROTO
	axle_strain_RL_PROTO
	strain_FR_GT3
	strain_FL_GT3
	strain_RR_GT3_AXLE
	strain_RL_GT3_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_GT3
	crankshaft_GT3
	clutch_MODERN-GT_1200Nm
	clutchshaft_MODERN-GT
	clutchshaft_MODERN-GT_bearing
	clutchshaft_strain_MODERN-GT_flex_proto
	clutchshaft_GT3_POST
	gearbox_GT3_POST_GT-MR_flex
	driveshaft_GT-MR
	driveshaft_strain_gauge_GT-MR_flex
	driveshaft_GT3_POST
	RWD_P1_rear_diff_v3
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_30hp_wheel_bearing_RR
	RWD_30hp_wheel_bearing_RL

## DPI
RECORD RWD_CADILLAC_DPI-VR_01 l_driveline
	name "CADILLAC_DPI-VR"
	contents RWD_MODERN_SEQUENTIAL_GTPROTO2_FLEX_MR_v3
	dl:minhz	3000
##

## P1
RECORD RWD_METALMORO_AJR_01 l_driveline
	name "METALMORO_AJR_CHEVY"
	contents RWD_MODERN_SEQUENTIAL_GTPROTO2_FLEX_MR_v3
	dl:minhz	3000
	
RECORD RWD_METALMORO_AJR_02 l_driveline
	name "METALMORO_AJR_HONDA"
	contents RWD_MODERN_SEQUENTIAL_GTPROTO2_FLEX_MR_v3
	dl:minhz	3000

RECORD RWD_METALMORO_AJR_03 l_driveline
	name "METALMORO_AJR_JUDD"
	contents RWD_MODERN_SEQUENTIAL_GTPROTO2_FLEX_MR_v3
	dl:minhz	3000
	
RECORD RWD_METALMORO_AJR_04 l_driveline
	name "METALMORO_AJR_POWERTEC"
	contents RWD_MODERN_SEQUENTIAL_GTPROTO2_FLEX_MR_v3
	dl:minhz	3000

RECORD RWD_TRACK_DAY_SEQUENTIAL_02 l_driveline
	name "GINETTA_G57"
	contents RWD_MODERN_SEQUENTIAL_GTPROTO2_FLEX_MR_v3
	dl:minhz	3000
##



###############
# RWD, modern, sequential, IDENTICAL except softer flex for fr
# FLEX ADDED! DIFF v3 ADDED!
###############
RECORDGROUP RWD_MODERN_SEQUENTIAL_FLEX_SOFT_FR_v3
	wheel_FR_GT3
	wheel_FL_GT3
	wheel_RR_GT3
	wheel_RL_GT3
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_GT3
	axle_strain_RL_GT3
	strain_FR_GT3
	strain_FL_GT3
	strain_RR_GT3_AXLE
	strain_RL_GT3_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_GT3
	crankshaft_GT3
	clutch_MODERN-GT_1200Nm
	clutchshaft_MODERN-GT
	clutchshaft_MODERN-GT_bearing
	clutchshaft_strain_MODERN-GT_flex
	clutchshaft_GT3_POST
	gearbox_GT3_POST_GT-FR_flex
	driveshaft_GT-FR
	driveshaft_strain_gauge_GT-FR_flex_waxle_soft
	driveshaft_GT3_POST
	RWD_VLSD_rear_diff_v3
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_30hp_wheel_bearing_RR
	RWD_30hp_wheel_bearing_RL

## Stock Cars
RECORD RWD_STOCK_CRUZE l_driveline
	name "STOCK_CRUZE"
	contents RWD_MODERN_SEQUENTIAL_FLEX_SOFT_FR_v3
	dl:minhz	3000

RECORD RWD_STOCK_CRUZE_20 l_driveline
	name "STOCK_CRUZE_20"
	contents RWD_MODERN_SEQUENTIAL_FLEX_SOFT_FR_v3
	dl:minhz	3000
	
RECORD RWD_STOCK_COROLLA l_driveline
	name "STOCK_COROLLA"
	contents RWD_MODERN_SEQUENTIAL_FLEX_SOFT_FR_v3
	dl:minhz	3000

RECORD RWD_MONTANA l_driveline
	name "MONTANA"
	contents RWD_MODERN_SEQUENTIAL_FLEX_SOFT_FR_v3
	dl:minhz	3000
	
RECORD RWD_STOCK_CRUZE_SO l_driveline
	name "STOCK_CRUZE_SO"
	contents RWD_MODERN_SEQUENTIAL_FLEX_SOFT_FR_v3
	dl:minhz	3000

RECORD RWD_STOCK_CRUZE_SO_20 l_driveline
	name "STOCK_CRUZE_20_SO"
	contents RWD_MODERN_SEQUENTIAL_FLEX_SOFT_FR_v3
	dl:minhz	3000
	
RECORD RWD_STOCK_COROLLA_SO l_driveline
	name "STOCK_COROLLA_SO"
	contents RWD_MODERN_SEQUENTIAL_FLEX_SOFT_FR_v3
	dl:minhz	3000

RECORD RWD_MONTANA_SO l_driveline
	name "MONTANA_SO"
	contents RWD_MODERN_SEQUENTIAL_FLEX_SOFT_FR_v3
	dl:minhz	3000

RECORD RWD_STOCK_CRUZE_SW l_driveline
	name "STOCK_CRUZE_SW"
	contents RWD_MODERN_SEQUENTIAL_FLEX_SOFT_FR_v3
	dl:minhz	3000

RECORD RWD_STOCK_CRUZE_SW_20 l_driveline
	name "STOCK_CRUZE_20_SW"
	contents RWD_MODERN_SEQUENTIAL_FLEX_SOFT_FR_v3
	dl:minhz	3000
	
RECORD RWD_STOCK_COROLLA_SW l_driveline
	name "STOCK_COROLLA_SW"
	contents RWD_MODERN_SEQUENTIAL_FLEX_SOFT_FR_v3
	dl:minhz	3000

RECORD RWD_MONTANA_SW l_driveline
	name "MONTANA_SW"
	contents RWD_MODERN_SEQUENTIAL_FLEX_SOFT_FR_v3
	dl:minhz	3000
##



###############
# RWD, modern, sequential, IDENTICAL except softer flex for mr
# FLEX ADDED! DIFF v3 ADDED!
###############
RECORDGROUP RWD_MODERN_SEQUENTIAL_FLEX_SOFT_MR_v3
	wheel_FR_GT3
	wheel_FL_GT3
	wheel_RR_GT3
	wheel_RL_GT3
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_PROTO
	axle_strain_RL_PROTO
	strain_FR_GT3
	strain_FL_GT3
	strain_RR_GT3_AXLE
	strain_RL_GT3_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_GT3
	crankshaft_GT3
	clutch_MODERN-GT_1200Nm
	clutchshaft_MODERN-GT
	clutchshaft_MODERN-GT_bearing
	clutchshaft_strain_MODERN-GT_flex
	clutchshaft_GT3_POST
	gearbox_GT3_POST_GT-MR_flex
	driveshaft_GT-MR
	driveshaft_strain_gauge_GT-MR_flex
	driveshaft_GT3_POST
	RWD_P2_rear_diff_v3
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_30hp_wheel_bearing_RR
	RWD_30hp_wheel_bearing_RL

## P2
RECORD RWD_SIGMA_P1_01 l_driveline
	name "SIGMA_P1"
	contents RWD_MODERN_SEQUENTIAL_FLEX_SOFT_MR_v3
	dl:minhz	3000

RECORD RWD_METALMORO_MRX_02 l_driveline
	name "METALMORO_MRX_SHARKFIN"
	contents RWD_MODERN_SEQUENTIAL_FLEX_SOFT_MR_v3
	dl:minhz	3000
##



###############
# RWD, modern, sequential, IDENTICAL except softer flex for mr
# FLEX ADDED! DIFF v3 ADDED!
###############
RECORDGROUP RWD_MODERN_SEQUENTIAL_FLEX_SOFT_MR2_v3
	wheel_FR_GT3
	wheel_FL_GT3
	wheel_RR_GT3
	wheel_RL_GT3
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_PROTO
	axle_strain_RL_PROTO
	strain_FR_GT3
	strain_FL_GT3
	strain_RR_GT3_AXLE
	strain_RL_GT3_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_GT3
	crankshaft_GT3
	clutch_MODERN-GT_1200Nm
	clutchshaft_MODERN-GT
	clutchshaft_MODERN-GT_bearing
	clutchshaft_strain_MODERN-GT_flex
	clutchshaft_GT3_POST
	gearbox_GT3_POST_GT-MR_flex
	driveshaft_GT-MR
	driveshaft_strain_gauge_GT-MR_flex
	driveshaft_GT3_POST
	RWD_GT3_rear_diff_v3
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_30hp_wheel_bearing_RR
	RWD_30hp_wheel_bearing_RL

## Ultima
RECORD RWD_TRACK_DAY_SEQUENTIAL_05 l_driveline
	name "ULTIMA_RACE"
	contents RWD_MODERN_SEQUENTIAL_FLEX_SOFT_MR2_v3
	dl:minhz	3000
##



###############
# RWD, modern, sequential gearbox Porschesballpark
# FLEX ADDED! DIFF v3 ADDED!
###############
RECORDGROUP RWD_MODERN_SEQUENTIAL_2_FLEX_v3
	wheel_FR_GT3
	wheel_FL_GT3
	wheel_RR_GT3
	wheel_RL_GT3
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_GT3
	axle_strain_RL_GT3
	strain_FR_GT3
	strain_FL_GT3
	strain_RR_GT3_AXLE
	strain_RL_GT3_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_GT3
	crankshaft_GT3
	clutch_MODERN-GT_1200Nm
	clutchshaft_MODERN-GT
	clutchshaft_MODERN-GT_bearing
	clutchshaft_strain_MODERN-GT_flex
	clutchshaft_GT3_POST
	gearbox_GT3_POST_GT-MR_flex
	driveshaft_GT-MR
	driveshaft_strain_gauge_GT-MR_flex
	driveshaft_GT3_POST
	RWD_VLSD_rear_diff_v3
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_30hp_wheel_bearing_RR
	RWD_30hp_wheel_bearing_RL
	
RECORD RWD_GT3CUP_1 l_driveline
	name "PORSCHE_991_CUP"
	contents RWD_MODERN_SEQUENTIAL_2_FLEX_v3
	dl:minhz	3000	

RECORD RWD_GT3CUP_2 l_driveline
	name "PORSCHE_991_CUP2"
	contents RWD_MODERN_SEQUENTIAL_2_FLEX_v3
	dl:minhz	3000
##	



###############
# RWD, modern, sequential gearbox racecars with wheel inertia in the GT3 ballpark
# Semi-automatic gearbox. No clutch pedal
# FLEX ADDED! DIFF v3 ADDED!
###############
RECORDGROUP RWD_MODERN_SEQUENTIAL_SEMI-AUTO_FLEX_FR_v3
	wheel_FR_GT3
	wheel_FL_GT3
	wheel_RR_GT3
	wheel_RL_GT3
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_TCR
	axle_strain_RL_TCR
	strain_FR_GT3
	strain_FL_GT3
	strain_RR_GT3_AXLE
	strain_RL_GT3_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_GT3
	crankshaft_GT3
	clutch_MODERN-GT_1200Nm
	clutchshaft_MODERN-GT
	clutchshaft_MODERN-GT_bearing
	clutchshaft_strain_MODERN-GT_flex
	clutchshaft_GT3_POST
	gearbox_GT3_POST_GT-FR_flex
	driveshaft_GT-FR
	driveshaft_strain_gauge_GT-FR_flex_waxle
	driveshaft_GT3_POST
	RWD_GT4_rear_diff_v3
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_30hp_wheel_bearing_RR
	RWD_30hp_wheel_bearing_RL

## GT4
RECORD RWD_GT4_SEMI-AUTO_01 l_driveline
	name "ASTON_MARTIN_VANTAGE_GT4"
	contents RWD_MODERN_SEQUENTIAL_SEMI-AUTO_FLEX_FR_v3
	dl:minhz	3000

RECORD RWD_GT4_SEMI-AUTO_03 l_driveline
	name "GINETTA_G55_GT4"
	contents RWD_MODERN_SEQUENTIAL_SEMI-AUTO_FLEX_FR_v3
	dl:minhz	3000

RECORD RWD_GT4_SEMI-AUTO_04 l_driveline
	name "GINETTA_G55_GT4_2"
	contents RWD_MODERN_SEQUENTIAL_SEMI-AUTO_FLEX_FR_v3
	dl:minhz	3000

RECORD RWD_GT4_SEMI-AUTO_05 l_driveline
	name "BMW_M4_GT4"
	contents RWD_MODERN_SEQUENTIAL_SEMI-AUTO_FLEX_FR_v3
	dl:minhz	3000

RECORD RWD_GT4_SEMI-AUTO_06 l_driveline
	name "MERCEDES_AMG_GT4"
	contents RWD_MODERN_SEQUENTIAL_SEMI-AUTO_FLEX_FR_v3
	dl:minhz	3000

RECORD RWD_GT4_02 l_driveline
	name "CAMARO_GT4R"
	contents RWD_MODERN_SEQUENTIAL_SEMI-AUTO_FLEX_FR_v3
	dl:minhz	3000

# Note:
## Cayman in RWD_MODERN_SEQUENTIAL_SEMI-AUTO_FLEX_MR
## McLaren 570 in RWD_MODERN_SEQUENTIAL_SEMI-AUTO_FLEX_MR



## Track day cars that are basically GT3 with semi-auto gearbox
RECORD RWD_TRACK_DAY_SEMI-AUTO_01 l_driveline
	name "PAGANI_ZONDA_REVO"
	contents RWD_MODERN_SEQUENTIAL_SEMI-AUTO_FLEX
##


###############
# RWD, modern, sequential gearbox racecars with wheel inertia in the GT3 ballpark
# Semi-automatic gearbox. No clutch pedal
# FLEX ADDED! DIFF v3 ADDED!
###############
RECORDGROUP RWD_MODERN_SEQUENTIAL_SEMI-AUTO_FLEX_MR_v3
	wheel_FR_GT3
	wheel_FL_GT3
	wheel_RR_GT3
	wheel_RL_GT3
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_TCR
	axle_strain_RL_TCR
	strain_FR_GT3
	strain_FL_GT3
	strain_RR_GT3_AXLE
	strain_RL_GT3_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_GT3
	crankshaft_GT3
	clutch_MODERN-GT_1200Nm
	clutchshaft_MODERN-GT
	clutchshaft_MODERN-GT_bearing
	clutchshaft_strain_MODERN-GT_flex
	clutchshaft_GT3_POST
	gearbox_GT3_POST_GT-MR_flex
	driveshaft_GT-MR
	driveshaft_strain_gauge_GT-MR_flex
	driveshaft_GT3_POST
	RWD_GT4_rear_diff_v3
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_30hp_wheel_bearing_RR
	RWD_30hp_wheel_bearing_RL

## GT4
RECORD RWD_GT4_SEMI-AUTO_02 l_driveline
	name "PORSCHE_CAYMAN_GT4CS"
	contents RWD_MODERN_SEQUENTIAL_SEMI-AUTO_FLEX_MR_v3
	dl:minhz	3000

RECORD RWD_MODERN_DUAL-CLUTCH_09 l_driveline
	name "MCLAREN_570S_GT4"
	contents RWD_MODERN_SEQUENTIAL_SEMI-AUTO_FLEX_MR_v3
	dl:minhz	3000
##



###############
# Variant for the Huayra so it holds on the start line and doesn't jump start
###############
RECORDGROUP RWD_MODERN_SEQUENTIAL_SEMI-AUTO_HUAYRA
	wheel_FR_ROAD_medium
	wheel_FL_ROAD_medium
	wheel_RR_ROAD_medium
	wheel_RL_ROAD_medium
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR_ROAD_medium
	strain_FL_ROAD_medium
	strain_RR_ROAD_medium
	strain_RL_ROAD_medium
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	crankshaft_GT3
	clutch_GT3_1500Nm
	clutchshaft_GT3
	clutchshaft_GT3_bearing
	gearbox_GT3
	driveshaft_GT3
	driveshaft_strain_gauge
	driveshaft_GT3_POST
	RWD_rear_diff
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_30hp_wheel_bearing_RR
	RWD_30hp_wheel_bearing_RL

RECORD RWD_TRACK_DAY_SEMI-AUTO_02 l_driveline
	name "PAGANI_HUAYRA_BC"
	contents RWD_MODERN_SEQUENTIAL_SEMI-AUTO_HUAYRA
	dl:minhz	3000

RECORD RWD_ROAD_AUTOMATIC_04 l_driveline
	name "FERRARI_ENZO"
	contents RWD_MODERN_SEQUENTIAL_SEMI-AUTO_HUAYRA
	dl:minhz	3000

###############
# RWD, modern, dual-clutch or automated manual gearbox cars. Normal road car wheel inertia and moderate driveline power loss
# ADD FLEX!
###############
RECORDGROUP RWD_MODERN_DUAL-CLUTCH_FLEX
	wheel_FR_GT3
	wheel_FL_GT3
	wheel_RR_GT3
	wheel_RL_GT3
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR_GT3
	strain_FL_GT3
	strain_RR_GT3
	strain_RL_GT3
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	crankshaft_GT3
	clutch_GT3_650Nm
	clutchshaft_GT3
	clutchshaft_GT3_bearing
	gearbox_AMT_synchro_MEDIUM-LIGHT_flex_stiff
	driveshaft_MEDIUM-LIGHT
	driveshaft_strain_gauge_MEDIUM-LIGHT_flex_stiff
	driveshaft_GT3_POST
	RWD_VLSD_rear_diff
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_30hp_wheel_bearing_RR
	RWD_30hp_wheel_bearing_RL

##
## Originals
##
RECORD RWD_MODERN_DUAL-CLUTCH_01 l_driveline
	name "MCLAREN_570S"
	contents RWD_MODERN_DUAL-CLUTCH_FLEX
	dl:minhz	3000

RECORD RWD_MODERN_DUAL-CLUTCH_02 l_driveline
	name "MCLAREN_P1"
	contents RWD_MODERN_DUAL-CLUTCH_FLEX
	dl:minhz	3000

RECORD RWD_MODERN_DUAL-CLUTCH_03 l_driveline
	name "MCLAREN_P1_GTR"
	contents RWD_MODERN_DUAL-CLUTCH_FLEX
	dl:minhz	3000

RECORD RWD_MODERN_DUAL-CLUTCH_04 l_driveline
	name "MCLAREN_P14"
	contents RWD_MODERN_DUAL-CLUTCH_FLEX
	dl:minhz	3000

RECORD RWD_MODERN_DUAL-CLUTCH_06 l_driveline
	name "FORD_GT_2016"
	contents RWD_MODERN_DUAL-CLUTCH_FLEX
	dl:minhz	3000

RECORD RWD_MODERN_DUAL-CLUTCH_07 l_driveline
	name "PORSCHE_991_GT3RS"
	contents RWD_MODERN_DUAL-CLUTCH_FLEX
	dl:minhz	3000

RECORD RWD_MODERN_DUAL-CLUTCH_08 l_driveline
	name "FERRARI_488_CHALLENGE"
	contents RWD_MODERN_DUAL-CLUTCH_FLEX
	dl:minhz	3000



###############
# RWD, modern, sequential gearbox racecars with wheel inertia in the GT3 ballpark and higher drivetrain loss
# Variant of typical GT3 model for very high power cars
###############
RECORDGROUP RWD_MODERN_SEQUENTIAL_HIGHPOWER
	wheel_FR_ROAD_medium
	wheel_FL_ROAD_medium
	wheel_RR_ROAD_medium
	wheel_RL_ROAD_medium
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR_ROAD_medium
	strain_FL_ROAD_medium
	strain_RR_ROAD_medium
	strain_RL_ROAD_medium
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	crankshaft_GT3
	clutch_GT3_1000Nm
	clutchshaft_GT3
	clutchshaft_GT3_bearing
	gearbox_GT3
	driveshaft_GT3
	driveshaft_strain_gauge
	driveshaft_GT3_POST
	RWD_rear_diff
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_20hp_wheel_bearing_RR
	RWD_20hp_wheel_bearing_RL

RECORD RWD_V8SUPERCAR_01 l_driveline
	name "FORD_FALCON_FG_SV8"
	contents RWD_MODERN_SEQUENTIAL_HIGHPOWER
	dl:minhz	3000

RECORD RWD_DRIFT_01 l_driveline
	name "MAZDA_MX5_RADBUL"
	contents RWD_MODERN_SEQUENTIAL_HIGHPOWER
	dl:minhz	3000

RECORD RWD_DRIFT_02 l_driveline
	name "FORD_MUSTANG_RTR_FD"
	contents RWD_MODERN_SEQUENTIAL_HIGHPOWER
	dl:minhz	3000
#



###############
# RWD, modern, sequential gearbox racecars with wheel inertia in the GT3 ballpark and higher drivetrain loss
# Variant of typical GT3 model for very high power cars
# FLEX ADDED!
###############
RECORDGROUP RWD_MODERN_SEQUENTIAL_HIGHPOWER_FLEX
	wheel_FR_ROAD_medium
	wheel_FL_ROAD_medium
	wheel_RR_ROAD_medium
	wheel_RL_ROAD_medium
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_SV8
	axle_strain_RL_SV8
	strain_FR_ROAD_medium
	strain_FL_ROAD_medium
	strain_RR_ROAD_medium_AXLE
	strain_RL_ROAD_medium_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_GT3
	crankshaft_GT3
	clutch_MODERN-GT_1200Nm
	clutchshaft_MODERN-GT
	clutchshaft_MODERN-GT_bearing
	clutchshaft_strain_MODERN-GT_flex
	clutchshaft_GT3_POST
	gearbox_GT3_POST_GT-FR_flex
	driveshaft_GT-FR
	driveshaft_strain_gauge_GT-FR_flex_waxle_soft
	driveshaft_GT3_POST
	RWD_rear_diff
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_20hp_wheel_bearing_RR
	RWD_20hp_wheel_bearing_RL

RECORD RWD_SUPER_V8 l_driveline
	name "SUPER_V8"
	contents RWD_MODERN_SEQUENTIAL_HIGHPOWER_FLEX
	dl:minhz	3000	
	
RECORD RWD_SUPER_V8_SO l_driveline
	name "SUPER_V8_SO"
	contents RWD_MODERN_SEQUENTIAL_HIGHPOWER_FLEX
	dl:minhz	3000		

RECORD RWD_SUPER_V8_SW l_driveline
	name "SUPER_V8_SW"
	contents RWD_MODERN_SEQUENTIAL_HIGHPOWER_FLEX
	dl:minhz	3000			
#



###############
# RWD, modern sequential gearbox, low engine inertia, low wheel inertia
# FLEX ADDED!
###############
RECORDGROUP RWD_MODERN_SEQUENTIAL_TCR_FLEX
	wheel_FR_TCR
	wheel_FL_TCR
	wheel_RR_TCR
	wheel_RL_TCR
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR_TCR
	strain_FL_TCR
	strain_RR_TCR
	strain_RL_TCR
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	crankshaft_TCR
	clutch_TCR_550Nm
	clutchshaft_GT3
	clutchshaft_GT3_bearing
	clutchshaft_strain_GT3_flex_stiff
	clutchshaft_GT3_POST
	gearbox_GT3_POST_LIGHT_flex
	driveshaft_LIGHT
	driveshaft_strain_gauge_LIGHT_flex_stiff
	driveshaft_GT3_POST
	RWD_light_rear_diff
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	wheel_bearing_RR
	wheel_bearing_RL

## FWD TCR
RECORD RWD_TOURINGCAR_01 l_driveline
	name "BMW_320TC"
	contents RWD_MODERN_SEQUENTIAL_TCR_FLEX
	dl:minhz	3000
	
##

## Road cars that essentially work like small formula cars	
RECORD RWD_LIGHT_SPORTSCAR_02 l_driveline
	name "CATERHAM_SP300R"
	contents RWD_MODERN_SEQUENTIAL_TCR_FLEX
	dl:minhz	3000

RECORD RWD_LIGHT_SPORTSCAR_03 l_driveline
	name "RADICAL_SR3"
	contents RWD_MODERN_SEQUENTIAL_TCR_FLEX
	dl:minhz	3000	
	
RECORD RWD_LIGHT_SPORTSCAR_04 l_driveline
	name "RADICAL_SR8"
	contents RWD_MODERN_SEQUENTIAL_TCR_FLEX
	dl:minhz	3000
	
RECORD RWD_LIGHT_SPORTSCAR_05 l_driveline
	name "BAC_MONO"
	contents RWD_MODERN_SEQUENTIAL_TCR_FLEX
	dl:minhz	3000



###############
# RWD, modern sequential gearbox, low engine inertia, low wheel inertia
# For Caterhams with open diff
# FLEX ADDED!
###############
RECORDGROUP RWD_MODERN_SEQUENTIAL_TCR_CAT_OPEN_FLEX
	wheel_FR_TCR
	wheel_FL_TCR
	wheel_RR_TCR
	wheel_RL_TCR
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_TRAINER
	axle_strain_RL_TRAINER
	strain_FR_TCR
	strain_FL_TCR
	strain_RR_TCR_AXLE
	strain_RL_TCR_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_GT3
	crankshaft_GT3
	clutch_MODERN-GT
	clutchshaft_MODERN-GT
	clutchshaft_MODERN-GT_bearing
	clutchshaft_strain_MODERN-GT_flex_soft
	clutchshaft_GT3_POST
	gearbox_H-pattern_synchro_POST_GT-FR_flex
	driveshaft_GT-FR
	driveshaft_strain_gauge_GT-FR_flex_waxle_soft
	driveshaft_GT3_POST
	RWD_proto_open_rear_diff
	planet_gear_rear_MED
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	wheel_bearing_RR
	wheel_bearing_RL

RECORD RWD_H-PATTERN_SYNCHRO_LOW_LOW_10 l_driveline
	name "CATERHAM_ACADEMY"
	contents RWD_MODERN_SEQUENTIAL_TCR_CAT_OPEN_FLEX
	dl:minhz	3000
##



###############
# RWD, modern sequential gearbox, low engine inertia, low wheel inertia
# For Caterhams with LSD
# FLEX ADDED! DIFF v3 ADDED!
###############
RECORDGROUP RWD_MODERN_SEQUENTIAL_TCR_CAT_LSD_FLEX_v3
	wheel_FR_TCR
	wheel_FL_TCR
	wheel_RR_TCR
	wheel_RL_TCR
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_F1L
	axle_strain_RL_F1L
	strain_FR_TCR
	strain_FL_TCR
	strain_RR_TCR_AXLE
	strain_RL_TCR_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_GT3
	crankshaft_GT3
	clutch_MODERN-GT
	clutchshaft_MODERN-GT
	clutchshaft_MODERN-GT_bearing
	clutchshaft_strain_MODERN-GT_flex_soft
	clutchshaft_GT3_POST
	gearbox_GT3_POST_GT-FR_flex
	driveshaft_GT-FR
	driveshaft_strain_gauge_GT-FR_flex_waxle_soft
	driveshaft_GT3_POST
	RWD_light_rear_diff_v3
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	wheel_bearing_RR
	wheel_bearing_RL

RECORD RWD_LIGHT_CATERHAM l_driveline
	name "CATERHAM_SUPERLIGHT"
	contents RWD_MODERN_SEQUENTIAL_TCR_CAT_LSD_FLEX_v3
	dl:minhz	3000

RECORD RWD_LIGHT_CATERHAM_2 l_driveline
	name "CATERHAM_SUPERSPORT"
	contents RWD_MODERN_SEQUENTIAL_TCR_CAT_LSD_FLEX_v3
	dl:minhz	3000

RECORD RWD_LIGHT_SPORTSCAR_01 l_driveline
	name "CATERHAM_620R"
	contents RWD_MODERN_SEQUENTIAL_TCR_CAT_LSD_FLEX_v3
	dl:minhz	3000
##



###############	
# RWD, modern sequential gearbox, low engine inertia, low wheel inertia
# FLEX ADDED! DIFF v3 ADDED!
###############
RECORDGROUP RWD_MODERN_SEQUENTIAL_TCR_2_FLEX_v3
	wheel_FR_TCR
	wheel_FL_TCR
	wheel_RR_TCR
	wheel_RL_TCR
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_LPROTO
	axle_strain_RL_LPROTO
	strain_FR_TCR
	strain_FL_TCR
	strain_RR_TCR_AXLE
	strain_RL_TCR_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_TCR
	crankshaft_TCR
	clutch_TCR_450Nm
	clutchshaft_GT3
	clutchshaft_GT3_bearing
	clutchshaft_strain_GT3_flex_stiff
	clutchshaft_GT3_POST
	gearbox_GT3_POST_GT-MR_flex
	driveshaft_GT-MR
	driveshaft_strain_gauge_GT-MR_flex_soft
	driveshaft_GT3_POST
	RWD_light_rear_diff_v3
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	wheel_bearing_RR
	wheel_bearing_RL	

RECORD RWD_F301_01 l_driveline
	name "F301"
	contents RWD_MODERN_SEQUENTIAL_TCR_2_FLEX_v3
	dl:minhz	3000

RECORD RWD_F309_01 l_driveline
	name "F309"
	contents RWD_MODERN_SEQUENTIAL_TCR_2_FLEX_v3
	dl:minhz	3000

RECORD RWD_ROCO_01 l_driveline
	name "ROCO"
	contents RWD_MODERN_SEQUENTIAL_TCR_2_FLEX_v3
	dl:minhz	3000	
	
RECORD RWD_METALMORO_MRX_01 l_driveline
	name "METALMORO_MRX"
	contents RWD_MODERN_SEQUENTIAL_TCR_2_FLEX_v3
	dl:minhz	3000
#



###############
# RWD, modern sequential gearbox, low engine inertia, low wheel inertia, low drivetrain power loss
# DIFF v3 ADDED!
###############
RECORDGROUP RWD_MODERN_SEQUENTIAL_TCR_3_FLEX_v3
	wheel_FR_TCR
	wheel_FL_TCR
	wheel_RR_TCR
	wheel_RL_TCR
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_LPROTO
	axle_strain_RL_LPROTO
	strain_FR_TCR
	strain_FL_TCR
	strain_RR_TCR_AXLE
	strain_RL_TCR_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_TCR
	crankshaft_TCR
	clutch_TCR_550Nm
	clutchshaft_GT3
	clutchshaft_GT3_bearing
	clutchshaft_strain_GT3_flex_stiff
	clutchshaft_GT3_POST
	gearbox_GT3_POST_GT-MR_flex
	driveshaft_GT-MR
	driveshaft_strain_gauge_GT-MR_flex_soft
	driveshaft_GT3_POST
	RWD_light_rear_diff_v3
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_15hp_wheel_bearing_RR
	RWD_15hp_wheel_bearing_RL

## P3
RECORD RWD_METALMORO_MRX_03 l_driveline
	name "METALMORO_MRX_P3"
	contents RWD_MODERN_SEQUENTIAL_TCR_3_FLEX_v3
	dl:minhz	3000

RECORD RWD_METALMORO_MRX_04 l_driveline
	name "METALMORO_MRX_HONDA"
	contents RWD_MODERN_SEQUENTIAL_TCR_3_FLEX_v3
	dl:minhz	3000
#

## Sprint Race
RECORD RWD_SPRINTRACE l_driveline
	name "SPRINTRACE"
	contents RWD_MODERN_SEQUENTIAL_TCR_3_FLEX_v3
	dl:minhz	3000	
#



###############
# RWD, modern sequential gearbox, low engine inertia, low wheel inertia, low drivetrain power loss
# Open diff
###############
RECORDGROUP RWD_MODERN_SEQUENTIAL_TCR_3_OPEN_FLEX
	wheel_FR_TCR
	wheel_FL_TCR
	wheel_RR_TCR
	wheel_RL_TCR
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_TCR
	axle_strain_RL_TCR
	strain_FR_TCR
	strain_FL_TCR
	strain_RR_TCR_AXLE
	strain_RL_TCR_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_TCR
	crankshaft_TCR
	clutch_TCR_550Nm
	clutchshaft_GT3
	clutchshaft_GT3_bearing
	clutchshaft_strain_GT3_flex_stiff
	clutchshaft_GT3_POST
	gearbox_GT3_POST_GT-MR_flex
	driveshaft_GT-MR
	driveshaft_strain_gauge_GT-MR_flex_soft
	driveshaft_GT3_POST
	RWD_proto_open_rear_diff
	planet_gear_rear_MED
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_15hp_wheel_bearing_RR
	RWD_15hp_wheel_bearing_RL

RECORD RWD_PUMA_P052 l_driveline
	name "PUMA_P052"
	contents RWD_MODERN_SEQUENTIAL_TCR_3_OPEN_FLEX
	dl:minhz	3000
#



###############
# RWD, modern gearbox, GT3 engine inertia, low wheel inertia, very low drivetrain power loss
# Ginetta G40s
# FLEX ADDED!
###############
RECORDGROUP RWD_MODERN_SEQUENTIAL_TCR_4_FLEX
	wheel_FR_TCR
	wheel_FL_TCR
	wheel_RR_TCR
	wheel_RL_TCR
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_TCR
	axle_strain_RL_TCR
	strain_FR_TCR
	strain_FL_TCR
	strain_RR_TCR_AXLE
	strain_RL_TCR_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_GT3
	crankshaft_GT3
	clutch_TCR_350Nm
	clutchshaft_GT3
	clutchshaft_GT3_bearing
	clutchshaft_strain_GT3_flex_soft
	clutchshaft_GT3_POST
	gearbox_GT3_POST_GT-FR_flex
	driveshaft_GT-FR
	driveshaft_strain_gauge_GT-FR_flex_waxle_soft
	driveshaft_GT3_POST
	RWD_geared_rear_diff
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	wheel_bearing_RR
	wheel_bearing_RL

RECORD RWD_GINETTA_G40_01 l_driveline
	name "GINETTA_G40"
	contents RWD_MODERN_SEQUENTIAL_TCR_4_FLEX
	dl:minhz	3000

RECORD RWD_GINETTA_G40_02 l_driveline
	name "GINETTA_G40_GT5"
	contents RWD_MODERN_SEQUENTIAL_TCR_4_FLEX
	dl:minhz	3000

RECORD RWD_GINETTA_G40_03 l_driveline
	name "GINETTA_G40_CUP"
	contents RWD_MODERN_SEQUENTIAL_TCR_4_FLEX
	dl:minhz	3000
#



###############
# Variant of above with super low engine inertia for 19,000rpm Formula A
# FLEX ADDED! DIFF v3 ADDED!
###############
RECORDGROUP RWD_MODERN_SEQUENTIAL_FORMULA_A_FLEX_v3
	wheel_FR_TCR
	wheel_FL_TCR
	wheel_RR_TCR
	wheel_RL_TCR
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_F1L
	axle_strain_RL_F1L
	strain_FR_TCR
	strain_FL_TCR
	strain_RR_TCR_AXLE
	strain_RL_TCR_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_F1
	crankshaft_F1
	clutch_F1_750Nm
	clutchshaft_F1
	clutchshaft_F1_bearing
	clutchshaft_strain_F1_flex
	clutchshaft_F1_POST
    gearbox_F1_POST_F1_flex_soft
	driveshaft_F1
	driveshaft_strain_gauge_F1_flex_waxle_soft
	driveshaft_GT3_POST
	RWD_F1LSD_rear_diff_v3
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_15hp_wheel_bearing_RR
	RWD_15hp_wheel_bearing_RL

RECORD RWD_MODERN_FORMULA_02 l_driveline
	name "FORMULA_A"
	contents RWD_MODERN_SEQUENTIAL_FORMULA_A_FLEX_v3
	dl:minhz	3000

RECORD RWD_FORMULA_V10_01 l_driveline
	name "FORMULA_V10"
	contents RWD_MODERN_SEQUENTIAL_FORMULA_A_FLEX_v3
	dl:minhz	3000

RECORD RWD_FORMULA_V10_G1_01 l_driveline
	name "FORMULA_V10_G1"
	contents RWD_MODERN_SEQUENTIAL_FORMULA_A_FLEX_v3
	dl:minhz	3000

RECORD RWD_FORMULA_V10_G1_02 l_driveline
	name "MCLAREN_MP4_12"
	contents RWD_MODERN_SEQUENTIAL_FORMULA_A_FLEX_v3
	dl:minhz	3000
	
RECORD RWD_FORMULA_V12_01 l_driveline
	name "FORMULA_V12"
	contents RWD_MODERN_SEQUENTIAL_FORMULA_A_FLEX_v3
	dl:minhz	3000
	
RECORD RWD_FORMULA_V10_LD_01 l_driveline
	name "FORMULA_V10_LD"
	contents RWD_MODERN_SEQUENTIAL_FORMULA_A_FLEX_v3
	dl:minhz	3000

RECORD RWD_FORMULA_V10_G1_LD_01 l_driveline
	name "FORMULA_V10_G1_LD"
	contents RWD_MODERN_SEQUENTIAL_FORMULA_A_FLEX_v3
	dl:minhz	3000

RECORD RWD_FORMULA_V10_G1_LD_02 l_driveline
	name "MCLAREN_MP4_12_LD"
	contents RWD_MODERN_SEQUENTIAL_FORMULA_A_FLEX_v3
	dl:minhz	3000
	
RECORD RWD_FORMULA_V12_LD_01 l_driveline
	name "FORMULA_V12_LD"
	contents RWD_MODERN_SEQUENTIAL_FORMULA_A_FLEX_v3
	dl:minhz	3000

RECORD RWD_FORMULA_REIZA_01 l_driveline
	name "FORMULA_REIZA"
	contents RWD_MODERN_SEQUENTIAL_FORMULA_A_FLEX_v3
	dl:minhz	3000

RECORD RWD_FORMULA_REIZA_LD_01 l_driveline
	name "FORMULA_REIZA_LD"
	contents RWD_MODERN_SEQUENTIAL_FORMULA_A_FLEX_v3
	dl:minhz	3000
#

## Formula cars wanting low engine inertia. 1000Nm clutch is plenty
RECORD RWD_MODERN_INDYCAR_01 l_driveline
	name "DALLARA_DW12_OVAL"
	contents RWD_MODERN_SEQUENTIAL_FORMULA_A_FLEX_v3
	dl:minhz	3000

RECORD RWD_MODERN_INDYCAR_02 l_driveline
	name "DALLARA_DW12_SPEEDWAY_NON-OVAL"
	contents RWD_MODERN_SEQUENTIAL_FORMULA_A_FLEX_v3
	dl:minhz	3000

RECORD RWD_MODERN_INDYCAR_03 l_driveline
	name "DALLARA_DW12_ROAD"
	contents RWD_MODERN_SEQUENTIAL_FORMULA_A_FLEX_v3
	dl:minhz	3000
#



###############
# FLEX ADDED! DIFF v3 ADDED!
###############
RECORDGROUP RWD_MODERN_SEQUENTIAL_FORMULA_ULTIMATE_FLEX_v3
	wheel_FR_TCR
	wheel_FL_TCR
	wheel_RR_TCR
	wheel_RL_TCR
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_F1
	axle_strain_RL_F1
	strain_FR_TCR
	strain_FL_TCR
	strain_RR_TCR_AXLE
	strain_RL_TCR_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_F1_ERS
	crankshaft_F1_ERS
	clutch_F1_1000Nm
	clutchshaft_F1
	clutchshaft_F1_bearing
	clutchshaft_strain_F1_flex
	clutchshaft_F1_POST
    gearbox_F1_POST_F1_flex
	driveshaft_F1
	driveshaft_strain_gauge_F1_flex_waxle
	driveshaft_GT3_POST
	RWD_F1LSD_rear_diff_v3
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_15hp_wheel_bearing_RR
	RWD_15hp_wheel_bearing_RL
	
RECORD RWD_FORMULA_ULTIMATE_01 l_driveline
	name "FORMULA_ULTIMATE_2019"
	contents RWD_MODERN_SEQUENTIAL_FORMULA_ULTIMATE_FLEX_v3
	dl:minhz	3000		
	
RECORD RWD_FORMULA_ULTIMATE_02 l_driveline
	name "FORMULA_ULTIMATE_2022"
	contents RWD_MODERN_SEQUENTIAL_FORMULA_ULTIMATE_FLEX_v3
	dl:minhz	3000		

RECORD RWD_FORMULA_ULTIMATE_LD_01 l_driveline
	name "FORMULA_ULTIMATE_2019_LD"
	contents RWD_MODERN_SEQUENTIAL_FORMULA_ULTIMATE_FLEX_v3
	dl:minhz	3000		
	
RECORD RWD_FORMULA_ULTIMATE_LD_02 l_driveline
	name "FORMULA_ULTIMATE_2022_LD"
	contents RWD_MODERN_SEQUENTIAL_FORMULA_ULTIMATE_FLEX_v3
	dl:minhz	3000	
##	
##


	
###############
# RWD, super light everything with low drivetrain loss. Honda 2&4 MotoGP drivetrain
###############
RECORDGROUP RWD_MODERN_DUALCLUTCH_HONDA2AND4
	wheel_FR_TCR
	wheel_FL_TCR
	wheel_RR_TCR
	wheel_RL_TCR
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR_ARC
	axle_RL_ARC
	axle_strain_RR_ARC
	axle_strain_RL_ARC
	strain_FR_TCR
	strain_FL_TCR
	strain_RR_TCR_AXLE_ARC
	strain_RL_TCR_AXLE_ARC
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_F1
	crankshaft_F1
	clutch_TCR_ARC
	clutchshaft_GT3
	gearbox_GT3_GT-MR_flex
	driveshaft_GT-MR
	driveshaft_strain_gauge_GT-MR_flex_ultrasoft
	driveshaft_GT3_POST
	RWD_light_rear_diff
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	wheel_bearing_RR
	wheel_bearing_RL		

RECORD RWD_MODERN_DUALCLUTCH_HONDA2AND4_01 l_driveline
	name "HONDA_24_CONCEPT"
	contents RWD_MODERN_DUALCLUTCH_HONDA2AND4
	dl:minhz	3000
	
RECORD RWD_MODERN_DUALCLUTCH_HONDA2AND4_02 l_driveline
	name "ARC_CAMARO"
	contents RWD_MODERN_DUALCLUTCH_HONDA2AND4
	dl:minhz	3000	
#



###############
# RWD, synchro H-pattern gearbox, TCR wheel inertia, low drivetrain loss via wheel bearings
###############
RECORDGROUP RWD_H-PATTERN_SYNCHRO_LOW_LOW
	wheel_FR_TCR
	wheel_FL_TCR
	wheel_RR_TCR
	wheel_RL_TCR
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR_TCR
	strain_FL_TCR
	strain_RR_TCR
	strain_RL_TCR
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	crankshaft_ROAD_MED_LIGHT
	clutch_ROAD_250Nm
	clutchshaft_ROAD
	clutchshaft_ROAD_bearing
	gearbox_H-pattern_synchro
	driveshaft_ROAD
	driveshaft_strain_gauge_ROAD
	driveshaft_ROAD_POST
	RWD_open_rear_diff
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	wheel_bearing_RR
	wheel_bearing_RL
		
RECORD RWD_H-PATTERN_SYNCHRO_LOW_LOW_01 l_driveline
	name "FORD_ESCORT_MK1"
	contents RWD_H-PATTERN_SYNCHRO_LOW_LOW
	dl:minhz	3000

RECORD RWD_H-PATTERN_SYNCHRO_LOW_LOW_03 l_driveline
	name "MERCEDES_300SL_W194"
	contents RWD_DBR1
	dl:minhz	3000
#



###############
# RWD, synchro H-pattern gearbox, TCR wheel inertia, low drivetrain loss via wheel bearings
# Light driveshaft
# FLEX ADDED!
###############
RECORDGROUP RWD_H-PATTERN_SYNCHRO_LOW_LOW_2_FLEX
	wheel_FR_TCR
	wheel_FL_TCR
	wheel_RR_TCR
	wheel_RL_TCR
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR_TCR
	strain_FL_TCR
	strain_RR_TCR
	strain_RL_TCR
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_ROAD_MED_LIGHT
	crankshaft_ROAD_MED_LIGHT
	clutch_ROAD_GT3_200Nm
	clutchshaft_GT3
	clutchshaft_GT3_bearing
	clutchshaft_strain_GT3_flex_ultrasoft
	clutchshaft_GT3_POST
	gearbox_H-pattern_synchro_GT3_POST_LIGHT_flex
	driveshaft_LIGHT
	driveshaft_strain_gauge_LIGHT_flex_soft
	driveshaft_GT3_POST
	RWD_vintage_open_rear_diff
	planet_gear_rear_LIGHT
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	wheel_bearing_RR
	wheel_bearing_RL

RECORD RWD_H-PATTERN_SYNCHRO_LOW_LOW_09 l_driveline
	name "LOTUS_23"
	contents RWD_H-PATTERN_SYNCHRO_LOW_LOW_2_FLEX
	dl:minhz	3000
#



###############
# RWD, synchro H-pattern gearbox, TCR wheel inertia, low drivetrain loss via wheel bearings
# Vee driveline
# FLEX ADDED!
###############
RECORDGROUP RWD_H-PATTERN_SYNCHRO_VEE_FLEX
	wheel_FR_TCR
	wheel_FL_TCR
	wheel_RR_TCR
	wheel_RL_TCR
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR_TCR
	strain_FL_TCR
	strain_RR_TCR
	strain_RL_TCR
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_ROAD_MED_LIGHT
	crankshaft_ROAD_MED_LIGHT
	clutch_ROAD_250Nm
	clutchshaft_ROAD
	clutchshaft_ROAD_bearing
	clutchshaft_strain_ROAD_flex
	clutchshaft_ROAD_POST
	gearbox_H-pattern_synchro_POST_MEDIUM-ROAD_flex
	driveshaft_MEDIUM-ROAD
	driveshaft_strain_gauge_MEDIUM-ROAD_flex
	driveshaft_ROAD_POST
	RWD_open_rear_diff_MED
	planet_gear_rear_MED
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	wheel_bearing_RR
	wheel_bearing_RL
	
RECORD RWD_FORMULA_VEE_01 l_driveline
	name "FORMULA_VEE"
	contents RWD_H-PATTERN_SYNCHRO_VEE_FLEX
	dl:minhz	3000

RECORD RWD_FORMULA_VEE_FIN_01 l_driveline
	name "FORMULA_VEE_FIN"
	contents RWD_H-PATTERN_SYNCHRO_VEE_FLEX
	dl:minhz	3000
#



###############
# Opala 79 + Puma GTB
###############
RECORDGROUP RWD_H-PATTERN_SYNCHRO_MED_MED_FLEX
	wheel_FR_TCR
	wheel_FL_TCR
	wheel_RR_TCR
	wheel_RL_TCR
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_LOEM
	axle_strain_RL_LOEM
	strain_FR_TCR
	strain_FL_TCR
	strain_RR_TCR_AXLE
	strain_RL_TCR_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_ROAD
	crankshaft_ROAD
	clutch_ROAD_500Nm
	clutchshaft_ROAD
	clutchshaft_ROAD_bearing
	clutchshaft_strain_ROAD_flex
	clutchshaft_ROAD_POST
	gearbox_H-pattern_synchro_POST_ROAD-FR_flex
	driveshaft_ROAD-FR
	driveshaft_strain_gauge_ROAD-FR_flex_soft
	driveshaft_ROAD_POST
	RWD_open_rear_diff_HEAVY
	planet_gear_rear_HEAVY
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_15hp_wheel_bearing_RR
	RWD_15hp_wheel_bearing_RL

RECORD RWD_H-PATTERN_SYNCHRO_MED_MED_07 l_driveline
	name "OPALA_79"
	contents RWD_H-PATTERN_SYNCHRO_MED_MED_FLEX
	dl:minhz	3000	

RECORD RWD_H-PATTERN_SYNCHRO_MED_MED_08 l_driveline
	name "PUMA_GTB"
	contents RWD_H-PATTERN_SYNCHRO_MED_MED_FLEX
	dl:minhz	3000		
	
RECORD RWD_H-PATTERN_SYNCHRO_MED_MED_09 l_driveline
	name "OPALA_79_SO"
	contents RWD_H-PATTERN_SYNCHRO_MED_MED_FLEX
	dl:minhz	3000		

RECORD RWD_H-PATTERN_SYNCHRO_MED_MED_10 l_driveline
	name "OPALA_79_SW"
	contents RWD_H-PATTERN_SYNCHRO_MED_MED_FLEX
	dl:minhz	3000		
##



###############
# Opala 86 + Old Stock
###############
RECORDGROUP RWD_H-PATTERN_SYNCHRO_MED_MED_FLEX_2
	wheel_FR_TCR
	wheel_FL_TCR
	wheel_RR_TCR
	wheel_RL_TCR
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_LOEM
	axle_strain_RL_LOEM
	strain_FR_TCR
	strain_FL_TCR
	strain_RR_TCR_AXLE
	strain_RL_TCR_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_ROAD
	crankshaft_ROAD
	clutch_ROAD_500Nm
	clutchshaft_ROAD
	clutchshaft_ROAD_bearing
	clutchshaft_strain_ROAD_flex_stiff
	clutchshaft_ROAD_POST
	gearbox_H-pattern_synchro_POST_ROAD-FR_flex
	driveshaft_ROAD-FR
	driveshaft_strain_gauge_ROAD-FR_flex
	driveshaft_ROAD_POST
	RWD_open_rear_diff_HEAVY
	planet_gear_rear_HEAVY
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_15hp_wheel_bearing_RR
	RWD_15hp_wheel_bearing_RL

RECORD RWD_H-PATTERN_SYNCHRO_MED_MED_05 l_driveline
	name "OPALA_86"
	contents RWD_H-PATTERN_SYNCHRO_MED_MED_FLEX_2
	dl:minhz	3000	

RECORD RWD_H-PATTERN_SYNCHRO_MED_MED_06 l_driveline
	name "OPALA_OLDSTOCK"
	contents RWD_H-PATTERN_SYNCHRO_MED_MED_FLEX_2
	dl:minhz	3000	
	
RECORD RWD_H-PATTERN_SYNCHRO_MED_MED_11 l_driveline
	name "OPALA_86_SO"
	contents RWD_H-PATTERN_SYNCHRO_MED_MED_FLEX_2
	dl:minhz	3000	

RECORD RWD_H-PATTERN_SYNCHRO_MED_MED_12 l_driveline
	name "OPALA_OLDSTOCK_SO"
	contents RWD_H-PATTERN_SYNCHRO_MED_MED_FLEX_2
	dl:minhz	3000	

RECORD RWD_H-PATTERN_SYNCHRO_MED_MED_13 l_driveline
	name "OPALA_86_SW"
	contents RWD_H-PATTERN_SYNCHRO_MED_MED_FLEX_2
	dl:minhz	3000	

RECORD RWD_H-PATTERN_SYNCHRO_MED_MED_14 l_driveline
	name "OPALA_OLDSTOCK_SW"
	contents RWD_H-PATTERN_SYNCHRO_MED_MED_FLEX_2
	dl:minhz	3000		
##



###############
# RWD, synchro H-pattern gearbox, medium wheel inertia, medium drivetrain loss via wheel bearings
# Street cars / Camaro - DIFF v3.0 ADDED!
###############
RECORDGROUP RWD_H-PATTERN_SYNCHRO_MEDIUM_MEDIUM_ROAD_1_FLEX_v3
	wheel_FR_TCR
	wheel_FL_TCR
	wheel_RR_TCR
	wheel_RL_TCR
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_OEM
	axle_strain_RL_OEM
	strain_FR_TCR
	strain_FL_TCR
	strain_RR_TCR_AXLE
	strain_RL_TCR_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_ROAD
	crankshaft_ROAD
	clutch_ROAD_700Nm
	clutchshaft_ROAD
	clutchshaft_ROAD_bearing
	clutchshaft_strain_ROAD_flex_stiff
	clutchshaft_ROAD_POST
	gearbox_H-pattern_synchro_POST_ROAD-FR_flex
	driveshaft_ROAD-FR
	driveshaft_strain_gauge_ROAD-FR_flex
	driveshaft_ROAD_POST
	RWD_rear_manual_diff_v3
	planet_gear_rear
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_15hp_wheel_bearing_RR
	RWD_15hp_wheel_bearing_RL

RECORD RWD_H-PATTERN_SYNCHRO_MEDIUM_MEDIUM_11 l_driveline
	name "CAMARO_SS"
	contents RWD_H-PATTERN_SYNCHRO_MEDIUM_MEDIUM_ROAD_1_FLEX_v3
	dl:minhz	3000
#



###############
# RWD, synchro H-pattern gearbox, medium wheel inertia, medium drivetrain loss via wheel bearings
# Street cars / McLaren F1 + Ultima - DIFF v3.0 ADDED!
###############
RECORDGROUP RWD_H-PATTERN_SYNCHRO_MEDIUM_MEDIUM_ROAD_2_FLEX_v3
	wheel_FR_TCR
	wheel_FL_TCR
	wheel_RR_TCR
	wheel_RL_TCR
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_PROTO
	axle_strain_RL_PROTO
	strain_FR_TCR
	strain_FL_TCR
	strain_RR_TCR_AXLE
	strain_RL_TCR_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_ROAD
	crankshaft_ROAD
	clutch_ROAD_900Nm
	clutchshaft_ROAD
	clutchshaft_ROAD_bearing
	clutchshaft_strain_ROAD_flex_ultrastiff
	clutchshaft_ROAD_POST
	gearbox_H-pattern_synchro_POST_ROAD-MR_flex
	driveshaft_ROAD-MR
	driveshaft_strain_gauge_ROAD-MR_flex
	driveshaft_ROAD_POST
	RWD_rear_manual_diff_v3
	planet_gear_rear
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_15hp_wheel_bearing_RR
	RWD_15hp_wheel_bearing_RL	

RECORD RWD_H-PATTERN_SYNCHRO_MEDIUM_MEDIUM_12 l_driveline
	name "ULTIMA"
	contents RWD_H-PATTERN_SYNCHRO_MEDIUM_MEDIUM_ROAD_2_FLEX_v3
	dl:minhz	3000	
	
RECORD RWD_H-PATTERN_SYNCHRO_MEDIUM_MEDIUM_13 l_driveline
	name "MCLAREN_F1_LM"
	contents RWD_H-PATTERN_SYNCHRO_MEDIUM_MEDIUM_ROAD_2_FLEX_v3
	dl:minhz	3000
##



###############
# RWD, synchro H-pattern gearbox, medium wheel inertia, medium drivetrain loss via wheel bearings
# Street cars / Senna - E-DIFF
###############
RECORDGROUP RWD_H-PATTERN_SYNCHRO_MEDIUM_MEDIUM_ROAD_2_FLEX_EDIFF
	wheel_FR_GT3
	wheel_FL_GT3
	wheel_RR_GT3
	wheel_RL_GT3
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_GT3
	axle_strain_RL_GT3
	strain_FR_GT3
	strain_FL_GT3
	strain_RR_GT3_AXLE
	strain_RL_GT3_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_GT3
	crankshaft_GT3
	clutch_MODERN-GT_1200Nm
	clutchshaft_MODERN-GT
	clutchshaft_MODERN-GT_bearing
	clutchshaft_strain_MODERN-GT_flex
	clutchshaft_GT3_POST
	gearbox_GT3_POST_GT-MR_flex
	driveshaft_GT-MR
	driveshaft_strain_gauge_GT-MR_flex
	driveshaft_GT3_POST
	RWD_GT4_rear_ediff_v3
	planet_gear_rear
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_15hp_wheel_bearing_RR
	RWD_15hp_wheel_bearing_RL

RECORD RWD_H-PATTERN_SYNCHRO_MEDIUM_MEDIUM_14 l_driveline
	name "MCLAREN_SENNA"
	contents RWD_H-PATTERN_SYNCHRO_MEDIUM_MEDIUM_ROAD_2_FLEX_EDIFF
	dl:minhz	3000	
##



###############
# RWD, synchro H-pattern gearbox, medium wheel inertia, medium drivetrain loss via wheel bearings
# FLEX ADDED! DIFF v3 ADDED!
###############
RECORDGROUP RWD_H-PATTERN_SYNCHRO_MEDIUM_MEDIUM_FLEX_v3
	wheel_FR_TCR
	wheel_FL_TCR
	wheel_RR_TCR
	wheel_RL_TCR
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_GT3
	axle_strain_RL_GT3
	strain_FR_TCR
	strain_FL_TCR
	strain_RR_TCR_AXLE
	strain_RL_TCR_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_ROAD
	crankshaft_ROAD
	clutch_ROAD_700Nm
	clutchshaft_ROAD
	clutchshaft_ROAD_bearing
	clutchshaft_strain_ROAD_flex
	clutchshaft_ROAD_POST
	gearbox_H-pattern_synchro_POST_HEAVY_flex
	driveshaft_HEAVY
	driveshaft_strain_gauge_HEAVY_flex_waxle
	driveshaft_ROAD_POST
	RWD_rear_manual_diff_v3
	planet_gear_rear
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_15hp_wheel_bearing_RR
	RWD_15hp_wheel_bearing_RL

RECORD RWD_H-PATTERN_SYNCHRO_MEDIUM_MEDIUM_15 l_driveline
	name "Chevrolet_Corvette_C3_R"
	contents RWD_H-PATTERN_SYNCHRO_MEDIUM_MEDIUM_FLEX_v3
	dl:minhz	3000

RECORD RWD_H-PATTERN_SYNCHRO_MEDIUM_MEDIUM_16 l_driveline
	name "CHEVROLET_CORVETTE_73"
	contents RWD_H-PATTERN_SYNCHRO_MEDIUM_MEDIUM_FLEX_v3
	dl:minhz	3000
#

###############
# RWD, synchro H-pattern gearbox, medium wheel inertia, medium drivetrain loss via wheel bearings
# FLEX ADDED! OPEN DIFF v2 added
###############
RECORDGROUP RWD_H-PATTERN_SYNCHRO_MEDIUM_MEDIUM_2_FLEX
	wheel_FR_TCR
	wheel_FL_TCR
	wheel_RR_TCR
	wheel_RL_TCR
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_TCR
	axle_strain_RL_TCR
	strain_FR_TCR
	strain_FL_TCR
	strain_RR_TCR_AXLE
	strain_RL_TCR_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_ROAD
	crankshaft_ROAD
	clutch_ROAD_700Nm
	clutchshaft_ROAD
	clutchshaft_ROAD_bearing
	clutchshaft_strain_ROAD_flex
	clutchshaft_ROAD_POST
	gearbox_H-pattern_synchro_POST_HEAVY_flex
	driveshaft_HEAVY
	driveshaft_strain_gauge_HEAVY_flex_waxle_soft
	driveshaft_ROAD_POST
	RWD_open_rear_diff_HEAVY
	planet_gear_rear_HEAVY
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_15hp_wheel_bearing_RR
	RWD_15hp_wheel_bearing_RL	

RECORD RWD_H-PATTERN_SYNCHRO_MEDIUM_MEDIUM_17 l_driveline
	name "STOCK_OMEGA"
	contents RWD_H-PATTERN_SYNCHRO_MEDIUM_MEDIUM_2_FLEX
	dl:minhz	3000
	
RECORD RWD_H-PATTERN_SYNCHRO_MEDIUM_MEDIUM_18 l_driveline
	name "STOCK_OMEGA_SO"
	contents RWD_H-PATTERN_SYNCHRO_MEDIUM_MEDIUM_2_FLEX
	dl:minhz	3000

RECORD RWD_H-PATTERN_SYNCHRO_MEDIUM_MEDIUM_19 l_driveline
	name "STOCK_OMEGA_SW"
	contents RWD_H-PATTERN_SYNCHRO_MEDIUM_MEDIUM_2_FLEX
	dl:minhz	3000	
##



###############
# Light RWD touring cars with H-pattern
# FLEX ADDED! DIFF v3 ADDED!
###############
RECORDGROUP RWD_H-PATTERN_TOURING_FLEX_v3
	wheel_FR_TCR
	wheel_FL_TCR
	wheel_RR_TCR
	wheel_RL_TCR
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_TCR
	axle_strain_RL_TCR
	strain_FR_TCR
	strain_FL_TCR
	strain_RR_TCR_AXLE
	strain_RL_TCR_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_ROAD_MED
	crankshaft_ROAD_MED
	clutch_ROAD_450Nm
	clutchshaft_ROAD
	clutchshaft_ROAD_bearing
	clutchshaft_strain_ROAD_flex_stiff
	clutchshaft_ROAD_POST
	gearbox_H-pattern_synchro_POST_ROAD-FR_flex
	driveshaft_ROAD-FR
	driveshaft_strain_gauge_ROAD-FR_flex
	driveshaft_ROAD_POST
	RWD_rear_manual_diff_v3
	planet_gear_rear
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_15hp_wheel_bearing_RR
	RWD_15hp_wheel_bearing_RL

RECORD RWD_H-PATTERN_SYNCHRO_LOW_MED_05 l_driveline
	name "BMW_2002_TURBO"
	contents RWD_H-PATTERN_TOURING_FLEX_v3
	dl:minhz	3000

## Group A Touring Cars
RECORD RWD_GROUPA_01 l_driveline
	name "BMW_M3_E30_GROUPA"
	contents RWD_H-PATTERN_TOURING_FLEX_v3
	dl:minhz	3000

RECORD RWD_GROUPA_02 l_driveline
	name "MERCEDES_EVO2_DTM"
	contents RWD_H-PATTERN_TOURING_FLEX_v3
	dl:minhz	3000
#



###############
# Old touring cars with small engines, short shaft
# FLEX ADDED! DIFF v3 ADDED!
###############
RECORDGROUP RWD_H-PATTERN_TOURING_2_FLEX_v3
	wheel_FR_TCR
	wheel_FL_TCR
	wheel_RR_TCR
	wheel_RL_TCR
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_GT3
	axle_strain_RL_GT3
	strain_FR_TCR
	strain_FL_TCR
	strain_RR_TCR_AXLE
	strain_RL_TCR_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_ROAD_MED
	crankshaft_ROAD_MED
	clutch_ROAD_600Nm
	clutchshaft_ROAD
	clutchshaft_ROAD_bearing
	clutchshaft_strain_ROAD_flex_stiff
	clutchshaft_ROAD_POST
	gearbox_H-pattern_synchro_POST_ROAD-MR_flex
	driveshaft_ROAD-MR
	driveshaft_strain_gauge_ROAD-MR_flex
	driveshaft_ROAD_POST
	RWD_rear_manual_diff_v3
	planet_gear_rear
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_30hp_wheel_bearing_RR
	RWD_30hp_wheel_bearing_RL

RECORD RWD_TOURING_1 l_driveline
	name "BMW_M1"
	contents RWD_H-PATTERN_TOURING_2_FLEX_v3
	dl:minhz	3000

RECORD RWD_TOURING_2 l_driveline
	name "PORSCHE_911_RSR_74"
	contents RWD_H-PATTERN_TOURING_2_FLEX_v3
	dl:minhz	3000
#



###############
# Chevette & Puma GTE
###############
RECORDGROUP RWD_H-PATTERN_SYNCHRO_LOW_LOW_CC_FLEX
	wheel_FR_TCR
	wheel_FL_TCR
	wheel_RR_TCR
	wheel_RL_TCR
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR_TCR
	strain_FL_TCR
	strain_RR_TCR
	strain_RL_TCR
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_ROAD_MED_LIGHT
	crankshaft_ROAD_MED_LIGHT
	clutch_ROAD_250Nm
	clutchshaft_ROAD
	clutchshaft_ROAD_bearing
	clutchshaft_strain_ROAD_flex
	clutchshaft_ROAD_POST
	gearbox_H-pattern_synchro_POST_MEDIUM-ROAD_flex
	driveshaft_MEDIUM-ROAD
	driveshaft_strain_gauge_MEDIUM-ROAD_flex
	driveshaft_ROAD_POST
	RWD_open_rear_diff_MED
	planet_gear_rear_MED
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	wheel_bearing_RR
	wheel_bearing_RL

RECORD RWD_H-PATTERN_SYNCHRO_LOW_LOW_05 l_driveline
	name "CHEVETTE"
	contents RWD_H-PATTERN_SYNCHRO_LOW_LOW_CC_FLEX
	dl:minhz	3000
	
RECORD RWD_H-PATTERN_SYNCHRO_LOW_LOW_06 l_driveline
	name "PUMA_GTE"
	contents RWD_H-PATTERN_SYNCHRO_LOW_LOW_CC_FLEX
	dl:minhz	3000
#



###############
# Pas/Gol CCB + Unos
# Weaker clutch than CCA
# FLEX ADDED!
###############
RECORDGROUP FWD_H-PATTERN_SYNCHRO_LOW_LOW_FLEX
	wheel_FR_TCR
	wheel_FL_TCR
	wheel_RR_TCR
	wheel_RL_TCR
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR_TCR
	strain_FL_TCR
	strain_RR_TCR
	strain_RL_TCR
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_ROAD_MED_LIGHT
	crankshaft_ROAD_MED_LIGHT
	clutch_ROAD_250Nm
	clutchshaft_ROAD
	clutchshaft_ROAD_bearing
	clutchshaft_strain_ROAD_flex
	clutchshaft_ROAD_POST
	gearbox_H-pattern_synchro_POST_MEDIUM-ROAD_flex
	driveshaft_MEDIUM-ROAD
	driveshaft_strain_gauge_MEDIUM-ROAD_flex_stiff
	driveshaft_ROAD_POST
	FWD_open_front_diff_MED
	planet_gear_front_MED
	FWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	wheel_bearing_RR
	wheel_bearing_RL
	
RECORD FWD_H-PATTERN_SYNCHRO_LOW_LOW_01 l_driveline
	name "UNO"
	contents FWD_H-PATTERN_SYNCHRO_LOW_LOW_FLEX
	dl:minhz	3000	
	
RECORD FWD_H-PATTERN_SYNCHRO_LOW_LOW_02 l_driveline
	name "UNO_CLASSICB"
	contents FWD_H-PATTERN_SYNCHRO_LOW_LOW_FLEX
	dl:minhz	3000

RECORD FWD_H-PATTERN_SYNCHRO_LOW_LOW_03 l_driveline
	name "PAS_CLASSICB"
	contents FWD_H-PATTERN_SYNCHRO_LOW_LOW_FLEX
	dl:minhz	3000

RECORD FWD_H-PATTERN_SYNCHRO_LOW_LOW_04 l_driveline
	name "GOL_CLASSICB"
	contents FWD_H-PATTERN_SYNCHRO_LOW_LOW_FLEX
	dl:minhz	3000		
#



###############
# 60s Mini
# FLEX ADDED!
###############
RECORDGROUP FWD_H-PATTERN_SYNCHRO_LOW_LOW2_FLEX
	wheel_FR_TCR
	wheel_FL_TCR
	wheel_RR_TCR
	wheel_RL_TCR
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR_TCR
	strain_FL_TCR
	strain_RR_TCR
	strain_RL_TCR
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_ROAD_MED_LIGHT
	crankshaft_ROAD_MED_LIGHT
	clutch_ROAD_250Nm
	clutchshaft_ROAD
	clutchshaft_ROAD_bearing
	clutchshaft_strain_ROAD_flex
	clutchshaft_ROAD_POST
	gearbox_H-pattern_synchro_POST_MEDIUM-ROAD_flex
	driveshaft_MEDIUM-ROAD
	driveshaft_strain_gauge_MEDIUM-ROAD_flex
	driveshaft_ROAD_POST
	FWD_vintage_open_front_diff
	planet_gear_front_LIGHT
	FWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	wheel_bearing_RR
	wheel_bearing_RL
	
RECORD FWD_H-PATTERN_SYNCHRO_LOW_LOW2_01 l_driveline
	name "MINI_COOPERS_1965"
	contents FWD_H-PATTERN_SYNCHRO_LOW_LOW2_FLEX
	dl:minhz	3000

RECORD FWD_H-PATTERN_SYNCHRO_LOW_LOW2_02 l_driveline
	name "MINI_COOPERS_1965_B"
	contents FWD_H-PATTERN_SYNCHRO_LOW_LOW2_FLEX
	dl:minhz	3000
#



###############
# Gol/Pas driveline, FWD, low driveline losses via bearings
# Stronger clutch than CCB
# FLEX ADDED!
###############
RECORDGROUP FWD_H-PATTERN_SYNCHRO_LOW_MED_FLEX
	wheel_FR_TCR
	wheel_FL_TCR
	wheel_RR_TCR
	wheel_RL_TCR
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR_TCR
	strain_FL_TCR
	strain_RR_TCR
	strain_RL_TCR
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_ROAD_MED_LIGHT
	crankshaft_ROAD_MED_LIGHT
	clutch_ROAD_350Nm
	clutchshaft_ROAD
	clutchshaft_ROAD_bearing
	clutchshaft_strain_ROAD_flex
	clutchshaft_ROAD_POST
	gearbox_H-pattern_synchro_POST_MEDIUM-ROAD_flex
	driveshaft_MEDIUM-ROAD
	driveshaft_strain_gauge_MEDIUM-ROAD_flex_stiff
	driveshaft_ROAD_POST
	FWD_open_front_diff_MED
	planet_gear_front_MED
	FWD_spool
	FWD_15hp_wheel_bearing_FR
	FWD_15hp_wheel_bearing_FL
	wheel_bearing_RR
	wheel_bearing_RL

RECORD FWD_H-PATTERN_SYNCHRO_LOW_MED_01 l_driveline
	name "GOL_HOTCARS"
	contents FWD_H-PATTERN_SYNCHRO_LOW_MED_FLEX
	dl:minhz	3000		
	
RECORD FWD_H-PATTERN_SYNCHRO_LOW_MED_02 l_driveline
	name "PAS_CLASSICA"
	contents FWD_H-PATTERN_SYNCHRO_LOW_MED_FLEX
	dl:minhz	3000		

RECORD FWD_H-PATTERN_SYNCHRO_LOW_MED_03 l_driveline
	name "GOL_CLASSICA"
	contents FWD_H-PATTERN_SYNCHRO_LOW_MED_FLEX
	dl:minhz	3000		

RECORD FWD_H-PATTERN_SYNCHRO_LOW_MED_04 l_driveline
	name "PAS_HOTCARS"
	contents FWD_H-PATTERN_SYNCHRO_LOW_MED_FLEX
	dl:minhz	3000													
#



###############
# Fusca driveline, lighter driveshaft, H-synchro, low driveline losses via bearings
# Strong clutch
# FLEX ADDED!
###############
RECORDGROUP RWD_H-PATTERN_SYNCHRO_LOW_MED2_FLEX
	wheel_FR_TCR
	wheel_FL_TCR
	wheel_RR_TCR
	wheel_RL_TCR
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR_TCR
	strain_FL_TCR
	strain_RR_TCR
	strain_RL_TCR
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_ROAD_MED_LIGHT
	crankshaft_ROAD_MED_LIGHT
	clutch_ROAD_350Nm
	clutchshaft_ROAD
	clutchshaft_ROAD_bearing
	clutchshaft_strain_ROAD_flex
	clutchshaft_ROAD_POST
	gearbox_H-pattern_synchro_POST_MEDIUM-ROAD_flex
	driveshaft_MEDIUM-ROAD
	driveshaft_strain_gauge_MEDIUM-ROAD_flex
	driveshaft_ROAD_POST
	RWD_open_rear_diff_MED
	planet_gear_rear_MED
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_15hp_wheel_bearing_RR
	RWD_15hp_wheel_bearing_RL		

RECORD RWD_H-PATTERN_SYNCHRO_LOW_MED_03 l_driveline
	name "FUSCA_HOTCARS_M1"
	contents RWD_H-PATTERN_SYNCHRO_LOW_MED2_FLEX
	dl:minhz	3000		
	
RECORD RWD_H-PATTERN_SYNCHRO_LOW_MED_04 l_driveline
	name "FUSCA_HOTCARS_M2"
	contents RWD_H-PATTERN_SYNCHRO_LOW_MED2_FLEX
	dl:minhz	3000
#



###############
# Fusca driveline, lighter driveshaft, H-synchro, low driveline losses via bearings
# Weaker clutch
# FLEX ADDED!
###############
RECORDGROUP RWD_H-PATTERN_SYNCHRO_LOW_MED3_FLEX
	wheel_FR_TCR
	wheel_FL_TCR
	wheel_RR_TCR
	wheel_RL_TCR
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR_TCR
	strain_FL_TCR
	strain_RR_TCR
	strain_RL_TCR
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_ROAD_MED_LIGHT
	crankshaft_ROAD_MED_LIGHT
	clutch_ROAD_250Nm
	clutchshaft_ROAD
	clutchshaft_ROAD_bearing
	clutchshaft_strain_ROAD_flex
	clutchshaft_ROAD_POST
	gearbox_H-pattern_synchro_POST_MEDIUM-ROAD_flex
	driveshaft_MEDIUM-ROAD
	driveshaft_strain_gauge_MEDIUM-ROAD_flex
	driveshaft_ROAD_POST
	RWD_open_rear_diff_MED
	planet_gear_rear_MED
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_15hp_wheel_bearing_RR
	RWD_15hp_wheel_bearing_RL

RECORD RWD_H-PATTERN_SYNCHRO_LOW_MED_02 l_driveline
	name "FUSCA_CLASSICA"
	contents RWD_H-PATTERN_SYNCHRO_LOW_MED3_FLEX
	dl:minhz	3000

RECORD RWD_FUSCA_01 l_driveline
	name "FUSCA_COPA"
	contents RWD_H-PATTERN_SYNCHRO_LOW_MED3_FLEX
	dl:minhz	3000
#



###############
# RWD, non-synchro race gearbox, GT3 wheel inertia, medium drivetrain power loss, low engine inertia
# FLEX ADDED! DIFF v3 ADDED!
###############
RECORDGROUP RWD_FORMULA_HEWLAND_1_FLEX_v3
	wheel_FR_GT3
	wheel_FL_GT3
	wheel_RR_GT3
	wheel_RL_GT3
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_F1L
	axle_strain_RL_F1L
	strain_FR_GT3
	strain_FL_GT3
	strain_RR_GT3_AXLE
	strain_RL_GT3_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_TCR
	crankshaft_TCR
	clutch_TCR_600Nm
	clutchshaft_GT3
	clutchshaft_GT3_bearing
	clutchshaft_strain_GT3_flex_stiff
	clutchshaft_GT3_POST
	gearbox_Hewland_GT3_POST_F1_flex
	driveshaft_F1
	driveshaft_strain_gauge_F1_flex_waxle
	driveshaft_GT3_POST
	RWD_rear_diff_v3
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	wheel_bearing_RR
	wheel_bearing_RL

## Vintage Formula cars

RECORD RWD_FORMULA_VINTAGE_01 l_driveline
	name "FORMULA_VINTAGE_G1M1"
	contents RWD_FORMULA_HEWLAND_1_FLEX_v3
	dl:minhz	3000

RECORD RWD_FORMULA_VINTAGE_02 l_driveline
	name "FORMULA_VINTAGE_G1M2"
	contents RWD_FORMULA_HEWLAND_1_FLEX_v3
	dl:minhz	3000
	
RECORD RWD_FORMULA_VINTAGE_03 l_driveline
	name "FORMULA_VINTAGE_G2M1"
	contents RWD_FORMULA_HEWLAND_1_FLEX_v3
	dl:minhz	3000
	
RECORD RWD_FORMULA_VINTAGE_04 l_driveline
	name "FORMULA_VINTAGE_G2M2"
	contents RWD_FORMULA_HEWLAND_1_FLEX_v3
	dl:minhz	3000

RECORD RWD_VINTAGE_FORMULA_05 l_driveline
	name "LOTUS_49"
	contents RWD_FORMULA_HEWLAND_1_FLEX_v3
	dl:minhz	3000

RECORD RWD_VINTAGE_FORMULA_06 l_driveline
	name "LOTUS_49C"
	contents RWD_FORMULA_HEWLAND_1_FLEX_v3
	dl:minhz	3000

## Retros
RECORD RWD_VINTAGE_FORMULA_07 l_driveline
	name "LOTUS_72D"
	contents RWD_FORMULA_HEWLAND_1_FLEX_v3
	dl:minhz	3000

RECORD RWD_VINTAGE_FORMULA_08 l_driveline
	name "LOTUS_78"
	contents RWD_FORMULA_HEWLAND_1_FLEX_v3
	dl:minhz	3000

RECORD RWD_VINTAGE_FORMULA_09 l_driveline
	name "MCLAREN_M23"
	contents RWD_FORMULA_HEWLAND_1_FLEX_v3
	dl:minhz	3000	

RECORD RWD_VINTAGE_FORMULA_10 l_driveline
	name "LOTUS_72E"
	contents RWD_FORMULA_HEWLAND_1_FLEX_v3
	dl:minhz	3000

RECORD RWD_VINTAGE_FORMULA_11 l_driveline
	name "FORMULA_RETRO_V8"
	contents RWD_FORMULA_HEWLAND_1_FLEX_v3
	dl:minhz	3000

RECORD RWD_VINTAGE_FORMULA_12 l_driveline
	name "FORMULA_RETRO_V12"
	contents RWD_FORMULA_HEWLAND_1_FLEX_v3
	dl:minhz	3000
	
RECORD RWD_VINTAGE_FORMULA_13 l_driveline
	name "BRABHAM_BT26"
	contents RWD_FORMULA_HEWLAND_1_FLEX_v3
	dl:minhz	3000

RECORD RWD_VINTAGE_FORMULA_14 l_driveline
	name "LOTUS_79"
	contents RWD_FORMULA_HEWLAND_1_FLEX_v3
	dl:minhz	3000	
	
RECORD RWD_VINTAGE_FORMULA_15 l_driveline
	name "BRABHAM_BT49"
	contents RWD_FORMULA_HEWLAND_1_FLEX_v3
	dl:minhz	3000
	
RECORD RWD_VINTAGE_FORMULA_16 l_driveline
	name "BRABHAM_BT52"
	contents RWD_FORMULA_HEWLAND_1_FLEX_v3
	dl:minhz	3000
	
RECORD RWD_VINTAGE_FORMULA_17 l_driveline
	name "FORMULA_RETRO_G2"
	contents RWD_FORMULA_HEWLAND_1_FLEX_v3
	dl:minhz	3000

RECORD RWD_VINTAGE_FORMULA_18 l_driveline
	name "BRABHAM_BT46B"
	contents RWD_FORMULA_HEWLAND_1_FLEX_v3
	dl:minhz	3000

RECORD RWD_FORMULA_RETRO_01 l_driveline
	name "FORMULA_RETRO"
	contents RWD_FORMULA_HEWLAND_1_FLEX_v3
	dl:minhz	3000

RECORD RWD_VINTAGE_FORMULA_19 l_driveline
	name "FORMULA_RETRO_G3"
	contents RWD_FORMULA_HEWLAND_1_FLEX_v3
	dl:minhz	3000

RECORD RWD_VINTAGE_FORMULA_20 l_driveline
	name "MCLAREN_MP4_1C"
	contents RWD_FORMULA_HEWLAND_1_FLEX_v3
	dl:minhz	3000
#



###############
# Group C and other heavier stuff that's kind of like F1
# FLEX ADDED! DIFF v3 ADDED!
###############
RECORDGROUP RWD_FORMULA_HEWLAND_2_FLEX_v3
	wheel_FR_GT3
	wheel_FL_GT3
	wheel_RR_GT3
	wheel_RL_GT3
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_PROTO
	axle_strain_RL_PROTO
	strain_FR_GT3
	strain_FL_GT3
	strain_RR_GT3_AXLE
	strain_RL_GT3_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_F1_80s
	crankshaft_F1_80s
	clutch_F1_1500Nm_80s
	clutchshaft_F1
	clutchshaft_F1_bearing
	clutchshaft_strain_F1_flex_ultrastiff
	clutchshaft_F1_POST
	gearbox_Hewland_F1_POST_GT-MR_flex
	driveshaft_GT-MR
	driveshaft_strain_gauge_GT-MR_flex_soft
	driveshaft_GT3_POST
	RWD_rear_GRC_manual_diff_v3
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_15hp_wheel_bearing_RR
	RWD_15hp_wheel_bearing_RL

## Group C / IMSA GTP
RECORD RWD_GRPC-GTP_03 l_driveline
	name "NISSAN_GTP_ZX-TURBO"
	contents RWD_FORMULA_HEWLAND_2_FLEX_v3
	dl:minhz	3000
	
RECORD RWD_GRPC-GTP_04 l_driveline
	name "NISSAN_R89C_HD"
	contents RWD_FORMULA_HEWLAND_2_FLEX_v3
	dl:minhz	3000

RECORD RWD_GRPC-GTP_05 l_driveline
	name "NISSAN_R89C_LM"
	contents RWD_FORMULA_HEWLAND_2_FLEX_v3
	dl:minhz	3000

RECORD RWD_GRPC-GTP_06 l_driveline
	name "PORSCHE_962C"
	contents RWD_FORMULA_HEWLAND_2_FLEX_v3
	dl:minhz	3000

RECORD RWD_GRPC-GTP_07 l_driveline
	name "PORSCHE_962C_LH"
	contents RWD_FORMULA_HEWLAND_2_FLEX_v3
	dl:minhz	3000

RECORD RWD_GRPC-GTP_08 l_driveline
	name "MERCEDES-SAUBER_C9"
	contents RWD_FORMULA_HEWLAND_2_FLEX_v3
	dl:minhz	3000
	
	RECORD RWD_GRPC-GTP_09 l_driveline
	name "PORSCHE_962C_LD"
	contents RWD_FORMULA_HEWLAND_2_FLEX_v3
	dl:minhz	3000

RECORD RWD_GRPC-GTP_10 l_driveline
	name "MERCEDES-SAUBER_C9_LD"
	contents RWD_FORMULA_HEWLAND_2_FLEX_v3
	dl:minhz	3000

RECORD RWD_GRPC-GTP_11 l_driveline
	name "CORVETTE_GTP"
	contents RWD_FORMULA_HEWLAND_2_FLEX_v3
	dl:minhz	3000
	
RECORD RWD_GRPC-GTP_12 l_driveline
	name "CORVETTE_GTP_LD"
	contents RWD_FORMULA_HEWLAND_2_FLEX_v3
	dl:minhz	3000	
##



###############
# 80s F1
# FLEX ADDED! DIFF v3 ADDED!
###############
RECORDGROUP RWD_FORMULA_HEWLAND_2_LIGHT_FLEX_v3
	wheel_FR_GT3
	wheel_FL_GT3
	wheel_RR_GT3
	wheel_RL_GT3
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_F1
	axle_strain_RL_F1
	strain_FR_GT3
	strain_FL_GT3
	strain_RR_GT3_AXLE
	strain_RL_GT3_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_F1_80s
	crankshaft_F1_80s
	clutch_F1_1000Nm_80s
	clutchshaft_F1
	clutchshaft_F1_bearing
	clutchshaft_strain_F1_flex
	clutchshaft_F1_POST
	gearbox_Hewland_F1_POST_F1_flex
	driveshaft_F1
	driveshaft_strain_gauge_F1_flex_waxle_stiff
	driveshaft_GT3_POST
	RWD_rear_F1_manual_diff_v3
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_15hp_wheel_bearing_RR
	RWD_15hp_wheel_bearing_RL

RECORD RWD_RETRO_G3_FORMULA_01 l_driveline
	name "FORMULA_RETRO_G3_TE"
	contents RWD_FORMULA_HEWLAND_2_LIGHT_FLEX_v3
	dl:minhz	3000

RECORD RWD_CLASSIC_FORMULA_01 l_driveline
	name "LOTUS_98T"
	contents RWD_FORMULA_HEWLAND_2_LIGHT_FLEX_v3
	dl:minhz	3000

RECORD RWD_FORMULA_CLASSIC_G1M1_01 l_driveline
	name "FORMULA_CLASSIC_G1M1"
	contents RWD_FORMULA_HEWLAND_2_LIGHT_FLEX_v3
	dl:minhz	3000
	
RECORD RWD_FORMULA_CLASSIC_G1M2_02 l_driveline
	name "FORMULA_CLASSIC_G1M2"
	contents RWD_FORMULA_HEWLAND_2_LIGHT_FLEX_v3
	dl:minhz	3000

RECORD RWD_FORMULA_CLASSIC_G2M3_03 l_driveline
	name "FORMULA_CLASSIC_G2M3"
	contents RWD_FORMULA_HEWLAND_2_LIGHT_FLEX_v3
	dl:minhz	3000
	
RECORD RWD_MCLAREN_MP44_04 l_driveline
	name "MCLAREN_MP44"
	contents RWD_FORMULA_HEWLAND_2_LIGHT_FLEX_v3
	dl:minhz	3000
##



###############
# F-Classics era without turbo
# FLEX ADDED! DIFF v3 ADDED!
###############
RECORDGROUP RWD_FORMULA_HEWLAND_3_FLEX_v3
	wheel_FR_GT3
	wheel_FL_GT3
	wheel_RR_GT3
	wheel_RL_GT3
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_F1L
	axle_strain_RL_F1L
	strain_FR_GT3
	strain_FL_GT3
	strain_RR_GT3_AXLE
	strain_RL_GT3_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_F1_90s
	crankshaft_F1_90s
	clutch_F1_750Nm_90s
	clutchshaft_F1
	clutchshaft_F1_bearing
	clutchshaft_strain_F1_flex
	clutchshaft_F1_POST
	gearbox_Hewland_F1_POST_F1_flex
	driveshaft_F1
	driveshaft_strain_gauge_F1_flex_waxle
	driveshaft_GT3_POST
	RWD_light_rear_diff_v3
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_15hp_wheel_bearing_RR
	RWD_15hp_wheel_bearing_RL

RECORD RWD_FORMULA_CLASSIC_G2M1_01 l_driveline
	name "FORMULA_CLASSIC_G2M1"
	contents RWD_FORMULA_HEWLAND_3_FLEX_v3
	dl:minhz	3000	

RECORD RWD_FORMULA_CLASSIC_G2M2_01 l_driveline
	name "FORMULA_CLASSIC_G2M2"
	contents RWD_FORMULA_HEWLAND_3_FLEX_v3
	dl:minhz	3000

RECORD RWD_FORMULA_CLASSIC_G3M2_01 l_driveline
	name "FORMULA_CLASSIC_G3M2"
	contents RWD_FORMULA_HEWLAND_3_FLEX_v3
	dl:minhz	3000

RECORD RWD_FORMULA_CLASSIC_G3M4_01 l_driveline
	name "FORMULA_CLASSIC_G3M4"
	contents RWD_FORMULA_HEWLAND_3_FLEX_v3
	dl:minhz	3000

RECORD RWD_FORMULA_CLASSIC_G4M3_08 l_driveline
	name "FORMULA_CLASSIC_G4M3"
	contents RWD_FORMULA_HEWLAND_3_FLEX_v3
	dl:minhz	3000

RECORD RWD_FORMULA_CLASSIC_G2M1_LD_01 l_driveline
	name "FORMULA_CLASSIC_G2M1_LD"
	contents RWD_FORMULA_HEWLAND_3_FLEX_v3
	dl:minhz	3000	

RECORD RWD_FORMULA_CLASSIC_G2M2_LD_01 l_driveline
	name "FORMULA_CLASSIC_G2M2_LD"
	contents RWD_FORMULA_HEWLAND_3_FLEX_v3
	dl:minhz	3000

RECORD RWD_FORMULA_CLASSIC_G3M2_LD_01 l_driveline
	name "FORMULA_CLASSIC_G3M2_LD"
	contents RWD_FORMULA_HEWLAND_3_FLEX_v3
	dl:minhz	3000	

RECORD RWD_FORMULA_CLASSIC_G3M4_LD_01 l_driveline
	name "FORMULA_CLASSIC_G3M4_LD"
	contents RWD_FORMULA_HEWLAND_3_FLEX_v3
	dl:minhz	3000

RECORD RWD_FORMULA_CLASSIC_G4M3_LD_08 l_driveline
	name "FORMULA_CLASSIC_G4M3_LD"
	contents RWD_FORMULA_HEWLAND_3_FLEX_v3
	dl:minhz	3000
##



###############
# F-Classics era without turbo, sequential gearbox with no synchro
# FLEX ADDED! DIFF v3 ADDED!
###############
RECORDGROUP RWD_FORMULA_HEWLAND_3S_FLEX_v3
	wheel_FR_GT3
	wheel_FL_GT3
	wheel_RR_GT3
	wheel_RL_GT3
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_F1L
	axle_strain_RL_F1L
	strain_FR_GT3
	strain_FL_GT3
	strain_RR_GT3_AXLE
	strain_RL_GT3_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_F1_90s
	crankshaft_F1_90s
	clutch_F1_750Nm_90s
	clutchshaft_F1
	clutchshaft_F1_bearing
	clutchshaft_strain_F1_flex
	clutchshaft_F1_POST
	gearbox_F1_POST_F1_flex
	driveshaft_F1
	driveshaft_strain_gauge_F1_flex_waxle
	driveshaft_GT3_POST
	RWD_light_rear_diff_v3
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_15hp_wheel_bearing_RR
	RWD_15hp_wheel_bearing_RL

RECORD RWD_FORMULA_CLASSIC_G4M1_06 l_driveline
	name "FORMULA_CLASSIC_G4M1"
	contents RWD_FORMULA_HEWLAND_3S_FLEX_v3
	dl:minhz	3000

RECORD RWD_FORMULA_CLASSIC_G4M2_07 l_driveline
	name "FORMULA_CLASSIC_G4M2"
	contents RWD_FORMULA_HEWLAND_3S_FLEX_v3
	dl:minhz	3000

RECORD RWD_FORMULA_CLASSIC_G4M1_LD_06 l_driveline
	name "FORMULA_CLASSIC_G4M1_LD"
	contents RWD_FORMULA_HEWLAND_3S_FLEX_v3
	dl:minhz	3000

RECORD RWD_FORMULA_CLASSIC_G4M2_LD_07 l_driveline
	name "FORMULA_CLASSIC_G4M2_LD"
	contents RWD_FORMULA_HEWLAND_3S_FLEX_v3
	dl:minhz	3000
	
RECORD RWD_FORMULA_CLASSIC_G3M1_08 l_driveline
	name "FORMULA_CLASSIC_G3M1"
	contents RWD_FORMULA_HEWLAND_3S_FLEX_v3
	dl:minhz	3000

RECORD RWD_FORMULA_CLASSIC_G3M3_09 l_driveline
	name "FORMULA_CLASSIC_G3M3"
	contents RWD_FORMULA_HEWLAND_3S_FLEX_v3
	dl:minhz	3000

RECORD RWD_FORMULA_CLASSIC_G3M1_LD_10 l_driveline
	name "FORMULA_CLASSIC_G3M1_LD"
	contents RWD_FORMULA_HEWLAND_3S_FLEX_v3
	dl:minhz	3000

RECORD RWD_FORMULA_CLASSIC_G3M3_LD_11 l_driveline
	name "FORMULA_CLASSIC_G3M3_LD"
	contents RWD_FORMULA_HEWLAND_3S_FLEX_v3
	dl:minhz	3000
		
	
RECORD RWD_MCLAREN_MP45B_01 l_driveline
	name "MCLAREN_MP45B"
	contents RWD_FORMULA_HEWLAND_3S_FLEX_v3
	dl:minhz	3000
		
RECORD RWD_MCLAREN_MP45B_LD_01 l_driveline
	name "MCLAREN_MP45B_LD"
	contents RWD_FORMULA_HEWLAND_3S_FLEX_v3
	dl:minhz	3000	

RECORD RWD_MCLAREN_MP46_01 l_driveline
	name "MCLAREN_MP46"
	contents RWD_FORMULA_HEWLAND_3S_FLEX_v3
	dl:minhz	3000
		
RECORD RWD_MCLAREN_MP46_LD_01 l_driveline
	name "MCLAREN_MP46_LD"
	contents RWD_FORMULA_HEWLAND_3S_FLEX_v3
	dl:minhz	3000			
		
##



###############
# CART with turbo, more flex than F-Classics etc
# FLEX ADDED!
###############
RECORDGROUP RWD_FORMULA_HEWLAND_4_FLEX_v3
	wheel_FR_GT3
	wheel_FL_GT3
	wheel_RR_GT3
	wheel_RL_GT3
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_CART
	axle_strain_RL_CART
	strain_FR_GT3
	strain_FL_GT3
	strain_RR_GT3_AXLE
	strain_RL_GT3_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_CART_90s
	crankshaft_CART_90s
	clutch_CART_1000Nm_90s
	clutchshaft_F1
	clutchshaft_F1_bearing
	clutchshaft_strain_F1_flex_soft
	clutchshaft_F1_POST
	gearbox_F1_POST_F1_flex_soft
	driveshaft_F1
	driveshaft_strain_gauge_F1_flex_waxle
	driveshaft_GT3_POST
	RWD_CART_rear_diff_v3
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_15hp_wheel_bearing_RR
	RWD_15hp_wheel_bearing_RL
	
RECORD RWD_CART_LOLA_T95_FORD_01 l_driveline
	name "CART_LOLA_T95_FORD"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000	

RECORD RWD_CART_LOLA_T95_MERCEDES_01 l_driveline
	name "CART_LOLA_T95_MERCEDES"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000	

RECORD RWD_CART_REYNARD_95I_FORD_01 l_driveline
	name "CART_REYNARD_95I_FORD"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000

RECORD RWD_CART_REYNARD_95I_HONDA_01 l_driveline
	name "CART_REYNARD_95I_HONDA"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000

RECORD RWD_CART_REYNARD_95I_MERCEDES_01 l_driveline
	name "CART_REYNARD_95I_MERCEDES"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000

RECORD RWD_CART_REYNARD_98I_FORD_01 l_driveline
	name "CART_REYNARD_98I_FORD"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000

RECORD RWD_CART_REYNARD_98I_HONDA_01 l_driveline
	name "CART_REYNARD_98I_HONDA"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000

RECORD RWD_CART_REYNARD_98I_MERCEDES_01 l_driveline
	name "CART_REYNARD_98I_MERCEDES"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000

RECORD RWD_CART_REYNARD_98I_TOYOTA_01 l_driveline
	name "CART_REYNARD_98I_TOYOTA"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000
	
RECORD RWD_CART_SWIFT_009C_01 l_driveline
	name "CART_SWIFT_009C"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000
	
RECORD RWD_CART_LOLA_T98_01 l_driveline
	name "CART_LOLA_T98"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000	

RECORD RWD_CART_REYNARD_2KI_FORD_02 l_driveline
	name "CART_REYNARD_2KI_FORD"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000

RECORD RWD_CART_REYNARD_2KI_HONDA_02 l_driveline
	name "CART_REYNARD_2KI_HONDA"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000

RECORD RWD_CART_REYNARD_2KI_MERCEDES_02 l_driveline
	name "CART_REYNARD_2KI_MERCEDES"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000

RECORD RWD_CART_REYNARD_2KI_TOYOTA_02 l_driveline
	name "CART_REYNARD_2KI_TOYOTA"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000
	
RECORD RWD_CART_LOLA_B2K00_01_FORD l_driveline
	name "CART_LOLA_B2K00_FORD"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000	

RECORD RWD_CART_LOLA_B2K00_MERCEDES_01 l_driveline
	name "CART_LOLA_B2K00_MERCEDES"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000	

RECORD RWD_CART_LOLA_B2K00_TOYOTA_01 l_driveline
	name "CART_LOLA_B2K00_TOYOTA"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000	

RECORD RWD_CART_REYNARD_98I_FORD_SS_01 l_driveline
	name "CART_REYNARD_98I_FORD_SS"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000

RECORD RWD_CART_REYNARD_98I_HONDA_SS_01 l_driveline
	name "CART_REYNARD_98I_HONDA_SS"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000

RECORD RWD_CART_REYNARD_98I_MERCEDES_SS_01 l_driveline
	name "CART_REYNARD_98I_MERCEDES_SS"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000

RECORD RWD_CART_REYNARD_98I_TOYOTA_SS_01 l_driveline
	name "CART_REYNARD_98I_TOYOTA_SS"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000
	
RECORD RWD_CART_SWIFT_009C_SS_01 l_driveline
	name "CART_SWIFT_009C_SS"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000
	
RECORD RWD_CART_LOLA_T98_SS_01 l_driveline
	name "CART_LOLA_T98_SS"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000	

RECORD RWD_CART_REYNARD_2KI_FORD_SS_01 l_driveline
	name "CART_REYNARD_2KI_FORD_SS"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000

RECORD RWD_CART_REYNARD_2KI_HONDA_SS_01 l_driveline
	name "CART_REYNARD_2KI_HONDA_SS"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000

RECORD RWD_CART_REYNARD_2KI_MERCEDES_SS_01 l_driveline
	name "CART_REYNARD_2KI_MERCEDES_SS"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000

RECORD RWD_CART_REYNARD_2KI_TOYOTA_SS_01 l_driveline
	name "CART_REYNARD_2KI_TOYOTA_SS"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000
	
RECORD RWD_CART_LOLA_B2K00_01_FORD_SS l_driveline
	name "CART_LOLA_B2K00_FORD_SS"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000	

RECORD RWD_CART_LOLA_B2K00_HONDA_SS_01 l_driveline
	name "CART_LOLA_B2K00_HONDA_SS"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000	

RECORD RWD_CART_LOLA_B2K00_MERCEDES_SS_01 l_driveline
	name "CART_LOLA_B2K00_MERCEDES_SS"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000	

RECORD RWD_CART_LOLA_B2K00_TOYOTA_SS_01 l_driveline
	name "CART_LOLA_B2K00_TOYOTA_SS"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000	

RECORD RWD_CART_LOLA_T95_FORD_SW_01 l_driveline
	name "CART_LOLA_T95_FORD_SW"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000	

RECORD RWD_CART_LOLA_T95_MERCEDES_SW_01 l_driveline
	name "CART_LOLA_T95_MERCEDES_SW"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000	

RECORD RWD_CART_REYNARD_95I_FORD_SW_01 l_driveline
	name "CART_REYNARD_95I_FORD_SW"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000

RECORD RWD_CART_REYNARD_95I_HONDA_SW_01 l_driveline
	name "CART_REYNARD_95I_HONDA_SW"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000

RECORD RWD_CART_REYNARD_95I_MERCEDES_SW_01 l_driveline
	name "CART_REYNARD_95I_MERCEDES_SW"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000

RECORD RWD_CART_REYNARD_98I_FORD_SW_01 l_driveline
	name "CART_REYNARD_98I_FORD_SW"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000

RECORD RWD_CART_REYNARD_98I_MERCEDES_SW_01 l_driveline
	name "CART_REYNARD_98I_MERCEDES_SW"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000

RECORD RWD_CART_REYNARD_98I_TOYOTA_SW_01 l_driveline
	name "CART_REYNARD_98I_TOYOTA_SW"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000
	
RECORD RWD_CART_SWIFT_009C_SW_01 l_driveline
	name "CART_SWIFT_009C_SW"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000
	
RECORD RWD_CART_LOLA_T98_SW_01 l_driveline
	name "CART_LOLA_T98_SW"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000	

RECORD RWD_CART_REYNARD_2KI_FORD_SW_01 l_driveline
	name "CART_REYNARD_2KI_FORD_SW"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000

RECORD RWD_CART_REYNARD_2KI_HONDA_SW_01 l_driveline
	name "CART_REYNARD_2KI_HONDA_SW"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000

RECORD RWD_CART_REYNARD_2KI_MERCEDES_SW_01 l_driveline
	name "CART_REYNARD_2KI_MERCEDES_SW"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000

RECORD RWD_CART_REYNARD_2KI_TOYOTA_SW_01 l_driveline
	name "CART_REYNARD_2KI_TOYOTA_SW"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000
	
RECORD RWD_CART_LOLA_B2K00_01_FORD_SW_01 l_driveline
	name "CART_LOLA_B2K00_FORD_SW"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000	

RECORD RWD_CART_LOLA_B2K00_MERCEDES_SW_01 l_driveline
	name "CART_LOLA_B2K00_MERCEDES_SW"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000	

RECORD RWD_CART_LOLA_B2K00_TOYOTA_SW_01 l_driveline
	name "CART_LOLA_B2K00_TOYOTA_SW"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000	

RECORD RWD_CART_REYNARD_98I_HONDA_SW_01 l_driveline
	name "CART_REYNARD_98I_HONDA_SW"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000

RECORD RWD_CART_LOLA_T95_FORD_SO_01 l_driveline
	name "CART_LOLA_T95_FORD_SO"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000	

RECORD RWD_CART_LOLA_T95_MERCEDES_SO_01 l_driveline
	name "CART_LOLA_T95_MERCEDES_SO"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000	

RECORD RWD_CART_REYNARD_95I_FORD_SO_01 l_driveline
	name "CART_REYNARD_95I_FORD_SO"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000

RECORD RWD_CART_REYNARD_95I_HONDA_SO_01 l_driveline
	name "CART_REYNARD_95I_HONDA_SO"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000

RECORD RWD_CART_REYNARD_95I_MERCEDES_SO_01 l_driveline
	name "CART_REYNARD_95I_MERCEDES_SO"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000

RECORD RWD_CART_REYNARD_98I_FORD_SO_01 l_driveline
	name "CART_REYNARD_98I_FORD_SO"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000

RECORD RWD_CART_REYNARD_98I_HONDA_SO_01 l_driveline
	name "CART_REYNARD_98I_HONDA_SO"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000	

RECORD RWD_CART_REYNARD_98I_MERCEDES_SO_01 l_driveline
	name "CART_REYNARD_98I_MERCEDES_SO"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000

RECORD RWD_CART_REYNARD_98I_TOYOTA_SO_01 l_driveline
	name "CART_REYNARD_98I_TOYOTA_SO"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000
	
RECORD RWD_CART_SWIFT_009C_SO_01 l_driveline
	name "CART_SWIFT_009C_SO"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000
	
RECORD RWD_CART_LOLA_T98_SO_01 l_driveline
	name "CART_LOLA_T98_SO"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000	

RECORD RWD_CART_REYNARD_2KI_FORD_SO_01 l_driveline
	name "CART_REYNARD_2KI_FORD_SO"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000

RECORD RWD_CART_REYNARD_2KI_HONDA_SO_01 l_driveline
	name "CART_REYNARD_2KI_HONDA_SO"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000

RECORD RWD_CART_REYNARD_2KI_MERCEDES_SO_01 l_driveline
	name "CART_REYNARD_2KI_MERCEDES_SO"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000

RECORD RWD_CART_REYNARD_2KI_TOYOTA_SO_01 l_driveline
	name "CART_REYNARD_2KI_TOYOTA_SO"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000
	
RECORD RWD_CART_LOLA_B2K00_01_FORD_SO l_driveline
	name "CART_LOLA_B2K00_FORD_SO"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000	

RECORD RWD_CART_LOLA_B2K00_MERCEDES_SO_01 l_driveline
	name "CART_LOLA_B2K00_MERCEDES_SO"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000	
	
RECORD RWD_CART_LOLA_B2K00_HONDA_SO_01 l_driveline
	name "CART_LOLA_B2K00_HONDA_SO"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000		

RECORD RWD_CART_LOLA_B2K00_TOYOTA_SO_01 l_driveline
	name "CART_LOLA_B2K00_TOYOTA_SO"
	contents RWD_FORMULA_HEWLAND_4_FLEX_v3
	dl:minhz	3000	

##



###############
# CART with turbo, more flex than F-Classics etc
# FLEX ADDED! V3 diff added!
###############
RECORDGROUP RWD_FORMULA_HEWLAND_5_FLEX_v3
	wheel_FR_GT3
	wheel_FL_GT3
	wheel_RR_GT3
	wheel_RL_GT3
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_CART
	axle_strain_RL_CART
	strain_FR_GT3
	strain_FL_GT3
	strain_RR_GT3_AXLE
	strain_RL_GT3_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_CART_90s
	crankshaft_CART_90s
	clutch_CART_1000Nm_90s
	clutchshaft_F1
	clutchshaft_F1_bearing
	clutchshaft_strain_F1_flex_soft
	clutchshaft_F1_POST
	gearbox_F1_POST_F1_flex_soft
	driveshaft_F1
	driveshaft_strain_gauge_F1_flex_waxle
	driveshaft_GT3_POST
	RWD_FUSA_rear_diff_v3
	planet_gear_rear
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_15hp_wheel_bearing_RR
	RWD_15hp_wheel_bearing_RL

RECORD RWD_FORMULA_USA_2022_01 l_driveline
	name "FORMULA_USA_2022"
	contents RWD_FORMULA_HEWLAND_5_FLEX_v3
	dl:minhz	3000

RECORD RWD_FORMULA_USA_2022_SO_01 l_driveline
	name "FORMULA_USA_2022_SO"
	contents RWD_FORMULA_HEWLAND_5_FLEX_v3
	dl:minhz	3000

RECORD RWD_FORMULA_USA_2022_SW_01 l_driveline
	name "FORMULA_USA_2022_SW"
	contents RWD_FORMULA_HEWLAND_5_FLEX_v3
	dl:minhz	3000
##



#############
# RWD, open differential, Hewland gearbox, low inertia, minimal drivetrain loss
# Formula Ford and such
# FLEX ADDED!
#############
RECORDGROUP RWD_FORMULA_FORD_FLEX
	wheel_FR_TCR
	wheel_FL_TCR
	wheel_RR_TCR
	wheel_RL_TCR
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_LPROTO
	axle_strain_RL_LPROTO
	strain_FR_TCR
	strain_FL_TCR
	strain_RR_TCR_AXLE
	strain_RL_TCR_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_ROAD_LIGHT
	crankshaft_ROAD_LIGHT
	clutch_ROAD_GT3_300Nm
	clutchshaft_GT3
	clutchshaft_GT3_bearing
	clutchshaft_strain_GT3_flex_stiff
	clutchshaft_GT3_POST
	gearbox_H-pattern_synchro_GT3_POST_LIGHT_flex
	driveshaft_LIGHT
	driveshaft_strain_gauge_LIGHT_flex_waxle
	driveshaft_GT3_POST
	RWD_trainer_open_rear_diff
	planet_gear_rear_LIGHT
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	wheel_bearing_RR
	wheel_bearing_RL		

RECORD RWD_FORMULA_FORD_01 l_driveline
	name "FORMULA_ROOKIE"
	contents RWD_FORMULA_FORD_FLEX
	dl:minhz	3000
	
RECORD RWD_FORMULA_TRAINER_01 l_driveline
	name "FORMULA_TRAINER"
	contents RWD_FORMULA_FORD_FLEX
	dl:minhz	3000
	
RECORD RWD_FORMULA_TRAINER_A_01 l_driveline
	name "FORMULA_TRAINER_A"
	contents RWD_FORMULA_FORD_FLEX
	dl:minhz	3000	
##



#############
# RWD, open differential, Hewland gearbox, low inertia, minimal drivetrain loss
# Formula Ford and such
# FLEX ADDED!
#############
RECORDGROUP RWD_FORMULA_FORD2_FLEX
	wheel_FR_TCR
	wheel_FL_TCR
	wheel_RR_TCR
	wheel_RL_TCR
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	axle_RR
	axle_RL
	axle_strain_RR_LPROTO
	axle_strain_RL_LPROTO
	strain_FR_TCR
	strain_FL_TCR
	strain_RR_TCR_AXLE
	strain_RL_TCR_AXLE
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_ROAD_LIGHT
	crankshaft_ROAD_LIGHT
	clutch_ROAD_GT3_300Nm
	clutchshaft_GT3
	clutchshaft_GT3_bearing
	clutchshaft_strain_GT3_flex_stiff
	clutchshaft_GT3_POST
	gearbox_H-pattern_synchro_GT3_POST_LIGHT_flex
	driveshaft_LIGHT
	driveshaft_strain_gauge_LIGHT_flex_waxle
	driveshaft_GT3_POST
	RWD_proto_open_rear_diff
	planet_gear_rear_MED
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	wheel_bearing_RR
	wheel_bearing_RL		
	
RECORD RWD_MCR2000_01 l_driveline	
	name "MCR2000"
	contents RWD_FORMULA_FORD2_FLEX
	dl:minhz	3000	

RECORD RWD_FORMULA_INTER_01 l_driveline	
	name "FORMULA_INTER"
	contents RWD_FORMULA_FORD2_FLEX
	dl:minhz	3000	
##



#############
# FWD, modern, sequential gearbox race cars, low engine inertia, low wheel inertia, medium drivetrain power loss
# FLEX ADDED! DIFF v3 ADDED!
#############
RECORDGROUP FWD_MODERN_SEQUENTIAL_TCR_FLEX_v3
	wheel_FR_TCR
	wheel_FL_TCR
	wheel_RR_TCR
	wheel_RL_TCR
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR_TCR
	strain_FL_TCR
	strain_RR_TCR
	strain_RL_TCR
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_TCR
	crankshaft_TCR
	clutch_TCR_550Nm
	clutchshaft_GT3
	clutchshaft_GT3_bearing
	clutchshaft_strain_GT3_flex_stiff
	clutchshaft_GT3_POST
	gearbox_GT3_POST_LIGHT_flex
	driveshaft_LIGHT
	driveshaft_strain_gauge_LIGHT_flex_ultrastiff
	driveshaft_GT3_POST
	FWD_front_diff_v3
	planet_gear_front
	FWD_spool
	FWD_15hp_wheel_bearing_FR
	FWD_15hp_wheel_bearing_FL
	wheel_bearing_RR
	wheel_bearing_RL

RECORD FWD_TC_05 l_driveline
	name "MINI_COOPER"
	contents FWD_MODERN_SEQUENTIAL_TCR_FLEX_v3
	dl:minhz	3000	
##



#############
# FWD, modern, sequential gearbox race cars, low engine inertia, low wheel inertia, medium drivetrain power loss
# FLEX ADDED!
#############
RECORDGROUP FWD_MODERN_SEQUENTIAL_TCR_2_FLEX
	wheel_FR_TCR
	wheel_FL_TCR
	wheel_RR_TCR
	wheel_RL_TCR
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR_TCR
	strain_FL_TCR
	strain_RR_TCR
	strain_RL_TCR
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	torqueshaft
	torqueshaft_strain_TCR
	crankshaft_TCR
	clutch_TCR_300Nm
	clutchshaft_GT3
	clutchshaft_GT3_bearing
	clutchshaft_strain_GT3_flex_ultrastiff
	clutchshaft_GT3_POST
	gearbox_GT3_POST_LIGHT_instant_flex
	driveshaft_LIGHT
	driveshaft_strain_gauge_LIGHT_flex_ultraultrastiff
	driveshaft_GT3_POST
	FWD_front_diff
	planet_gear_front
	FWD_spool
	FWD_15hp_wheel_bearing_FR
	FWD_15hp_wheel_bearing_FL
	wheel_bearing_RR
	wheel_bearing_RL

RECORD FWD_TC_06 l_driveline
	name "VW_POLO"
	contents FWD_MODERN_SEQUENTIAL_TCR_2_FLEX
	dl:minhz	3000	
	
RECORD FWD_TC_07 l_driveline
	name "VW_VIRTUS"
	contents FWD_MODERN_SEQUENTIAL_TCR_2_FLEX
	dl:minhz	3000		
	
RECORD FWD_TC_08 l_driveline
	name "VW_POLO_GTS"
	contents FWD_MODERN_SEQUENTIAL_TCR_2_FLEX
	dl:minhz	3000	
	
RECORD FWD_TC_09 l_driveline
	name "VW_VIRTUS_GTS"
	contents FWD_MODERN_SEQUENTIAL_TCR_2_FLEX
	dl:minhz	3000
##



###############
# AWD, sequential gearbox, road car wheel inertia, high drivetrain power loss on all wheels, no handbrake clutch on rear axle
# FLEX ADDED! DIFF v3 ADDED!
###############
RECORDGROUP AWD_RACE_SEQUENTIAL_SVA_FLEX_v3
	wheel_FR_ROAD_medium
	wheel_FL_ROAD_medium
	wheel_RR_ROAD_medium
	wheel_RL_ROAD_medium
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR_ROAD_medium
	strain_FL_ROAD_medium
	strain_RR_ROAD_medium
	strain_RL_ROAD_medium
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	crankshaft_GT3
	clutch_GT3_650Nm
	clutchshaft_GT3
	clutchshaft_GT3_bearing
	clutchshaft_strain_GT3_flex_stiff
	clutchshaft_GT3_POST
	gearbox_GT3_POST_MEDIUM-LIGHT_flex
	driveshaft_MEDIUM-LIGHT
	driveshaft_strain_gauge_MEDIUM-LIGHT_flex_stiff
	driveshaft_GT3_POST
	AWD_front_diff_v3
	driveshaft_AWD_front
	AWD_center_diff_v3
	driveshaft_AWD_rear
	driveshaft_AWD_rear_coupling
	driveshaft_AWD_rear_clutch
	AWD_rear_diff_v3
	planet_gear_front
	planet_gear_center
	planet_gear_rear
	FWD_spool
	AWD_center_spool
	RWD_spool
	FWD_15hp_wheel_bearing_FR
	FWD_15hp_wheel_bearing_FL
	RWD_15hp_wheel_bearing_RR
	RWD_15hp_wheel_bearing_RL

##
RECORD AWD_RACE_SEQUENTIAL_01 l_driveline
	name "MITSUBISHI_SVA_EVO6RS"
	contents AWD_RACE_SEQUENTIAL_SVA_FLEX_v3
	dl:minhz	3000
	
RECORD AWD_RACE_SEQUENTIAL_02 l_driveline
	name "MITSUBISHI_LANCERR"
	contents AWD_RACE_SEQUENTIAL_SVA_FLEX_v3
	dl:minhz	3000
	
RECORD AWD_RACE_SEQUENTIAL_03 l_driveline
	name "MITSUBISHI_LANCERRS"
	contents AWD_RACE_SEQUENTIAL_SVA_FLEX_v3
	dl:minhz	3000
##



###############
# AWD, paddle shift semi-auto or dual-clutch gearbox, road car wheel inertia, medium drivetrain power loss on all wheels
###############

RECORDGROUP AWD_SEMI-AUTO_ROAD_A
	wheel_FR_ROAD_medium
	wheel_FL_ROAD_medium
	wheel_RR_ROAD_medium
	wheel_RL_ROAD_medium
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR_ROAD_medium
	strain_FL_ROAD_medium
	strain_RR_ROAD_medium
	strain_RL_ROAD_medium
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	crankshaft_GT3
	clutch_GT3_1000Nm
	clutchshaft_GT3
	clutchshaft_GT3_bearing
	gearbox_AMT_synchro
	driveshaft_GT3
	driveshaft_strain_gauge
	driveshaft_GT3_POST
	AWD_front_diff
	driveshaft_AWD_front
	AWD_center_diff
	driveshaft_AWD_rear
	AWD_clutch_rear
	driveshaft_AWD_rear_clutch
	AWD_rear_diff
	planet_gear_front
	planet_gear_center
	planet_gear_rear
	FWD_spool
	AWD_center_spool
	RWD_spool
	FWD_15hp_wheel_bearing_FR
	FWD_15hp_wheel_bearing_FL
	RWD_15hp_wheel_bearing_RR
	RWD_15hp_wheel_bearing_RL

##
RECORD AWD_SEMI-AUTO_ROAD_A_01 l_driveline
	name "LAMBORGHINI_SESTO_ELEMENTO"
	contents AWD_SEMI-AUTO_ROAD_A
	dl:minhz	3000

RECORD AWD_SEMI-AUTO_ROAD_A_03 l_driveline
	name "AUDI_R8_V10_PLUS"
	contents AWD_SEMI-AUTO_ROAD_A
	dl:minhz	3000

RECORD AWD_SEMI-AUTO_ROAD_A_04 l_driveline
	name "LAMBORGHINI_HURACAN"
	contents AWD_SEMI-AUTO_ROAD_A
	dl:minhz	3000

RECORD AWD_SEMI-AUTO_ROAD_A_06 l_driveline
	name "LAMBORGHINI_AVENTADOR"
	contents AWD_SEMI-AUTO_ROAD_A
	dl:minhz	3000

RECORD AWD_SEMI-AUTO_ROAD_A_07 l_driveline
	name "LAMBORGHINI_VENENO"
	contents AWD_SEMI-AUTO_ROAD_A
	dl:minhz	3000
##


###############
# AWD, paddle shift semi-auto or dual-clutch gearbox, road car wheel inertia, medium drivetrain power loss on all wheels
# Variant for F-Type and GT-R
###############

RECORDGROUP AWD_SEMI-AUTO_ROAD_B
	wheel_FR_ROAD_medium
	wheel_FL_ROAD_medium
	wheel_RR_ROAD_medium
	wheel_RL_ROAD_medium
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR_ROAD_medium
	strain_FL_ROAD_medium
	strain_RR_ROAD_medium
	strain_RL_ROAD_medium
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	crankshaft_GT3
	clutch_GT3_1000Nm
	clutchshaft_GT3
	clutchshaft_GT3_bearing
	gearbox_AMT_synchro
	driveshaft_GT3
	driveshaft_strain_gauge
	driveshaft_GT3_POST
	AWD_front_diff
	driveshaft_AWD_front
	AWD_center_diff
	driveshaft_AWD_rear
	AWD_clutch_rear
	driveshaft_AWD_rear_clutch
	AWD_rear_diff
	planet_gear_front
	planet_gear_center
	planet_gear_rear
	FWD_spool
	AWD_center_spool
	RWD_spool
	FWD_15hp_wheel_bearing_FR
	FWD_15hp_wheel_bearing_FL
	RWD_15hp_wheel_bearing_RR
	RWD_15hp_wheel_bearing_RL

RECORD AWD_SEMI-AUTO_ROAD_A_02 l_driveline
	name "JAGUAR_F-TYPE_SVR"
	contents AWD_SEMI-AUTO_ROAD_B
	dl:minhz	3000

RECORD AWD_SEMI-AUTO_ROAD_A_05 l_driveline
	name "NISSAN_GTR_NISMO"
	contents AWD_SEMI-AUTO_ROAD_B
	dl:minhz	3000
##



#############
# AWD system that starts as pure RWD but shifts to the rear on wheelspin. Using a viscous coupling for this.
# Model for Nissan Skyline R32 & R34. H-Pattern gearbox, medium wheel inertia, medium drivetrain power loss
#############

RECORDGROUP AWD_H-PATTERN_SKYLINE_R32
	wheel_FR_ROAD_medium
	wheel_FL_ROAD_medium
	wheel_RR_ROAD_medium
	wheel_RL_ROAD_medium
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR_ROAD_medium
	strain_FL_ROAD_medium
	strain_RR_ROAD_medium
	strain_RL_ROAD_medium
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	crankshaft_GT3
	clutch_GT3_1000Nm
	clutchshaft_GT3
	clutchshaft_GT3_bearing
	gearbox_H-pattern_synchro
	driveshaft_GT3
	driveshaft_strain_gauge
	driveshaft_GT3_POST
	AWD_front_diff
	driveshaft_AWD_front
	AWD_SKYLINE_R32_front_coupling
	RWD_rear_diff
	planet_gear_front
	planet_gear_rear
	FWD_spool
	RWD_spool
	FWD_15hp_wheel_bearing_FR
	FWD_15hp_wheel_bearing_FL
	RWD_15hp_wheel_bearing_RR
	RWD_15hp_wheel_bearing_RL

##
RECORD AWD_H-PATTERN_SKYLINE_R32_01 l_driveline
	name "NISSAN_SKYLINE_R34_SMSR"
	contents AWD_H-PATTERN_SKYLINE_R32
	dl:minhz	3000
	
RECORD AWD_SKYLINE_R32_02 l_driveline
	name "NISSAN_SKYLINE_BNR32_GROUPA"
	contents AWD_H-PATTERN_SKYLINE_R32
	dl:minhz	3000
##

#############
# AWD road cars with ICE on the rear only and hybrid on front or all four wheels
#############

RECORDGROUP AWD_DUAL-CLUTCH_FRONT-HYBRID
	wheel_FR_ROAD_medium
	wheel_FL_ROAD_medium
	wheel_RR_ROAD_medium
	wheel_RL_ROAD_medium
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR_ROAD_medium
	strain_FL_ROAD_medium
	strain_RR_ROAD_medium
	strain_RL_ROAD_medium
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	crankshaft_GT3
	clutch_GT3_1000Nm
	clutchshaft_GT3
	clutchshaft_GT3_bearing
	gearbox_AMT_synchro
	driveshaft_GT3
	driveshaft_strain_gauge
	driveshaft_GT3_POST
	HYBRID_front_diff
	RWD_rear_diff
	planet_gear_front
	planet_gear_rear
	shaft_dummy
	RWD_spool
	FWD_15hp_wheel_bearing_FR
	FWD_15hp_wheel_bearing_FL
	RWD_15hp_wheel_bearing_RR
	RWD_15hp_wheel_bearing_RL

##
RECORD AWD_DUAL-CLUTCH_FRONT-HYBRID_01 l_driveline
	name "ACURA_NSX_2017"
	contents AWD_DUAL-CLUTCH_FRONT-HYBRID
	dl:minhz	3000

RECORD AWD_DUAL-CLUTCH_FRONT-HYBRID_02 l_driveline
	name "PORSCHE_918"
	contents AWD_DUAL-CLUTCH_FRONT-HYBRID
	dl:minhz	3000
##


#############
# Driveline model for all modern RX cars and the OMSE Supercar Lites
# Spool center, Salisbury front & rear. Bearing friction adding up to about 10% drivetrain loss on the 600hp cars
#############
RECORDGROUP AWD_RX
	wheel_FR_GT3
	wheel_FL_GT3
	wheel_RR_GT3
	wheel_RL_GT3
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR_GT3
	strain_FL_GT3
	strain_RR_GT3
	strain_RL_GT3
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	crankshaft_TCR
	clutch_TCR_1000Nm
	clutchshaft_GT3
	clutchshaft_GT3_bearing
	gearbox_GT3
	driveshaft_GT3
	driveshaft_strain_gauge
	driveshaft_GT3_POST
	FWD_front_diff
	clutch_RX_rear
	driveshaft_AWD_rear_clutch
	AWD_rear_diff
	planet_gear_front
	planet_gear_rear
	FWD_spool
	RWD_spool
	FWD_15hp_wheel_bearing_FR
	FWD_15hp_wheel_bearing_FL
	RWD_15hp_wheel_bearing_RR
	RWD_15hp_wheel_bearing_RL

##
RECORD AWD_RX_01 l_driveline
	name "MINI_RX"
	contents AWD_RX
	dl:minhz	6000

RECORD AWD_RX_02 l_driveline
	name "MERCEDES_A45_RX"
	contents AWD_RX
	dl:minhz	6000

RECORD AWD_RX_03 l_driveline
	name "RENAULT_MEGANE_RX"
	contents AWD_RX
	dl:minhz	6000

RECORD AWD_RX_04 l_driveline
	name "OMSE_RX_SCL"
	contents AWD_RX
	dl:minhz	6000

RECORD AWD_RX_05 l_driveline
	name "FORD_FOCUS_GRC"
	contents AWD_RX
	dl:minhz	6000

RECORD AWD_RX_06 l_driveline
	name "HONDA_CIVIC_GRC"
	contents AWD_RX
	dl:minhz	6000

RECORD AWD_RX_07 l_driveline
	name "VW_POLO_RX"
	contents AWD_RX
	dl:minhz	6000

RECORD AWD_RX_08 l_driveline
	name "AUDI_S1_EKS"
	contents AWD_RX
	dl:minhz	6000

RECORD AWD_RX_09 l_driveline
	name "CITROEN_DS3_RX"
	contents AWD_RX
	dl:minhz	6000
	
##


#############
# FWD, modern, sequential gearbox race cars, low engine inertia, low wheel inertia, medium drivetrain power loss
#############
RECORDGROUP FWD_MODERN_SEQUENTIAL_TCR
	wheel_FR_TCR
	wheel_FL_TCR
	wheel_RR_TCR
	wheel_RL_TCR
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR_TCR
	strain_FL_TCR
	strain_RR_TCR
	strain_RL_TCR
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	crankshaft_TCR
	clutch_TCR_550Nm
	clutchshaft_GT3
	clutchshaft_GT3_bearing
	gearbox_GT3
	driveshaft_GT3
	driveshaft_strain_gauge
	driveshaft_GT3_POST
	FWD_front_diff
	planet_gear_front
	FWD_spool
	FWD_15hp_wheel_bearing_FR
	FWD_15hp_wheel_bearing_FL
	wheel_bearing_RR
	wheel_bearing_RL

##
RECORD FWD_TC_01 l_driveline
	name "RENAULT_CLIO_CUP14"
	contents FWD_MODERN_SEQUENTIAL_TCR
	dl:minhz	3000

RECORD FWD_TC_02 l_driveline
	name "MERCEDES_A45_TCR"
	contents FWD_MODERN_SEQUENTIAL_TCR
	dl:minhz	3000

RECORD FWD_TC_03 l_driveline
	name "RENAULT_MEGANE_TCR"
	contents FWD_MODERN_SEQUENTIAL_TCR
	dl:minhz	3000

RECORD FWD_TC_04 l_driveline
	name "OPEL_ASTRA_TCR"
	contents FWD_MODERN_SEQUENTIAL_TCR
	dl:minhz	3000
##


#############
# AWD, H-pattern synchro manual. Front, center, and rear diffs with handbrake clutch on the rear.
#############
RECORDGROUP AWD_H-PATTERN_SYNCHRO_ROAD_A
	wheel_FR_ROAD_medium
	wheel_FL_ROAD_medium
	wheel_RR_ROAD_medium
	wheel_RL_ROAD_medium
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR_ROAD_medium
	strain_FL_ROAD_medium
	strain_RR_ROAD_medium
	strain_RL_ROAD_medium
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	crankshaft_GT3
	clutch_GT3_700Nm
	clutchshaft_GT3
	clutchshaft_GT3_bearing
	gearbox_H-pattern_synchro
	driveshaft_GT3
	driveshaft_strain_gauge
	driveshaft_GT3_POST
	AWD_front_diff
	driveshaft_AWD_front
	AWD_center_diff
	driveshaft_AWD_rear
	AWD_clutch_rear
	driveshaft_AWD_rear_clutch
	AWD_rear_diff
	planet_gear_front
	planet_gear_center
	planet_gear_rear
	FWD_spool
	AWD_center_spool
	RWD_spool
	FWD_15hp_wheel_bearing_FR
	FWD_15hp_wheel_bearing_FL
	RWD_15hp_wheel_bearing_RR
	RWD_15hp_wheel_bearing_RL

##	
RECORD AWD_H-PATTERN_SYNCHRO_ROAD_A_02 l_driveline
	name "MITSUBISHI_LANCER_EVO_IX_FQ360"
	contents AWD_H-PATTERN_SYNCHRO_ROAD_A
	dl:minhz	3000

RECORD AWD_H-PATTERN_SYNCHRO_ROAD_A_03 l_driveline
	name "MITSUBISHI_LANCER_EVO_X_FQ400"
	contents AWD_H-PATTERN_SYNCHRO_ROAD_A
	dl:minhz	3000
##


#############
# AWD, H-pattern synchro manual. Front, center, and rear diffs. No handbrake clutch disconnect on rear axle.
#############
RECORDGROUP AWD_H-PATTERN_SYNCHRO_ROAD_B
	wheel_FR_ROAD_medium
	wheel_FL_ROAD_medium
	wheel_RR_ROAD_medium
	wheel_RL_ROAD_medium
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR_ROAD_medium
	strain_FL_ROAD_medium
	strain_RR_ROAD_medium
	strain_RL_ROAD_medium
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	crankshaft_GT3
	clutch_GT3_700Nm
	clutchshaft_GT3
	clutchshaft_GT3_bearing
	gearbox_H-pattern_synchro
	driveshaft_GT3
	driveshaft_strain_gauge
	driveshaft_GT3_POST
	AWD_front_diff
	driveshaft_AWD_front
	AWD_center_diff
	driveshaft_AWD_rear
	driveshaft_AWD_rear_coupling
	driveshaft_AWD_rear_clutch
	AWD_rear_diff
	planet_gear_front
	planet_gear_center
	planet_gear_rear
	FWD_spool
	AWD_center_spool
	RWD_spool
	FWD_15hp_wheel_bearing_FR
	FWD_15hp_wheel_bearing_FL
	RWD_15hp_wheel_bearing_RR
	RWD_15hp_wheel_bearing_RL

##
RECORD AWD_H-PATTERN_SYNCHRO_ROAD_B_01 l_driveline
	name "MITSUBISHI_LANCER_EVOVI_TME"
	contents AWD_H-PATTERN_SYNCHRO_ROAD_B
	dl:minhz	3000
##


#############
# AWD, race H-pattern gearbox, low engine inertia, medium wheel inertia, medium power loss on all four wheels
#############

RECORDGROUP AWD_RACE_HEWLAND
	wheel_FR_GT3
	wheel_FL_GT3
	wheel_RR_GT3
	wheel_RL_GT3
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR_GT3
	strain_FL_GT3
	strain_RR_GT3
	strain_RL_GT3
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	crankshaft_TCR
	clutch_TCR_800Nm
	clutchshaft_GT3
	clutchshaft_GT3_bearing
	gearbox_Hewland
	driveshaft_GT3
	driveshaft_strain_gauge
	driveshaft_GT3_POST
	AWD_front_diff
	driveshaft_AWD_front
	AWD_center_diff
	driveshaft_AWD_rear
	driveshaft_AWD_rear_coupling
	driveshaft_AWD_rear_clutch
	AWD_rear_diff
	planet_gear_front
	planet_gear_center
	planet_gear_rear
	FWD_spool
	AWD_center_spool
	RWD_spool
	FWD_15hp_wheel_bearing_FR
	FWD_15hp_wheel_bearing_FL
	RWD_15hp_wheel_bearing_RR
	RWD_15hp_wheel_bearing_RL
	
##
RECORD AWD_AUDI_90_IMSA_01 l_driveline
	name "AUDI_90_IMSA_GTO"
	contents AWD_RACE_HEWLAND
	dl:minhz	6000

RECORD AWD_AUDI_90_IMSA_02 l_driveline
	name "AUDI_V8_DTM"
	contents AWD_RACE_HEWLAND
	dl:minhz	6000

RECORD AWD_GROUP_B_01 l_driveline
	name "AUDI_SPORT_QUATTRO_S1"
	contents AWD_RACE_HEWLAND
	dl:minhz	6000

RECORD AWD_GROUP_B_02 l_driveline
	name "FORD_RS200"
	contents AWD_RACE_HEWLAND
	dl:minhz	6000
##

#############
# AWD system that starts as pure FWD but shifts to the rear on wheelspin. Using a viscous coupling for this.
# H-pattern synchro gearbox, medium engine and wheel inertia, medium drivetrain loss on front wheels only
#############
RECORDGROUP AWD_AUDI_A1_QUATTRO
	wheel_FR_ROAD_medium
	wheel_FL_ROAD_medium
	wheel_RR_ROAD_medium
	wheel_RL_ROAD_medium
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR_ROAD_medium
	strain_FL_ROAD_medium
	strain_RR_ROAD_medium
	strain_RL_ROAD_medium
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	crankshaft_GT3
	clutch_GT3_700Nm
	clutchshaft_GT3
	clutchshaft_GT3_bearing
	gearbox_H-pattern_synchro
	driveshaft_GT3
	driveshaft_strain_gauge
	driveshaft_GT3_POST
	FWD_front_diff
	AUDI_A1_viscous_rear_coupling
	driveshaft_AWD_rear
	AWD_clutch_rear
	driveshaft_AWD_rear_clutch
	AWD_rear_diff
	planet_gear_front
	planet_gear_rear
	FWD_spool
	FWD_15hp_wheel_bearing_FR
	FWD_15hp_wheel_bearing_FL
	wheel_bearing_RR
	wheel_bearing_RL

##	
RECORD AWD_AUDI_A1_QUATTRO_01 l_driveline
	name "AUDI_A1_QUATTRO"
	contents AWD_AUDI_A1_QUATTRO
	dl:minhz	3000
##

#############
# AWD system that starts as pure FWD but shifts to the rear on wheelspin. Using a viscous coupling for this.
# Dual-Clutch gearbox, medium engine and wheel inertia, medium drivetrain loss on front wheels only
#############
RECORDGROUP AWD_MERCEDES_A45AMG
	wheel_FR_ROAD_medium
	wheel_FL_ROAD_medium
	wheel_RR_ROAD_medium
	wheel_RL_ROAD_medium
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR_ROAD_medium
	strain_FL_ROAD_medium
	strain_RR_ROAD_medium
	strain_RL_ROAD_medium
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	crankshaft_GT3
	clutch_GT3_1000Nm
	clutchshaft_GT3
	clutchshaft_GT3_bearing
	gearbox_AMT_synchro
	driveshaft_GT3
	driveshaft_strain_gauge
	driveshaft_GT3_POST
	FWD_front_diff
	AUDI_A1_viscous_rear_coupling
	driveshaft_AWD_rear
	AWD_clutch_rear
	driveshaft_AWD_rear_clutch
	AWD_rear_diff
	planet_gear_front
	planet_gear_rear
	FWD_spool
	FWD_15hp_wheel_bearing_FR
	FWD_15hp_wheel_bearing_FL
	wheel_bearing_RR
	wheel_bearing_RL

##
RECORD AWD_AUDI_A1_QUATTRO_02 l_driveline
	name "MERCEDES_A45_AMG"
	contents AWD_MERCEDES_A45AMG
	dl:minhz	3000
##



#############
# Lotus 56 4-wheel drive system. Ferguson transfer drive in the center going to regular differentials front and rear
#############

RECORD AWD_LOTUS_56_center_diff amalgam_diff
	pair:left driveshaft_AWD_front
	pair:right driveshaft_AWD_rear
	diff:shaft driveshaft_GT3_POST
	diff:planet planet_gear_center
	mat:stiffness 1.0e6
	diff:drag "0.0 0.0 0.0"
	mat:flags 0
	# Torsen
	diff:gear_lsd false
	diff:bias_ratio "2.4 1.0"
	diff:right_ratio 0.5
	# Salisbury
	diff:clutch_lsd false
	diff:preload 0
	diff:ramp_angle "90 90"
	diff:lock_per_clutch 0.04
	diff:clutches 4
	diff:clutch_slip_factor 1.5
	# VLSD
	diff:visc_lsd false
	diff:visc_locking 100
	diff:visc_hump "0.0 390.0"
	diff:visc_degrade "0.001 300.0"
	diff:visc_fail 1000.0
	diff:visc_heating "0.0 0.0"
	# Ratchet
	diff:ratchet_lsd true

##
RECORD AWD_LOTUS_56 l_driveline
	name "LOTUS_56"
	contents AWD_LOTUS_56
	dl:minhz	3000

RECORD AWD_LOTUS_56_02 l_driveline
	name "LOTUS_56_OVAL"
	contents AWD_LOTUS_56
	dl:minhz	3000
##


#############
# kart models
#############
RECORDGROUP RWD_SUPERKART
	wheel_FR_KART
	wheel_FL_KART
	wheel_RR_KART
	wheel_RL_KART
	wheel_FR_KART_internal
	wheel_FL_KART_internal
	wheel_RR_KART_internal
	wheel_RL_KART_internal
	strain_FR_KART
	strain_FL_KART
	strain_RR_KART
	strain_RL_KART
	brake_FR_kart2
	brake_FL_kart2
	brake_RR_kart2
	brake_RL_kart2
	crankshaft_KART
	clutch_SUPERKART
	clutchshaft_KART
	clutchshaft_KART_bearing
	gearbox_KART
	driveshaft_KART
	driveshaft_KART_strain_gauge
	driveshaft_KART_POST
	KART_rear_diff
	planet_gear_rear
	KART_spool
	
RECORD RWD_SUPERKART l_driveline
	name "SUPERKART"
	contents RWD_SUPERKART
	dl:minhz	3000		
	
RECORDGROUP RWD_KART_SHIFTER
	wheel_FR_KART
	wheel_FL_KART
	wheel_RR_KART
	wheel_RL_KART
	wheel_FR_KART_internal
	wheel_FL_KART_internal
	wheel_RR_KART_internal
	wheel_RL_KART_internal
	strain_FR_KART
	strain_FL_KART
	strain_RR_KART
	strain_RL_KART
	brake_FR_kart2
	brake_FL_kart2
	brake_RR_kart2
	brake_RL_kart2
	crankshaft_KART
	clutch_SUPERKART
	clutchshaft_KART
	clutchshaft_KART_bearing
	gearbox_KART
	driveshaft_KART
	driveshaft_KART_strain_gauge
	driveshaft_KART_POST
	KART_rear_diff
	planet_gear_rear
	KART_spool
	
RECORD RWD_KART_SHIFTER_01 l_driveline
	name "KART_SHIFTER"
	contents RWD_KART_SHIFTER
	dl:minhz	3000

RECORD brake_FR_kart2 l_brake
	brake:disc			wheel_FR_KART_internal
	brake:slip_factor	0.9
	brake:wheel			"FR"

RECORD brake_FL_kart2 l_brake
	brake:disc			wheel_FL_KART_internal
	brake:slip_factor	0.9
	brake:wheel			"FL"

RECORD brake_RR_kart2 l_brake
	brake:disc			wheel_RR_KART_internal
	brake:slip_factor	0.9
	brake:wheel			"RR"

RECORD brake_RL_kart2 l_brake
	brake:disc			wheel_RL_KART_internal
	brake:slip_factor	0.9
	brake:wheel			"RL"



RECORDGROUP RWD_KART
	wheel_FR_KART
	wheel_FL_KART
	wheel_RR_KART
	wheel_RL_KART
	wheel_FR_KART_internal
	wheel_FL_KART_internal
	wheel_RR_KART_internal
	wheel_RL_KART_internal
	strain_FR_KART
	strain_FL_KART
	strain_RR_KART
	strain_RL_KART
	brake_FR_kart
	brake_FL_kart
	brake_RR_kart
	brake_RL_kart
	crankshaft_KART
	clutch_KART
	clutchshaft_KART
	clutchshaft_KART_bearing
	gearbox_KART
	driveshaft_KART
	driveshaft_KART_strain_gauge
	driveshaft_KART_POST
	KART_rear_diff
	planet_gear_rear
	KART_spool

RECORD RWD_KART_01 l_driveline
	name "KART_01"
	contents RWD_KART
	dl:minhz	3000
	

	
RECORDGROUP RWD_RENTALKART
	wheel_FR_KART
	wheel_FL_KART
	wheel_RR_KART
	wheel_RL_KART
	wheel_FR_KART_internal
	wheel_FL_KART_internal
	wheel_RR_KART_internal
	wheel_RL_KART_internal
	strain_FR_KART
	strain_FL_KART
	strain_RR_KART
	strain_RL_KART
	brake_FR_kart
	brake_FL_kart
	brake_RR_kart
	brake_RL_kart
	crankshaft_KART
	clutch_RENTALKART
	clutchshaft_KART
	clutchshaft_KART_bearing
	gearbox_KART
	driveshaft_KART
	driveshaft_KART_strain_gauge
	driveshaft_KART_POST
	KART_rear_diff
	planet_gear_rear
	KART_spool
	
RECORD RWD_RENTALKART_01 l_driveline
	name "KART_GX390_RENTAL"
	contents RWD_RENTALKART
	dl:minhz	3000
	
RECORD RWD_RENTALKART_02 l_driveline
	name "KART_GX390"
	contents RWD_RENTALKART
	dl:minhz	3000

# Kart wheel inertia
RECORD wheel_FR_KART shaft
	name "wheel_FR"
	sim:mass 0.07
RECORD wheel_FL_KART shaft
	name "wheel_FL"
	sim:mass 0.07
RECORD wheel_RR_KART shaft
	name "wheel_RR"
	sim:mass 0.1
RECORD wheel_RL_KART shaft
	name "wheel_RL"
	sim:mass 0.1

RECORD strain_FR_KART l_spring
	name "strain_FR"
	pair:left wheel_FR_KART_internal
	pair:right wheel_FR_KART
	mat:stiffness 1.0e6

RECORD strain_FL_KART l_spring
	name "strain_FL"
	pair:left wheel_FL_KART_internal
	pair:right wheel_FL_KART
	mat:stiffness 1.0e6

RECORD strain_RR_KART l_spring
	name "strain_RR"
	pair:left wheel_RR_KART_internal
	pair:right wheel_RR_KART
	mat:stiffness 1.0e6

RECORD strain_RL_KART l_spring
	name "strain_RL"
	pair:left wheel_RL_KART_internal
	pair:right wheel_RL_KART
	mat:stiffness 1.0e6

# All four brakes on the rear axle so the AI work and player gets rear brakes only
RECORD brake_FR_kart l_brake
	brake:disc			wheel_RR_KART_internal
	brake:slip_factor	0.9
	brake:wheel			"RL"

RECORD brake_FL_kart l_brake
	brake:disc			wheel_RL_KART_internal
	brake:slip_factor	0.9
	brake:wheel			"RL"

RECORD brake_RR_kart l_brake
	brake:disc			wheel_RR_KART_internal
	brake:slip_factor	0.9
	brake:wheel			"RL"

RECORD brake_RL_kart l_brake
	brake:disc			wheel_RL_KART_internal
	brake:slip_factor	0.9
	brake:wheel			"RL"


#############
# AWD LM P1H cars with some front differential action on the hybrid motors
#############
RECORDGROUP AWD_LMP1H
	wheel_FR_GT3
	wheel_FL_GT3
	wheel_RR_GT3
	wheel_RL_GT3
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR_GT3
	strain_FL_GT3
	strain_RR_GT3
	strain_RL_GT3
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	crankshaft_GT3
	clutch_GT3_1500Nm
	clutchshaft_GT3
	clutchshaft_GT3_bearing
	gearbox_GT3
	driveshaft_GT3
	driveshaft_strain_gauge
	driveshaft_GT3_POST
	RWD_rear_diff
	RWD_spool
	HYBRID_front_diff
	planet_gear_rear
	planet_gear_front
	shaft_dummy
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_15hp_wheel_bearing_RR
	RWD_15hp_wheel_bearing_RL

##
RECORD AWD_LMP1H_01 l_driveline
	name "AUDI_R18_ETRON"
	contents AWD_LMP1H
	dl:minhz	3000

RECORD AWD_LMP1H_02 l_driveline
	name "MAREK_RP339H"
	contents AWD_LMP1H
	dl:minhz	3000
	
RECORD AWD_LMP1H_03 l_driveline
	name "RWD_P30_LMP1"
	contents AWD_LMP1H
	dl:minhz	3000

RECORD AWD_LMP1H_04 l_driveline
	name "TOYOTA_TS040_14"
	contents AWD_LMP1H
	dl:minhz	3000

RECORD AWD_LMP1H_05 l_driveline
	name "AUDI_R18_LM2016"
	contents AWD_LMP1H
	dl:minhz	3000

RECORD AWD_LMP1H_06 l_driveline
	name "AUDI_R18_2016"
	contents AWD_LMP1H
	dl:minhz	3000

RECORD AWD_LMP1H_07 l_driveline
	name "PORSCHE_919"
	contents AWD_LMP1H
	dl:minhz	3000

RECORD AWD_LMP1H_08 l_driveline
	name "TOYOTA_TS050_16"
	contents AWD_LMP1H
	dl:minhz	3000
##


###############
# Class 4500 Buggy.
###############
RECORDGROUP AWD_CLASS4500_BUGGY
	wheel_FR_F150
	wheel_FL_F150
	wheel_RR_F150
	wheel_RL_F150
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR_F150
	strain_FL_F150
	strain_RR_F150
	strain_RL_F150
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	crankshaft_TRUCK
	#clutch_TH400_AUTO
	clutch_ROAD_1000Nm
	clutchshaft_GT3
	clutchshaft_GT3_bearing
	gearbox_AMT_synchro
	driveshaft_GT3
	driveshaft_strain_gauge
	driveshaft_GT3_POST
	#clutch_SEMI-AUTO_launch_rear
	#driveshaft_AWD_rear_clutch
	#clutch_SEMI-AUTO_launch_rear_db11
	RWD_rear_diff
	planet_gear_front
	planet_gear_rear
	FWD_spool
	RWD_spool
	AWD_front_diff
	driveshaft_AWD_front
	BROCKY_spool
	FWD_15hp_wheel_bearing_FR
	FWD_15hp_wheel_bearing_FL
	RWD_15hp_wheel_bearing_RR
	RWD_15hp_wheel_bearing_RL

RECORD AWD_FORD_BRONCO_RTR l_driveline
	name "FORD_BRONCO_RTR"
	contents AWD_CLASS4500_BUGGY
	dl:minhz	3000

#############
# Porsche 959 AWD system.
# Driveshaft goes to front and rear diff with an 'active' clutch in the middle to control how much torque the front gets
#############

RECORDGROUP AWD_H-PATTERN_PORSCHE_959
	wheel_FR_ROAD_medium
	wheel_FL_ROAD_medium
	wheel_RR_ROAD_medium
	wheel_RL_ROAD_medium
	wheel_FR_internal
	wheel_FL_internal
	wheel_RR_internal
	wheel_RL_internal
	strain_FR_ROAD_medium
	strain_FL_ROAD_medium
	strain_RR_ROAD_medium
	strain_RL_ROAD_medium
	brake_FR
	brake_FL
	brake_RR
	brake_RL
	crankshaft_GT3
	clutch_GT3_1000Nm
	clutchshaft_GT3
	clutchshaft_GT3_bearing
	gearbox_H-pattern_synchro
	driveshaft_GT3
	driveshaft_strain_gauge
	driveshaft_GT3_POST
	AWD_front_diff
	driveshaft_AWD_front
	clutch_AWD_PORSCHE_959
	RWD_rear_diff
	planet_gear_front
	planet_gear_rear
	FWD_spool
	BROCKY_spool
	RWD_spool
	wheel_bearing_FR
	wheel_bearing_FL
	RWD_15hp_wheel_bearing_RR
	RWD_15hp_wheel_bearing_RL

RECORD AWD_GROUP_B_03 l_driveline
	name "PORSCHE_959S"
	contents AWD_H-PATTERN_PORSCHE_959
	dl:minhz	6000

RECORD AWD_GROUP_B_04 l_driveline
	name "PORSCHE_961"
	contents AWD_H-PATTERN_PORSCHE_959
	dl:minhz	3000
#############

############ Indycar 2023 ############

RECORD RWD_INDYCAR_01 l_driveline
	name "INDYCAR"
	contents RWD_FORMULA_HEWLAND_5_FLEX_v3
	dl:minhz	3000
	
RECORD RWD_INDYCAR_01_SW l_driveline
	name "INDYCAR_SW"
	contents RWD_FORMULA_HEWLAND_5_FLEX_v3
	dl:minhz	3000		


RECORD RWD_GRPC-GTP_08_sauber_c9_1989 l_driveline
	name "sauber_c9_1989"
	contents RWD_FORMULA_HEWLAND_2_FLEX_v3
	dl:minhz	3000

RECORD RWD_GRPC-GTP_08_sauber_c9_1989_ld l_driveline
	name "sauber_c9_1989_ld"
	contents RWD_FORMULA_HEWLAND_2_FLEX_v3
	dl:minhz	3000
	
RECORD FWD_TC_05_mini_hybrid l_driveline
	name "mini_hybrid"
	contents FWD_MODERN_SEQUENTIAL_TCR_FLEX_v3
	dl:minhz	3000	
	
RECORD RWD_LMP3_03 l_driveline
	name "GINETTA_E58"
	contents RWD_MODERN_SEQUENTIAL
	dl:minhz	3000	

RECORD RWD_MONTANA2 l_driveline
	name "stocams"
	contents RWD_MODERN_SEQUENTIAL_FLEX_SOFT_FR_v3
	dl:minhz	3000

RECORD RWD_H-PATTERN_SYNCHRO_MED_MED_05_nscar_80 l_driveline
	name "nscar_80"
	contents RWD_H-PATTERN_SYNCHRO_MED_MED_FLEX_2
	dl:minhz	3000	
	
RECORD RWD_FORMULA_CLASSIC_G3M8_01 l_driveline
	name "FORMULA_CLASSIC_G3M8"
	contents RWD_FORMULA_HEWLAND_3_FLEX_v3
	dl:minhz	3000	
	
RECORD RWD_FORMULA_CLASSIC_G3M8_LD_01 l_driveline
	name "FORMULA_CLASSIC_G3M8_LD"
	contents RWD_FORMULA_HEWLAND_3_FLEX_v3
	dl:minhz	3000		
	
	

END
