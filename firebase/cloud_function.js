// Deploy under cloud function for provision of timestamp on reporting values.
import * as functions from "firebase-functions";

const admin = require("firebase-admin");
// const db = admin.firestore();

admin.initializeApp();

exports.timestampdata = functions.database.ref("/sensor/{pushId}")
    .onCreate((snapshot, context) => {
      const original = snapshot.val();
      const pushId = context.params.pushId;
      console.log(Detected new measure ${original} with pushId ${pushId});
      const path = "sensor/" + pushId;
      // db.collection('sensor').document(pushId).setData({
      //   value: original,
      //   timestamp: admin.database.ServerValue.TIMESTAMP
      // });
      return admin.database().ref(path).update({
        timestamp: admin.database.ServerValue.TIMESTAMP,
      });
    });