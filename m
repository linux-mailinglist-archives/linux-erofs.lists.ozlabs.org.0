Return-Path: <linux-erofs+bounces-1144-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71972BAC18A
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Sep 2025 10:41:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cbWkR6pVGz3cZt;
	Tue, 30 Sep 2025 18:41:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.189
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759221695;
	cv=none; b=XYg8hEX4aTEGIhIe/lONhrYDJWAyTr90XZLjG7QZOr5LOwXpynKKDMQOQXL9RytJ23U5l4T2IpeQKImskQGvQ2hS60KsoX9Rx9Yo/fRK2zbUcRSlR9k8FUUAYNiNLBW6SI+0mq6OBwgAM47fGPdwJvoTpehBxTNjV/3+xo2XS/41uydToz1olvK6HlDiuAFwugMcuwfr863+8iFaevpesaU8Y7XlsNDP1zjCZOJqUQ/D+26zI27vEQ8l32XgS3fpYR/NoeWoUoRvK8+qoYfj4+UaLIrHY67GakGob4PrwsVTXJkXFhC9g/fIu0YJrdD0g4v6VjbSEfHgRBXwm263VA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759221695; c=relaxed/relaxed;
	bh=2muwtgr4kAp1vTHESrDfIpbSvflttYZcOToCfpP5Mi0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QYBdWgnDqbIMfn8K6lZjXoI0WIfoT2Q+sFg2ior9gBNSjmHDG1LZ1bfQCPFKs09+v0yDxQBYpLQOirXazZ3snRe7ckDGfvPswChy4DS/IU5RI7nkWBNj5J1POHahHDwC4wDEhppdBfG50oBSXBuHCkasiaZkBn7qw741/dLmMeW11KeKJFJ9dKcMqQwDaEtj8Rn/zsejpb2kXxBrm2t1pAaZapQ/EG+YbQEh9X+hV1Pkok5DaHhNRLROMhjF8hIzUn7HugW/JM0+ycnhmqlOct3LYPKBAXHTVzrBn/QtMLnrJ8R/KZ8c5J/u5SWFk3cy1pIbGhNtkM+Yf7tVfXvjFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=fUQAab+v; dkim-atps=neutral; spf=pass (client-ip=45.249.212.189; helo=szxga03-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=fUQAab+v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.189; helo=szxga03-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cbWkP1mspz3cZd
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Sep 2025 18:41:32 +1000 (AEST)
Received: from canpmsgout11.his.huawei.com (unknown [172.19.92.148])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cbWcv54RLzJsZ7
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Sep 2025 16:36:47 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2muwtgr4kAp1vTHESrDfIpbSvflttYZcOToCfpP5Mi0=;
	b=fUQAab+vsFlmKhudJAiad9MjgzqzSVFK6BFjk3XtP0LMhYm77mkr8b9VKMMBViv4X9EUHceyx
	PePNRhDLx3oJiCWBdnRFA7gHYsmZm8ostWVhzIg/2GSMOOxiNjmp7dUw9HWPqd7PrbNPg7yJJLb
	fBJTQ2Q69HSNYGI3FXod1NM=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cbWjy3JTLzKm5H
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Sep 2025 16:41:10 +0800 (CST)
Received: from kwepemp500007.china.huawei.com (unknown [7.202.195.151])
	by mail.maildlp.com (Postfix) with ESMTPS id 6CBFA140279
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Sep 2025 16:41:21 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemp500007.china.huawei.com
 (7.202.195.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 30 Sep
 2025 16:41:20 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, <wayne.ma@huawei.com>
Subject: [PATCH] erofs-utils: lib: simplify s3erofs_prepare_url logic
Date: Tue, 30 Sep 2025 16:40:56 +0800
Message-ID: <20250930084056.170447-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.46.0
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
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemp500007.china.huawei.com (7.202.195.151)
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: zhaoyifan <zhaoyifan28@huawei.com>

`mkfs.erofs` failed to generate image from Huawei OBS with the following command:

	mkfs.erofs --s3=<endpoint>,urlstyle=vhost,sig=2 s3.erofs test-bucket

because it mistakenly generated a url with repeated '/':

	https://test-bucket.<endpoint>//<keyname>

In fact, the splitting of bucket name and path has already been performed prior
to the call to `s3erofs_prepare_url`, and this function does not need to handle
this logic. This patch simplifies this part accordingly and fixes the problem.

Fixes: 29728ba8f6f6 ("erofs-utils: mkfs: support EROFS meta-only image generation from S3")
Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 lib/remotes/s3.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
index 2e7763e..2bd5322 100644
--- a/lib/remotes/s3.c
+++ b/lib/remotes/s3.c
@@ -41,17 +41,16 @@ struct s3erofs_curl_request {
 
 static int s3erofs_prepare_url(struct s3erofs_curl_request *req,
 			       const char *endpoint,
-			       const char *path, const char *key,
+			       const char *bucket, const char *key,
 			       struct s3erofs_query_params *params,
 			       enum s3erofs_url_style url_style)
 {
 	static const char https[] = "https://";
 	const char *schema, *host;
-	bool slash = false;
 	char *url = req->url;
 	int pos, i;
 
-	if (!endpoint || !path)
+	if (!endpoint || !bucket)
 		return -EINVAL;
 
 	schema = strstr(endpoint, "://");
@@ -65,30 +64,16 @@ static int s3erofs_prepare_url(struct s3erofs_curl_request *req,
 			return -ENOMEM;
 	}
 
-	if (url_style == S3EROFS_URL_STYLE_PATH) {
-		pos = snprintf(url, S3EROFS_URL_LEN, "%s%s/%s", schema,
-			       host, path);
-	} else {
-		const char * split = strchr(path, '/');
+	if (url_style == S3EROFS_URL_STYLE_PATH)
+		pos = snprintf(url, S3EROFS_URL_LEN, "%s%s/%s/", schema, host, bucket);
+	else
+		pos = snprintf(url, S3EROFS_URL_LEN, "%s%s.%s/", schema, bucket, host);
 
-		if (!split) {
-			pos = snprintf(url, S3EROFS_URL_LEN, "%s%s.%s/",
-				       schema, path, host);
-			slash = true;
-		} else {
-			pos = snprintf(url, S3EROFS_URL_LEN, "%s%.*s.%s%s",
-				       schema, (int)(split - path), path,
-				       host, split);
-		}
-	}
-	if (key) {
-		slash |= url[pos - 1] != '/';
-		pos -= !slash;
-		pos += snprintf(url + pos, S3EROFS_URL_LEN - pos, "/%s", key);
-	}
+	if (key)
+		pos += snprintf(url + pos, S3EROFS_URL_LEN - pos, "%s", key);
 
 	i = snprintf(req->canonical_query, S3EROFS_CANONICAL_QUERY_LEN,
-		     "/%s%s%s", path, slash ? "/" : "", key ? key : "");
+		     "/%s/%s", bucket, key ? key : "");
 	req->canonical_query[i] = '\0';
 
 	for (i = 0; i < params->num; i++)
@@ -503,7 +488,7 @@ s3erofs_create_object_iterator(struct erofs_s3 *s3, const char *path,
 	if (prefix) {
 		if (++prefix - path > S3EROFS_PATH_MAX)
 			return ERR_PTR(-EINVAL);
-		iter->bucket = strndup(path, prefix - path);
+		iter->bucket = strndup(path, prefix - 1 - path);
 		iter->prefix = strdup(prefix);
 	} else {
 		iter->bucket = strdup(path);
-- 
2.46.0


