Return-Path: <linux-erofs+bounces-1851-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05F2D1CE02
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Jan 2026 08:38:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4drdJV2jQBz2x9M;
	Wed, 14 Jan 2026 18:38:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768376298;
	cv=none; b=N7DHY5n4OqPZNkcibDAh8Cv8XUS4c4PyyxLh9bVmFO80oyRNF25A0OQmteBYQEQI3vi5MVVftDjj73BvAhAs9Lz/fRtf48p1j2RPYlKmmTK6AKuHNl88N4K7dgBkiJr3uXr2bfRM2opSixwVwMPCqawR+bw1pqpfyzbkSPmnRWc9o1rrWj4MhdxWgN3ZzvaBvZ2MR1IzCDCijfXLKSsZ8iLsiBEbywsSlNCK+6IrXhLjug5ymlK68dgFD+rkv1e27HHMauqR0ipNostk2snLrAAop0sBzPqQuGTdEd5Q01OAglWBlGIyQ9Zvp80NRI9nSQ1ildhpM4Xx0X4NVfW2hg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768376298; c=relaxed/relaxed;
	bh=re1j1HELV+kdRdHkjfZgOsyXqBe7K8JYuWcd9OJpgIM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oLyuJsr1dpF+CfxOz4G0zfJkajVcTD+U5a6w+WGm0fTgs/gAWIh0je1qvzqAvR0xU6u0tMqHpt+7QIthynuwE+6l017sHzvVmCZsh9PybjiWJI1UmKO02nDFX9qHJofcniTVVWtxtlM4U34DBDRgxNaiVphlgiyzkezCNHkWR2KKuQzrzclC1Gwf53hbRLKbPXSRLF+ZSBeKk8dl6yc/VSHmb05QkpWeQDwMlpQqJ6RGBMaanyKVZJfG37ClMLLGkUs7pZsqejrQ1/2dgwUEOOWlKr8x+5NxKMH0uaBJPZABbpZSsxTX42IU4yquZ2kUlNpI7bdOEKgky3prSn6m0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=FMwTVQS4; dkim-atps=neutral; spf=pass (client-ip=113.46.200.223; helo=canpmsgout08.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=FMwTVQS4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.223; helo=canpmsgout08.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4drdJS0GMtz2xlP
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 Jan 2026 18:38:15 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=re1j1HELV+kdRdHkjfZgOsyXqBe7K8JYuWcd9OJpgIM=;
	b=FMwTVQS4Y79HEHZPHl//3MRYQkNp1nLsilTgX/xxbuz+A2p9XXr8e5kKtvK55raQ9xePw0YE3
	Q9BbXUWURA92xm1qBosHRx6Kyj4JnlMx9bLMN8zJIHu/0jQyP26D1KwcJGh/QbInG9fNjHeXjBt
	MpOyB0YkKz/LYVJV0j9ykIM=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4drdDN3Cl6zmV69
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 Jan 2026 15:34:44 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 975D640539
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 Jan 2026 15:38:04 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 14 Jan
 2026 15:38:03 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, <wayne.ma@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH] erofs-utils: lib: s3: fix SigV4 signature timestamp mismatch
Date: Wed, 14 Jan 2026 15:38:08 +0800
Message-ID: <20260114073808.3640696-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.47.3
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
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

The current SigV4 implementation calls `s3erofs_now()` multiple times
during the signing process. This can cause inconsistent timestamps if a
second boundary is crossed, leading to signature verification failure.

Fix this by generating the timestamp once and passing it throughout the
signing process to ensure consistency.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 lib/remotes/s3.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
index 223c3e8..97f06b4 100644
--- a/lib/remotes/s3.c
+++ b/lib/remotes/s3.c
@@ -315,11 +315,10 @@ enum s3erofs_date_format {
 	S3EROFS_DATE_YYYYMMDD
 };
 
-static void s3erofs_now(char *buf, size_t maxlen, enum s3erofs_date_format fmt)
+static void s3erofs_format_time(time_t t, char *buf, size_t maxlen, enum s3erofs_date_format fmt)
 {
 	const char *format;
-	time_t now = time(NULL);
-	struct tm *ptm = gmtime(&now);
+	struct tm *ptm = gmtime(&t);
 
 	switch (fmt) {
 	case S3EROFS_DATE_RFC1123:
@@ -402,10 +401,9 @@ free_string:
 
 // See: https://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-header-based-auth.html
 static char *s3erofs_sigv4_header(const struct curl_slist *headers,
-				  const char *canonical_uri,
-				  const char *canonical_query,
-				  const char *region, const char *ak,
-				  const char *sk)
+				  time_t request_time, const char *canonical_uri,
+				  const char *canonical_query, const char *region,
+				  const char *ak, const char *sk)
 {
 	u8 ping_buf[EVP_MAX_MD_SIZE], pong_buf[EVP_MAX_MD_SIZE];
 	char hex_buf[EVP_MAX_MD_SIZE * 2 + 1];
@@ -423,10 +421,12 @@ static char *s3erofs_sigv4_header(const struct curl_slist *headers,
 		canonical_query = "";
 
 	canonical_headers = get_canonical_headers(headers);
+	if (!canonical_headers)
+		return ERR_PTR(-ENOMEM);
 
 	// Get current time in required formats
-	s3erofs_now(date_str, sizeof(date_str), S3EROFS_DATE_YYYYMMDD);
-	s3erofs_now(timestamp, sizeof(timestamp), S3EROFS_DATE_ISO8601);
+	s3erofs_format_time(request_time, date_str, sizeof(date_str), S3EROFS_DATE_YYYYMMDD);
+	s3erofs_format_time(request_time, timestamp, sizeof(timestamp), S3EROFS_DATE_ISO8601);
 
 	// Task 1: Create canonical request
 	if (asprintf(&canonical_request,
@@ -530,9 +530,8 @@ static int s3erofs_request_insert_auth_v2(struct curl_slist **request_headers,
 	char date[64], *sigv2;
 
 	memcpy(date, date_prefix, sizeof(date_prefix) - 1);
-	s3erofs_now(date + sizeof(date_prefix) - 1,
-		    sizeof(date) - sizeof(date_prefix) + 1,
-		    S3EROFS_DATE_RFC1123);
+	s3erofs_format_time(time(NULL), date + sizeof(date_prefix) - 1,
+			    sizeof(date) - sizeof(date_prefix) + 1, S3EROFS_DATE_RFC1123);
 
 	sigv2 = s3erofs_sigv2_header(*request_headers, NULL, NULL,
 				     date + sizeof(date_prefix) - 1, req->canonical_uri,
@@ -553,6 +552,7 @@ static int s3erofs_request_insert_auth_v4(struct curl_slist **request_headers,
 {
 	char timestamp[32], *sigv4, *tmp;
 	const char *host, *host_end;
+	time_t request_time = time(NULL);
 
 	/* Add following headers for SigV4 in alphabetical order: */
 	/* 1. host */
@@ -570,15 +570,15 @@ static int s3erofs_request_insert_auth_v4(struct curl_slist **request_headers,
 		*request_headers, "x-amz-content-sha256:UNSIGNED-PAYLOAD");
 
 	/* 3. x-amz-date */
-	s3erofs_now(timestamp, sizeof(timestamp), S3EROFS_DATE_ISO8601);
+	s3erofs_format_time(request_time, timestamp, sizeof(timestamp), S3EROFS_DATE_ISO8601);
 	if (asprintf(&tmp, "x-amz-date:%s", timestamp) < 0)
 		return -ENOMEM;
 	*request_headers = curl_slist_append(*request_headers, tmp);
 	free(tmp);
 
-	sigv4 = s3erofs_sigv4_header(*request_headers, req->canonical_uri,
-				     req->canonical_query, s3->region, s3->access_key,
-				     s3->secret_key);
+	sigv4 = s3erofs_sigv4_header(*request_headers, request_time,
+				     req->canonical_uri, req->canonical_query,
+				     s3->region, s3->access_key, s3->secret_key);
 	if (IS_ERR(sigv4))
 		return PTR_ERR(sigv4);
 	*request_headers = curl_slist_append(*request_headers, sigv4);
-- 
2.47.3


