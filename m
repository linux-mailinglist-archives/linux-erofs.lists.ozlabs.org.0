Return-Path: <linux-erofs+bounces-766-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8ABB1AC9A
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Aug 2025 05:05:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bwyws3BV0z3bV6;
	Tue,  5 Aug 2025 13:05:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.188
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754363149;
	cv=none; b=GvGguToEHoKR3F9QhelBwgN3lExAOuDUDTXs4GX7Uh5pUSx2r+XDnTrFT9Lke3SvZmTg3AtxNzMb9tnWmKpGmoM+pgrw2DZpGRbd0hBGmZqzv/+/HeUQe7PL6FYLbgvNYUTz7VCC+wS8zncehPTOokBpqZfzSbJtQGVTBF1D7FFnuK2qb7C/ltLy3ZwlWrN6AwHn34YbymQkXOLQNYmDxb+MotF+gXmyMx6JQNF3+IMRj4/w5S5YsfqaDRZlGLbQmcKzqF0p8bAzXmAbyCk28KskUPhCRLoy6z9LHXzvE4Q3aPl7N8OenxIz3h7lLsGlClwDM8Xg25lFYe2R5VzDyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754363149; c=relaxed/relaxed;
	bh=ddGNCXGNfdUd3uZ6Tuur6nv7wEMCopgOlBS52EKhQ2c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WWmGTmUgRD+JF0nbwMysMlmaNR4KDAswRq2D98uciyk+xdY+69v1VvJCOP8Q57o8SHhRnDkT2hs53GAxX1WgJt5jyAbur1TFkK1XJcLZ+VXmWYLeoqgfYh1MU6tRYjGGvAd1M/uzKGtKWmTFwx1uYTTtiY9nEbjUNU+GuKKWPw8ZYI8TZW+1gO45A4Mc/Xpzi9cpJPZsSBVzHbrt5vWcJY0JdHG49u/1t7uSbI4SqQjfksY8FYat50DVvlDamft1gsx5rZ9PYOA6uFkywbSxhGKNsCLu8SzW6Lz1w81IxLtDdR/1uu4s2T/pxpIIdixwhCXyhXhi6GVLaVyw0g3ldQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bwywr2MBKz2yLJ
	for <linux-erofs@lists.ozlabs.org>; Tue,  5 Aug 2025 13:05:46 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bwyvX18QGztSt5;
	Tue,  5 Aug 2025 11:04:40 +0800 (CST)
Received: from kwepemp500007.china.huawei.com (unknown [7.202.195.151])
	by mail.maildlp.com (Postfix) with ESMTPS id D237B18049C;
	Tue,  5 Aug 2025 11:05:41 +0800 (CST)
Received: from localhost.localdomain (10.175.124.27) by
 kwepemp500007.china.huawei.com (7.202.195.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 5 Aug 2025 11:05:41 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <hsiangkao@linux.alibaba.com>, <jingrui@huawei.com>,
	<lihongbo22@huawei.com>, zhaoyifan <zhaoyifan28@huawei.com>
Subject: [Interdiff v3~v4 4/4] erofs-utils: mkfs: support EROFS index-only image generation from S3
Date: Tue, 5 Aug 2025 11:05:13 +0800
Message-ID: <20250805030513.446510-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250804152825.428197-4-zhaoyifan28@huawei.com>
References: <20250804152825.428197-4-zhaoyifan28@huawei.com>
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
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemp500007.china.huawei.com (7.202.195.151)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: zhaoyifan <zhaoyifan28@huawei.com>

Interdiff against v3:
diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
index 5638057..dd682a4 100644
--- a/lib/remotes/s3.c
+++ b/lib/remotes/s3.c
@@ -30,18 +30,17 @@ struct s3erofs_query_params {
 	const char *value[S3EROFS_MAX_QUERY_PARAMS];
 };
 
-static void s3erofs_prepare_url(const char *endpoint, const char *bucket, const char *object,
-				struct s3erofs_query_params *params, char *url,
-				enum s3erofs_url_style url_style)
+static int s3erofs_prepare_url(const char *endpoint, const char *bucket, const char *object,
+			       struct s3erofs_query_params *params, char *url,
+			       enum s3erofs_url_style url_style)
 {
 	const char *schema = NULL;
 	const char *host = NULL;
 	size_t pos = 0;
 	int i;
 
-	if (!endpoint || !bucket || !url) {
-		return;
-	}
+	if (!endpoint || !bucket || !url)
+		return -EINVAL;
 
 	if (strncmp(endpoint, "https://", 8) == 0) {
 		schema = "https://";
@@ -50,8 +49,8 @@ static void s3erofs_prepare_url(const char *endpoint, const char *bucket, const
 		schema = "http://";
 		host = endpoint + 7;
 	} else {
-		schema = "http://";
-		host = endpoint;
+		erofs_err("endpoint has invalid format, missing http/https protocol");
+		return -EINVAL;
 	}
 
 	if (url_style == S3EROFS_URL_STYLE_VIRTUAL_HOST) {
@@ -68,6 +67,8 @@ static void s3erofs_prepare_url(const char *endpoint, const char *bucket, const
 		pos += snprintf(url + pos, S3EROFS_URL_LEN - pos, "%c%s=%s", (i == 0 ? '?' : '&'),
 				params->key[i], params->value[i]);
 	}
+
+	return 0;
 }
 
 static char *get_canonical_headers(const struct curl_slist *list) { return ""; }
@@ -432,8 +433,11 @@ static int s3erofs_list_objects(struct s3erofs_object_iterator *it)
 	++params.num;
 
 	req.method = "GET";
-	s3erofs_prepare_url(s3cfg->endpoint, s3cfg->bucket, NULL, &params,
-			    req.url, s3cfg->url_style);
+	ret = s3erofs_prepare_url(s3cfg->endpoint, s3cfg->bucket, NULL, &params,
+				  req.url, s3cfg->url_style);
+	if (ret < 0)
+		return ret;
+
 	snprintf(req.canonical_query, S3EROFS_CANONICAL_QUERY_LEN, "/%s", s3cfg->bucket);
 
 	ret = s3erofs_request_perform(s3cfg, &req, &resp);
@@ -515,7 +519,6 @@ static int s3erofs_global_init(void)
 	curl_easy_setopt(easy_curl, CURLOPT_WRITEFUNCTION, s3erofs_request_write_memory_cb);
 	curl_easy_setopt(easy_curl, CURLOPT_FOLLOWLOCATION, 1L);
 	curl_easy_setopt(easy_curl, CURLOPT_TIMEOUT, 30L);
-	curl_easy_setopt(easy_curl, CURLOPT_SSL_VERIFYPEER, 0);
 
 	xmlInitParser();
 
-- 
2.46.0


