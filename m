Return-Path: <linux-erofs+bounces-1019-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92549B53C43
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Sep 2025 21:28:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cN6zl2WQHz2yrF;
	Fri, 12 Sep 2025 05:28:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757618915;
	cv=none; b=AR/vkL8hK31UPEuniNeWNCR+MhmLuI7HSWcqp8gy9eDV3R970M0qwOgz/ISFexuLP7juUuSF3d9nN+UoQci/JHOq9pvaSltFK3j97mLVwnb3SkBaKKZnblFBoAMXOTm3+krMwwCDV8GVaXLiWcd6MwGZA6brFI/4K0379zW8CSW9y21trd8WDO/4t3bIjC7ewTP42Yur24s4bTQIV5PCkekZiRn0w3mVrBuvkxiduHzb37B2miI1udu9E1JCeoAcd3eR4sKiW9FJfczQRqDOEJtyLndrYJnBKxzJaSfX6KzSGVOetyTz3TrZSqtGuNcrwAzTvwq7Sqz/6/FAThIjww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757618915; c=relaxed/relaxed;
	bh=zfWUrFLUXaHFYUjhmCKnvVnWUOJx2vaw2BFQitQEwWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MM0p3g31azmk/75UyxkGw3f0bRb2UqrcHqUwSNR9JT7DJISZLLz4VKPNEZxfo5tajBl8AOshodBiMssuZl0aW9wPwGI+L1sqJ8Lq2HrDxWO77zRKmkn8nqGniYMa8NGCncTmm80ShGVe8AUayufpfrb9HaKmhztMpQYNSZZh8DgSiWCDVl/wGAzPzy+Vpn7yp5fmyiYQY2SH+CkyfUDyvV8wmmciRrRLF1gXwStqSJr50u1FMRg/Mewd0FS1sDN1EI0sbso8uHUpRA0G3E0a3sOLfX7RGHyOhQI0I+K6dxzEG1DM/O2kMbnAlp76/RKd9joV+2fW4r2CCYEva+lMog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WIgSxgb/; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WIgSxgb/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cN6zk3Tqxz2yr6
	for <linux-erofs@lists.ozlabs.org>; Fri, 12 Sep 2025 05:28:33 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757618910; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zfWUrFLUXaHFYUjhmCKnvVnWUOJx2vaw2BFQitQEwWI=;
	b=WIgSxgb/2I1b+1gYK1/oaJWDr62tXTIVFNnYaO/GPvk8kDBw6GnwfbzQUtsjsJ/eeg4hwvYxPPYHHD3maO7iZerbHS/zwjinMV6Ijft4wAQ+LO0zN7U9VyXOzrIjbeOJYmaZuIRUuR2peHyuNcoq+DqZw3ABoKjmqRy3LAxn0bo=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WnnX5NM_1757618908 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 12 Sep 2025 03:28:28 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/2] erofs-utils: mkfs: correct sb_size if metabox is on
Date: Fri, 12 Sep 2025 03:28:26 +0800
Message-ID: <20250911192827.1774829-1-hsiangkao@linux.alibaba.com>
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

Fixes: 4f7aa6b8fb7f ("erofs-utils: lib: introduce API helpers to prepare mkfs context")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/importer.c | 10 ++++------
 lib/metabox.c  |  4 +++-
 mkfs/main.c    |  1 +
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/importer.c b/lib/importer.c
index 9c57c07..bb29bd0 100644
--- a/lib/importer.c
+++ b/lib/importer.c
@@ -55,12 +55,10 @@ int erofs_importer_init(struct erofs_importer *im)
 			goto out_err;
 	}
 
-	if (cfg.c_mkfs_pclustersize_metabox >= 0) {
-		subsys = "metabox";
-		err = erofs_metabox_init(sbi);
-		if (err)
-			goto out_err;
-	}
+	subsys = "metabox";
+	err = erofs_metabox_init(sbi);
+	if (err)
+		goto out_err;
 
 	if (cfg.c_fragments) {
 		subsys = "dedupe_ext";
diff --git a/lib/metabox.c b/lib/metabox.c
index abde5e6..bf188f6 100644
--- a/lib/metabox.c
+++ b/lib/metabox.c
@@ -30,6 +30,9 @@ int erofs_metabox_init(struct erofs_sb_info *sbi)
 	struct erofs_metaboxmgr *m2gr;
 	int ret;
 
+	if (!erofs_sb_has_metabox(sbi))
+		return 0;
+
 	m2gr = malloc(sizeof(*m2gr));
 	if (!m2gr)
 		return -ENOMEM;
@@ -41,7 +44,6 @@ int erofs_metabox_init(struct erofs_sb_info *sbi)
 	m2gr->vf = (struct erofs_vfile){ .fd = ret };
 	m2gr->bmgr = erofs_buffer_init(sbi, 0, &m2gr->vf);
 	if (m2gr->bmgr) {
-		erofs_sb_set_metabox(sbi);
 		sbi->m2gr = m2gr;
 		return 0;
 	}
diff --git a/mkfs/main.c b/mkfs/main.c
index 3dd5815..c328e0a 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1444,6 +1444,7 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 		}
 		cfg.c_mkfs_pclustersize_metabox = pclustersize_metabox;
 		cfg.c_mkfs_metabox_algid = metabox_algorithmid;
+		erofs_sb_set_metabox(&g_sbi);
 	}
 
 	if (has_timestamp && cfg.c_timeinherit == TIMESTAMP_UNSPECIFIED)
-- 
2.43.5


