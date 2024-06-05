import { localAxios } from "@/util/http-commons";


const local = localAxios();

async function cartInsert(param, success, fail) {
  await local.post(`/cart/`, JSON.stringify(param)).then(success).catch( fail);
}

async function cartDelete(param, success, fail) {
  await local.delete(`/cart/`,  { data: param }).then(success).catch( fail);
}

async function findCartById(userid, success, fail) {
  await local.get(`/cart/${userid}`).then(success).catch(fail);
}
export {
  cartInsert,
  cartDelete,
  findCartById
};