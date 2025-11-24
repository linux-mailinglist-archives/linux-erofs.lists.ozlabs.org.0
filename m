Return-Path: <linux-erofs+bounces-1432-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52C6C80823
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Nov 2025 13:40:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dFQQP5H6Jz2xQs;
	Mon, 24 Nov 2025 23:40:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763988013;
	cv=none; b=KPVNlAUMpEdYLa31sMXg/1KwgIzX53izQhOA6vmdpdTBlO47o/WCH2D+gcGFz55QI7CgJRSDeoSrhvWRnhjlQGKxh6e8qpDehnn9gAxCFwGYBMlniqiqtUWE1KOCOImqJ4hddjnTU3SpycUxduxJAiY/bFWBd3G0puLBIp6rhbuT40UrxTmhJ/KvlFlh5WjoGfNMPzH0dbERUeW0R0viS0GKQNlKncUVw6XQ2s2m1qTqNekWpfcVixaeFM37/WqLfLIasxsyVTNKWg40CX+zE8Tyzrg6BlCTT4dUKuncQqhSYOt1eAGd6EziXsttKvYeKQgX9yY0xUSYk+0QOCYMiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763988013; c=relaxed/relaxed;
	bh=jBD/QupJFcqdfr8UEIg1XYBvnQsS29LKxS+YfA4vBUA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q43LnhnXvaZHiFq5cxB3YPHfX5FPPEEKjOajIHTjKhfOhtS22o5BVUzUQ+h4rooGlaR8NnGwJqlJ6PZMXYItKP9DBBSoCx1VmwhtkMwDnDHiAhN0PHFEY/VQwRyf7jGWIBcUd1F17BXQYttWjp1xyT32NimU1eiga40y3veDXS2OVDyvUI6KY4o+EY0sfJ7zcoOzXO4337pCiglM24RR8WJlXC6Kf/IpgcSdrAtIZDaoy99ePfL7RX0XKAJDgklabLNMnXZphvuQ3oPjzmk2qQBP50vUTilh53Ex+AwGSKtHbU2D1UmIVZcdIO1NopIdaKdI2pOe92v3KzNq+jsI2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=0it3KHCy; dkim-atps=neutral; spf=pass (client-ip=113.46.200.222; helo=canpmsgout07.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=0it3KHCy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.222; helo=canpmsgout07.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dFQQN5LfLz2xPy
	for <linux-erofs@lists.ozlabs.org>; Mon, 24 Nov 2025 23:40:12 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jBD/QupJFcqdfr8UEIg1XYBvnQsS29LKxS+YfA4vBUA=;
	b=0it3KHCydFLpK6RLYMDU8ob/YKcz+F87E0AjbCsJBFsh/Mk7HCmN3ULqTxkY/pXe3j9LuVpVh
	ZVGPlApfUaveUdfYlT2oCM41ICzVS7se1+zSkgUYrLNPJhBVyT0Ov0+NajM07yUQzNC23L67E3r
	IYLxuCok1j/1zGnrv1nyzio=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dFQNG0v50zLlTK;
	Mon, 24 Nov 2025 20:38:22 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 9AB4E140275;
	Mon, 24 Nov 2025 20:40:08 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 24 Nov
 2025 20:40:08 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>, <hsiangkao@linux.alibaba.com>
CC: <wayne.ma@huawei.com>, <jingrui@huawei.com>
Subject: [Interdiff v2~v1] erofs-utils: lib: support AWS SigV4 for S3 backend
Date: Mon, 24 Nov 2025 20:36:06 +0800
Message-ID: <20251124123606.21330-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <9c78f293-9536-4463-9c25-817937e40cc2@linux.alibaba.com>
References: <9c78f293-9536-4463-9c25-817937e40cc2@linux.alibaba.com>
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
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Yifan Zhao (1):
  erofs-utils: lib: support AWS SigV4 for S3 backend

 lib/liberofs_s3.h |   1 +
 lib/remotes/s3.c  | 581 +++++++++++++++++++++++++++++++++++++---------
 mkfs/main.c       |  14 +-
 3 files changed, 485 insertions(+), 111 deletions(-)

Interdiff against v1:
diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
index 3263dd7..cc37880 100644
--- a/lib/remotes/s3.c
+++ b/lib/remotes/s3.c
@@ -23,7 +23,7 @@
 #define S3EROFS_PATH_MAX		1024
 #define S3EROFS_MAX_QUERY_PARAMS	16
 #define S3EROFS_URL_LEN			8192
-#define S3EROFS_CANONICAL_URI_LEN	1024
+#define S3EROFS_CANONICAL_URI_LEN	2048
 #define S3EROFS_CANONICAL_QUERY_LEN	S3EROFS_URL_LEN
 
 #define BASE64_ENCODE_LEN(len)	(((len + 2) / 3) * 4)
@@ -40,7 +40,8 @@ struct s3erofs_curl_request {
 	char canonical_query[S3EROFS_CANONICAL_QUERY_LEN];
 };
 
-static const char *s3erofs_parse_host(const char *endpoint, const char **schema) {
+static const char *s3erofs_parse_host(const char *endpoint, const char **schema)
+{
 	const char *tmp = strstr(endpoint, "://");
 	const char *host;
 
@@ -60,17 +61,17 @@ static const char *s3erofs_parse_host(const char *endpoint, const char **schema)
 	return host;
 }
 
-static int s3erofs_urlencode(const char *input, char **output)
+static void* s3erofs_urlencode(const char *input)
 {
 	static const char hex[] = "0123456789ABCDEF";
 	int i;
-	char c, *p;
+	char c, *p, *ret;
 
-	*output = malloc(strlen(input) * 3 + 1);
-	if (!*output)
-		return -ENOMEM;
+	ret = malloc(strlen(input) * 3 + 1);
+	if (!ret)
+		return ERR_PTR(-ENOMEM);
 
-	p = *output;
+	p = ret;
 	for (i = 0; i < strlen(input); ++i) {
 		c = (unsigned char)input[i];
 
@@ -87,7 +88,7 @@ static int s3erofs_urlencode(const char *input, char **output)
 	}
 	*p = '\0';
 
-	return 0;
+	return ret;
 }
 
 struct kv_pair {
@@ -106,17 +107,23 @@ static int s3erofs_prepare_canonical_query(struct s3erofs_curl_request *req,
 	struct kv_pair *pairs;
 	int i, pos = 0, ret = 0;
 
-	if (params->num == 0)
+	if (!params->num)
 		return 0;
 
-	pairs = malloc(sizeof(struct kv_pair) * params->num);
+	pairs = calloc(1, sizeof(struct kv_pair) * params->num);
 	for (i = 0; i < params->num; i++) {
-		ret = s3erofs_urlencode(params->key[i], &pairs[i].key);
-		if (ret < 0)
+		pairs[i].key = s3erofs_urlencode(params->key[i]);
+		if (IS_ERR(pairs[i].key)) {
+			ret = PTR_ERR(pairs[i].key);
+			pairs[i].key = NULL;
 			goto out;
-		ret = s3erofs_urlencode(params->value[i], &pairs[i].value);
-		if (ret < 0)
+		}
+		pairs[i].value = s3erofs_urlencode(params->value[i]);
+		if (IS_ERR(pairs[i].value)) {
+			ret = PTR_ERR(pairs[i].value);
+			pairs[i].value = NULL;
 			goto out;
+		}
 	}
 
 	qsort(pairs, params->num, sizeof(struct kv_pair), compare_kv_pair);
@@ -126,7 +133,14 @@ static int s3erofs_prepare_canonical_query(struct s3erofs_curl_request *req,
 				pairs[i].key, pairs[i].value,
 				(i == params->num - 1) ? "" : "&");
 	req->canonical_query[pos] = '\0';
+
 out:
+	for (i = 0; i < params->num; i++) {
+		if (pairs[i].key)
+			free(pairs[i].key);
+		if (pairs[i].value)
+			free(pairs[i].value);
+	}
 	free(pairs);
 	return ret;
 }
-- 
2.33.0


