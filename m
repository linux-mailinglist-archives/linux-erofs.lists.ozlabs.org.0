Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 034996D6633
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Apr 2023 16:56:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PrW736Rfyz3cdt
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 00:56:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g147OSDi;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g147OSDi;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=aalbersh@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g147OSDi;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g147OSDi;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PrW6K3xWHz3cMy
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Apr 2023 00:55:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680620151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZ44esIMT3kAt7OLJeI5Rmr0v42z8alztiMuL7yx4Dc=;
	b=g147OSDin46DFlRGzPZ2MS3+xeHQAyAl86sXcO3V18hu8cWrsQ5mkIqED+DU7KpzGS0Jxl
	uKxM9mnZgoSdRz5rLGXJeEByS0BUJL0DH1FrhMVE9b+QoWzkU0ObsNd810aZV3PH/Zlm82
	P2zB4jTMFmrpGx21KuYjB+d7TykJkbE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680620151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZ44esIMT3kAt7OLJeI5Rmr0v42z8alztiMuL7yx4Dc=;
	b=g147OSDin46DFlRGzPZ2MS3+xeHQAyAl86sXcO3V18hu8cWrsQ5mkIqED+DU7KpzGS0Jxl
	uKxM9mnZgoSdRz5rLGXJeEByS0BUJL0DH1FrhMVE9b+QoWzkU0ObsNd810aZV3PH/Zlm82
	P2zB4jTMFmrpGx21KuYjB+d7TykJkbE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-mDaYs3fzN_eL4_NX-krk-w-1; Tue, 04 Apr 2023 10:55:49 -0400
X-MC-Unique: mDaYs3fzN_eL4_NX-krk-w-1
Received: by mail-qk1-f200.google.com with SMTP id p63-20020a374242000000b007468eaf866aso5347582qka.17
        for <linux-erofs@lists.ozlabs.org>; Tue, 04 Apr 2023 07:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZ44esIMT3kAt7OLJeI5Rmr0v42z8alztiMuL7yx4Dc=;
        b=Bfunn9H/nIggF78C8t3ljenKhYjBk3A55aSFPbeIBmSL+VaM9zPw5osbBMe+TIKzm7
         xz7/c64nM/u5d7krcOJJ8S/iwX/AD/yPzArMVLfd6mGvLAyKLT0Uc6h5ossT8dGz9FjN
         u0bKdoE/E2T3/+kQ08ueg88/ZelxUIrsJopWUEgvRHUxrMqBn0iWSVsUNDbW1oKYp2ab
         s+G99sgdk4PZH+nk3bPQA4qzHCZ/8heTbOTlaRmqKUm3XgXN3TAcqvxu2KFh/SNh9Shd
         OZwkhpbKYkwTrG3pglMio67Hz2zxqGMlHPj/ItXBs6R6Q5Kjz3/tcpF4eKjkQaZYTxQS
         C3YQ==
X-Gm-Message-State: AAQBX9cE2+9HkAiHh5OY8D7pSmTsSW2ShBiybraUgGfT9z8RxpTDMmjS
	l3UYy4Nb1uMP4Lu7vpt+2DQdHhJfbXnDMPgwXt58QNBZGYiFRPq0gf0w7305MSS1z2e2HhOl3GG
	2fVWJlcCrQ5jTT4O/i7CZkF4=
X-Received: by 2002:ac8:5ac8:0:b0:3e4:e2ee:7e5a with SMTP id d8-20020ac85ac8000000b003e4e2ee7e5amr4171021qtd.42.1680620148648;
        Tue, 04 Apr 2023 07:55:48 -0700 (PDT)
X-Google-Smtp-Source: AKy350bwc9iuzi42k6PG1Z2EHFjbux3ZcqY5pGuG2LoS+W27lrxGYKXLZLRw4bc6uW+B90GS0ZtH1g==
X-Received: by 2002:ac8:5ac8:0:b0:3e4:e2ee:7e5a with SMTP id d8-20020ac85ac8000000b003e4e2ee7e5amr4170973qtd.42.1680620148239;
        Tue, 04 Apr 2023 07:55:48 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id j4-20020ac86644000000b003e6387431dcsm3296539qtp.7.2023.04.04.07.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:55:48 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: djwong@kernel.org,
	dchinner@redhat.com,
	ebiggers@kernel.org,
	hch@infradead.org,
	linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev
Subject: [PATCH v2 20/23] xfs: add fs-verity support
Date: Tue,  4 Apr 2023 16:53:16 +0200
Message-Id: <20230404145319.2057051-21-aalbersh@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230404145319.2057051-1-aalbersh@redhat.com>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
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
Cc: linux-ext4@vger.kernel.org, agruenba@redhat.com, damien.lemoal@opensource.wdc.com, linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com, rpeterso@redhat.com, jth@kernel.org, linux-erofs@lists.ozlabs.org, Andrey Albershteyn <aalbersh@redhat.com>, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add integration with fs-verity. The XFS store fs-verity metadata in
the extended attributes. The metadata consist of verity descriptor
and Merkle tree blocks.

The descriptor is stored under "verity_descriptor" extended
attribute. The Merkle tree blocks are stored under binary indexes.

When fs-verity is enabled on an inode, the XFS_IVERITY_CONSTRUCTION
flag is set meaning that the Merkle tree is being build. The
initialization ends with storing of verity descriptor and setting
inode on-disk flag (XFS_DIFLAG2_VERITY).

The verification on read is done in iomap. Based on the inode verity
flag the IOMAP_F_READ_VERITY is set in xfs_read_iomap_begin() to let
iomap know that verification is needed.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/Makefile          |   1 +
 fs/xfs/libxfs/xfs_attr.c |  13 +++
 fs/xfs/xfs_inode.h       |   3 +-
 fs/xfs/xfs_iomap.c       |   3 +
 fs/xfs/xfs_ondisk.h      |   4 +
 fs/xfs/xfs_super.c       |   8 ++
 fs/xfs/xfs_verity.c      | 214 +++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_verity.h      |  19 ++++
 8 files changed, 264 insertions(+), 1 deletion(-)
 create mode 100644 fs/xfs/xfs_verity.c
 create mode 100644 fs/xfs/xfs_verity.h

diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
index 92d88dc3c9f7..76174770d91a 100644
--- a/fs/xfs/Makefile
+++ b/fs/xfs/Makefile
@@ -130,6 +130,7 @@ xfs-$(CONFIG_XFS_POSIX_ACL)	+= xfs_acl.o
 xfs-$(CONFIG_SYSCTL)		+= xfs_sysctl.o
 xfs-$(CONFIG_COMPAT)		+= xfs_ioctl32.o
 xfs-$(CONFIG_EXPORTFS_BLOCK_OPS)	+= xfs_pnfs.o
+xfs-$(CONFIG_FS_VERITY)		+= xfs_verity.o
 
 # notify failure
 ifeq ($(CONFIG_MEMORY_FAILURE),y)
diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
index 298b74245267..39d9038fbeee 100644
--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -26,6 +26,7 @@
 #include "xfs_trace.h"
 #include "xfs_attr_item.h"
 #include "xfs_xattr.h"
+#include "xfs_verity.h"
 
 struct kmem_cache		*xfs_attr_intent_cache;
 
@@ -1635,6 +1636,18 @@ xfs_attr_namecheck(
 		return xfs_verify_pptr(mp, (struct xfs_parent_name_rec *)name);
 	}
 
+	if (flags & XFS_ATTR_VERITY) {
+		/* Merkle tree pages are stored under u64 indexes */
+		if (length == sizeof(__be64))
+			return true;
+
+		/* Verity descriptor blocks are held in a named attribute. */
+		if (length == XFS_VERITY_DESCRIPTOR_NAME_LEN)
+			return true;
+
+		return false;
+	}
+
 	return xfs_str_attr_namecheck(name, length);
 }
 
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 69d21e42c10a..a95f28cb049f 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -324,7 +324,8 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
  * inactivation completes, both flags will be cleared and the inode is a
  * plain old IRECLAIMABLE inode.
  */
-#define XFS_INACTIVATING	(1 << 13)
+#define XFS_INACTIVATING		(1 << 13)
+#define XFS_IVERITY_CONSTRUCTION	(1 << 14) /* merkle tree construction */
 
 /* All inode state flags related to inode reclaim. */
 #define XFS_ALL_IRECLAIM_FLAGS	(XFS_IRECLAIMABLE | \
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index e0f3c5d709f6..0adde39f02a5 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -143,6 +143,9 @@ xfs_bmbt_to_iomap(
 	    (ip->i_itemp->ili_fsync_fields & ~XFS_ILOG_TIMESTAMP))
 		iomap->flags |= IOMAP_F_DIRTY;
 
+	if (fsverity_active(VFS_I(ip)))
+		iomap->flags |= IOMAP_F_READ_VERITY;
+
 	iomap->validity_cookie = sequence_cookie;
 	iomap->folio_ops = &xfs_iomap_folio_ops;
 	return 0;
diff --git a/fs/xfs/xfs_ondisk.h b/fs/xfs/xfs_ondisk.h
index 9737b5a9f405..7fe88ccda519 100644
--- a/fs/xfs/xfs_ondisk.h
+++ b/fs/xfs/xfs_ondisk.h
@@ -189,6 +189,10 @@ xfs_check_ondisk_structs(void)
 	XFS_CHECK_VALUE(XFS_DQ_BIGTIME_EXPIRY_MIN << XFS_DQ_BIGTIME_SHIFT, 4);
 	XFS_CHECK_VALUE(XFS_DQ_BIGTIME_EXPIRY_MAX << XFS_DQ_BIGTIME_SHIFT,
 			16299260424LL);
+
+	/* fs-verity descriptor xattr name */
+	XFS_CHECK_VALUE(strlen(XFS_VERITY_DESCRIPTOR_NAME),
+			XFS_VERITY_DESCRIPTOR_NAME_LEN);
 }
 
 #endif /* __XFS_ONDISK_H */
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index d40de32362b1..b6e99ed3b187 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -30,6 +30,7 @@
 #include "xfs_filestream.h"
 #include "xfs_quota.h"
 #include "xfs_sysfs.h"
+#include "xfs_verity.h"
 #include "xfs_ondisk.h"
 #include "xfs_rmap_item.h"
 #include "xfs_refcount_item.h"
@@ -1489,6 +1490,9 @@ xfs_fs_fill_super(
 	sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP | QTYPE_MASK_PRJ;
 #endif
 	sb->s_op = &xfs_super_operations;
+#ifdef CONFIG_FS_VERITY
+	sb->s_vop = &xfs_verity_ops;
+#endif
 
 	/*
 	 * Delay mount work if the debug hook is set. This is debug
@@ -1685,6 +1689,10 @@ xfs_fs_fill_super(
 		xfs_warn(mp,
 	"EXPERIMENTAL Large extent counts feature in use. Use at your own risk!");
 
+	if (xfs_has_verity(mp))
+		xfs_alert(mp,
+	"EXPERIMENTAL fs-verity feature in use. Use at your own risk!");
+
 	error = xfs_mountfs(mp);
 	if (error)
 		goto out_filestream_unmount;
diff --git a/fs/xfs/xfs_verity.c b/fs/xfs/xfs_verity.c
new file mode 100644
index 000000000000..a9874ff4efcd
--- /dev/null
+++ b/fs/xfs/xfs_verity.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Red Hat, Inc.
+ */
+#include "xfs.h"
+#include "xfs_shared.h"
+#include "xfs_format.h"
+#include "xfs_da_format.h"
+#include "xfs_da_btree.h"
+#include "xfs_trans_resv.h"
+#include "xfs_mount.h"
+#include "xfs_inode.h"
+#include "xfs_attr.h"
+#include "xfs_verity.h"
+#include "xfs_bmap_util.h"
+#include "xfs_log_format.h"
+#include "xfs_trans.h"
+
+static int
+xfs_get_verity_descriptor(
+	struct inode		*inode,
+	void			*buf,
+	size_t			buf_size)
+{
+	struct xfs_inode	*ip = XFS_I(inode);
+	int			error = 0;
+	struct xfs_da_args	args = {
+		.dp		= ip,
+		.attr_filter	= XFS_ATTR_VERITY,
+		.name		= (const uint8_t *)XFS_VERITY_DESCRIPTOR_NAME,
+		.namelen	= XFS_VERITY_DESCRIPTOR_NAME_LEN,
+		.value		= buf,
+		.valuelen	= buf_size,
+	};
+
+	/*
+	 * The fact that (returned attribute size) == (provided buf_size) is
+	 * checked by xfs_attr_copy_value() (returns -ERANGE)
+	 */
+	error = xfs_attr_get(&args);
+	if (error)
+		return error;
+
+	return args.valuelen;
+}
+
+static int
+xfs_begin_enable_verity(
+	struct file	    *filp)
+{
+	struct inode	    *inode = file_inode(filp);
+	struct xfs_inode    *ip = XFS_I(inode);
+	int		    error = 0;
+
+	ASSERT(xfs_isilocked(ip, XFS_IOLOCK_EXCL));
+
+	if (IS_DAX(inode))
+		return -EINVAL;
+
+	if (xfs_iflags_test(ip, XFS_IVERITY_CONSTRUCTION))
+		return -EBUSY;
+	xfs_iflags_set(ip, XFS_IVERITY_CONSTRUCTION);
+
+	return error;
+}
+
+static int
+xfs_end_enable_verity(
+	struct file		*filp,
+	const void		*desc,
+	size_t			desc_size,
+	u64			merkle_tree_size)
+{
+	struct inode		*inode = file_inode(filp);
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_trans	*tp;
+	struct xfs_da_args	args = {
+		.dp		= ip,
+		.whichfork	= XFS_ATTR_FORK,
+		.attr_filter	= XFS_ATTR_VERITY,
+		.attr_flags	= XATTR_CREATE,
+		.name		= (const uint8_t *)XFS_VERITY_DESCRIPTOR_NAME,
+		.namelen	= XFS_VERITY_DESCRIPTOR_NAME_LEN,
+		.value		= (void *)desc,
+		.valuelen	= desc_size,
+	};
+	int			error = 0;
+
+	ASSERT(xfs_isilocked(ip, XFS_IOLOCK_EXCL));
+
+	/* fs-verity failed, just cleanup */
+	if (desc == NULL)
+		goto out;
+
+	error = xfs_attr_set(&args);
+	if (error)
+		goto out;
+
+	/* Set fsverity inode flag */
+	error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_ichange,
+			0, 0, false, &tp);
+	if (error)
+		goto out;
+
+	/*
+	 * Ensure that we've persisted the verity information before we enable
+	 * it on the inode and tell the caller we have sealed the inode.
+	 */
+	ip->i_diflags2 |= XFS_DIFLAG2_VERITY;
+
+	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
+	xfs_trans_set_sync(tp);
+
+	error = xfs_trans_commit(tp);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+
+	if (!error)
+		inode->i_flags |= S_VERITY;
+
+out:
+	xfs_iflags_clear(ip, XFS_IVERITY_CONSTRUCTION);
+	return error;
+}
+
+static struct page *
+xfs_read_merkle_tree_page(
+	struct inode		*inode,
+	pgoff_t			index,
+	unsigned long		num_ra_pages,
+	u8			log_blocksize)
+{
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct page		*page = NULL;
+	__be64			name = cpu_to_be64(index << PAGE_SHIFT);
+	uint32_t		bs = 1 << log_blocksize;
+	struct xfs_da_args	args = {
+		.dp		= ip,
+		.attr_filter	= XFS_ATTR_VERITY,
+		.op_flags	= XFS_DA_OP_BUFFER,
+		.name		= (const uint8_t *)&name,
+		.namelen	= sizeof(__be64),
+		.valuelen	= bs,
+	};
+	int			error = 0;
+
+	page = alloc_page(GFP_KERNEL);
+	if (!page)
+		return ERR_PTR(-ENOMEM);
+
+	error = xfs_attr_get(&args);
+	if (error) {
+		kmem_free(args.value);
+		xfs_buf_rele(args.bp);
+		put_page(page);
+		return ERR_PTR(-EFAULT);
+	}
+
+	if (args.bp->b_flags & XBF_VERITY_CHECKED)
+		SetPageChecked(page);
+
+	page->private = (unsigned long)args.bp;
+	memcpy(page_address(page), args.value, args.valuelen);
+
+	kmem_free(args.value);
+	return page;
+}
+
+static int
+xfs_write_merkle_tree_block(
+	struct inode		*inode,
+	const void		*buf,
+	u64			pos,
+	unsigned int		size)
+{
+	struct xfs_inode	*ip = XFS_I(inode);
+	__be64			name = cpu_to_be64(pos);
+	struct xfs_da_args	args = {
+		.dp		= ip,
+		.whichfork	= XFS_ATTR_FORK,
+		.attr_filter	= XFS_ATTR_VERITY,
+		.attr_flags	= XATTR_CREATE,
+		.name		= (const uint8_t *)&name,
+		.namelen	= sizeof(__be64),
+		.value		= (void *)buf,
+		.valuelen	= size,
+	};
+
+	return xfs_attr_set(&args);
+}
+
+static void
+xfs_drop_page(
+	struct page	*page)
+{
+	struct xfs_buf *buf = (struct xfs_buf *)page->private;
+
+	ASSERT(buf != NULL);
+
+	if (PageChecked(page))
+		buf->b_flags |= XBF_VERITY_CHECKED;
+
+	xfs_buf_rele(buf);
+	put_page(page);
+}
+
+const struct fsverity_operations xfs_verity_ops = {
+	.begin_enable_verity = &xfs_begin_enable_verity,
+	.end_enable_verity = &xfs_end_enable_verity,
+	.get_verity_descriptor = &xfs_get_verity_descriptor,
+	.read_merkle_tree_page = &xfs_read_merkle_tree_page,
+	.write_merkle_tree_block = &xfs_write_merkle_tree_block,
+	.drop_page = &xfs_drop_page,
+};
diff --git a/fs/xfs/xfs_verity.h b/fs/xfs/xfs_verity.h
new file mode 100644
index 000000000000..ae5d87ca32a8
--- /dev/null
+++ b/fs/xfs/xfs_verity.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Red Hat, Inc.
+ */
+#ifndef __XFS_VERITY_H__
+#define __XFS_VERITY_H__
+
+#include <linux/fsverity.h>
+
+#define XFS_VERITY_DESCRIPTOR_NAME "verity_descriptor"
+#define XFS_VERITY_DESCRIPTOR_NAME_LEN 17
+
+#ifdef CONFIG_FS_VERITY
+extern const struct fsverity_operations xfs_verity_ops;
+#else
+#define xfs_verity_ops NULL
+#endif	/* CONFIG_FS_VERITY */
+
+#endif	/* __XFS_VERITY_H__ */
-- 
2.38.4

