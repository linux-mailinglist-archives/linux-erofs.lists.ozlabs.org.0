Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B4C3BAD1E
	for <lists+linux-erofs@lfdr.de>; Sun,  4 Jul 2021 15:34:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GHqXk4ssBz2yXj
	for <lists+linux-erofs@lfdr.de>; Sun,  4 Jul 2021 23:33:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44;
 helo=out30-44.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GHqXd59lqz2yMp
 for <linux-erofs@lists.ozlabs.org>; Sun,  4 Jul 2021 23:33:51 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0UeeMY2m_1625405608; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UeeMY2m_1625405608) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 04 Jul 2021 21:33:42 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: add "noinline_data" extended option
Date: Sun,  4 Jul 2021 21:33:27 +0800
Message-Id: <20210704133327.32151-1-hsiangkao@linux.alibaba.com>
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In order to add preliminary DAX feature support.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/config.h | 1 +
 lib/inode.c            | 5 +++++
 mkfs/main.c            | 6 ++++++
 3 files changed, 12 insertions(+)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 67e7a0fed24c..8124f3b36baf 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -44,6 +44,7 @@ struct erofs_configure {
 	bool c_random_pclusterblks;
 #endif
 	char c_timeinherit;
+	bool c_noinline_data;
 
 #ifdef HAVE_LIBSELINUX
 	struct selabel_handle *sehnd;
diff --git a/lib/inode.c b/lib/inode.c
index 97f0cf763baf..38906370f533 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -562,6 +562,11 @@ static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 	if (is_inode_layout_compression(inode))
 		goto noinline;
 
+	if (cfg.c_noinline_data && S_ISREG(inode->i_mode)) {
+		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
+		goto noinline;
+	}
+
 	/*
 	 * if the file size is block-aligned for uncompressed files,
 	 * should use EROFS_INODE_FLAT_PLAIN data mapping mode.
diff --git a/mkfs/main.c b/mkfs/main.c
index 28539da5ea5f..10fe14d7a722 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -161,6 +161,12 @@ static int parse_extended_opts(const char *opts)
 				return -EINVAL;
 			erofs_sb_clear_sb_chksum();
 		}
+
+		if (MATCH_EXTENTED_OPT("noinline_data", token, keylen)) {
+			if (vallen)
+				return -EINVAL;
+			cfg.c_noinline_data = true;
+		}
 	}
 	return 0;
 }
-- 
2.24.4

