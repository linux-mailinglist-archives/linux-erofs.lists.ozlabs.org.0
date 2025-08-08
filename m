Return-Path: <linux-erofs+bounces-801-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0C9B1E13A
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Aug 2025 06:21:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4byrSt6wcMz2xcC;
	Fri,  8 Aug 2025 14:21:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754626894;
	cv=none; b=WVFFosEJY2q1mcPkjzS0Ol/gVvIwA+3oaF+orgMuwExXUtK4QsvmrmPKPZWm5xH007UKtGzlHNmH4bO/+2bYkKJUSMcIKOIomG29Q6g6q82BHlGhZQpTCOwyUZcXtq+AHyTXj9m44lcH4U43oqgEj6zApE7yXXmh7zAnwuxOr9KL9majqQJWBSkFReBnj0ZTADZlqSKaBcjXGQIqSYk+eNJ3Bp0TG8S7vL9GXN2rHRVE+WdgI1QxzZBv0ipCCB50SU6+yBSY5N7x1041FGx70ElbR1OYllBwu4XxSwmKTI+jiiowiPPMi7ruCJNBzNKmxpWMNbPk6L0EEOI6MjLJUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754626894; c=relaxed/relaxed;
	bh=+we6Bgq7k1QharcLJ/yHXottTBL9yZjSzyF4W7ydOjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFSWVZi6jPHCF1CE3+Q7wy/OccyPe+a+CGvUXb42fC4AEhV62t3X3T/1LOO9Hmx+OOaRrUIEcUxV6EWrPm+mgqIzIW7r/JJYKlljnWanLENtjmyXucy/bqA50L2VY1ZdRC+yBtiGCGH6yP3n2cTOcsnklvK1rBSa3WYuzmVlkt+c4ARa7pQQnQKLM0kA8bHFFc20NwtcBgH2hjsixlXVL2DxhQXHqDiU9frTyzAVz7Xli+H5qyNtPeWtnJpRvPfSO5nzTjOJ7rx5fXfubh2Gk7Xvck5HYDwc1Zim49hJv+2NzxDczAjWMROZ8DG0RRqlO5FqCfd7QBGWHfTsRtN8+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oKfINRcb; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oKfINRcb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4byrSt0hC3z3bmC
	for <linux-erofs@lists.ozlabs.org>; Fri,  8 Aug 2025 14:21:33 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754626889; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+we6Bgq7k1QharcLJ/yHXottTBL9yZjSzyF4W7ydOjk=;
	b=oKfINRcbKMAmF9EdVju7Y33SY1MxT9YGrspfbUl5jwF5qx/NGVIg40xWxIEYfvD6GbDgD6eoffT7ZXqg1gSuXIT1WNPfSGrkBewZ1aqEZKxJICnFt3SaCSGPNDKe0MsKpBdvViTUTCqYrVqmqLWD6X2akUkPTe3AquVQPehL1LE=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WlG6-40_1754626884 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 Aug 2025 12:21:28 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2] erofs-utils: mkfs: support AWS_{ACCESS_KEY_ID,SECRET_ACCESS_KEY}
Date: Fri,  8 Aug 2025 12:21:23 +0800
Message-ID: <20250808042123.435547-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250808034711.390887-1-hsiangkao@linux.alibaba.com>
References: <20250808034711.390887-1-hsiangkao@linux.alibaba.com>
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
index 07bc3ed..d3bd1cd 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1737,6 +1737,17 @@ int main(int argc, char **argv)
 				goto exit;
 #ifdef S3EROFS_ENABLED
 		} else if (source_mode == EROFS_MKFS_SOURCE_S3) {
+			if (!s3cfg.access_key[0] && getenv("AWS_ACCESS_KEY_ID")) {
+				strncpy(s3cfg.access_key, getenv("AWS_ACCESS_KEY_ID"),
+					sizeof(s3cfg.access_key));
+				s3cfg.access_key[S3_ACCESS_KEY_LEN] = '\0';
+			}
+			if (!s3cfg.secret_key[0] && getenv("AWS_SECRET_ACCESS_KEY")) {
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


