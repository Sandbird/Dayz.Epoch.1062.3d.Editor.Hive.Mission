diag_log format["::::::::::::::::::::Scheduler init::::::::::::::::::::"];
while {true} do {
	scopeName "init";
	__sc_taskArray = [];
	__sc_time = diag_tickTime;
	{
	  private ["__sc_period", "__sc_offset", "__sc_code", "__sc_init", "__sc_ctx"];
	  __sc_period = _x select 0;
	  __sc_offset = _x select 1;
	  __sc_code = _x select 2;
	  __sc_init = _x select 3;
	  __sc_ctx = if (!isNil "__sc_init") then { call __sc_init } else { objNull };
	  __sc_taskArray set [ count __sc_taskArray, [ __sc_code, __sc_ctx, __sc_period, __sc_time + __sc_offset - __sc_period ]];
		//diag_log [ __sc_period, __sc_time - __sc_offset + __sc_period, __sc_ctx, __sc_code ];
	} count _this;
	_this=nil;
	uiSleep 0.01;

	while {true} do {
		scopeName "loop";
		//diag_log["Scheduler loop action"];
		__sc_lootT0 = diag_tickTime;
		{
			private [ "__sc_task", "__sc_period", "__sc_offset", "__sc_code", "__sc_next", "__sc_ctx" ];
			__sc_task = _x;
			__sc_code = __sc_task select 0;
			__sc_ctx = __sc_task select 1;
			__sc_period = __sc_task select 2;
			__sc_next = __sc_task select 3;
			if (diag_tickTime >= __sc_next) then {
			  //if (__sc_period>=0.2) then {diag_log['scheduler idx/period/previous/time/next', __sc_task];};
			__sc_ctx = __sc_ctx call __sc_code;
			if (__sc_period > 0) then { __sc_next = __sc_next + __sc_period * (1 + floor((diag_tickTime - __sc_next) / __sc_period)); };
			__sc_task set [1, __sc_ctx];
			__sc_task set [3, __sc_next];
			};
			if ((__sc_period == 0) AND {(__sc_ctx)}) exitWith {};
			if (diag_tickTime - __sc_lootT0 > 0.02) exitWith {}; // hopefully should not happen frequently
		} count __sc_taskArray;
		uiSleep 0.01;
		if(deathHandled) then {BreakOut "loop";};
	};
	uiSleep 0.01;
	scopeName "end";
	diag_log["::::::::::::::::::::Scheduler terminated::::::::::::::::::::"];
	BreakOut "init";
};