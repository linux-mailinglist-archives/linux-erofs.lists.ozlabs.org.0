Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D780682754
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Jan 2023 09:48:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P5dxM0qqFz3cL1
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Jan 2023 19:48:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.1; helo=out30-1.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-1.freemail.mail.aliyun.com (out30-1.freemail.mail.aliyun.com [115.124.30.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P5dxG1Sjmz2yXL
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 Jan 2023 19:48:17 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VaW3D.8_1675154887;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VaW3D.8_1675154887)
          by smtp.aliyun-inc.com;
          Tue, 31 Jan 2023 16:48:12 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fuse: fix warnings on MacOS
Date: Tue, 31 Jan 2023 16:48:05 +0800
Message-Id: <20230131084805.2494-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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

Reported by the latest nightly build:
https://github.com/erofs/erofsnightly/actions/runs/4050082667/jobs/6969376259

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fuse/main.c  | 9 +++++++--
 lib/config.c | 3 ++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fuse/main.c b/fuse/main.c
index f1d1b47..e6af890 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -143,7 +143,12 @@ static int erofsfuse_readlink(const char *path, char *buffer, size_t size)
 }
 
 static int erofsfuse_getxattr(const char *path, const char *name, char *value,
-			size_t size)
+			size_t size
+#ifdef __APPLE__
+			, uint32_t position)
+#else
+			)
+#endif
 {
 	int ret;
 	struct erofs_inode vi;
@@ -227,7 +232,7 @@ static void usage(void)
 static void erofsfuse_dumpcfg(void)
 {
 	erofs_dump("disk: %s\n", fusecfg.disk);
-	erofs_dump("offset: %lu\n", fusecfg.offset);
+	erofs_dump("offset: %llu\n", fusecfg.offset | 0ULL);
 	erofs_dump("mountpoint: %s\n", fusecfg.mountpoint);
 	erofs_dump("dbglevel: %u\n", cfg.c_dbg_lvl);
 }
diff --git a/lib/config.c b/lib/config.c
index 3963df2..20200be 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -100,10 +100,11 @@ static bool __erofs_is_progressmsg;
 
 char *erofs_trim_for_progressinfo(const char *str, int placeholder)
 {
-	struct winsize winsize;
 	int col, len;
 
 #ifdef GWINSZ_IN_SYS_IOCTL
+	struct winsize winsize;
+
 	if(ioctl(1, TIOCGWINSZ, &winsize) >= 0 &&
 	   winsize.ws_col > 0)
 		col = winsize.ws_col;
-- 
2.24.4

