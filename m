Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAD52E3617
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Dec 2020 11:52:46 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D4DsS2K5vzDqCD
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Dec 2020 21:52:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=ebKF+CDm; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ebKF+CDm; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D4DsP3dLvzDqBv
 for <linux-erofs@lists.ozlabs.org>; Mon, 28 Dec 2020 21:52:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609152756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rw3pdru7uk8E36R1wS+u3mV1r9XMv9mOcib8uhk/uwg=;
 b=ebKF+CDmhAtqPV7ZT5hErqMbj41JFB/dQZvDLgmTzBpFwCQ0jJBnDR2YAsQswQZ/YoXfu4
 unu1r3xpBcbMqzgDoTFdym82vSbfcKxUi0t5dXwBjbghkN6pYAowGZ7YuA4nPW9FCUpTyD
 SzzQwIEy7VBwRm27SO9cax2BXpL8LXM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609152756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rw3pdru7uk8E36R1wS+u3mV1r9XMv9mOcib8uhk/uwg=;
 b=ebKF+CDmhAtqPV7ZT5hErqMbj41JFB/dQZvDLgmTzBpFwCQ0jJBnDR2YAsQswQZ/YoXfu4
 unu1r3xpBcbMqzgDoTFdym82vSbfcKxUi0t5dXwBjbghkN6pYAowGZ7YuA4nPW9FCUpTyD
 SzzQwIEy7VBwRm27SO9cax2BXpL8LXM=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-ReNJD56sMZm6nlYIOiiJyA-1; Mon, 28 Dec 2020 05:52:33 -0500
X-MC-Unique: ReNJD56sMZm6nlYIOiiJyA-1
Received: by mail-pf1-f198.google.com with SMTP id y187so3386220pfc.7
 for <linux-erofs@lists.ozlabs.org>; Mon, 28 Dec 2020 02:52:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Rw3pdru7uk8E36R1wS+u3mV1r9XMv9mOcib8uhk/uwg=;
 b=cx9ztCnMKj3ae5nDaFDSKSGWCL/KvPyjcCcAqNLoLb2iKwkap/ILXYhS7bqMeAh/13
 HkBg2qBPYnsnfUub8LLSjc44Pur4sg4S/aApibmjaHTIcNbhbBBZ6l4GupWKrn9dc9/P
 DNKKTlOynueV3RXLp6EXgbA2Cvj1Yh269usxGgSTpeyNUSZYR6GRGRNl7Vsa8CPfz5rr
 oZLKbpfObsgjeWoTwXt3p9ZxhnBuSViPv060WdCOA5WkRC/tnMFo1ofaQRFskWiIqKCn
 1yfe8nKCqYgDdYPA+VzXCOERQELmykYZoFPnT9I95Fzoa/WDN1lyp2O0BFimZvXlM3Rg
 3qGA==
X-Gm-Message-State: AOAM533XVZwDglat8MGQYl/YyR17nPGM35mtq8xb0Y70oSokv0Wbkphg
 u6zgGbEHNTRMHEoloDmNTEHydugJD+uX9ylvoaBKt3c+qRUxPIxM698JGt5LtRo8AU10mbO5cjX
 biCq3SLfry/z4lbYTRLxXA2BTPwhIHMZIr/cuzmr+0ZViiJ4W2iYqpN7anshJiQGPeEErMYxXyK
 lOzA==
X-Received: by 2002:aa7:8486:0:b029:19e:307f:2941 with SMTP id
 u6-20020aa784860000b029019e307f2941mr20424570pfn.26.1609152752736; 
 Mon, 28 Dec 2020 02:52:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxbCLNzQuyLMO95HvOGxdKVZNmFdSyOyCb7wt5Ze3w9KSphGYAiHB0qLqIfBJVOCvjMmhhK+A==
X-Received: by 2002:aa7:8486:0:b029:19e:307f:2941 with SMTP id
 u6-20020aa784860000b029019e307f2941mr20424551pfn.26.1609152752463; 
 Mon, 28 Dec 2020 02:52:32 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id u6sm38571443pgj.37.2020.12.28.02.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Dec 2020 02:52:32 -0800 (PST)
From: Gao Xiang <hsiangkao@redhat.com>
To: linux-erofs@lists.ozlabs.org, Yue Hu <zbestahu@gmail.com>,
 Huang Jianan <huangjianan@oppo.com>, Li Guifu <bluce.lee@aliyun.com>
Subject: [PATCH v2] AOSP: erofs-utils: fix sub-directory prefix for canned
 fs_config
Date: Mon, 28 Dec 2020 18:51:46 +0800
Message-Id: <20201228105146.2939914-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201226062736.29920-1-hsiangkao@aol.com>
References: <20201226062736.29920-1-hsiangkao@aol.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
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
Cc: Yue Hu <huyue2@yulong.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@aol.com>

"failed to find [%s] in canned fs_config" was observed by using
"--fs-config-file" option as reported by Yue Hu [1].

The root cause was that the mountpoint prefix to subdirectories is
also needed if "--mount-point" presents. However, such prefix cannot
be added by just using erofs_fspath().

One exception is that the root directory itself needs to be handled
specially for canned fs_config. For such case, the prefix of the root
directory has to be dropped instead.

[1] https://lkml.kernel.org/r/20201222020430.12512-1-zbestahu@gmail.com

Link: https://lore.kernel.org/r/20201226062736.29920-1-hsiangkao@aol.com
Fixes: 8a9e8046f170 ("AOSP: erofs-utils: add fs_config support")
Reported-by: Yue Hu <huyue2@yulong.com>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
changes since v2:
 - fix IS_ROOT misuse reported by Jianan, very sorry about this since
   I know little about canned fs_config.

(please kindly test again...)

 lib/inode.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 0c4839d..e6159c9 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -696,32 +696,43 @@ int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
 	/* filesystem_config does not preserve file type bits */
 	mode_t stat_file_type_mask = st->st_mode & S_IFMT;
 	unsigned int uid = 0, gid = 0, mode = 0;
-	char *fspath;
+	const char *fspath;
+	char *decorated = NULL;
 
 	inode->capabilities = 0;
+	if (!cfg.fs_config_file && !cfg.mount_point)
+		return 0;
+
+	if (!cfg.mount_point ||
+	/* have to drop the mountpoint for rootdir of canned fsconfig */
+	    (cfg.fs_config_file && erofs_fspath(path)[0] == '\0')) {
+		fspath = erofs_fspath(path);
+	} else {
+		if (asprintf(&decorated, "%s/%s", cfg.mount_point,
+			     erofs_fspath(path)) <= 0)
+			return -ENOMEM;
+		fspath = decorated;
+	}
+
 	if (cfg.fs_config_file)
-		canned_fs_config(erofs_fspath(path),
+		canned_fs_config(fspath,
 				 S_ISDIR(st->st_mode),
 				 cfg.target_out_path,
 				 &uid, &gid, &mode, &inode->capabilities);
-	else if (cfg.mount_point) {
-		if (asprintf(&fspath, "%s/%s", cfg.mount_point,
-			     erofs_fspath(path)) <= 0)
-			return -ENOMEM;
-
+	else
 		fs_config(fspath, S_ISDIR(st->st_mode),
 			  cfg.target_out_path,
 			  &uid, &gid, &mode, &inode->capabilities);
-		free(fspath);
-	}
-	st->st_uid = uid;
-	st->st_gid = gid;
-	st->st_mode = mode | stat_file_type_mask;
 
 	erofs_dbg("/%s -> mode = 0x%x, uid = 0x%x, gid = 0x%x, "
 		  "capabilities = 0x%" PRIx64 "\n",
-		  erofs_fspath(path),
-		  mode, uid, gid, inode->capabilities);
+		  fspath, mode, uid, gid, inode->capabilities);
+
+	if (decorated)
+		free(decorated);
+	st->st_uid = uid;
+	st->st_gid = gid;
+	st->st_mode = mode | stat_file_type_mask;
 	return 0;
 }
 #else
-- 
2.27.0

