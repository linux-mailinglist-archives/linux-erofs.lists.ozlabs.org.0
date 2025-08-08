Return-Path: <linux-erofs+bounces-797-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE61B1E123
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Aug 2025 06:02:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4byr376Bdpz30WY;
	Fri,  8 Aug 2025 14:02:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754625763;
	cv=none; b=O/wGNP9tBDF3GhoBYP6cH2QLybLZlaJLfvhKW9W6p92R15nj/UvoyUrS9amxN6Bxpni6tXiClZPPPC568Y5hriHw1N9WqRxu5fczMtDCW4zxr92xHbzgNVgqF41WoRHXBvutuRJ2fZR3EDP0XhNuLKttw3MjHMWKza0iLI7MkkdZf8J0zFuqsvs+touT3VQwZdU50oj60u6mIypvVq0vYW3RRS5qVS1Z4NoM7aUfePPk8CRfMEKHWl+R6Pd29Bvqn03xL+2iyvVIm0Bo1lkGOy6N+uTL/K/z0DHyoZGx5SrpemD6F3PrhVBU3r9t8/t7lKBsv4VyEa7Sm03ro2BsIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754625763; c=relaxed/relaxed;
	bh=r4EMzQeAC4pDFIUAIgF8aoJ8KLmy/fO/QOQlewvQJL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TsPSSmKOy0cMc76/me40Xb32hA8/VhBQsSYXD9/HZCUqzs6hhsmxSL4nGykB1Hyv5hLfeSfhYVR20biHO+nxexhMBV6OtzMk/D+zi6/OxfJha1xsZFLt22MfyZRioiakiPhaswr7iMbtX+/wUYt2jlkZduqvx7dzkJiKjicB1CSa+wAKMKf/ds63I1fgIx2pljh1zrv9c3FzNb+vCRHOhBpG6X9NeEbydKQPpzAfEgsHYd5ENi+wiau5nqLsO0LWS7XSEPOKi5HDk/q8kc6br772bzP7TJbTnMtQLBmIVsWpmcsXvBVwS9eftfDpq3I4xclgqjKVzyPDE2S4qYT2Dg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Ovzj5BrO; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Ovzj5BrO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4byr361c7Kz30Vl
	for <linux-erofs@lists.ozlabs.org>; Fri,  8 Aug 2025 14:02:40 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754625757; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=r4EMzQeAC4pDFIUAIgF8aoJ8KLmy/fO/QOQlewvQJL0=;
	b=Ovzj5BrOxoFX2vcy2uP3RePAJtlVuQR54ooCJtE2aMEfYatlS5an5D8nphEACjKapmOBATYGMkeCizasbmzJrlzUVT1EfG4zyXew1hTB+NBbtHJva+UEsScFNx+JPZ6xi1DgstRYXYFi/3GfZk5L6nxLAkorK0KO5t+xmcVUsgI=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WlFo4XQ_1754624833 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 Aug 2025 11:47:17 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: mkfs: support AWS_{ACCESS_KEY_ID,SECRET_ACCESS_KEY}
Date: Fri,  8 Aug 2025 11:47:11 +0800
Message-ID: <20250808034711.390887-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

https://docs.aws.amazon.com/sdkref/latest/guide/feature-static-credentials.html

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 mkfs/main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mkfs/main.c b/mkfs/main.c
index 07bc3ed..4e65978 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1737,6 +1737,17 @@ int main(int argc, char **argv)
 				goto exit;
 #ifdef S3EROFS_ENABLED
 		} else if (source_mode == EROFS_MKFS_SOURCE_S3) {
+			if (!s3cfg.access_key[0]) {
+				strncpy(s3cfg.access_key, getenv("AWS_ACCESS_KEY_ID"),
+					sizeof(s3cfg.access_key));
+				s3cfg.access_key[S3_ACCESS_KEY_LEN] = '\0';
+			}
+			if (!s3cfg.secret_key[0]) {
+				strncpy(s3cfg.secret_key, getenv("AWS_SECRET_ACCESS_KEY"),
+					sizeof(s3cfg.secret_key));
+				s3cfg.secret_key[S3_SECRET_KEY_LEN] = '\0';
+			}
+
 			if (incremental_mode ||
 			    dataimport_mode != EROFS_MKFS_DATA_IMPORT_ZEROFILL)
 				err = -EOPNOTSUPP;
-- 
2.43.5


