import { localAxios } from "@/util/http-commons";
const local = localAxios();

export async function getResponse(prompt, success, fail) {
  try {
    const response = await local.post('/bot/chat', { prompt: prompt });
    success(response);
  } catch (error) {
    fail(error);
  }
}
