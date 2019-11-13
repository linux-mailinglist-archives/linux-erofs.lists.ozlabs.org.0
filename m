Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C05FB5DB
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Nov 2019 18:03:58 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47CrYP75cSzF4mf
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2019 04:03:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::443;
 helo=mail-pf1-x443.google.com; envelope-from=blucerlee@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="sxvP/kcY"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47CrYH6KT7zF445
 for <linux-erofs@lists.ozlabs.org>; Thu, 14 Nov 2019 04:03:47 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id 3so2044404pfb.10
 for <linux-erofs@lists.ozlabs.org>; Wed, 13 Nov 2019 09:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=X5WHLnE8RpFSuxoBVP4zgriXpjbW7Xx8j5YZiiicrAM=;
 b=sxvP/kcYid6993bE7z3l3Rt4zFamXSTN6J5rGYCbXXF9T/tGOqEoeFPyiHhEXrTsjV
 sXuR6YJHM1zFiEzWALQaLxIN0Kk7t8rQqbrQWRsZazfcKnFrh+auKmnlfVuADyyjTdC9
 uPZ8YL6LOaWusLk10XFcMbqQfScXitK2rZhPYyEaXBapgvNO0KpK5iQ8q3hoJw3hQOpQ
 rxmJNq/GL/Ll93tmnGDbHV2X2INf2mj2fkEI+e4/s6nCzIKkTfTRDz1xtgoijEKwdxeZ
 jsNTyzUuWC2OCFtTAn/hfE7ARla1SgQNwPcDtGnMVVyv6VFez/bVA/sF6Hsbp06ddxtu
 Jbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=X5WHLnE8RpFSuxoBVP4zgriXpjbW7Xx8j5YZiiicrAM=;
 b=f4SbNGfSBjKaQTaSoaqE91Dvf+482Qic7k1+4vcLQFW0gN+oLQMThxMxmcrAoI0D4g
 qXXZ4cxdcXAuUfDvRaxLnJT+0kpx/U2LqeGd5CGWrbMcboy24I53efYPgtQ0/hKIKXU0
 hlcVnm8JR6e+TJ3nCZ+Udap6HZElYB1xFvjSi/YxKQhxhkBEinyQU1VW28ZvRhFruFGf
 zHic9ThIHLQYrKf+EAAEg7izRfkpGOU4dkL9i+txVmNC5fZzuPsZMqB7JbOP64r9qf0K
 FfOdn4MPnVsBalZvaFjG3ouY3X6bqYJFdntc2f8LN12x/EDaLTnIWdRvw9EipISgZzcO
 nEJw==
X-Gm-Message-State: APjAAAWlli+UEa+UoOupEppkC4LekBzSjytgk/ge8vPnUY3x0lcmpvjV
 51o8dIQxaGWQjNxORxtUBS150yAZJ1Q=
X-Google-Smtp-Source: APXvYqzvgBL34I/DKWfnmISUslluniSqxGH1LltHRV6iA9gnvuoMpQuZ+4l66ZUQjAw1LX7uffeiRw==
X-Received: by 2002:a17:90b:28f:: with SMTP id
 az15mr6497893pjb.27.1573664624821; 
 Wed, 13 Nov 2019 09:03:44 -0800 (PST)
Received: from localhost ([167.172.195.219])
 by smtp.gmail.com with ESMTPSA id u7sm3226624pfh.84.2019.11.13.09.03.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Nov 2019 09:03:42 -0800 (PST)
From: Li Guifu <blucerlee@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: complete missing memory handling
Date: Thu, 14 Nov 2019 01:03:35 +0800
Message-Id: <20191113170335.17621-1-blucerlee@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191112112650.143498-1-gaoxiang25@huawei.com>
References: <20191112112650.143498-1-gaoxiang25@huawei.com>
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

From: Li Guifu <bluce.liguifu@huawei.com>

memory allocation failure should be handled
properly in principle.

Signed-off-by: Li Guifu <bluce.liguifu@huawei.com>
[ Gao Xiang: due to Huawei outgoing email limitation,
  I have to help Guifu send out his patches at work. ]
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Li Guifu <blucerlee@gmail.com>
---
 lib/inode.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 86c465e..b6c2b13 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -264,6 +264,8 @@ int erofs_write_dir_file(struct erofs_inode *dir)
 	if (used) {
 		/* fill tail-end dir block */
 		dir->idata = malloc(used);
+		if (!dir->idata)
+			return -ENOMEM;
 		DBG_BUGON(used != dir->idata_size);
 		fill_dirblock(dir->idata, dir->idata_size, q, head, d);
 	}
@@ -286,6 +288,8 @@ int erofs_write_file_from_buffer(struct erofs_inode *inode, char *buf)
 	inode->idata_size = inode->i_size % EROFS_BLKSIZ;
 	if (inode->idata_size) {
 		inode->idata = malloc(inode->idata_size);
+		if (!inode->idata)
+			return -ENOMEM;
 		memcpy(inode->idata, buf + blknr_to_addr(nblocks),
 		       inode->idata_size);
 	}
@@ -347,9 +351,14 @@ int erofs_write_file(struct erofs_inode *inode)
 	inode->idata_size = inode->i_size % EROFS_BLKSIZ;
 	if (inode->idata_size) {
 		inode->idata = malloc(inode->idata_size);
-
+		if (!inode->idata) {
+			errno = ENOMEM;
+			goto fail;
+		}
 		ret = read(fd, inode->idata, inode->idata_size);
 		if (ret < inode->idata_size) {
+			free(inode->idata);
+			inode->idata = NULL;
 			close(fd);
 			return -EIO;
 		}
@@ -825,12 +834,18 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 		if (S_ISLNK(dir->i_mode)) {
 			char *const symlink = malloc(dir->i_size);
 
+			if (!symlink)
+				return ERR_PTR(-ENOMEM);
 			ret = readlink(dir->i_srcpath, symlink, dir->i_size);
-			if (ret < 0)
+			if (ret < 0) {
+				free(symlink);
 				return ERR_PTR(-errno);
+			}
 
-			erofs_write_file_from_buffer(dir, symlink);
+			ret = erofs_write_file_from_buffer(dir, symlink);
 			free(symlink);
+			if (ret)
+				return ERR_PTR(ret);
 		} else {
 			erofs_write_file(dir);
 		}
-- 
2.17.1

