Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 040BA56D313
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Jul 2022 04:50:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lh7f43p1zz3bv4
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Jul 2022 12:50:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=59.36.132.74; helo=qq.com; envelope-from=lihe@uniontech.com; receiver=<UNKNOWN>)
X-Greylist: delayed 68 seconds by postgrey-1.36 at boromir; Mon, 11 Jul 2022 12:49:57 AEST
Received: from qq.com (smtpbg474.qq.com [59.36.132.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lh7dx1btNz30LS
	for <linux-erofs@lists.ozlabs.org>; Mon, 11 Jul 2022 12:49:54 +1000 (AEST)
X-QQ-mid: bizesmtp85t1657507638tjpoe34p
Received: from localhost.localdomain ( [61.183.83.60])
	by bizesmtp.qq.com (ESMTP) with SMTP id 0
	for <linux-erofs@lists.ozlabs.org>; Mon, 11 Jul 2022 10:47:17 +0800 (CST)
X-QQ-SSF: 01400000000000P0W000000A0000000
X-QQ-FEAT: FVl8EHhfVR6rDfeQoTxhMmnl1eiBHW3qcQwk9CKuNiY3ZGm0sqEoQVvl6DM3A
	DGlZvyoIaOHWVz9sTOdHCdssbFK9PPlfI74epFPfoUwktL78DE+SrawuuyMCw6YqBliWRu0
	QOKM0DTtqATgWs+AmjnlAuuHH2P/OES2O2YyIE3il65J57xOEwdNdkdw7qBeJpm020E+PsH
	FHy9uZo5G+qmeD6VP2P3wpqqP8dkwJBPZQZ1zg5nnUm/4xg5H+omJEBh9bofDq359mP3gAo
	Cox+AWFYI5LEMDaJW7pMg+tG4eryPnZ/9rqEMEqSEIwEzHquI+mmBZL6bL+C9uiGvnxb+LT
	aeOJ2G7CodHOmH5Be3u/jMsvM4bVeBrY8s844nPp8+OHhHHZDVboQsGMN929a7M64y2cWYV
X-QQ-GoodBg: 2
From: Li He <lihe@uniontech.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fuse: support offset when read image
Date: Mon, 11 Jul 2022 10:47:17 +0800
Message-Id: <20220711024717.5554-1-lihe@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign10
X-QQ-Bgrelay: 1
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add --offset to erofsfuse to skip bytes at the start of the image file.

Signed-off-by: Li He <lihe@uniontech.com>
---
 fuse/main.c            | 6 ++++++
 include/erofs/config.h | 3 +++
 lib/io.c               | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/fuse/main.c b/fuse/main.c
index f4c2476..a2a6449 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -151,6 +151,7 @@ static struct fuse_operations erofs_ops = {
 static struct options {
 	const char *disk;
 	const char *mountpoint;
+	u64 offset;
 	unsigned int debug_lvl;
 	bool show_help;
 	bool odebug;
@@ -158,6 +159,7 @@ static struct options {
 
 #define OPTION(t, p) { t, offsetof(struct options, p), 1 }
 static const struct fuse_opt option_spec[] = {
+	OPTION("--offset=%lu", offset),
 	OPTION("--dbglevel=%u", debug_lvl),
 	OPTION("--help", show_help),
 	FUSE_OPT_KEY("--device=", 1),
@@ -170,6 +172,7 @@ static void usage(void)
 
 	fputs("usage: [options] IMAGE MOUNTPOINT\n\n"
 	      "Options:\n"
+	      "    --offset=#             # bytes to skip when read IMAGE\n"
 	      "    --dbglevel=#           set output message level to # (maximum 9)\n"
 	      "    --device=#             specify an extra device to be used together\n"
 #if FUSE_MAJOR_VERSION < 3
@@ -190,6 +193,7 @@ static void usage(void)
 static void erofsfuse_dumpcfg(void)
 {
 	erofs_dump("disk: %s\n", fusecfg.disk);
+	erofs_dump("offset: %lu\n", fusecfg.offset);
 	erofs_dump("mountpoint: %s\n", fusecfg.mountpoint);
 	erofs_dump("dbglevel: %u\n", cfg.c_dbg_lvl);
 }
@@ -279,6 +283,8 @@ int main(int argc, char *argv[])
 	if (fusecfg.odebug && cfg.c_dbg_lvl < EROFS_DBG)
 		cfg.c_dbg_lvl = EROFS_DBG;
 
+	cfg.c_offset = fusecfg.offset;
+
 	erofsfuse_dumpcfg();
 	ret = dev_open_ro(fusecfg.disk);
 	if (ret) {
diff --git a/include/erofs/config.h b/include/erofs/config.h
index 0d0916c..8b6f7db 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -73,6 +73,9 @@ struct erofs_configure {
 	char *fs_config_file;
 	char *block_list_file;
 #endif
+
+	/* offset when read mutli partiton image */
+	u64 c_offset;
 };
 
 extern struct erofs_configure cfg;
diff --git a/lib/io.c b/lib/io.c
index 9c663c5..524cfb4 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -261,6 +261,8 @@ int dev_read(int device_id, void *buf, u64 offset, size_t len)
 	if (cfg.c_dry_run)
 		return 0;
 
+	offset += cfg.c_offset;
+
 	if (!buf) {
 		erofs_err("buf is NULL");
 		return -EINVAL;
-- 
2.20.1



