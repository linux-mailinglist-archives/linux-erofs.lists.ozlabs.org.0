Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 911AC28F383
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Oct 2020 15:41:27 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CBr6D5np3zDqVq
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Oct 2020 00:41:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1042;
 helo=mail-pj1-x1042.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=QuzOxx96; dkim-atps=neutral
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20::1042])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CBr542d4SzDqLK
 for <linux-erofs@lists.ozlabs.org>; Fri, 16 Oct 2020 00:40:24 +1100 (AEDT)
Received: by mail-pj1-x1042.google.com with SMTP id h4so2090572pjk.0
 for <linux-erofs@lists.ozlabs.org>; Thu, 15 Oct 2020 06:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8/lG02vwERg5HB+UB4k/TPmv/LpbMaSgueRaEQshPYU=;
 b=QuzOxx96y/YgCeb11xZGqn99A9uhuNg02ogIu6KE/P29u+IXDl6QyBsNKdrSeRusP9
 tk/+9Hll32bo+mhkOPFw6jD7ZgVJfeJOKPVRuuPFgvQRYjx8xNkRIDp8dB6FlRp5X/HW
 jGJPctGifPXFC3+oF0h4JtuHJOOsq3Hxc0mc+n6pQW2PaABuB59tdapymFDOAlmD2QPK
 1qfoRLjsoUT6FtTTVzAqMSb/udVXPsutdA84qH03TuDwpjhm2dffBqFGB/xVNG2CIRvQ
 OB7wvUYkKNVCL+XtwWbM5yg5vYtcJQPsxow0vJHObsiPu9cP5dqhgzoc/2dWxxqaJOa7
 tRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8/lG02vwERg5HB+UB4k/TPmv/LpbMaSgueRaEQshPYU=;
 b=pLloJ98a8goTOYtifhpMpLZ4dwtRek+74uEsXn4DpxobCjTQptQEhVb+li2k9Y10m4
 q4Qs3o9fHpUAAUsvFD0qpQJDM/Lhw7tTwmBwLiicLmdvFiOkY0F5NM52eA4eshJplozu
 6sEA0klCYpVHsvR4M8ZNbd3jY45ijMnKRBvwxy+RhBEkEfX2cBrrSQTPxuv6YO2yeuZ6
 bjvbcSQZxmi0X+EvOLT6NZOIUTCd2MGxt7ekyoNIE2wIGOhaXYLZ+v2vJNon41SOOtRG
 74tXrma4G7llpz6dcRXaT8urAyLO2DqcUt+JoriPGFvhfzBqHGwQmMv3ql89UI188U6q
 qUrw==
X-Gm-Message-State: AOAM533VzgCC/eF9CLSWjDA5mF3P4peHBba228rnWhjA2p5Xg9CuTALS
 EvB5meTYQ9wZ+ArmffCynzGwpjOo0ZElrbKr
X-Google-Smtp-Source: ABdhPJzLcj09kcWo1dHhI8cC+dQ4xyefykikfnDGnoI6Od04xqrmxXdpVhV2hNzbBNwG182aG7EWAQ==
X-Received: by 2002:a17:90b:4a10:: with SMTP id
 kk16mr4505485pjb.77.1602769221198; 
 Thu, 15 Oct 2020 06:40:21 -0700 (PDT)
Received: from localhost.localdomain (69-172-89-151.static.imsbiz.com.
 [69.172.89.151])
 by smtp.gmail.com with ESMTPSA id a19sm3426058pjq.29.2020.10.15.06.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 06:40:20 -0700 (PDT)
From: Huang Jianan <jnhuang95@gmail.com>
X-Google-Original-From: Huang Jianan <huangjianan@oppo.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 4/5] erofs-utils: support read special file
Date: Thu, 15 Oct 2020 21:39:58 +0800
Message-Id: <20201015133959.61007-4-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201015133959.61007-1-huangjianan@oppo.com>
References: <20201015133959.61007-1-huangjianan@oppo.com>
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
Cc: guoweichao@oppo.com, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
---
 fuse/getattr.c           |  1 +
 fuse/main.c              |  1 +
 fuse/namei.c             | 14 ++++++++++----
 fuse/read.c              | 26 ++++++++++++++++++++++++++
 fuse/read.h              |  1 +
 include/erofs/internal.h |  1 +
 6 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/fuse/getattr.c b/fuse/getattr.c
index 542cf35..d2134f4 100644
--- a/fuse/getattr.c
+++ b/fuse/getattr.c
@@ -56,6 +56,7 @@ int erofs_getattr(const char *path, struct stat *stbuf)
 	stbuf->st_blocks = stbuf->st_size / EROFS_BLKSIZ;
 	stbuf->st_uid = le16_to_cpu(v.i_uid);
 	stbuf->st_gid = le16_to_cpu(v.i_gid);
+	stbuf->st_rdev = le32_to_cpu(v.i_rdev);
 	stbuf->st_atime = super.build_time;
 	stbuf->st_mtime = super.build_time;
 	stbuf->st_ctime = super.build_time;
diff --git a/fuse/main.c b/fuse/main.c
index fa9795e..8841013 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -113,6 +113,7 @@ static void signal_handle_sigsegv(int signal)
 }
 
 static struct fuse_operations erofs_ops = {
+	.readlink = erofs_readlink,
 	.getattr = erofs_getattr,
 	.readdir = erofs_readdir,
 	.open = erofs_open,
diff --git a/fuse/namei.c b/fuse/namei.c
index 3503a8d..7ed1168 100644
--- a/fuse/namei.c
+++ b/fuse/namei.c
@@ -11,6 +11,7 @@
 #include <stdio.h>
 #include <errno.h>
 #include <sys/stat.h>
+#include <sys/sysmacros.h>
 
 #include "erofs/defs.h"
 #include "logging.h"
@@ -39,6 +40,13 @@ static uint8_t get_path_token_len(const char *path)
 	return len;
 }
 
+static inline dev_t new_decode_dev(u32 dev)
+{
+	unsigned major = (dev & 0xfff00) >> 8;
+	unsigned minor = (dev & 0xff) | ((dev >> 12) & 0xfff00);
+	return makedev(major, minor);
+}
+
 int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *vi)
 {
 	int ret;
@@ -65,13 +73,11 @@ int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *vi)
 	switch (vi->i_mode & S_IFMT) {
 	case S_IFBLK:
 	case S_IFCHR:
-		/* fixme: add special devices support
-		 * vi->i_rdev = new_decode_dev(le32_to_cpu(v1->i_u.rdev));
-		 */
+		vi->i_rdev = new_decode_dev(le32_to_cpu(v1->i_u.rdev));
 		break;
 	case S_IFIFO:
 	case S_IFSOCK:
-		/*fixme: vi->i_rdev = 0; */
+		vi->i_rdev = 0;
 		break;
 	case S_IFREG:
 	case S_IFLNK:
diff --git a/fuse/read.c b/fuse/read.c
index ffe976e..3ce5c4f 100644
--- a/fuse/read.c
+++ b/fuse/read.c
@@ -112,3 +112,29 @@ int erofs_read(const char *path, char *buffer, size_t size, off_t offset,
 		return -EINVAL;
 	}
 }
+
+int erofs_readlink(const char *path, char *buffer, size_t size)
+{
+	int ret;
+	erofs_nid_t nid;
+	size_t lnksz;
+	struct erofs_vnode v;
+
+	ret = walk_path(path, &nid);
+	if (ret)
+		return ret;
+
+	ret = erofs_iget_by_nid(nid, &v);
+	if (ret)
+		return ret;
+
+	lnksz = min((size_t)v.i_size, size - 1);
+
+	ret = erofs_read(path, buffer, lnksz, 0, NULL);
+	buffer[lnksz] = '\0';
+	if (ret != (int)lnksz)
+		return ret;
+
+	logi("path:%s link=%s size=%llu", path, buffer, lnksz);
+	return 0;
+}
\ No newline at end of file
diff --git a/fuse/read.h b/fuse/read.h
index f2fcebe..89d4b4c 100644
--- a/fuse/read.h
+++ b/fuse/read.h
@@ -12,5 +12,6 @@
 
 int erofs_read(const char *path, char *buffer, size_t size, off_t offset,
 	    struct fuse_file_info *fi);
+int erofs_readlink(const char *path, char *buffer, size_t size);
 
 #endif
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index cba3ce4..47ad96d 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -153,6 +153,7 @@ struct erofs_vnode {
 	uint16_t i_uid;
 	uint16_t i_gid;
 	uint16_t i_nlink;
+	uint32_t i_rdev;
 
 	/* if file is inline read inline data witch inode */
 	char *idata;
-- 
2.25.1

