var/datum/subsystem/diseases/SSdisease

/datum/subsystem/diseases
	name = "Diseases"

	flags = SS_NO_INIT | SS_KEEP_TIMING

	var/list/currentrun = list()
	var/list/processing = list()

/datum/subsystem/diseases/New()
	NEW_SS_GLOBAL(SSdisease)

/datum/subsystem/diseases/stat_entry(msg)
	..("P:[processing.len]")

/datum/subsystem/diseases/fire(resumed = 0)
	if (!resumed)
		src.currentrun = processing.Copy()

	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun

	while (currentrun.len)
		var/datum/thing = currentrun[currentrun.len]
		currentrun.len--

		if(thing)
			thing.process()
		else
			processing -= thing

		if (MC_TICK_CHECK)
			return