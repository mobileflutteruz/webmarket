// Firebase funksiyalari modullarini import qilish
const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

// Sizning birinchi funksiyangizni yaratish va joylashtirish
// https://firebase.google.com/docs/functions/get-started

exports.helloWorld = onRequest((request, response) => {
  // Log yozish
  logger.info("Hello logs!", {structuredData: true});
  
  // Murojaat qiluvchi foydalanuvchiga javob berish
  response.send("Hello from Firebase!");
});
