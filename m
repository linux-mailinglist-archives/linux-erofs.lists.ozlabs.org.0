Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A801436AFBF
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Apr 2021 10:30:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FTJ42549gz2yxr
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Apr 2021 18:30:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J60R9+rJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J60R9+rJ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=J60R9+rJ; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=J60R9+rJ; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FTJ4008K6z2xYt
 for <linux-erofs@lists.ozlabs.org>; Mon, 26 Apr 2021 18:30:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619425800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=L4AvVpyGWJtFA1xEDRJo1/6yF8ft/rr9lpl7Yyk/hrg=;
 b=J60R9+rJFEzr3gGsns9zzcYi+jy3ltdQO2hvpOkrSbmYuy4L9YQd8sGVxjlJOR7syfMSl4
 RTMNgPXyZDy0WUDfOiaiZjxBvs8w8YFEjLZzSz0RmtdbjPmqyKG1a0N/meZFnsVVrQtlkE
 pVQbpZDm78xECNBYIkt0Ty1hwYCvnOE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619425800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=L4AvVpyGWJtFA1xEDRJo1/6yF8ft/rr9lpl7Yyk/hrg=;
 b=J60R9+rJFEzr3gGsns9zzcYi+jy3ltdQO2hvpOkrSbmYuy4L9YQd8sGVxjlJOR7syfMSl4
 RTMNgPXyZDy0WUDfOiaiZjxBvs8w8YFEjLZzSz0RmtdbjPmqyKG1a0N/meZFnsVVrQtlkE
 pVQbpZDm78xECNBYIkt0Ty1hwYCvnOE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-_5VZN8RhNle-8mE5Q4WJGw-1; Mon, 26 Apr 2021 04:29:57 -0400
X-MC-Unique: _5VZN8RhNle-8mE5Q4WJGw-1
Received: by mail-pj1-f70.google.com with SMTP id
 m1-20020a17090a7f81b029014e3dc1b035so26109918pjl.0
 for <linux-erofs@lists.ozlabs.org>; Mon, 26 Apr 2021 01:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=L4AvVpyGWJtFA1xEDRJo1/6yF8ft/rr9lpl7Yyk/hrg=;
 b=V+MTa5iyh5F+VHcLUhGLJkKhQDGKFkWHlpsfUArTlz1+AP9zqN3GmkW9yfaPUvXhge
 caoVWBbZIR1P3tTa6CVwo05SqGVAoJSGku+AG4b1RL1MeYJGhQy/9zvaEz6jAHs1CIVM
 WcA3a94nUB2ZppxY9o2nkIhRaPdM0LZch8nJQvHMhBvX35exYv9whTNiIhhRLL0TapNF
 YOYLvKYGJJnZNe5kA2W9GjfqrgC877RAnM89UKJf75jlu+rir6Y6OFosmaAyyH390bS8
 sWr+7XN03bhuhrezVb+GOZQBt89+KBZAnpAtbOmeesylHorOeLBoSc8TDzvmHQxE6mZX
 Ig3w==
X-Gm-Message-State: AOAM531s19TwkOMz3y9r7bcgXuL5lpGHV5vI8HuBs5tg3emN1I/uUvub
 0HpNiPleNfXpjLQi9MpKwHk9YQ9g5sI7JSwdxfWlXAHCiV14X6JkvODIfklJnvH3MY/pobjB9ml
 7L+bbAr+2gDOsT3eRAqTNVNQv
X-Received: by 2002:aa7:904e:0:b029:25a:4469:222a with SMTP id
 n14-20020aa7904e0000b029025a4469222amr16476485pfo.72.1619425796667; 
 Mon, 26 Apr 2021 01:29:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy07sqSid1M4O/CqwxthTniWNwGWquVQnkSyzxcEQp4Z/p0+c4FxIs47UYo+DHqBfvQUj90Xg==
X-Received: by 2002:aa7:904e:0:b029:25a:4469:222a with SMTP id
 n14-20020aa7904e0000b029025a4469222amr16476456pfo.72.1619425796349; 
 Mon, 26 Apr 2021 01:29:56 -0700 (PDT)
Received: from xiangao.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b7sm10674188pfi.42.2021.04.26.01.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Apr 2021 01:29:55 -0700 (PDT)
From: Gao Xiang <hsiangkao@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: [PATCH for-4.19] erofs: fix extended inode could cross boundary
Date: Mon, 26 Apr 2021 16:29:33 +0800
Message-Id: <20210426082933.4040996-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.27.0
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

commit 0dcd3c94e02438f4a571690e26f4ee997524102a upstream.

Each ondisk inode should be aligned with inode slot boundary
(32-byte alignment) because of nid calculation formula, so all
compact inodes (32 byte) cannot across page boundary. However,
extended inode is now 64-byte form, which can across page boundary
in principle if the location is specified on purpose, although
it's hard to be generated by mkfs due to the allocation policy
and rarely used by Android use case now mainly for > 4GiB files.

For now, only two fields `i_ctime_nsec` and `i_nlink' couldn't
be read from disk properly and cause out-of-bound memory read
with random value.

Let's fix now.

Fixes: 431339ba9042 ("staging: erofs: add inode operations")
Cc: <stable@vger.kernel.org> # 4.19+
Link: https://lore.kernel.org/r/20200729175801.GA23973@xiangao.remote.csb
Reviewed-by: Chao Yu <yuchao0@huawei.com>
[ Gao Xiang: resolve non-trivial conflicts for latest 4.19.y. ]
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 drivers/staging/erofs/inode.c | 135 ++++++++++++++++++++++------------
 1 file changed, 90 insertions(+), 45 deletions(-)

diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index 12a5be95457f..a43abd530cc1 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -14,26 +14,78 @@
 
 #include <trace/events/erofs.h>
 
-/* no locking */
-static int read_inode(struct inode *inode, void *data)
+/*
+ * if inode is successfully read, return its inode page (or sometimes
+ * the inode payload page if it's an extended inode) in order to fill
+ * inline data if possible.
+ */
+static struct page *read_inode(struct inode *inode, unsigned int *ofs)
 {
+	struct super_block *sb = inode->i_sb;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct erofs_vnode *vi = EROFS_V(inode);
-	struct erofs_inode_v1 *v1 = data;
-	const unsigned advise = le16_to_cpu(v1->i_advise);
+	const erofs_off_t inode_loc = iloc(sbi, vi->nid);
+	erofs_blk_t blkaddr;
+	struct page *page;
+	struct erofs_inode_v1 *v1;
+	struct erofs_inode_v2 *v2, *copied = NULL;
+	unsigned int ifmt;
+	int err;
 
-	vi->data_mapping_mode = __inode_data_mapping(advise);
+	blkaddr = erofs_blknr(inode_loc);
+	*ofs = erofs_blkoff(inode_loc);
 
+	debugln("%s, reading inode nid %llu at %u of blkaddr %u",
+		__func__, vi->nid, *ofs, blkaddr);
+
+	page = erofs_get_meta_page(sb, blkaddr, false);
+	if (IS_ERR(page)) {
+		errln("failed to get inode (nid: %llu) page, err %ld",
+		      vi->nid, PTR_ERR(page));
+		return page;
+	}
+
+	v1 = page_address(page) + *ofs;
+	ifmt = le16_to_cpu(v1->i_advise);
+
+	vi->data_mapping_mode = __inode_data_mapping(ifmt);
 	if (unlikely(vi->data_mapping_mode >= EROFS_INODE_LAYOUT_MAX)) {
 		errln("unknown data mapping mode %u of nid %llu",
 			vi->data_mapping_mode, vi->nid);
-		DBG_BUGON(1);
-		return -EIO;
+		err = -EOPNOTSUPP;
+		goto err_out;
 	}
 
-	if (__inode_version(advise) == EROFS_INODE_LAYOUT_V2) {
-		struct erofs_inode_v2 *v2 = data;
-
+	switch (__inode_version(ifmt)) {
+	case EROFS_INODE_LAYOUT_V2:
 		vi->inode_isize = sizeof(struct erofs_inode_v2);
+		/* check if the inode acrosses page boundary */
+		if (*ofs + vi->inode_isize <= PAGE_SIZE) {
+			*ofs += vi->inode_isize;
+			v2 = (struct erofs_inode_v2 *)v1;
+		} else {
+			const unsigned int gotten = PAGE_SIZE - *ofs;
+
+			copied = kmalloc(vi->inode_isize, GFP_NOFS);
+			if (!copied) {
+				err = -ENOMEM;
+				goto err_out;
+			}
+			memcpy(copied, v1, gotten);
+			unlock_page(page);
+			put_page(page);
+
+			page = erofs_get_meta_page(sb, blkaddr + 1, false);
+			if (IS_ERR(page)) {
+				errln("failed to get inode payload page (nid: %llu), err %ld",
+				      vi->nid, PTR_ERR(page));
+				kfree(copied);
+				return page;
+			}
+			*ofs = vi->inode_isize - gotten;
+			memcpy((u8 *)copied + gotten, page_address(page), *ofs);
+			v2 = copied;
+		}
 		vi->xattr_isize = ondisk_xattr_ibody_size(v2->i_xattr_icount);
 
 		inode->i_mode = le16_to_cpu(v2->i_mode);
@@ -46,7 +98,7 @@ static int read_inode(struct inode *inode, void *data)
 		} else if (S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
 			inode->i_rdev = 0;
 		} else {
-			return -EIO;
+			goto bogusimode;
 		}
 
 		i_uid_write(inode, le32_to_cpu(v2->i_uid));
@@ -58,10 +110,11 @@ static int read_inode(struct inode *inode, void *data)
 		inode->i_ctime.tv_nsec = le32_to_cpu(v2->i_ctime_nsec);
 
 		inode->i_size = le64_to_cpu(v2->i_size);
-	} else if (__inode_version(advise) == EROFS_INODE_LAYOUT_V1) {
-		struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
-
+		kfree(copied);
+		break;
+	case EROFS_INODE_LAYOUT_V1:
 		vi->inode_isize = sizeof(struct erofs_inode_v1);
+		*ofs += vi->inode_isize;
 		vi->xattr_isize = ondisk_xattr_ibody_size(v1->i_xattr_icount);
 
 		inode->i_mode = le16_to_cpu(v1->i_mode);
@@ -74,7 +127,7 @@ static int read_inode(struct inode *inode, void *data)
 		} else if (S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
 			inode->i_rdev = 0;
 		} else {
-			return -EIO;
+			goto bogusimode;
 		}
 
 		i_uid_write(inode, le16_to_cpu(v1->i_uid));
@@ -86,11 +139,12 @@ static int read_inode(struct inode *inode, void *data)
 		inode->i_ctime.tv_nsec = sbi->build_time_nsec;
 
 		inode->i_size = le32_to_cpu(v1->i_size);
-	} else {
+		break;
+	default:
 		errln("unsupported on-disk inode version %u of nid %llu",
-			__inode_version(advise), vi->nid);
-		DBG_BUGON(1);
-		return -EIO;
+		      __inode_version(ifmt), vi->nid);
+		err = -EOPNOTSUPP;
+		goto err_out;
 	}
 
 	inode->i_mtime.tv_sec = inode->i_ctime.tv_sec;
@@ -100,7 +154,16 @@ static int read_inode(struct inode *inode, void *data)
 
 	/* measure inode.i_blocks as the generic filesystem */
 	inode->i_blocks = ((inode->i_size - 1) >> 9) + 1;
-	return 0;
+	return page;
+bogusimode:
+	errln("bogus i_mode (%o) @ nid %llu", inode->i_mode, vi->nid);
+	err = -EIO;
+err_out:
+	DBG_BUGON(1);
+	kfree(copied);
+	unlock_page(page);
+	put_page(page);
+	return ERR_PTR(err);
 }
 
 /*
@@ -132,7 +195,7 @@ static int fill_inline_data(struct inode *inode, void *data, unsigned m_pofs)
 		if (unlikely(lnk == NULL))
 			return -ENOMEM;
 
-		m_pofs += vi->inode_isize + vi->xattr_isize;
+		m_pofs += vi->xattr_isize;
 
 		/* inline symlink data shouldn't across page boundary as well */
 		if (unlikely(m_pofs + inode->i_size > PAGE_SIZE)) {
@@ -153,35 +216,17 @@ static int fill_inline_data(struct inode *inode, void *data, unsigned m_pofs)
 
 static int fill_inode(struct inode *inode, int isdir)
 {
-	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
-	struct erofs_vnode *vi = EROFS_V(inode);
 	struct page *page;
-	void *data;
-	int err;
-	erofs_blk_t blkaddr;
-	unsigned ofs;
+	unsigned int ofs;
+	int err = 0;
 
 	trace_erofs_fill_inode(inode, isdir);
 
-	blkaddr = erofs_blknr(iloc(sbi, vi->nid));
-	ofs = erofs_blkoff(iloc(sbi, vi->nid));
-
-	debugln("%s, reading inode nid %llu at %u of blkaddr %u",
-		__func__, vi->nid, ofs, blkaddr);
-
-	page = erofs_get_meta_page(inode->i_sb, blkaddr, isdir);
-
+	/* read inode base data from disk */
+	page = read_inode(inode, &ofs);
 	if (IS_ERR(page)) {
-		errln("failed to get inode (nid: %llu) page, err %ld",
-			vi->nid, PTR_ERR(page));
 		return PTR_ERR(page);
-	}
-
-	DBG_BUGON(!PageUptodate(page));
-	data = page_address(page);
-
-	err = read_inode(inode, data + ofs);
-	if (!err) {
+	} else {
 		/* setup the new inode */
 		if (S_ISREG(inode->i_mode)) {
 #ifdef CONFIG_EROFS_FS_XATTR
@@ -229,7 +274,7 @@ static int fill_inode(struct inode *inode, int isdir)
 		inode->i_mapping->a_ops = &erofs_raw_access_aops;
 
 		/* fill last page if inline data is available */
-		fill_inline_data(inode, data, ofs);
+		fill_inline_data(inode, page_address(page), ofs);
 	}
 
 out_unlock:
-- 
2.27.0

