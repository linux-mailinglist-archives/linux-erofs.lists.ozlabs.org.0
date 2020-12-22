Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C50612E043A
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 03:05:17 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D0KRb0C0WzDqGx
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Dec 2020 13:05:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029;
 helo=mail-pj1-x1029.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=C2K00WuB; dkim-atps=neutral
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D0KRX4pFbzDqFJ
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Dec 2020 13:05:09 +1100 (AEDT)
Received: by mail-pj1-x1029.google.com with SMTP id f14so484822pju.4
 for <linux-erofs@lists.ozlabs.org>; Mon, 21 Dec 2020 18:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Xh0xpHfY4hRhz6YMO+vpWXOLlC7ZC7vvBH+NX0qecNE=;
 b=C2K00WuBEpMzvR6+xWdf7fdMO3ytPTL7qE3rCmqmh8kmmE8eAMYCsii2mZ5tKklEOq
 mybrWCsgtZWCZ7gFGgjnHrHm4//5z5941jXupfToq6mqRVkaKh5ah138klscq9Gbn/eA
 S14J6jHvAy4pMtbmENoWGIDxiUZOnlhel5DqrTyVTCQ6ovJWHepl8NWhXSxQfY4hgxaM
 HgQsl1mZZcmou0ZuqEk+828kV+1SYlo7EqGLTrSzHD+0o8w0FIfjq0zMc5I7UIxoexlq
 3YchPBaNQmtk1u9bS+G9TgDXQN3Pdp8iKMwaI9/bBKh2s2PFgxkFixnDJBU3oMy4WAB1
 Thug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Xh0xpHfY4hRhz6YMO+vpWXOLlC7ZC7vvBH+NX0qecNE=;
 b=HVWgedd1iMxRd4y6FjR+HLWI6EL9Q5SXBJArv+sODB53VHehD75Oe++wDs7ldFWLBQ
 QnyVGEtXD1wJCPTYquuOajJZ1OUXUS9JfGytDwOjZLElEApxyjVizCi9DGf23NOTMOGx
 3bwgYoI9GCLNf5i9U3BNaQBDLs/9NsY5WCq51HffGpwdwIKJFhcmGAjyoMtjOuPDhPej
 HFd3siUVp5l5Ts2KESFDGrZW+kz+rudJyvTfjEOWHLKOGfE5FeNRoNmK+KroBkp0HDFl
 InwAREidEFfgjDPEw5+bvFDV+oJaIVa7HM5HDvXJ8tWLV7mf6e5XNAcxpg+tOCm02o6t
 6BcA==
X-Gm-Message-State: AOAM5329CfLCKnP+iuF+k2ibvyV9XWhAovDkgO8E345FMtpaZwa7qks6
 44K3+yOIZIXDE9b7+3rMzls=
X-Google-Smtp-Source: ABdhPJzHBBE/Y7gdAzaaI5LoY1IADpHmQ7+gfEOmVLh1UttJgcTG9svWidfJbAbW8Swj+DeFfl0ALw==
X-Received: by 2002:a17:90a:5509:: with SMTP id
 b9mr20182051pji.53.1608602706104; 
 Mon, 21 Dec 2020 18:05:06 -0800 (PST)
Received: from huyue2.ccdomain.com ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id o7sm19383177pfp.144.2020.12.21.18.05.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Dec 2020 18:05:05 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	bluce.lee@aliyun.com,
	hsiangkao@aol.com
Subject: [PATCH] AOSP: erofs-utils: fix sub directory prefix path in canned
 fs_config
Date: Tue, 22 Dec 2020 10:04:30 +0800
Message-Id: <20201222020430.12512-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.19.1.windows.1
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
Cc: huyue2@yulong.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@yulong.com>

We observe that creating image failed to find [%s] in canned fs_config
using --fs-config-file option under Android 10.

Notice that canned fs_config has a prefix to sub directory if mount_point
presents. However, erofs_fspath() does not contain the prefix.

Moreover, we should not add the mount point to fspath on root inode for
fs_config() branch.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 include/erofs/config.h |  4 ++++
 lib/inode.c            | 29 +++++++++++++++++++----------
 mkfs/main.c            | 14 ++++++++++----
 3 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 02ddf59..1277eda 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -58,6 +58,10 @@ struct erofs_configure {
 	char *mount_point;
 	char *target_out_path;
 	char *fs_config_file;
+	void (*fs_config_func)(const char *path, int dir,
+			       const char *target_out_path,
+			       unsigned *uid, unsigned *gid,
+			       unsigned *mode, uint64_t *capabilities);
 #endif
 };
 
diff --git a/lib/inode.c b/lib/inode.c
index eb2e0f2..d0805cd 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -684,20 +684,29 @@ int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
 	char *fspath;
 
 	inode->capabilities = 0;
-	if (cfg.fs_config_file)
-		canned_fs_config(erofs_fspath(path),
-				 S_ISDIR(st->st_mode),
-				 cfg.target_out_path,
-				 &uid, &gid, &mode, &inode->capabilities);
-	else if (cfg.mount_point) {
+
+	if (erofs_fspath(path)[0] == '\0')
+		goto e_fspath;
+
+	if (cfg.mount_point) {
 		if (asprintf(&fspath, "%s/%s", cfg.mount_point,
 			     erofs_fspath(path)) <= 0)
 			return -ENOMEM;
-
-		fs_config(fspath, S_ISDIR(st->st_mode),
-			  cfg.target_out_path,
-			  &uid, &gid, &mode, &inode->capabilities);
+		if (cfg.fs_config_func)
+			cfg.fs_config_func(fspath,
+					   S_ISDIR(st->st_mode),
+					   cfg.target_out_path,
+					   &uid, &gid, &mode,
+					   &inode->capabilities);
 		free(fspath);
+	} else {
+e_fspath:
+		if (cfg.fs_config_func)
+			cfg.fs_config_func(erofs_fspath(path),
+					   S_ISDIR(st->st_mode),
+					   cfg.target_out_path,
+					   &uid, &gid, &mode,
+					   &inode->capabilities);
 	}
 	st->st_uid = uid;
 	st->st_gid = gid;
diff --git a/mkfs/main.c b/mkfs/main.c
index c63b274..684767c 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -474,10 +474,16 @@ int main(int argc, char **argv)
 	}
 
 #ifdef WITH_ANDROID
-	if (cfg.fs_config_file &&
-	    load_canned_fs_config(cfg.fs_config_file) < 0) {
-		erofs_err("failed to load fs config %s", cfg.fs_config_file);
-		return 1;
+	cfg.fs_config_func = NULL;
+	if (cfg.fs_config_file) {
+		if (load_canned_fs_config(cfg.fs_config_file) < 0) {
+			erofs_err("failed to load fs config %s",
+					cfg.fs_config_file);
+			return 1;
+		}
+		cfg.fs_config_func = canned_fs_config;
+	} else if (cfg.mount_point) {
+		cfg.fs_config_func = fs_config;
 	}
 #endif
 
-- 
1.9.1

