Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2A43A9371
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Jun 2021 09:00:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G4bfm02KNz2yhf
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Jun 2021 17:00:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=o2C6fb+5;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::433;
 helo=mail-pf1-x433.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=o2C6fb+5; dkim-atps=neutral
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G4bfh4RM7z2xfN
 for <linux-erofs@lists.ozlabs.org>; Wed, 16 Jun 2021 17:00:10 +1000 (AEST)
Received: by mail-pf1-x433.google.com with SMTP id s14so1396928pfd.9
 for <linux-erofs@lists.ozlabs.org>; Wed, 16 Jun 2021 00:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nl4BQiDSpsrRv26gnwUO6xNqd8QC+aReaEuzoGeqVog=;
 b=o2C6fb+5mq8zL75WpTyguFa5A91hIKIpVDgXrJu34iSFUura5cOXpAKCIavjP/755P
 xtnTtumLr0oaYSWOWcTE8FVXnONNI5LPRJ+nHaDNEBa+u4H2pw3oSvN3S7GFMVh//jXH
 uBR+4iZjf2tc98ycDP8yoxICdEQVYKjbbei3iItvo6atp9bTKkWeIDlABj7nRW9g7SLN
 MoNmZlTwTjW6BbB3NaKxWQ61YWzJSZq+1S/ITeL3iO1OzyowKrnpY3mSzI/BrYCSLAof
 0tCrDjAPnPntIy2D0l1//hzuSuLrrZNsZNtqnjLgMFruBE7A5V9XgTqDbL4Dvt0DU1fZ
 o7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nl4BQiDSpsrRv26gnwUO6xNqd8QC+aReaEuzoGeqVog=;
 b=gUY5ToH+ld4QsplxXeoJ+PuRGllwVtpQAuLU4ykodxxAo4jZYPOxV9uhDfIILWVGvj
 BeQLciU/QwGbACpe3McHj7OO123/g6SKlJF9Lrh76ZpqqGM6MaXzwN+rbyCrya6cz5V3
 Z1fc7jXafISYZXkFI6xNzqTW57MLHwosMjCK1f9hB7mrCXaN//U625fD9iTzbu0hz5ot
 MKW1+coO6YaISIs8odGkXgnbYAWlU1yFDkrYiJoWI3adaOU03G9adC0JFZsWuCIVB26P
 aZrb6NZ5yJIxghivIjcPzXMnI9Pen0W85myAWocu5B5+yr1VEOsirc/d7PP/yfzhB3V9
 cuBw==
X-Gm-Message-State: AOAM5300E97A9aa6HXRH/+9YOBeC7zHyGWseNgt97RiDFMHM2O8S7MOv
 BjvqLvnfMJ1F/pQ4kR45/5YNUf/cjvKHkw==
X-Google-Smtp-Source: ABdhPJzQK0Zs4a58HwQ5x2D5N89Te69IeC/JAwgvETTQk73XLIF/O14Ur9EKyLTH3MXrhDPTud1LMw==
X-Received: by 2002:a63:3dcb:: with SMTP id k194mr3573237pga.202.1623826806358; 
 Wed, 16 Jun 2021 00:00:06 -0700 (PDT)
Received: from tj.ccdomain.com ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id p14sm1335463pgb.2.2021.06.16.00.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jun 2021 00:00:05 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org
Subject: [PATCH] erofs-utils: make some functions static in inode.c
Date: Wed, 16 Jun 2021 14:59:40 +0800
Message-Id: <20210616065941.881-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
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
Cc: huyue2@yulong.com, zbestahu@163.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@yulong.com>

They are only used in inode.c, no need to be in global scope.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 lib/inode.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 787e5b4..ca8952e 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -251,7 +251,7 @@ static int write_dirblock(unsigned int q, struct erofs_dentry *head,
 	return blk_write(buf, blkaddr, 1);
 }
 
-int erofs_write_dir_file(struct erofs_inode *dir)
+static int erofs_write_dir_file(struct erofs_inode *dir)
 {
 	struct erofs_dentry *head = list_first_entry(&dir->i_subdirs,
 						     struct erofs_dentry,
@@ -298,7 +298,7 @@ int erofs_write_dir_file(struct erofs_inode *dir)
 	return 0;
 }
 
-int erofs_write_file_from_buffer(struct erofs_inode *inode, char *buf)
+static int erofs_write_file_from_buffer(struct erofs_inode *inode, char *buf)
 {
 	const unsigned int nblocks = erofs_blknr(inode->i_size);
 	int ret;
@@ -516,7 +516,7 @@ static struct erofs_bhops erofs_write_inode_bhops = {
 	.flush = erofs_bh_flush_write_inode,
 };
 
-int erofs_prepare_tail_block(struct erofs_inode *inode)
+static int erofs_prepare_tail_block(struct erofs_inode *inode)
 {
 	struct erofs_buffer_head *bh;
 	int ret;
@@ -545,7 +545,7 @@ int erofs_prepare_tail_block(struct erofs_inode *inode)
 	return 0;
 }
 
-int erofs_prepare_inode_buffer(struct erofs_inode *inode)
+static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 {
 	unsigned int inodesize;
 	struct erofs_buffer_head *bh, *ibh;
@@ -623,7 +623,7 @@ static struct erofs_bhops erofs_write_inline_bhops = {
 	.flush = erofs_bh_flush_write_inline,
 };
 
-int erofs_write_tail_end(struct erofs_inode *inode)
+static int erofs_write_tail_end(struct erofs_inode *inode)
 {
 	struct erofs_buffer_head *bh, *ibh;
 
@@ -753,9 +753,9 @@ static int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
 }
 #endif
 
-int erofs_fill_inode(struct erofs_inode *inode,
-		     struct stat64 *st,
-		     const char *path)
+static int erofs_fill_inode(struct erofs_inode *inode,
+			    struct stat64 *st,
+			    const char *path)
 {
 	int err = erofs_droid_inode_fsconfig(inode, st, path);
 
@@ -819,7 +819,7 @@ int erofs_fill_inode(struct erofs_inode *inode,
 	return 0;
 }
 
-struct erofs_inode *erofs_new_inode(void)
+static struct erofs_inode *erofs_new_inode(void)
 {
 	static unsigned int counter;
 	struct erofs_inode *inode;
@@ -846,7 +846,7 @@ struct erofs_inode *erofs_new_inode(void)
 }
 
 /* get the inode from the (source) path */
-struct erofs_inode *erofs_iget_from_path(const char *path, bool is_src)
+static struct erofs_inode *erofs_iget_from_path(const char *path, bool is_src)
 {
 	struct stat64 st;
 	struct erofs_inode *inode;
@@ -885,7 +885,7 @@ struct erofs_inode *erofs_iget_from_path(const char *path, bool is_src)
 	return inode;
 }
 
-void erofs_fixup_meta_blkaddr(struct erofs_inode *rootdir)
+static void erofs_fixup_meta_blkaddr(struct erofs_inode *rootdir)
 {
 	const erofs_off_t rootnid_maxoffset = 0xffff << EROFS_ISLOTBITS;
 	struct erofs_buffer_head *const bh = rootdir->bh;
@@ -918,7 +918,7 @@ erofs_nid_t erofs_lookupnid(struct erofs_inode *inode)
 	return inode->nid = (off - meta_offset) >> EROFS_ISLOTBITS;
 }
 
-void erofs_d_invalidate(struct erofs_dentry *d)
+static void erofs_d_invalidate(struct erofs_dentry *d)
 {
 	struct erofs_inode *const inode = d->inode;
 
@@ -926,7 +926,7 @@ void erofs_d_invalidate(struct erofs_dentry *d)
 	erofs_iput(inode);
 }
 
-struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
+static struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 {
 	int ret;
 	DIR *_dir;
-- 
1.9.1

