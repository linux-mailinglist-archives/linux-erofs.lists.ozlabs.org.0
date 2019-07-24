Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A04172B34
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jul 2019 11:13:11 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45tqPw4tGlzDqDG
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jul 2019 19:13:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="qbamw+zI"; 
 dkim-atps=neutral
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45tqPr2CMlzDqBH
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jul 2019 19:13:04 +1000 (AEST)
Received: by mail-pl1-x62c.google.com with SMTP id az7so21741740plb.5
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jul 2019 02:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=fYjPdt71ccoZY9Tub83W0DgBdTzpHfoj8sGNgsa16As=;
 b=qbamw+zID8VVUwDTc5fy9dJqjDppPexLh7do+dYCs6JtbUIyrxdAqkMay+PUejFUX1
 0G+rnOG5xCK5VuOkrjdE7p0TRC0+yZpfVAFGqLaRjIAINYAYYZG6VE37LyDUo9Z7bpLF
 9nFT5Kqv5OAe64BHurgMsM4unAlMlE5eSWJSvnSbU9es1R8NLZngT0jIYqsE+3V/AiM1
 IiJlcVSBFiy8K/1rS3Sfmv2OLcodRAk1bbpKFHYyUr11nsay121L98blhFgKOE1Ud0S4
 NbwJ02MCbwrm//ZUicIZGOa/P06XKiTiu5P5ky4A/nBOnCLmcya/ee+tgW9RPn8B8fHc
 IYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=fYjPdt71ccoZY9Tub83W0DgBdTzpHfoj8sGNgsa16As=;
 b=SQdxI4GlZfMr4QP4teffYIgX0IX3nEZEPu9NkhCq+1ziOLXeQarv9vxqL+XDWBELDA
 fqltoVTsxHKyNGLSN1B1L5jvzu/gohkyVdsO6p2mCbFTXrHLh2ymGSXJPGWljK0RwxNg
 yHA30Xaa/ZuEag2G77bMgyCw3PbbuxqMBV2zxOK/+/6cXmpgoTR2Fd3VKkPeRgazU11g
 4gyCRjrqwJmFBTIhe+p/92A/3sySHeY70JCVYT/pCb5EJMi39ArYSQtDxf/n3KcQGkYe
 CPEk3CqL9UW4Pye+syWG1a6pxSoeYb5VF9bfT2R/6zgBIZg+bOsrmAK/Kr9Z0pwpHiR6
 Ke6Q==
X-Gm-Message-State: APjAAAXiOVImUyLPHWzcVko0ZscgxhAkBaoZsC8C0K1pgtq2k2YK9fmy
 7Jzy24REC4Bl1PUg7QpaiHiV4zRUcoI=
X-Google-Smtp-Source: APXvYqyLFpOaBhL0wdPUT45SeFaBIRlAqaQhsp4icFywR01Dl3jYTwDzwUnZAlMCCzoZuh1c9oJ7wQ==
X-Received: by 2002:a17:902:583:: with SMTP id
 f3mr84453436plf.137.1563959581336; 
 Wed, 24 Jul 2019 02:13:01 -0700 (PDT)
Received: from localhost.localdomain ([42.108.246.176])
 by smtp.gmail.com with ESMTPSA id n7sm52734342pff.59.2019.07.24.02.12.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Jul 2019 02:13:00 -0700 (PDT)
From: Pratik Shinde <pratikshinde320@gmail.com>
To: linux-erofs@lists.ozlabs.org, bluce.liguifu@huawei.com, miaoxie@huawei.com,
 fangwei1@huawei.com
Subject: [PATCH v3] erofs-utils: Add missing error code handling.
Date: Wed, 24 Jul 2019 14:42:46 +0530
Message-Id: <20190724091246.10367-1-pratikshinde320@gmail.com>
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
index 179aa26..8b38270 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -752,8 +752,14 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 	}
 	closedir(_dir);
 
-	erofs_prepare_dir_file(dir);
-	erofs_prepare_inode_buffer(dir);
+	ret = erofs_prepare_dir_file(dir);
+	if (ret)
+		goto err_closedir;
+
+	ret = erofs_prepare_inode_buffer(dir);
+	if (ret)
+		goto err_closedir;
+
 	if (IS_ROOT(dir))
 		erofs_fixup_meta_blkaddr(dir);
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 1348587..fdb65fd 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -212,6 +212,12 @@ int main(int argc, char **argv)
 	erofs_show_config();
 
 	sb_bh = erofs_buffer_init();
+	if (IS_ERR(sb_bh)) {
+		err = PTR_ERR(sb_bh);
+		erofs_err("Failed to initialize buffers: %s",
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

