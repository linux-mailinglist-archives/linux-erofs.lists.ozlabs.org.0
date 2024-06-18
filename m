Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A7F90C403
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2024 08:50:20 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RfhKBjCK;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W3HSP6wtzz30Th
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2024 16:50:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RfhKBjCK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W3HRJ2Qrtz3bnt
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Jun 2024 16:49:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718693353; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=jEq2bDUQciu5TexHCP5XaohFYYdwYBNJt+hjPUyYcb4=;
	b=RfhKBjCKq02yCaXAchGiEZ2ouWEcBJ1vqJg6eCUsjlXo99qqZSXxrl/8M6s8F8/uv2LC1jNObFrJhsyQb40UeGMKBvNhD/2pDkx2rOg3pN/IUugQM3KV+gH2ouaTuFSnLwCTnQMZ9Epx6UyYJx6weR5Yc0w9Sm6YuV/B3yOrxbY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W8jEr0D_1718693352;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8jEr0D_1718693352)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 14:49:13 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 9/9] erofs-utils: enable mapfile for `--tar=f`
Date: Tue, 18 Jun 2024 14:48:59 +0800
Message-Id: <20240618064859.4117858-9-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240618064859.4117858-1-hsiangkao@linux.alibaba.com>
References: <20240618064859.4117858-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The data offsets in the tar streams can always be looked up now:
    mkfs.erofs --tar=f,MAPFILE IMAGE TARBALL

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/tar.c   |  3 ++-
 mkfs/main.c | 40 ++++++++++++++++++++++++++++------------
 2 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/lib/tar.c b/lib/tar.c
index 8d2caa5..532e566 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -858,7 +858,8 @@ restart:
 			eh.link = strndup(th->linkname, sizeof(th->linkname));
 	}
 
-	if (tar->index_mode && !tar->mapfile &&
+	/* EROFS metadata index referring to the original tar data */
+	if (tar->index_mode && sbi->extra_devices &&
 	    erofs_blkoff(sbi, data_offset)) {
 		erofs_err("invalid tar data alignment @ %llu", tar_offset);
 		ret = -EIO;
diff --git a/mkfs/main.c b/mkfs/main.c
index d6c1980..4a0cd7b 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -423,6 +423,27 @@ static int mkfs_apply_zfeature_bits(uintmax_t bits)
 	return 0;
 }
 
+static void mkfs_parse_tar_cfg(char *cfg)
+{
+	char *p;
+
+	tar_mode = true;
+	if (!cfg)
+		return;
+	p = strchr(cfg, ',');
+	if (p) {
+		*p = '\0';
+		if ((*++p) != '\0')
+			erofstar.mapfile = strdup(p);
+	}
+	if (!strcmp(cfg, "headerball"))
+		erofstar.headeronly_mode = true;
+
+	if (erofstar.headeronly_mode || !strcmp(optarg, "i") ||
+	    !strcmp(optarg, "0"))
+		erofstar.index_mode = true;
+}
+
 static int mkfs_parse_one_compress_alg(char *alg,
 				       struct erofs_compr_opts *copts)
 {
@@ -729,15 +750,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			cfg.c_extra_ea_name_prefixes = true;
 			break;
 		case 20:
-			if (optarg && (!strcmp(optarg, "i") || (!strcmp(optarg, "headerball") ||
-				!strcmp(optarg, "0") || !memcmp(optarg, "0,", 2)))) {
-				erofstar.index_mode = true;
-				if (!memcmp(optarg, "0,", 2))
-					erofstar.mapfile = strdup(optarg + 2);
-				if (!strcmp(optarg, "headerball"))
-					erofstar.headeronly_mode = true;
-			}
-			tar_mode = true;
+			mkfs_parse_tar_cfg(optarg);
 			break;
 		case 21:
 			erofstar.aufs = true;
@@ -1266,10 +1279,13 @@ int main(int argc, char **argv)
 				erofs_err("failed to open %s", erofstar.mapfile);
 				goto exit;
 			}
-		}
-
-		if (erofstar.index_mode)
+		} else if (erofstar.index_mode) {
+			/*
+			 * If mapfile is unspecified for tarfs index mode, 512-byte
+			 * block size is enforced here.
+			 */
 			sbi.blkszbits = 9;
+		}
 	}
 
 	if (rebuild_mode) {
-- 
2.39.3

