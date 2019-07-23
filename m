Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id C326B726A0
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jul 2019 06:29:41 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45tj6q0PzgzDqCB
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jul 2019 14:29:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="TwtFIvpl"; 
 dkim-atps=neutral
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45tTwZ1mf9zDqLh
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jul 2019 06:05:01 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id y15so19677981pfn.5
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jul 2019 13:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=41afmad6GcKIsZXr/OQJK3US4ekIMgKbEsxQIRuLRTA=;
 b=TwtFIvplK+issrV/ZTMJ01K4vN2wrasgoAabYmsqGEXLZipX66fON9lwO1LjOtvka+
 5CLKeqwbYK3aHc6WiCXLdBoKuh2K1JH6vtfhcs51qZwixgdRwFpG+zr8qKhiaK9j288R
 +i01pd/2DoSbpIBBCiCxDVl8nNFAOQI2di238Pty6ceh510IbvXZVDVYoylJdaMJH4uT
 kfyA7XymF+WW37c11p3HnkvUsM4Gi2/jIsMUsZd41oAEfAzLOzzPJjJLj+kE6YmsVRA1
 o+6+E6Y/CklA6gnG8heX3wZ9ueqL+BN2hXEriGPghNhVGZYPlNvqb94hp5d5q6qaLwSG
 BALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=41afmad6GcKIsZXr/OQJK3US4ekIMgKbEsxQIRuLRTA=;
 b=SUGSaYYXGEEDoivWBW/EI0RzAhSADdXZ0mMKtB52PwxhiJwFQhsn/EWOFKYIICEJS/
 eamKXt5XLJDMNhTSOdFJR1Z+bGxegCND3ZK0p4Wg4oHhS+ZDUGd99WyEgdcEtAgjXCc3
 Dq3uaP0kKPNQPcTtw4p4mxaxYuVu7dfMlQydrijeaynlsHS2BCIWeDPl7n/OBlkc/1Zw
 8vRKNDfRzME83Yq9y4kON586cC4a54SJn1HcBYgyd2romnv9dOTZabSIgLURnUAVznWx
 BuJDAH7xTi09TbQp5TfHjmYJ5VyFTgNvPL0IumeQJmU22XYgDpmw4BqjDpSQOY54iZIq
 p55A==
X-Gm-Message-State: APjAAAVvp+PmI5e/Ad2+fUr/RXUzI+r60TD6aM/FD0tcMtKwLYFt8VmW
 Q6/GWsd+niRbLwxLibzaR8DeqtyG
X-Google-Smtp-Source: APXvYqyQmxFiu/EapzPR6xC73FXCp2S8mzJ4qswLMZCEQNssDoSqmAFkE1h79mcyhJofOJnanKIBcw==
X-Received: by 2002:a63:9dcb:: with SMTP id
 i194mr32529254pgd.444.1563912297711; 
 Tue, 23 Jul 2019 13:04:57 -0700 (PDT)
Received: from localhost.localdomain ([139.5.48.149])
 by smtp.gmail.com with ESMTPSA id y23sm45890016pfo.106.2019.07.23.13.04.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Jul 2019 13:04:56 -0700 (PDT)
From: Pratik Shinde <pratikshinde320@gmail.com>
To: linux-erofs@lists.ozlabs.org, bluce.liguifu@huawei.com, miaoxie@huawei.com,
 fangwei1@huawei.com
Subject: [PATCH] erofs-utils: Add missing error code handling.
Date: Wed, 24 Jul 2019 01:34:29 +0530
Message-Id: <20190723200429.7132-1-pratikshinde320@gmail.com>
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

Handling error conditions that are missing in few scenarios.

Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
---
 lib/inode.c | 10 ++++++++--
 mkfs/main.c | 10 ++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

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
index 1348587..9c9530d 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -200,18 +200,24 @@ int main(int argc, char **argv)
 	if (err) {
 		if (err == -EINVAL)
 			usage();
-		return 1;
+		return err;
 	}
 
 	err = dev_open(cfg.c_img_path);
 	if (err) {
 		usage();
-		return 1;
+		return err;
 	}
 
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
-- 
2.9.3

