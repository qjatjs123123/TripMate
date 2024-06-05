import { localAxios } from "@/util/http-commons";

const local = localAxios();

function listArticle(param, success, fail) {
  local.get(`/hotplace`, { params: param }).then(success).catch(fail);
}

function getImg(img, success, fail) {
  local.get(`/hotplace/img/${img}`).then(success).catch(fail);
}

function detailArticle(boardId, success, fail) {
  local.get(`/hotplace/${boardId}`).then(success).catch(fail);
}

function registArticle(formData, success, fail) {
  local
    .post(`/hotplace`, formData, {
      headers: {
        "Content-Type": "multipart/form-data",
      },
    })
    .then(success)
    .catch(fail);
}

function getModifyArticle(boardId, success, fail) {
  local.get(`/hotplace/modify/${boardId}`).then(success).catch(fail);
}

function modifyArticle(formData, success, fail) {
  local
    .post(`/hotplace`, formData, {
      headers: {
        "Content-Type": "multipart/form-data",
      },
    })
    .then(success)
    .catch(fail);
}

function deleteArticle(boardId, success, fail) {
  local.delete(`/hotplace/${boardId}`).then(success).catch(fail);
}

function getPopularArticle(success, fail) {
  local.get(`/hotplace/popular`).then(success).catch(fail);
}

export {
  listArticle,
  getImg,
  detailArticle,
  registArticle,
  getModifyArticle,
  modifyArticle,
  deleteArticle,
  getPopularArticle,
};
