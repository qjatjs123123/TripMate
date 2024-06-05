import {
  localAxios
} from "@/util/http-commons";


const local = localAxios();

async function login(param, success, fail) {
  await local.post(`/user/login`, JSON.stringify(param)).then(success).catch( fail);
}

async function findById(userid, success, fail) {
  local.defaults.headers["Authorization"] = sessionStorage.getItem("accessToken");
  await local.get(`/user/${userid}`).then(success).catch(fail);
}

async function tokenRegeneration(user, success, fail) {
  local.defaults.headers["refreshToken"] = sessionStorage.getItem("refreshToken"); //axios header에 refresh-token 셋팅
  await local.post(`/user/refresh`, user).then(success).catch(fail);
}

async function logout(userid, success, fail) {
  await local.get(`/user/logout/${userid}`).then(success).catch(fail);
}

async function register(param, success, fail) {
  await local.post(`/user/register`, JSON.stringify(param)).then(success).catch(fail);
}


async function update(param, success, fail) {
  await local.post(`/user/modify`, param).then(success).catch(fail);
}

async function withdraw(userId, success, fail) {
  await local.delete(`/user/${userId}`).then(success).catch(fail);
}

export {
  tokenRegeneration,
  logout,
  findById,
  update,
  login,
  register,
  withdraw,
};