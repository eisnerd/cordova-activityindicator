package org.apache.cordova.plugin;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;

import org.json.JSONArray;
import org.json.JSONException;

import android.app.ProgressDialog;
import android.content.DialogInterface;

public class ActivityIndicator extends CordovaPlugin {

	private ProgressDialog activityIndicator = null;
	private CallbackContext callbackContext;

	@Override
	public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		if (action.equals("show")) {
			this.callbackContext = callbackContext;
			String text = args.getString(0);
			show(text);
			PluginResult result = new PluginResult(PluginResult.Status.NO_RESULT);
			result.setKeepCallback(true);
			callbackContext.sendPluginResult(result);
			return true;
		} else if (action.equals("hide")) {
			hide();
			callbackContext.success();
			return true;
		}

		return false;
	}

	/**
	 * This show the ProgressDialog
	 * @param text - Message to display in the Progress Dialog
	 */
	public void show(String text) {
		final CallbackContext callbackContext = this.callbackContext;
		final ActivityIndicator This = this;
		ProgressDialog _activityIndicator = activityIndicator;
		if (_activityIndicator == null)
			activityIndicator = ProgressDialog.show(this.cordova.getActivity(), "", text, true, true,
				new DialogInterface.OnCancelListener() {
					public void onCancel(DialogInterface dialog) {
						if (This.activityIndicator != null) {
							This.activityIndicator = null;
							callbackContext.error("cancel");
						}
					}
				});
		else
			_activityIndicator.setMessage(text);
	}

	/**
	 * This hide the ProgressDialog
	 */
	public void hide() {
		ProgressDialog _activityIndicator = activityIndicator;
		if (_activityIndicator != null) {
			_activityIndicator.dismiss();
			activityIndicator = null;
		}
	}
}
