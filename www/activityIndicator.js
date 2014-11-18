var ActivityIndicator = {
    show: function (text, cancel) {
    	text = text || "Please wait...";
        cordova.exec(null, function(reason) {
            if (cancel && reason == "cancel")
                cancel();
        }, "ActivityIndicator", "show", [text]);
    },
    hide: function () {
        cordova.exec(null, null, "ActivityIndicator", "hide", []);
    }
};

module.exports = ActivityIndicator;