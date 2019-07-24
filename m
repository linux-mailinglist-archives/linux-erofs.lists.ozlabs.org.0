Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 5493972703
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jul 2019 06:55:47 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45tjhw6SPfzDqFL
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jul 2019 14:55:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="c9TgX33G"; 
 dkim-atps=neutral
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45tjhr3Dp3zDq7F
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jul 2019 14:55:39 +1000 (AEST)
Received: by mail-pf1-x429.google.com with SMTP id m30so20277362pff.8
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jul 2019 21:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=Hh3/3sGOYgmob9/XDPaJZnS3+AVAXoN/fxpr+k2+U5k=;
 b=c9TgX33Grvpdr7ehCpjYlIVuY5yIi8UBzcPrRQNjlyNMdefzqre8AbfZusvj/Ai/7+
 NBaJ7LADIVNzc7lt7RrrQ1KcAr8BDV9SU40e++SM9f6ZREaLrn8kGOSUbJlMXGRpg3za
 vVe9G49zIub64uSSHGN0o+EuJX2KChkucS0VYtxfHX4jRCrs8Y8QHm0hoaY8NB8FEEBC
 gii4GMlQf61LcMXxUvQRnXm+tMZZYLRcoQHOq7nPJEH1lq1XMlXkPRtTZuu/z/yhM1EK
 8v/VYLHpjGOsU2QI+SHaPrkvNJedo2HAA8gYtsgLGmED8+a5nbMSO6KI4UMgstoHojrc
 vQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Hh3/3sGOYgmob9/XDPaJZnS3+AVAXoN/fxpr+k2+U5k=;
 b=QoltmPv8cw206Us7fvGcdrCSxVuR3hZAdmzJz4Zx5v6G7wDuZZq0I86f9taHpxwjBR
 gIn7i6Lset5eEwVhbnVc15IpTMP2T+gqUoRCZjMkp51KRSL+JAUDJnkdVAgH08jkBXlL
 qffxAZ8hL/58uLSFgubB2gBUOEM/XpCKql7InyjyfDGVCdpZzeaj1fYmuXjl5HY+Hx4m
 QooF+oxOUEPm6vvDpEGQJMdD6Ie9WKHnFcCa0y6HczrU6nIYpvVjSsB2hcxEaZIAaJJP
 OpsFSto6O1B1Y0mf3x4r4NPTCz2P3TmXhap68sDUoO7L8MUuaFQ74QlhDWbob+SAsybY
 ZD1w==
X-Gm-Message-State: APjAAAUq4AQPVJAoDSS4xgBYG4F2hTXQmeLIhpw0js5lrclhdDyrGz2z
 vOuxce80cmZradH3PPrIk4DCxmj4qeg=
X-Google-Smtp-Source: APXvYqxumsf0hFu1hwB/DnCSHAXCGkY0s0r5XwehT1Tv/n5D3tSSULZU5yne3ec2sBXs5ujCU81CYA==
X-Received: by 2002:a63:66c5:: with SMTP id
 a188mr79321479pgc.127.1563944135546; 
 Tue, 23 Jul 2019 21:55:35 -0700 (PDT)
Received: from localhost.localdomain ([42.108.246.143])
 by smtp.gmail.com with ESMTPSA id q8sm85701974pjq.20.2019.07.23.21.55.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Jul 2019 21:55:34 -0700 (PDT)
From: Pratik Shinde <pratikshinde320@gmail.com>
To: linux-erofs@lists.ozlabs.org, bluce.liguifu@huawei.com, miaoxie@huawei.com,
 fangwei1@huawei.com
Subject: [PATCH v2] erofs-utils: Add missing error code handling.
Date: Wed, 24 Jul 2019 10:25:19 +0530
Message-Id: <20190724045519.8498-1-pratikshinde320@gmail.com>
X-Mailer: git-send-email 2.9.3
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Handling error conditions that are missed in few scenarios.
also, mkfs command should return 1 on failure and 0 on success.

Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
---
 lib/inode.c | 10 ++++++++--
 mkfs/main.c |  8 +++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 179aa26..08d38c0 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -752,8 +752,14 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 	}
 	closedir(_dir);
 
-	erofs_prepare_dir_file(dir);
-	erofs_prepare_inode_buffer(dir);
+	ret = erofs_prepare_dir_file(dir);
+	if(!ret)
+		goto err_closedir;
+
+	ret = erofs_prepare_inode_buffer(dir);
+	if(!ret)
+		goto err_closedir;
+
 	if (IS_ROOT(dir))
 		erofs_fixup_meta_blkaddr(dir);
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 1348587..f73eb10 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -212,6 +212,12 @@ int main(int argc, char **argv)
 	erofs_show_config();
 
 	sb_bh = erofs_buffer_init();
+	if(IS_ERR(sb_bh)) {
+		err = PTR_ERR(sb_bh);
+		erofs_err("Failed to initialize super block buffer head : %s",
+			  erofs_strerror(err));
+		goto exit;
+	}
 	err = erofs_bh_balloon(sb_bh, EROFS_SUPER_END);
 	if (err < 0) {
 		erofs_err("Failed to balloon erofs_super_block: %s",
@@ -254,5 +260,5 @@ exit:
 			  erofs_strerror(err));
 		return 1;
 	}
-	return err;
+	return 0;
 }
-- 
2.9.3

