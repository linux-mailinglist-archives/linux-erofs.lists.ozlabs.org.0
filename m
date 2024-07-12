Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA34992F814
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Jul 2024 11:38:31 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=n7AkJ84r;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WL63T272hz3cWY
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Jul 2024 19:38:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=n7AkJ84r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WL63M5JxNz30Wm
	for <linux-erofs@lists.ozlabs.org>; Fri, 12 Jul 2024 19:38:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720777096; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=qKLz+VAPGLRH9SJwJFEpG/UzjOcpRCfJr9lWmAMOZkQ=;
	b=n7AkJ84rffg1V8qEUZ3tYpYjVCzJw2x9h7AGUH5YZbvWSwAsGWwxnKmH0SqzMNwshBiRSpEvRXpzDGzhqiuq/se8GyG/Omm1c4714+poZi5vgDVStdlg8tF+xOEQYcoWu18y4RF+nSOfhHsQcKJd3qmcQPbT1StH7WSqcTZAfh4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WANvAj3_1720777094;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WANvAj3_1720777094)
          by smtp.aliyun-inc.com;
          Fri, 12 Jul 2024 17:38:15 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils: mkfs: fix -U option
Date: Fri, 12 Jul 2024 17:38:08 +0800
Message-ID: <20240712093808.2986196-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240712093808.2986196-1-hsiangkao@linux.alibaba.com>
References: <20240712093808.2986196-1-hsiangkao@linux.alibaba.com>
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

`-U <UUID>` option cannot work properly now.

Fixes: 7550a30c332c ("erofs-utils: enable incremental builds")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 mkfs/main.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 37f250b..e25e9d8 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -231,6 +231,8 @@ enum {
 
 static unsigned int rebuild_src_count;
 static LIST_HEAD(rebuild_src_list);
+static u8 fixeduuid[16];
+static bool valid_fixeduuid;
 
 static int erofs_mkfs_feat_set_legacy_compress(bool en, const char *val,
 					       unsigned int vallen)
@@ -606,10 +608,11 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			cfg.c_timeinherit = TIMESTAMP_FIXED;
 			break;
 		case 'U':
-			if (erofs_uuid_parse(optarg, g_sbi.uuid)) {
+			if (erofs_uuid_parse(optarg, fixeduuid)) {
 				erofs_err("invalid UUID %s", optarg);
 				return -EINVAL;
 			}
+			valid_fixeduuid = true;
 			break;
 		case 2:
 			opt = erofs_parse_exclude_path(optarg, false);
@@ -1250,8 +1253,6 @@ int main(int argc, char **argv)
 			err = PTR_ERR(sb_bh);
 			goto exit;
 		}
-		/* generate new UUIDs for clean builds */
-		erofs_uuid_generate(g_sbi.uuid);
 	} else {
 		union {
 			struct stat st;
@@ -1274,6 +1275,12 @@ int main(int argc, char **argv)
 		sb_bh = NULL;
 	}
 
+	/* Use the user-defined UUID or generate one for clean builds */
+	if (valid_fixeduuid)
+		memcpy(g_sbi.uuid, fixeduuid, sizeof(g_sbi.uuid));
+	else if (!incremental_mode)
+		erofs_uuid_generate(g_sbi.uuid);
+
 	if (tar_mode && !erofstar.index_mode) {
 		err = erofs_diskbuf_init(1);
 		if (err) {
-- 
2.43.5

