//  DZE_CLICK_ACTIONS
//      This is where you register your right-click actions
//  FORMAT -- (no comma after last array entry)
//      [_classname,_text,_execute,_condition],
//  PARAMETERS
//  _classname  : the name of the class to click on 
//                  (example = "ItemBloodbag")
//  _text       : the text for the option that is displayed when right clicking on the item 
//                  (example = "Self Transfuse")
//  _execute    : compiled code to execute when the option is selected 
//                  (example = "execVM 'my\scripts\self_transfuse.sqf';")
//  _condition  : compiled code evaluated to determine whether or not the option is displayed
//                  (example = {true})
// _color       : Color of the text in format [1,1,1,1]
//  EXAMPLE -- see below for some simple examples
DZE_CLICK_ACTIONS = [
    //["ItemZombieParts","Smear Guts on you","execVM 'custom\walkamongstthedead\smear_guts.sqf';","true",[1,0.502,0.502,1]],
    //["ItemWaterbottle","Wash zombie guts","execVM 'custom\walkamongstthedead\usebottle.sqf';","true",[1,0.502,0.502,1]],
    ["SMAW_HEDP","Deploy Fireworks","execVM 'custom\fireworks\deploy_fireworks.sqf';","true",[1,1,1,1]],
    ["ItemRadio","Activate Fireworks","closeDialog 0; execVM 'custom\fireworks\remoteActivateFireW.sqf';","true",[1,1,1,1]],
    ["IRStrobe","Wear Rabbit Hat","_class = 'Rabbit';_pos = [0.0,-0.07,0.80]; [_class,_pos, player] spawn fnc_hats;","true",[1,0.71,0.416,1]],
    ["IRStrobe","Wear Rooster Hat","_class = 'Cock';_pos = [0.0,-0.01,0.80]; [_class,_pos, player] spawn fnc_hats;","true",[1,0.502,0.251,1]],
    ["IRStrobe","Wear Hen Hat","_class = 'Hen';_pos = [0.0,-0.01,0.80]; [_class,_pos, player] spawn fnc_hats;","true",[0,1,0,1]],
    ["IRStrobe","Wear Bucket Hat","_class = 'MetalBucket';_pos = [0.0,0.0,0.85]; [_class,_pos, player] spawn fnc_hats;","true",[1,0,0,1]],
    ["IRStrobe","Wear Red Light","_class = 'Red_Light_Blinking_EP1';_pos = [0.0,0.06,0.82]; [_class,_pos, player] spawn fnc_hats;","true",[1,0.502,0.502,1]],
    ["IRStrobe","Remove Hat","_class = 'Remove';_pos = [0.0,0.0,0.85]; [_class,_pos, player] spawn fnc_hats;","true",[1,1,1,1]]
];