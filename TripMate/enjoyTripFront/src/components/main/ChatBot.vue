<template>
  <div class="chatbot-container">
    <div v-if="!isChatOpen" class="chatbot-icon" @click="toggleChat"><img :src="'/chatbot.png'"></div>
    <div v-else class="chat-window">
      <div class="chat-header">
        <h3>Chatbot</h3>
        <div class="qqq">
          <div class="trigger" @click="toggleChat">
            <span></span>
            <span></span>
          </div>
        </div>
      </div>
      <div class="chat-body">
        <div
          v-for="(message, index) in messages"
          :key="index"
          :class="message.isUser ? 'user-message' : 'bot-message'"
        >
          <div :class="message.isUser ? 'user-bubble' : 'bot-bubble'">
            {{ message.text }}
          </div>
        </div>
      </div>
      <div class="chat-input">
        <input
          v-model="userInput"
          @keyup.enter="sendMessage"
          placeholder="Type a message..."
        />
        <button @click="sendMessage">Send</button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from "vue";
import { getResponse } from "@/api/chatbot";

const isChatOpen = ref(false);
const userInput = ref("");
const messages = ref([]);

function toggleChat() {
  isChatOpen.value = !isChatOpen.value;
  if (!isChatOpen.value) {
    messages.value = []; // 메시지 삭제
  }
}

function sendMessage() {
  if (userInput.value.trim() === "") return;

  const userMessage = {
    text: userInput.value,
    isUser: true,
  };
  messages.value.push(userMessage);
  userInput.value = "";

  getResponse(
    userMessage.text,
    (response) => {
      messages.value.push({
        text: response.data,
        isUser: false,
      });
    },
    (error) => {
      console.error("Failed to get response from chatbot:", error);
    }
  );
}
</script>

<style scoped>
img {
  width: 40px;
  height: 40px;
}
.qqq{
  position: absolute;
  right: 10px;
  top: 10px;
}
.trigger {
  display: block;
  width: 20px;
  height: 14px;
  position: relative;
  cursor: pointer;
}
.trigger {
  display: block;
  width: 20px;
  height: 14px;
  position: relative;
  cursor: pointer;
}
.trigger span {
  position: absolute;
  height: 4px;
  width: 100%;
  background-color: var(--hambugerbtn-color);
}

.trigger span:nth-child(1) {
  top: 50%;
  transform: translateY(-50%) rotate(45deg);
}

.trigger span:nth-child(2) {
  top: 50%;
  transform: translateY(-50%) rotate(-45deg);
}
.chat-header {

}

.chatbot-container {
  position: fixed;
  bottom: 8%;
  right: 5%;
  z-index: 1000;
  overflow: hidden;
}
.chatbot-icon {
  width: 50px;
  height: 50px;
  cursor: pointer;
}
.chat-window {
  width: 400px;
  height: 500px;
  background: white;
  border: 1px solid #ccc;
  border-radius: 10px;
  display: flex;
  flex-direction: column;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}
.chat-header {
  padding: 10px;
  background: #007bff;
  color: white;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.chat-body {
  flex: 1;
  padding: 10px;
  overflow-y: auto;
}
.user-message {
  text-align: right;
  margin: 5px 0;
}
.bot-message {
  text-align: left;
  margin: 5px 0;
}
.user-bubble {
  display: inline-block;
  background: #4996f6;
  color: white;
  padding: 10px;
  border-radius: 10px;
  max-width: 70%;
  word-wrap: break-word;
}
.bot-bubble {
  display: inline-block;
  background: #e0e0e0;
  color: black;
  padding: 10px;
  border-radius: 10px;
  max-width: 70%;
  word-wrap: break-word;
}
.chat-input {
  display: flex;
  padding: 10px;
  border-top: 1px solid #ccc;
}
.chat-input input {
  flex: 1;
  padding: 5px;
  border: 1px solid #ccc;
  border-radius: 4px;
}
.chat-input button {
  margin-left: 10px;
  padding: 5px 10px;
  background: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}
.close-button {
  background: white;
  color: #007bff;
  border: 1px solid #007bff;
  border-radius: 4px;
  padding: 5px 10px;
  cursor: pointer;
  font-family: "Arial", sans-serif;
}
@media (max-width: 466px) {
  .chat-window  {
    width: 300px;
  }

}
@media (max-width: 350px) {
  .chat-window  {
    width: 200px;
  }

}
</style>
