sched_sync = {
		//Send request
		private ["_hour","_minute","_date","_key","_result","_outcome"];
		 // _key = "CHILD:307:";
		//_result = _key call server_hiveReadWrite;
		//_outcome = _result select 0;
		//_date = _result select 1; 
		_date = call compile ("real_date" callExtension "");
		if(dayz_ForcefullmoonNights) then {
				//_hour = _date select 3;
				//_minute = _date select 4;
				//Force full moon nights
				_date = [2013,8,3,11,0];
			};

			setDate _date;
			dayzSetDate = _date;
			publicVariable "dayzSetDate";
			diag_log ("TIME SYNC: Local Time set to " + str(_date));	
	objNull
};