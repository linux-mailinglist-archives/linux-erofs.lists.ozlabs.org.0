Return-Path: <linux-erofs+bounces-1969-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F9CD38BBD
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Jan 2026 03:44:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dtLdd1KcZz2xqG;
	Sat, 17 Jan 2026 13:44:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768617845;
	cv=none; b=V1KirgP131XpJMgb9Pf0So92XZrWg9UF8DrZ/rH/qIYIagzaaPx4M5nbk/uJ19c4oKBWUJ+eUOsjBTBW39d91zRuxMYBm8BlqsN0cGVUibdFx/kAwN0Yja/rnhSOKkDLpMGAXPibDTFFBoT/X6zzGjsyh0K/tHqDPE1g6Ild6uZfBxE2dgNB5OO/4ovtf4D1kwHxsgWQMTZEdV/8ksv1GvK3qATeZ++LNAepaPqNZNuPcvIcqYWGwn7V+f2fVOf1pntbvdBY+bBGByRGJIPlauh9/8nnrKK2HxCPTavCGYxJyqbtHqa4Vy+KkPpdPBSwGUoevRQFU433GGJLTN980A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768617845; c=relaxed/relaxed;
	bh=b51TIERO57PXXzCJ7mhnoEfUT7iZ2uKzbEMHyz9M26s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G8L56UxZG5jMRkfol95Bgfk5oOQsh/0q13m7c5sTWBJ5BMeUMhergQmHueKsKj1Dx55kT3oJ54pUSvzqjmNn05ldUKMwEJ3xGPjRaiBADfyNKOWvPv0IK08ZdJWzFY2QSxkh0VFDCmD/loHQE8AM44c5xuG4uzsSctv2wD6l5MSxGfjSFfQlPKfhC4s36A02r40/iMukrDVDr6acIUXEKYJwTEXXpp/E9/5W+7FrnBrc/RhDEWmTwSomfrrpDckIhmx2r7gOu0aQJ2rt4Zm7ElJfRtg7ldDciVx0ck3wE17J7rMkLIC8XaGpY6en4V8lx3M38vv6Fb3cakfh0fTmzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=fsADCt7c; dkim-atps=neutral; spf=pass (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=fsADCt7c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dtLdZ3WYmz2xP9
	for <linux-erofs@lists.ozlabs.org>; Sat, 17 Jan 2026 13:43:59 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=b51TIERO57PXXzCJ7mhnoEfUT7iZ2uKzbEMHyz9M26s=;
	b=fsADCt7ceoyVzJ7mfVZMDPXXMQTPnFOZykIEPurjjGARWLbAWUsLTrdnhiJQK8RbpTRehp6J2
	SDzEoRiG833qoPQnKMijCwosPwqf4gHb0LqerbrX4kdiC4YrRIvT6mtkNXwA1D7HdQSG/Zu6HKx
	uv0FSxgvkPFGhuInAqYIemI=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dtLYV5bRYz1prMW;
	Sat, 17 Jan 2026 10:40:30 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id E8B774058B;
	Sat, 17 Jan 2026 10:43:53 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Sat, 17 Jan
 2026 10:43:53 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, <wayne.ma@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH v4] erofs-utils: lib: fix incorrect mtime under -Edot-omitted
Date: Sat, 17 Jan 2026 10:43:56 +0800
Message-ID: <20260117024356.3697202-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <392a98d3-5e31-494c-a013-030f858067ad@linux.alibaba.com>
References: <392a98d3-5e31-494c-a013-030f858067ad@linux.alibaba.com>
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
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

`-Edot-omitted` enables `-E48bits`, which requires specific
configurations for g_sbi.{epoch, build_time}. Currently, the call to
`erofs_sb_set_48bit()` occurs too late in the execution flow, causing
the aforementioned logic to be bypassed and resulting in incorrect
mtimes for all inodes.

This patch moves time initialization logic into `erofs_importer_init()`
to resolve this issue.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 include/erofs/importer.h |  1 +
 lib/importer.c           | 10 ++++++++++
 mkfs/main.c              | 16 ++++------------
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/erofs/importer.h b/include/erofs/importer.h
index 60160d6..2dea963 100644
--- a/include/erofs/importer.h
+++ b/include/erofs/importer.h
@@ -41,6 +41,7 @@ struct erofs_importer_params {
 	u32 pclusterblks_def;
 	u32 pclusterblks_packed;
 	s32 pclusterblks_metabox;
+	s64 mkfs_time;
 	char force_inodeversion;
 	bool ignore_mtime;
 	bool no_datainline;
diff --git a/lib/importer.c b/lib/importer.c
index 958a433..45c9963 100644
--- a/lib/importer.c
+++ b/lib/importer.c
@@ -83,6 +83,16 @@ int erofs_importer_init(struct erofs_importer *im)
 
 	if (params->dot_omitted)
 		erofs_sb_set_48bit(sbi);
+
+	if (params->mkfs_time != -1) {
+		if (erofs_sb_has_48bit(sbi)) {
+			sbi->epoch = max_t(s64, 0, params->mkfs_time - UINT32_MAX);
+			sbi->build_time = params->mkfs_time - sbi->epoch;
+		} else {
+			sbi->epoch = params->mkfs_time;
+		}
+	}
+
 	return 0;
 
 out_err:
diff --git a/mkfs/main.c b/mkfs/main.c
index bc001a6..34d03ca 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1731,7 +1731,6 @@ int main(int argc, char **argv)
 	bool tar_index_512b = false;
 	struct timeval t;
 	FILE *blklst = NULL;
-	s64 mkfs_time = 0;
 	int err;
 	u32 crc;
 
@@ -1756,17 +1755,10 @@ int main(int argc, char **argv)
 	}
 
 	g_sbi.fixed_nsec = 0;
-	if (cfg.c_unix_timestamp != -1) {
-		mkfs_time = cfg.c_unix_timestamp;
-	} else if (!gettimeofday(&t, NULL)) {
-		mkfs_time = t.tv_sec;
-	}
-	if (erofs_sb_has_48bit(&g_sbi)) {
-		g_sbi.epoch = max_t(s64, 0, mkfs_time - UINT32_MAX);
-		g_sbi.build_time = mkfs_time - g_sbi.epoch;
-	} else {
-		g_sbi.epoch = mkfs_time;
-	}
+	if (cfg.c_unix_timestamp != -1)
+		importer_params.mkfs_time = cfg.c_unix_timestamp;
+	else
+		importer_params.mkfs_time = !gettimeofday(&t, NULL) ? t.tv_sec : -1;
 
 	err = erofs_dev_open(&g_sbi, cfg.c_img_path, O_RDWR |
 				(incremental_mode ? 0 : O_TRUNC));
-- 
2.47.3


