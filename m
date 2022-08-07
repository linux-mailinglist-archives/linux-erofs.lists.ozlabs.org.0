Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4F258BA2B
	for <lists+linux-erofs@lfdr.de>; Sun,  7 Aug 2022 10:09:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M0sSP1rxLz2ywr
	for <lists+linux-erofs@lfdr.de>; Sun,  7 Aug 2022 18:09:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=WoKE+Od1;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=shengyong2021@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=WoKE+Od1;
	dkim-atps=neutral
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M0sSF5c4hz2xG8
	for <linux-erofs@lists.ozlabs.org>; Sun,  7 Aug 2022 18:09:31 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id a8so6265219pjg.5
        for <linux-erofs@lists.ozlabs.org>; Sun, 07 Aug 2022 01:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rFNFpCv8qEIb59gaM9izyLENPIXIE8WXoFXAmEYhHQw=;
        b=WoKE+Od1l8w/komFItnzxUBwhngb7QcY9IOeXhgHH2iDaX+R1mzHEPIn4iV508j2ET
         gTGnm50MyoDA/CrNpWbbdao6fQHg6NrJENILQ5NmGL+exqBdoDRW+fAXPkQdzYuc5N4q
         2OEiN4bU/1ks/XA8iZJOhScWkrDOt6gjCyP3Fvr2Vq9jnbpXQB2HFvnSXRr5/IQzgS04
         nqe4VYdvB9TEd3VwTeUFlKxb2oFxs97G0s2yeZIgBY4O3Wr6XV4iILExTU1XbHmN7le8
         3b16Y6gvda/i8fbcl1lQ1OSAeSDmwXwNIPX/7fD5ae1IR7RKhrupijbLEt+0gQI9fVH7
         HLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rFNFpCv8qEIb59gaM9izyLENPIXIE8WXoFXAmEYhHQw=;
        b=LuP/qYZTvf1lO9alLNxFF3LussTKjpBPqFklZuZmPKBkvKVpRs/p+NRcn9f2UlsXkt
         LgwBXKJOZ6gX+jw4stM6Lms0GlU8lrEAJ1NQHlZ9VmNNkLIujdkHomEGnY/HPfNWpi2p
         hjFz6NvpHFQm0AL8AYco5cVK6kTkmFkUaO76v+pRTvsrKRR9ul+MyEC+wtZorQE/ALap
         ZSOYo5G+rHBUelHdXtpYahEyb4n08eCB1S/dHzo4PA640oiA4jyw42nXpkygIIOvx0dh
         8RwslB/0K0CmwbRlsEZ+gG6uZRWVcfoTzowt+ImcTceAl5x/oACwl+oqwSZdcGTW6TAb
         ah9g==
X-Gm-Message-State: ACgBeo3axGhrgiMC1m+Nc5MBWEoLTKLTB80VnBdMCQKn7jIZT4falSY5
	etFunetdIVucvooVSampGVQ=
X-Google-Smtp-Source: AA6agR5Se6SqdnvH2U0NcYr6AlCEUuaFFr323y61XgivBuUTdd3uNUQH9PRk3GK0B0S0cEFMb+bDYQ==
X-Received: by 2002:a17:902:db12:b0:16e:eaf9:e98d with SMTP id m18-20020a170902db1200b0016eeaf9e98dmr13900899plx.172.1659859767539;
        Sun, 07 Aug 2022 01:09:27 -0700 (PDT)
Received: from localhost.localdomain ([129.227.150.231])
        by smtp.gmail.com with ESMTPSA id m10-20020a65564a000000b0041a6638b357sm4185532pgs.72.2022.08.07.01.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 01:09:26 -0700 (PDT)
From: Sheng Yong <shengyong2021@gmail.com>
X-Google-Original-From: Sheng Yong <shengyong@oppo.com>
To: xiang@kernel.org,
	bluce.lee@aliyun.com,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: fuse: set d_type for readdir
Date: Sun,  7 Aug 2022 16:08:35 +0800
Message-Id: <20220807080835.4160209-1-shengyong@oppo.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <d783aec4-4d1c-46d8-202e-27ae5fe3cc72@oppo.com>
References: <d783aec4-4d1c-46d8-202e-27ae5fe3cc72@oppo.com>
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
Cc: shengyong@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Sheng Yong <shengyong@oppo.com>

Set inode mode for libfuse readdir filler so that readdir count get
correct d_type.

Signed-off-by: Sheng Yong <shengyong@oppo.com>
---
 fuse/main.c           |  5 ++++-
 include/erofs/inode.h |  1 +
 lib/inode.c           | 19 +++++++++++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/fuse/main.c b/fuse/main.c
index 95f939e..345bcb5 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -13,6 +13,7 @@
 #include "erofs/print.h"
 #include "erofs/io.h"
 #include "erofs/dir.h"
+#include "erofs/inode.h"
 
 struct erofsfuse_dir_context {
 	struct erofs_dir_context ctx;
@@ -24,11 +25,13 @@ struct erofsfuse_dir_context {
 static int erofsfuse_fill_dentries(struct erofs_dir_context *ctx)
 {
 	struct erofsfuse_dir_context *fusectx = (void *)ctx;
+	struct stat st = {0};
 	char dname[EROFS_NAME_LEN + 1];
 
 	strncpy(dname, ctx->dname, ctx->de_namelen);
 	dname[ctx->de_namelen] = '\0';
-	fusectx->filler(fusectx->buf, dname, NULL, 0);
+	st.st_mode = erofs_ftype_to_dtype(ctx->de_ftype) << 12;
+	fusectx->filler(fusectx->buf, dname, &st, 0);
 	return 0;
 }
 
diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index 79b39b0..79b8d89 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -16,6 +16,7 @@ extern "C"
 #include "erofs/internal.h"
 
 unsigned char erofs_mode_to_ftype(umode_t mode);
+unsigned char erofs_ftype_to_dtype(unsigned int filetype);
 void erofs_inode_manager_init(void);
 unsigned int erofs_iput(struct erofs_inode *inode);
 erofs_nid_t erofs_lookupnid(struct erofs_inode *inode);
diff --git a/lib/inode.c b/lib/inode.c
index f192510..ce75014 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -43,6 +43,25 @@ unsigned char erofs_mode_to_ftype(umode_t mode)
 	return erofs_ftype_by_mode[(mode & S_IFMT) >> S_SHIFT];
 }
 
+static const unsigned char erofs_dtype_by_ftype[EROFS_FT_MAX] = {
+	[EROFS_FT_UNKNOWN]	= DT_UNKNOWN,
+	[EROFS_FT_REG_FILE]	= DT_REG,
+	[EROFS_FT_DIR]		= DT_DIR,
+	[EROFS_FT_CHRDEV]	= DT_CHR,
+	[EROFS_FT_BLKDEV]	= DT_BLK,
+	[EROFS_FT_FIFO]		= DT_FIFO,
+	[EROFS_FT_SOCK]		= DT_SOCK,
+	[EROFS_FT_SYMLINK]	= DT_LNK
+};
+
+unsigned char erofs_ftype_to_dtype(unsigned int filetype)
+{
+	if (filetype >= EROFS_FT_MAX)
+		return DT_UNKNOWN;
+
+	return erofs_dtype_by_ftype[filetype];
+}
+
 #define NR_INODE_HASHTABLE	16384
 
 struct list_head inode_hashtable[NR_INODE_HASHTABLE];
-- 
2.25.1

