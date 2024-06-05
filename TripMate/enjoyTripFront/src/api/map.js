import { localAxios } from "@/util/http-commons";

const local = localAxios();

async function getMapList(param, success, fail) {
  const queryString = new URLSearchParams(param).toString();
  await local.get(`/map/?${queryString}`).then(success).catch(fail);
}

function getLatestAttraction(success, fail) {
  local.get(`/map/latest`).then(success).catch(fail);
}

export { getMapList, getLatestAttraction };
