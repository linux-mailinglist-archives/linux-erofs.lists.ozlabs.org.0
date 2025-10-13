Return-Path: <linux-erofs+bounces-1178-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 833F7BD152D
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Oct 2025 05:32:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4clNG00KJlz30P3;
	Mon, 13 Oct 2025 14:32:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760326359;
	cv=none; b=dUKMoV9z+dRAaYFMmHFyqSyn6MMBq4Qn+PxzvdVV1HJxH1WY95kLd883bUHA1GU10RFejUNgLnJ3bPNXAvyU+7w4D7/vRQCs16tCFbYvSQtkyNX8sNHof/UKKaDwzIlqgSe4YeRWbjgzh49j3gX81uuU0OS2uvQHJWPoyyu7cEhqVL+5dkWnHNIa9WM255qcUFZsN5JDk75r0SRTuhDJ4pDJ4MAUXD+9iXOhnfTAJyZ5CE3ZHbDMuKKHIkTspfv1DTT0VIbH0z84LCh/lrjLSgcE5FCD2hTI4OuAxpBaRD+lj19DhPwNSMLfFOFkYAQhh1BZHtsiPZo5S6TMVcCllg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760326359; c=relaxed/relaxed;
	bh=2HfrY5PwVjxO8eMSFPEQSw95scvHFNPXVrpnchsWHaM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6PpdPmMr4URzUbcbCAD6l46WYkHR13RfeIEzHZGgOYAvvzGg4nywir3eAxHCQ8+JBeTgYCS+afMSgwcNAdozMSML3lnCkZznCkZty1RZC4GWw2onQkdKqVYbNZmW/JrWgtLvGa4DTt4OqQukK9h8jgcKa+eXXxl/DjZBPkf2SZTNgx0touDnUF4e4q+794naE5BRpW1LF1ylwr4QobZS+HYFDoBdXCsnNyykuJgu2ODDN2SHZyEHpxGAI8/FSSUNb3qobmwZUdqNIwaln26KOjc+czLKGXTirV9Js+2gqPft17GjzYdliMlUj7nxtM8Ay3vsM8ykCFaMZN+ismp7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=3+s3eZVy; dkim-atps=neutral; spf=pass (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=3+s3eZVy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4clNFx0Hj8z2yrT
	for <linux-erofs@lists.ozlabs.org>; Mon, 13 Oct 2025 14:32:35 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2HfrY5PwVjxO8eMSFPEQSw95scvHFNPXVrpnchsWHaM=;
	b=3+s3eZVyLo9xQ3RThnQa0En1vdOUW2F7Y7Rq1/Jeo7KnAvgMRAj2KkbHqAURX4ERgYThZYnfH
	emKvZgOuDx8Ynsg8pYM0Lr0Sc7hdBq5XsIj2Kqi3+xODQTK5B1P3zBF0Nws+oydUsiL8euuC2sK
	SyhL8R7Jyu7jDoCFJi1Ik4o=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4clNDv1WXqz12LFF
	for <linux-erofs@lists.ozlabs.org>; Mon, 13 Oct 2025 11:31:43 +0800 (CST)
Received: from kwepemp500007.china.huawei.com (unknown [7.202.195.151])
	by mail.maildlp.com (Postfix) with ESMTPS id 917A0140109
	for <linux-erofs@lists.ozlabs.org>; Mon, 13 Oct 2025 11:32:29 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemp500007.china.huawei.com
 (7.202.195.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 13 Oct
 2025 11:32:28 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>
Subject: [PATCH 2/2] erofs-utils: lib: use libcurl multiplexing api to optimize S3 interaction
Date: Mon, 13 Oct 2025 11:32:22 +0800
Message-ID: <20251013033222.31072-2-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20251013033222.31072-1-zhaoyifan28@huawei.com>
References: <20251013033222.31072-1-zhaoyifan28@huawei.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemp500007.china.huawei.com (7.202.195.151)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

The current S3 remote implementation uses the `curl_easy*` API family to
interact with the backend, which operates serially. Let's migrate to the
`curl_multi*` APIs to leverage libcurl's multiplexing capabilities.

Now following `ListObjects`, `GetObject` are concurrently executed with
a sliding window limiting maximum concurrency.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 lib/remotes/s3.c | 400 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 281 insertions(+), 119 deletions(-)

diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
index 0f24c65..5e67779 100644
--- a/lib/remotes/s3.c
+++ b/lib/remotes/s3.c
@@ -25,6 +25,8 @@
 #define S3EROFS_URL_LEN			8192
 #define S3EROFS_CANONICAL_QUERY_LEN	2048
 
+#define S3EROFS_MAX_GETOBJECT_CONCUR	16
+
 #define BASE64_ENCODE_LEN(len)	(((len + 2) / 3) * 4)
 
 struct s3erofs_query_params {
@@ -86,8 +88,6 @@ static int s3erofs_prepare_url(struct s3erofs_curl_request *req,
 	return 0;
 }
 
-static char *get_canonical_headers(const struct curl_slist *list) { return ""; }
-
 // See: https://docs.aws.amazon.com/AmazonS3/latest/API/RESTAuthentication.html#ConstructingTheAuthenticationHeader
 static char *s3erofs_sigv2_header(const struct curl_slist *headers,
 		const char *method, const char *content_md5,
@@ -97,7 +97,6 @@ static char *s3erofs_sigv2_header(const struct curl_slist *headers,
 	u8 hmac_signature[EVP_MAX_MD_SIZE];
 	char *str, *output = NULL;
 	unsigned int len, pos, output_len;
-	const char *canonical_headers = get_canonical_headers(headers);
 	const char *prefix = "Authorization: AWS ";
 
 	if (!method || !date || !ak || !sk)
@@ -111,7 +110,7 @@ static char *s3erofs_sigv2_header(const struct curl_slist *headers,
 		canonical_query = "/";
 
 	pos = asprintf(&str, "%s\n%s\n%s\n%s\n%s%s", method, content_md5,
-		       content_type, date, canonical_headers, canonical_query);
+		       content_type, date, "", canonical_query);
 	if (pos < 0)
 		return ERR_PTR(-ENOMEM);
 
@@ -149,6 +148,11 @@ struct s3erofs_curl_response {
 	size_t size;
 };
 
+struct s3erofs_curl_getobject_resp {
+	struct erofs_vfile vf;
+	erofs_off_t pos, end;
+};
+
 static size_t s3erofs_request_write_memory_cb(void *contents, size_t size,
 					      size_t nmemb, void *userp)
 {
@@ -241,11 +245,48 @@ err_header:
 	return ret;
 }
 
+static CURL *s3erofs_curl_easy_init()
+{
+	CURL *curl;
+
+	curl = curl_easy_init();
+	if (!curl)
+		return ERR_PTR(-ENOMEM);
+
+	if (curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L) != CURLE_OK)
+		goto out_cleanup;
+
+	if (curl_easy_setopt(curl, CURLOPT_CONNECTTIMEOUT, 30L) != CURLE_OK)
+		goto out_cleanup;
+
+	if (curl_easy_setopt(curl, CURLOPT_USERAGENT,
+			     "s3erofs/" PACKAGE_VERSION) != CURLE_OK)
+		goto out_cleanup;
+
+	return curl;
+
+out_cleanup:
+	curl_easy_cleanup(curl);
+	return ERR_PTR(-EFAULT);
+}
+
 struct s3erofs_object_info {
 	char *key;
 	u64 size;
 	time_t mtime;
 	u32 mtime_ns;
+
+	bool downloaded;
+	struct erofs_diskbuf *diskbuf;
+};
+
+struct s3erofs_getobject_task {
+	CURL *easy_handle;
+	struct curl_slist *request_headers;
+	struct s3erofs_curl_request req;
+	struct s3erofs_curl_getobject_resp resp;
+	struct s3erofs_object_info *obj;
+	int index;
 };
 
 struct s3erofs_object_iterator {
@@ -258,8 +299,106 @@ struct s3erofs_object_iterator {
 
 	char *next_marker;
 	bool is_truncated;
+
+	/* fields for getobject */
+	CURLM *multi_handle;
+	struct s3erofs_getobject_task *getobj_tasks;
+	int getobj_idx;
 };
 
+static size_t s3erofs_remote_getobject_cb(void *contents, size_t size, size_t nmemb,
+					  void *userp)
+{
+	struct s3erofs_curl_getobject_resp *resp = userp;
+	size_t realsize = size * nmemb;
+
+	if (resp->pos + realsize > resp->end ||
+	    erofs_io_pwrite(&resp->vf, contents, resp->pos, realsize) != realsize)
+		return 0;
+
+	resp->pos += realsize;
+	return realsize;
+}
+
+static int s3erofs_add_getobject_task(struct s3erofs_object_iterator *it,
+				     struct s3erofs_object_info *obj,
+				     int task_index)
+{
+	struct s3erofs_query_params params = {0};
+	struct s3erofs_getobject_task *task;
+	int ret;
+
+	task = &it->getobj_tasks[task_index];
+	if (!task->easy_handle) {
+		task->easy_handle = s3erofs_curl_easy_init();
+		if (!task->easy_handle)
+			return PTR_ERR(task->easy_handle);
+
+		if (curl_easy_setopt(task->easy_handle, CURLOPT_PRIVATE, task) !=
+		    CURLE_OK) {
+			curl_easy_cleanup(task->easy_handle);
+			return -EFAULT;
+		}
+	}
+
+	task->index = task_index;
+	task->obj = obj;
+
+	obj->diskbuf = calloc(1, sizeof(struct erofs_diskbuf));
+	if (!obj->diskbuf)
+		return -ENOMEM;
+	task->resp.vf.fd = erofs_diskbuf_reserve(obj->diskbuf, 0, &task->resp.pos);
+	if (task->resp.vf.fd < 0) {
+		ret = -EBADF;
+		goto err;
+	}
+	erofs_diskbuf_commit(obj->diskbuf, obj->size);
+	task->resp.end = task->resp.pos + obj->size;
+
+	task->req.method = "GET";
+	ret = s3erofs_prepare_url(&task->req, it->s3->endpoint, it->bucket, obj->key,
+				  &params, it->s3->url_style);
+	if (ret < 0)
+		goto err;
+
+	curl_easy_setopt(task->easy_handle, CURLOPT_URL, task->req.url);
+	curl_easy_setopt(task->easy_handle, CURLOPT_WRITEFUNCTION,
+			 s3erofs_remote_getobject_cb);
+	curl_easy_setopt(task->easy_handle, CURLOPT_WRITEDATA, &task->resp);
+
+	/* Add authentication headers */
+	if (it->s3->access_key[0]) {
+		if (task->request_headers) {
+			curl_slist_free_all(task->request_headers);
+			task->request_headers = NULL;
+		}
+
+		ret = s3erofs_request_insert_auth(&task->request_headers, task->req.method,
+						  task->req.canonical_query,
+						  it->s3->access_key, it->s3->secret_key);
+		if (ret < 0) {
+			erofs_err("failed to insert auth headers");
+			goto err;
+		}
+		curl_easy_setopt(task->easy_handle, CURLOPT_HTTPHEADER, task->request_headers);
+	}
+
+	/* Add to multi handle */
+	ret = curl_multi_add_handle(it->multi_handle, task->easy_handle);
+	if (ret != CURLM_OK) {
+		erofs_err("failed to add getobject task to multi handle: %s",
+			  curl_multi_strerror(ret));
+		ret = -EIO;
+		goto err;
+	}
+
+	return 0;
+
+err:
+	free(obj->diskbuf);
+	return ret;
+}
+
 static int s3erofs_parse_list_objects_one(xmlNodePtr node,
 					  struct s3erofs_object_info *info)
 {
@@ -297,6 +436,8 @@ static int s3erofs_parse_list_objects_one(xmlNodePtr node,
 			xmlFree(str);
 		}
 	}
+
+	info->downloaded = false;
 	return 0;
 }
 
@@ -304,7 +445,7 @@ static int s3erofs_parse_list_objects_result(const char *data, int len,
 					     struct s3erofs_object_iterator *it)
 {
 	xmlNodePtr root = NULL, node, next;
-	int ret, i, contents_count;
+	int ret, i, j, contents_count;
 	xmlDocPtr doc = NULL;
 	xmlChar *str;
 	void *tmp;
@@ -383,6 +524,7 @@ static int s3erofs_parse_list_objects_result(const char *data, int len,
 		it->objects[0].key = NULL;
 	}
 	it->cur = 0;
+	it->getobj_idx = 0;
 
 	ret = 0;
 	for (i = 0, node = root->children; node; node = node->next) {
@@ -413,6 +555,26 @@ static int s3erofs_parse_list_objects_result(const char *data, int len,
 			ret = -ENOMEM;
 	}
 
+	if (!ret && i && it->multi_handle) {
+		j = 0;
+		while (it->getobj_idx < i && j < S3EROFS_MAX_GETOBJECT_CONCUR) {
+			if (it->objects[it->getobj_idx].size == 0) {
+				it->getobj_idx++;
+				continue;
+			}
+
+			ret = s3erofs_add_getobject_task(it, it->objects + it->getobj_idx,
+							 j++);
+			if (ret < 0) {
+				erofs_err("failed to add download task for object %s: %s",
+					  it->objects[it->getobj_idx].key,
+					  erofs_strerror(ret));
+				goto out;
+			}
+			it->getobj_idx++;
+		}
+	}
+
 	if (!ret)
 		ret = i;
 out:
@@ -475,10 +637,11 @@ static int s3erofs_list_objects(struct s3erofs_object_iterator *it)
 
 static struct s3erofs_object_iterator *
 s3erofs_create_object_iterator(struct erofs_s3 *s3, const char *path,
-			       const char *delimiter)
+			       const char *delimiter, bool fillzero)
 {
 	struct s3erofs_object_iterator *iter;
 	char *prefix;
+	int ret = 0;
 
 	iter = calloc(1, sizeof(struct s3erofs_object_iterator));
 	if (!iter)
@@ -486,8 +649,10 @@ s3erofs_create_object_iterator(struct erofs_s3 *s3, const char *path,
 	iter->s3 = s3;
 	prefix = strchr(path, '/');
 	if (prefix) {
-		if (++prefix - path > S3EROFS_PATH_MAX)
-			return ERR_PTR(-EINVAL);
+		if (++prefix - path > S3EROFS_PATH_MAX) {
+			ret = -EINVAL;
+			goto err_iter;
+		}
 		iter->bucket = strndup(path, prefix - 1 - path);
 		iter->prefix = strdup(prefix);
 	} else {
@@ -496,18 +661,60 @@ s3erofs_create_object_iterator(struct erofs_s3 *s3, const char *path,
 	}
 	iter->delimiter = delimiter;
 	iter->is_truncated = true;
+	if (!fillzero) {
+		iter->getobj_idx = 0;
+		iter->getobj_tasks = calloc(S3EROFS_MAX_GETOBJECT_CONCUR,
+					    sizeof(struct s3erofs_getobject_task));
+		if (!iter->getobj_tasks) {
+			ret = -ENOMEM;
+			goto err_prefix;
+		}
+		iter->multi_handle = curl_multi_init();
+		if (!iter->multi_handle) {
+			ret = -EIO;
+			free(iter->getobj_tasks);
+			goto err_prefix;
+		}
+	}
 	return iter;
+
+err_prefix:
+	if (iter->bucket)
+		free(iter->bucket);
+	if (iter->prefix)
+		free(iter->prefix);
+err_iter:
+	free(iter);
+	return ERR_PTR(ret);
 }
 
 static void s3erofs_destroy_object_iterator(struct s3erofs_object_iterator *it)
 {
+	struct s3erofs_getobject_task *task;
 	int i;
 
+	if (it->getobj_tasks) {
+		for (i = 0; i < S3EROFS_MAX_GETOBJECT_CONCUR; i++) {
+			task = &it->getobj_tasks[i];
+			if (task->easy_handle)
+				curl_easy_cleanup(task->easy_handle);
+			if (task->request_headers)
+				curl_slist_free_all(task->request_headers);
+		}
+		free(it->getobj_tasks);
+	}
+	if (it->multi_handle)
+		curl_multi_cleanup(it->multi_handle);
 	if (it->next_marker)
 		free(it->next_marker);
 	if (it->objects) {
-		for (i = 0; it->objects[i].key; ++i)
+		for (i = 0; it->objects[i].key; ++i) {
 			free(it->objects[i].key);
+			if (it->objects[i].diskbuf) {
+				erofs_diskbuf_close(it->objects[i].diskbuf);
+				free(it->objects[i].diskbuf);
+			}
+		}
 		free(it->objects);
 	}
 	free(it->prefix);
@@ -532,125 +739,79 @@ s3erofs_get_next_object(struct s3erofs_object_iterator *it)
 	return NULL;
 }
 
-static int s3erofs_curl_easy_init(struct erofs_s3 *s3)
+static void s3erofs_handover_object_data(struct erofs_inode *inode,
+					 struct s3erofs_object_info *obj)
 {
-	CURL *curl;
-
-	curl = curl_easy_init();
-	if (!curl)
-		return -ENOMEM;
-
-	if (curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L) != CURLE_OK)
-		goto out_cleanup;
-
-	if (curl_easy_setopt(curl, CURLOPT_CONNECTTIMEOUT, 30L) != CURLE_OK)
-		goto out_cleanup;
-
-	if (curl_easy_setopt(curl, CURLOPT_USERAGENT,
-			     "s3erofs/" PACKAGE_VERSION) != CURLE_OK)
-		goto out_cleanup;
-
-	s3->easy_curl = curl;
-	return 0;
-out_cleanup:
-	curl_easy_cleanup(curl);
-	return -EFAULT;
+	inode->datasource = EROFS_INODE_DATA_SOURCE_DISKBUF;
+	inode->i_diskbuf = obj->diskbuf;
+	obj->diskbuf = NULL;
 }
 
-static void s3erofs_curl_easy_exit(struct erofs_s3 *s3)
-{
-	if (!s3->easy_curl)
-		return;
-	curl_easy_cleanup(s3->easy_curl);
-	s3->easy_curl = NULL;
-}
-
-struct s3erofs_curl_getobject_resp {
-	struct erofs_vfile *vf;
-	erofs_off_t pos, end;
-};
-
-static size_t s3erofs_remote_getobject_cb(void *contents, size_t size,
-					  size_t nmemb, void *userp)
+static int s3erofs_remote_getobject(struct s3erofs_object_iterator *it,
+				    struct s3erofs_object_info *obj,
+				    struct erofs_inode *inode)
 {
-	struct s3erofs_curl_getobject_resp *resp = userp;
-	size_t realsize = size * nmemb;
+	int running_handles, msgs_in_queue;
+	CURLMsg *msg;
+	CURL *easy_handle;
+	struct s3erofs_getobject_task *task;
+	bool found = false;
+	int ret = 0;
 
-	if (resp->pos + realsize > resp->end ||
-	    erofs_io_pwrite(resp->vf, contents, resp->pos, realsize) != realsize)
+	if (obj->downloaded) {
+		s3erofs_handover_object_data(inode, obj);
 		return 0;
+	}
 
-	resp->pos += realsize;
-	return realsize;
-}
+	curl_multi_perform(it->multi_handle, &running_handles);
+	while (!found) {
+		ret = curl_multi_wait(it->multi_handle, NULL, 0, 1000, NULL);
+		if (ret != CURLM_OK) {
+			erofs_err("curl_multi_wait() failed: %s",
+				  curl_multi_strerror(ret));
+			return -EIO;
+		}
 
-static int s3erofs_remote_getobject(struct erofs_importer *im,
-				    struct erofs_s3 *s3,
-				    struct erofs_inode *inode,
-				    const char *bucket, const char *key)
-{
-	struct erofs_sb_info *sbi = inode->sbi;
-	struct s3erofs_curl_request req = {};
-	struct s3erofs_curl_getobject_resp resp;
-	struct s3erofs_query_params params;
-	struct erofs_vfile vf;
-	int ret;
+		curl_multi_perform(it->multi_handle, &running_handles);
 
-	params.num = 0;
-	req.method = "GET";
-	ret = s3erofs_prepare_url(&req, s3->endpoint, bucket, key,
-				  &params, s3->url_style);
-	if (ret < 0)
-		return ret;
+		while ((msg = curl_multi_info_read(it->multi_handle, &msgs_in_queue))) {
+			if (msg->msg != CURLMSG_DONE)
+				continue;
 
-	if (curl_easy_setopt(s3->easy_curl, CURLOPT_WRITEFUNCTION,
-			     s3erofs_remote_getobject_cb) != CURLE_OK)
-		return -EIO;
+			easy_handle = msg->easy_handle;
 
-	resp.pos = 0;
-	if (!cfg.c_compr_opts[0].alg && im->params->no_datainline) {
-		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
-		inode->idata_size = 0;
-		ret = erofs_allocate_inode_bh_data(inode,
-				DIV_ROUND_UP(inode->i_size, 1U << sbi->blkszbits));
-		if (ret)
-			return ret;
-		resp.vf = &sbi->bdev;
-		resp.pos = erofs_pos(inode->sbi, inode->u.i_blkaddr);
-		inode->datasource = EROFS_INODE_DATA_SOURCE_NONE;
-	} else {
-		u64 off;
+			task = NULL;
+			curl_easy_getinfo(easy_handle, CURLINFO_PRIVATE, &task);
+			if (!task) {
+				erofs_err("failed to get private data from curl handle");
+				curl_multi_remove_handle(it->multi_handle, easy_handle);
+				return -EIO;
+			}
 
-		if (!inode->i_diskbuf) {
-			inode->i_diskbuf = calloc(1, sizeof(*inode->i_diskbuf));
-			if (!inode->i_diskbuf)
-				return -ENOSPC;
-		} else {
-			erofs_diskbuf_close(inode->i_diskbuf);
-		}
+			ret = msg->data.result;
+			if (ret != CURLE_OK) {
+				erofs_err("getobject failed for object %s: %s",
+					  task->obj->key, curl_easy_strerror(ret));
+				curl_multi_remove_handle(it->multi_handle, easy_handle);
+				return -EIO;
+			}
 
-		vf = (struct erofs_vfile) {.fd =
-			erofs_diskbuf_reserve(inode->i_diskbuf, 0, &off)};
-		if (vf.fd < 0)
-			return -EBADF;
-		resp.pos = off;
-		resp.vf = &vf;
-		inode->datasource = EROFS_INODE_DATA_SOURCE_DISKBUF;
-	}
-	resp.end = resp.pos + inode->i_size;
+			curl_multi_remove_handle(it->multi_handle, easy_handle);
+			task->obj->downloaded = true;
 
-	ret = s3erofs_request_perform(s3, &req, &resp);
-	if (resp.vf == &vf) {
-		erofs_diskbuf_commit(inode->i_diskbuf, resp.end - resp.pos);
-		if (ret) {
-			erofs_diskbuf_close(inode->i_diskbuf);
-			inode->i_diskbuf = NULL;
-			inode->datasource = EROFS_INODE_DATA_SOURCE_NONE;
+			if (strcmp(task->obj->key, obj->key) == 0) {
+				s3erofs_handover_object_data(inode, task->obj);
+				found = true;
+			}
+
+			if (it->objects[it->getobj_idx].key) {
+				s3erofs_add_getobject_task(
+					it, &it->objects[it->getobj_idx++], task->index);
+			}
 		}
 	}
-	if (ret)
-		return ret;
-	return resp.pos != resp.end ? -EIO : 0;
+
+	return ret;
 }
 
 int s3erofs_build_trees(struct erofs_importer *im, struct erofs_s3 *s3,
@@ -670,13 +831,14 @@ int s3erofs_build_trees(struct erofs_importer *im, struct erofs_s3 *s3,
 	st.st_uid = root->i_uid;
 	st.st_gid = root->i_gid;
 
-	ret = s3erofs_curl_easy_init(s3);
-	if (ret) {
+	s3->easy_curl = s3erofs_curl_easy_init();
+	if (!s3->easy_curl) {
+		ret = PTR_ERR(s3->easy_curl);
 		erofs_err("failed to initialize s3erofs: %s", erofs_strerror(ret));
 		return ret;
 	}
 
-	iter = s3erofs_create_object_iterator(s3, path, NULL);
+	iter = s3erofs_create_object_iterator(s3, path, NULL, fillzero);
 	if (IS_ERR(iter)) {
 		erofs_err("failed to create object iterator");
 		ret = PTR_ERR(iter);
@@ -732,11 +894,10 @@ int s3erofs_build_trees(struct erofs_importer *im, struct erofs_s3 *s3,
 		ret = __erofs_fill_inode(im, inode, &st, obj->key);
 		if (!ret && S_ISREG(inode->i_mode)) {
 			inode->i_size = obj->size;
-			if (fillzero)
+			if (fillzero || !inode->i_size)
 				ret = erofs_write_zero_inode(inode);
 			else
-				ret = s3erofs_remote_getobject(im, s3, inode,
-						iter->bucket, obj->key);
+				ret = s3erofs_remote_getobject(iter, obj, inode);
 		}
 		if (ret)
 			goto err_iter;
@@ -745,7 +906,8 @@ int s3erofs_build_trees(struct erofs_importer *im, struct erofs_s3 *s3,
 err_iter:
 	s3erofs_destroy_object_iterator(iter);
 err_global:
-	s3erofs_curl_easy_exit(s3);
+	curl_easy_cleanup(s3->easy_curl);
+	s3->easy_curl = NULL;
 	return ret;
 }
 
-- 
2.46.0


