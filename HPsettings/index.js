// import { ARWorld } from 'ARWorld.js'

var text1 = function(){
    document.getElementById("area1").innerText = "sightEnter";
};

var text2 = function(){
    document.getElementById("area1").innerText = "sightLeave";
};

var text3 = function(){
    document.getElementById("area2").innerText = "proximityEnter";
};

var text4 = function(){
    document.getElementById("area2").innerText = "proximityLeave";
};

var text5 = function(){
    document.getElementById("area1").innerText = "sightMove";
    console.log("text5")
};

var text6 = function(){
    document.getElementById("area2").innerText = "proximityMove";
};

ARWorld.addEvent('ARSightEnter', text1, true);
ARWorld.addEvent('ARSightLeave', text2, false);
ARWorld.addEvent('ARProximityEnter', text3, true);
ARWorld.addEvent('ARProximityLeave', text4, false);
ARWorld.addEvent('ARSightMove', text5, true);
ARWorld.addEvent('ARProximityMove', text6, true);
