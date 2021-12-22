Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEA947CB24
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Dec 2021 02:54:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JJbwn0TlHz2ynj
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Dec 2021 12:54:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1640138073;
	bh=ZvCagmNj5YmpRpm1UXxkqvpXYCH/HzF5NFnNUDq9dI0=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=lCc8e7bTniRtwSLY0GjeaFRiMs/97wtdgcab/C7ne8HbTeM1UIuiPHmTMvIVBWjtm
	 QhGvSMIw7I0FgU3AP+qNXX5kqXnsJ7i4vXzVU/B6Ttp50LQQfNKIN+1AukX+yQcntO
	 5m7dH6+ApjNTRf6s2H/pjAQvpHSZKirGTfMytQq24c9Wfa1wRDEbLLaGan/k+FWo61
	 Hv+4OXiTg3PlPQrUemdVaC+ti7egxey09KMxSGoDOCeAi7RpAenYEeKrdxe994WNjc
	 zYlSJsZjOSFx9Wc5ikQJUCt0tuxZxrvfXZ+HupYJucKVwQHF4TSlU7jYJHVUNK5kSl
	 xXcDu/YChJedA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--zhangkelvin.bounces.google.com
 (client-ip=2607:f8b0:4864:20::b4a; helo=mail-yb1-xb4a.google.com;
 envelope-from=3uoxcyqskc3sygzmfjdkuhmfnnfkd.bnlkhmtw-dqnerkhrsr.nykzar.nqf@flex--zhangkelvin.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=PKXNBmQn; dkim-atps=neutral
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JJbwh74kZz2x9g
 for <linux-erofs@lists.ozlabs.org>; Wed, 22 Dec 2021 12:54:28 +1100 (AEDT)
Received: by mail-yb1-xb4a.google.com with SMTP id
 y125-20020a25dc83000000b005c2326bf744so1248550ybe.21
 for <linux-erofs@lists.ozlabs.org>; Tue, 21 Dec 2021 17:54:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=ZvCagmNj5YmpRpm1UXxkqvpXYCH/HzF5NFnNUDq9dI0=;
 b=Q7jboBE2+U49qyMym823xJFKE4UwGF4Ax/hVyIymIpjkXJcp9QSF8wevdBoL98wxpp
 ymcWEddbj3z5/nP2rgih49wASXUdrx1oiSWnnMUh5S58YBGczjY7aAviWvTaOHXmTcD4
 yTiEBrTxrAV1apSyN6EGHS5qwIXlOdSJveR+PmIkJUBUEtIsO9JoFj21M2yY2wKV44xq
 ZHzABPsdfZcohZAgBRShd4c33UwdhB1jRsV90s/s+oDnDUAzVF9lS4aU1eafgIrja53N
 GeOIkXlJb0vc1Lr/pAa8DqYV/Zgpv7qfpHR4LmzjBllWIvtlCn9oUvvEgXZmg5+xvfjI
 DBQg==
X-Gm-Message-State: AOAM5324baVrYfkSgC+81/5IRzrVbFDbKdq0u8cN7X8ABTIOC9GkWWiN
 BTvXRawRDLRpPYllltkwoBXiYqaZUxG2APlVySP++owJWJuUG72FbLu7UrDTkPyIAOQ8qxBqx/K
 bKWw33TuMIGAkSUbQNc2zAA6hM8SC96MgxxMHg/Qrm12O968tPVRTTvhZsjfWSorsUQVkGZHu5n
 deGEM5iE0=
X-Google-Smtp-Source: ABdhPJxfKC5qYGSY36Ikcb6Xia8bJukUW0O3DiPLYOKQ8te+xaiNVWoiPtihzo0GHir5hWCNPpSSOQXtV6QkUc82UA==
X-Received: from zhangkelvin-big.c.googlers.com
 ([fda3:e722:ac3:cc00:14:4d90:c0a8:1f4a])
 (user=zhangkelvin job=sendgmr) by 2002:a25:d157:: with SMTP id
 i84mr1410088ybg.703.1640138066333; Tue, 21 Dec 2021 17:54:26 -0800 (PST)
Date: Tue, 21 Dec 2021 17:54:19 -0800
In-Reply-To: <20211222015419.268586-1-zhangkelvin@google.com>
Message-Id: <20211222015419.268586-2-zhangkelvin@google.com>
Mime-Version: 1.0
References: <YcKEafQ+nJJ/xQYZ@B-P7TQMD6M-0146.local>
 <20211222015419.268586-1-zhangkelvin@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 2/2] erofs-utils: lib: Add API to get on disk size of an
 inode
To: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
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
From: Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Kelvin Zhang <zhangkelvin@google.com>
Cc: Kelvin Zhang <zhangkelvin@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Marginally improve code re-use. It's quite common for users to query for
compressed size of an inode.

Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
---
 dump/main.c              |  4 ++--
 include/erofs/internal.h | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 71b44b4..4c2c513 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -175,7 +175,7 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
 	return 0;
 }
 
-static int erofs_get_occupied_size(struct erofs_inode *inode,
+static int erofsdump_get_occupied_size(struct erofs_inode *inode,
 		erofs_off_t *size)
 {
 	*size = 0;
@@ -291,7 +291,7 @@ static int erofs_read_dirent(struct erofs_dirent *de,
 		return err;
 	}
 
-	err = erofs_get_occupied_size(&inode, &occupied_size);
+	err = erofsdump_get_occupied_size(&inode, &occupied_size);
 	if (err) {
 		erofs_err("get file size failed\n");
 		return err;
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 947304f..c64cf36 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -19,6 +19,7 @@ typedef unsigned short umode_t;
 
 #define __packed __attribute__((__packed__))
 
+#include "erofs/print.h"
 #include "erofs_fs.h"
 #include <fcntl.h>
 
@@ -320,6 +321,28 @@ int erofs_pread(struct erofs_inode *inode, char *buf,
 int erofs_map_blocks(struct erofs_inode *inode,
 		struct erofs_map_blocks *map, int flags);
 int erofs_map_dev(struct erofs_sb_info *sbi, struct erofs_map_dev *map);
+
+static inline int erofs_get_occupied_size(const struct erofs_inode *inode,
+					  erofs_off_t *size)
+{
+	*size = 0;
+	switch (inode->datalayout) {
+	case EROFS_INODE_FLAT_INLINE:
+	case EROFS_INODE_FLAT_PLAIN:
+	case EROFS_INODE_CHUNK_BASED:
+		*size = inode->i_size;
+		break;
+	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
+	case EROFS_INODE_FLAT_COMPRESSION:
+		*size = inode->u.i_blocks * EROFS_BLKSIZ;
+		break;
+	default:
+		erofs_err("unknown datalayout");
+		return -1;
+	}
+	return 0;
+}
+
 /* zmap.c */
 int z_erofs_fill_inode(struct erofs_inode *vi);
 int z_erofs_map_blocks_iter(struct erofs_inode *vi,
-- 
2.34.1.448.ga2b2bfdf31-goog

