/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const functions = require('firebase-functions');

// The Firebase Admin SDK to access Firestore.
const admin = require("firebase-admin");
admin.initializeApp();

const logger = require("firebase-functions/logger");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

// Listen for new messages in channel

const channelMessageRef = "/channel-messages/{channelId}/{messageId}"

exports.sendNotificationsForMessages = functions.database
.ref(channelMessageRef)
.onCreate(async (snapshot, context) => {
  const data = snapshot.val()
  const textMessage = data.text
  const senderName = data.channelNameAtSend
  const chatPartnerFCMTokens = data.chatPartnerFCMTokens
  const messageType = data.type

  let notificationMessage = textMessage;

  if (messageType == "photo") {
    notificationMessage = "Sent a photo message"
  } else if (messageType == "video") {
    notificationMessage = "Sent a video message"
  } else if (messageType == "audio") {
    notificationMessage = "Sent a voice message"
  }

  for (const fcmToken of chatPartnerFCMTokens) {
    await sendPushNotifications(notificationMessage, senderName, fcmToken)
  }

})

listenForNewMessages = functions.database
.ref(channelMessageRef)
.onCreate(async (snapshot, context) => {
  const data = snapshot.val()
  const channelId = context.params.channelId
  const message = data["text"]
  const ownerUid = data["ownerUid"]

  // Get the message sender name
  const messageSenderSnapshot = await admin
  .database()
  .ref("/users/" + ownerUid)
  .once("value")

  const messageSenderDict = messageSenderSnapshot.val()
  const senderName = messageSenderDict["username"]
  await getChannelMembers(channelId, message, senderName)
})

// Get the channel members
async function getChannelMembers(channelId, message, senderName) {
  const channelSnapshot = await admin
  .database()
  .ref("/channels/" + channelId)
  .once("value")

  const channelDict = channelSnapshot.val()
  const membersUids = channelDict["membersUids"]

  for (const userId of membersUids) {
    await getUserFcmToken(message, userId, senderName)
  }
}

// Get the fcmToken for each channel members
async function getUserFcmToken(message, userId, senderName) {
  const userSnapshot = await admin
  .database()
  .ref("/users/" + userId)
  .once("value")

  const userDict = userSnapshot.val()
  const fcmToken = userDict["fcmToken"]

  await sendPushNotifications(message, senderName, fcmToken)
}

// Send push notification from cloud functions using APNS
async function sendPushNotifications(message, senderName, fcmToken) {
  const payload = {
    notification: {
      title: senderName,
      body: message,
    },

    apns: {
      payload: {
        aps: {
          sound: "default",
          badge: 12,
        }
      }
    },

    token: fcmToken,
  };

  try {
    await admin.messaging().send(payload);
    console.info("Successfully sent message: ", message)
  } catch (error) {
    console.error("Error sending message: ", message)
  }
}