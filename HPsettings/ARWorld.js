class ARWorld{
    constructor(event, handler, flag, change){
        this.event = event 
        this.handler = handler
        this.flag = flag
        this.change = change
    }

    get getEve(){
        return this.event
    }

    get getHand(){
        return this.handler
    }

    get getflag(){
        return this.flag
    }

    static doHandler(event){
        var i;
        var j = 8;
        for(i=0;i<6; i++){
            console.log(Events[i].event);
            if(Events[i].event == event){
                if(Events[i].change == true){
                    console.log("5555")
                    Events[i].handler.call();
                    j = i;
                }
            }
        }
        if( j != 8){
            if(Events[j].flag == true){
                return false;
            }else if(Events[j].flag == false){
                return true;
            }else{
                return "none";
            }
        }
    }

    static addEvent(Event, Handler, flag){
        for(var i=0; i<6; i++){
            if(Events[i].event == Event){
                Events[i].handler = Handler;
                Events[i].flag = flag;
                Events[i].change = true;
                break;
            }
        }
    }
}

function example(){
    alert("未登録です");
}

var Events=[];
Events[0] = new ARWorld('ARSightEnter', example, false, false);
Events[1] = new ARWorld('ARSightLeave', example, false, false);
Events[2] = new ARWorld('ARProximityEnter', example, false, false);
Events[3] = new ARWorld('ARProximityLeave', example, false, false);
Events[4] = new ARWorld('ARSightMove', example, false, false);
Events[5] = new ARWorld('ARProximityMove', example, false, false);


/*
switch(Events[i]){
    case 'ARSightEnter':
        if(event.flag == true){
            event.handler;
        }
        break;
    case 'ARSightLeave':
        if(event.flag == true){
            event.handler;
        }
        break;
    case 'ARProximityEnter':
        if(event.flag == true){
            event.handler;
        }
        break;
    case 'ARProximityLeave':
        if(event.flag == true){
            event.handler;
        }
        break;
    case 'ARSightMove':
        if(event.flag == true){
            console.log(event.handler);
            event.handler;
        }
        break;
    case 'ARProximityMove':
        if(event.flag == true){
            event.handler;
        }
        break;
    default:
        console.log("default");
        break;
*/