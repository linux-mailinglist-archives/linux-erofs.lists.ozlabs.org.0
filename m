Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 567F290C4EA
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2024 10:25:38 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PkuBfmGK;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W3KZR0KV3z3cNj
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2024 18:25:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PkuBfmGK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W3KYL64k3z3bjK
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Jun 2024 18:24:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718699076; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=zVbBy0Dy3VHKe8W0wW0W3vNBpT8Z9uS8pekVxgZwUIk=;
	b=PkuBfmGKGTGDuP44k09n9jO7bBgVcqjJx08gCghsm8F+0s5v971vEhoTXGMUYyifla56gy4VZfXy/JNU6f41b5zt5d/KXXVJ66ffQngo50S+RUX6o/faHZvawr5OxsWb92A2bs/tYH70RsxZlQSRD68d5k85wlXdUu08qjKdIb0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W8jcNBw_1718699074;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8jcNBw_1718699074)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 16:24:35 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 09/10] erofs-utils: enable mapfile for `--tar=f`
Date: Tue, 18 Jun 2024 16:24:14 +0800
Message-Id: <20240618082414.47876-9-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240618082414.47876-1-hsiangkao@linux.alibaba.com>
References: <20240618082414.47876-1-hsiangkao@linux.alibaba.com>
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
 mkfs/main.c | 31 ++++++++++++++++++++++---------
 2 files changed, 24 insertions(+), 10 deletions(-)

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
index 6e9120f..5378b23 100644
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
-- 
2.39.3

