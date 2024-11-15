Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7D29CDAFB
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Nov 2024 09:56:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XqW8w1YDMz30VZ
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Nov 2024 19:56:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731660990;
	cv=none; b=DRjv+PKihbz8GN68ayro3C6hJVkYXQ2N+y1k1Zw3cRsx4n+mtLo9qD07AboqIG3zN/wyQTDACYW99aLbjm/1vPVkhphA5LA/35ZrqY4NWgBWW1LXCSbLBt8WzlL4P3vUOmoFYlT5R1BJGzHd7JA6D6W4G/wIDr5rdvjYXgdIqehaqOd96J4Z+LaGindm76pLHVy8OK2nhEQ2zhyo+KBoOswEjrYQSYINh2JVc8tvogc37hePZydDNVTqOKwfIFXyyMQRRGWhA1yVXBEROQkEGvx4PZ9jXRMEn1vVJfhgi50fc6xsDB0aTNZOJeRdhK+jbWPVGQhdPvuyuVQTyp263w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731660990; c=relaxed/relaxed;
	bh=qhuNIe7GctcjaF7YhUU22U4ZtGXEt2Yn6iupOXsNEqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TrGMJN1TqE9vX58xAXf7h/4XnjI0iAtRP9QbyJuN8rR30VI2f8ny4q3D13Ifp+UZ1hWsua6GqMUImZofB+yWgzsvpVBnHlo1HIhCuxA7VGBhOC3lVGLoIn7XEVm8dpfudqzZFciI2zHoQpsTKZCTfSANs1ckdLoe6QrzAwrX+XyphYXRgSSFjFfmY6jIGjN6Fky2TVh0n0OtrYz+kQh3uncwOgv+0th0nn9ewk91llG5rosich/RcR5Yne4deUJ16cNRrKI6y9zBEcqkYoOaRV1iRUlTBKF5WjSCKVoioGgjLfbDdub8/TjffS5imdBahTXv7uymtNVLyf9i5aIW5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bhG6LaTb; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bhG6LaTb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XqW8p535Jz2yDm
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Nov 2024 19:56:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731660978; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=qhuNIe7GctcjaF7YhUU22U4ZtGXEt2Yn6iupOXsNEqk=;
	b=bhG6LaTbCsgiIleZoVnu/FEHfQT8VWJeJ071OPCALD8Pi4iWp1W4kUvHq6s/kISC4P/JrJiwP/I+EwCSkBS9eI8mn/xZTDXz02j9ePLeF0J6T1nxQhzlRJCaIXlzRBfu7cj02LvMW1EAuG632C0ZxYbfjwW9B4w814RT2QJWRlY=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJT8Ado_1731660971 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 Nov 2024 16:56:16 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: support data alignment
Date: Fri, 15 Nov 2024 16:56:08 +0800
Message-ID: <20241115085608.2635901-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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

The underlay block storage could work in a stripe-like manner to improve
performance and space efficiency.

EROFS on-disk layout is flexible enough for such use cases.

Cc: Changpeng Liu <changpeliu@tencent.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/cache.h |  3 +++
 lib/cache.c           |  2 ++
 man/mkfs.erofs.1      |  3 +++
 mkfs/main.c           | 11 +++++++++++
 4 files changed, 19 insertions(+)

diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index 5411eed..bd32602 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -64,6 +64,9 @@ struct erofs_bufmgr {
 
 	/* last mapped buffer block to accelerate erofs_mapbh() */
 	struct erofs_buffer_block *last_mapped_block;
+
+	/* align data block addresses to multiples of `dsunit` */
+	unsigned int dsunit;
 };
 
 static inline const int get_alignsize(struct erofs_sb_info *sbi, int type,
diff --git a/lib/cache.c b/lib/cache.c
index 3208e9f..b782f25 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -330,6 +330,8 @@ static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
 
 	if (bb->blkaddr == NULL_ADDR) {
 		bb->blkaddr = bmgr->tail_blkaddr;
+		if (__erofs_unlikely(bmgr->dsunit) && bb->type == DATA)
+			bb->blkaddr = roundup(bb->blkaddr, bmgr->dsunit);
 		bmgr->last_mapped_block = bb;
 		erofs_bupdate_mapped(bb);
 	}
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index abdd9b9..e7da588 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -138,6 +138,9 @@ the given primary algorithm, alternative algorithms can be specified with
 are extended regular expressions, matched against absolute paths within
 the output filesystem, with no leading /.
 .TP
+.BI "\-\-dsunit=" #
+Align all data block addresses to multiples of #.
+.TP
 .BI "\-\-exclude-path=" path
 Ignore file that matches the exact literal path.
 You may give multiple
diff --git a/mkfs/main.c b/mkfs/main.c
index d422787..c92f408 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -85,6 +85,7 @@ static struct option long_options[] = {
 	{"mkfs-time", no_argument, NULL, 525},
 	{"all-time", no_argument, NULL, 526},
 	{"sort", required_argument, NULL, 527},
+	{"dsunit", required_argument, NULL, 528},
 	{0, 0, 0, 0},
 };
 
@@ -161,6 +162,7 @@ static void usage(int argc, char **argv)
 		" --blobdev=X           specify an extra device X to store chunked data\n"
 		" --chunksize=#         generate chunk-based files with #-byte chunks\n"
 		" --clean=X             run full clean build (default) or:\n"
+		" --dsunit=#            align all data block addresses to multiples of #\n"
 		" --incremental=X       run incremental build\n"
 		"                       (X = data|rvsp; data=full data, rvsp=space is allocated\n"
 		"                                       and filled with zeroes)\n"
@@ -241,6 +243,7 @@ static unsigned int rebuild_src_count;
 static LIST_HEAD(rebuild_src_list);
 static u8 fixeduuid[16];
 static bool valid_fixeduuid;
+static unsigned int dsunit;
 
 static int erofs_mkfs_feat_set_legacy_compress(bool en, const char *val,
 					       unsigned int vallen)
@@ -846,6 +849,13 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			if (!strcmp(optarg, "none"))
 				erofstar.try_no_reorder = true;
 			break;
+		case 528:
+			dsunit = strtoul(optarg, &endptr, 0);
+			if (*endptr != '\0') {
+				erofs_err("invalid dsunit %s", optarg);
+				return -EINVAL;
+			}
+			break;
 		case 'V':
 			version();
 			exit(0);
@@ -1308,6 +1318,7 @@ int main(int argc, char **argv)
 		}
 		sb_bh = NULL;
 	}
+	g_sbi.bmgr->dsunit = dsunit;
 
 	/* Use the user-defined UUID or generate one for clean builds */
 	if (valid_fixeduuid)
-- 
2.43.5

