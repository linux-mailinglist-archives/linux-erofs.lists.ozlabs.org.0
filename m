Return-Path: <linux-erofs+bounces-1726-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE60D04C8D
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 18:14:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dnBN62Xdfz2yFn;
	Fri, 09 Jan 2026 04:14:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767892470;
	cv=none; b=ahkC1A98II9uRjXT8zPZs9eK9ePZtFoq4zwsVSx0tQ1dXG5hgWscXnoruo/tT7tUmcKoJyaotQYQGDvikj6B6WGhHFKRnQaz/Xde1Ys8b7sMpnsmHClCZ+Znrv4Sg9VM0SewdPGEBj79LGrZB0vr2Fh31pfRfsT5RsuQkKhklRLaP2hDldyYyyoxfJY1N6tEAlr42n5BSfOVMvwqpZBwS5ysTgETpsmC9orGyYOT017O5GkKTk56MPjJJDC2pIWwQ7BWeYL6zKhtwEiqp0Hpw01pqqddVtlAvIMCWtPIxzTy7dl9WKm7EtdKWPTGuO6MgYofaNkaaiPA1CxyXPvUSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767892470; c=relaxed/relaxed;
	bh=4Ans1oOdE3NYLSz974mpEX/DcKF2I12Io514v9DbvaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lykr1hDAOCn0Y2mS9WBKOt2r0WepPmYjt5WOgwhrw5FKCxJ87C/fmJ/kkHQ9q5BXCk1vZSmRYKKfhCyyTUAQwbc1qddfR5Go45BFM2b2uD0BdJpVbd0GMwrV46R5FlYkVK/8VTj88O3h6yxDMVK1/8YzvmP6M8AvZ1DS4QpSOFC1VhvKuJ+F4KXPAT4HpM8qm5f5D5EZ6iPwYCujt5mxFaqmb93UkifIMIlq6BSrnuXKWoC7SEi/ia9ken8yMPz0RkU8Cn8Z2Ab55Oxi0Xy20/zgeCGY1+BfVLXq1nP3K2fvrE/DO0p0aIt8Kj/NlM082WWSzuomuykmyl/gQlot9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=d9MmB1m0; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=d9MmB1m0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dnBN54Df0z2xcB
	for <linux-erofs@lists.ozlabs.org>; Fri, 09 Jan 2026 04:14:29 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id EEBB444451;
	Thu,  8 Jan 2026 17:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7486EC19422;
	Thu,  8 Jan 2026 17:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892467;
	bh=hlxGHkYb3xkFH9tUolL/syLb6jWJ/uBVgo3tjpiBxyY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=d9MmB1m04Yq51+yvLj5Igg5jvjt2pHNxTK/fBefOXh8TeU4uLphzQaxU6IN9Pl04A
	 tBoV9hqBlk7GrHjFDyAHkh6LbqS7sqpCYUy/uoeiRJFegNbaFGoIR6bSSAPvq95x5b
	 3b0SAShJkVnakBG128c5vI/jQfrSS/P2TDGfDgGUgi59ILalooVkG0diDEYBmCbaSk
	 iqhZQYGDY3tXw2lXE6dkvpWeMQR+GcH0PTKSfpBqJDNYo/o+MTaFT+NUjuvjcrOq3e
	 msPZWt4sPG8TodhD1Ox97c2Oy73trggOtjHggajWT0gizYqDghDAFLpOjOEnQ7tPwQ
	 GG2zYe58TRBpw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 08 Jan 2026 12:13:01 -0500
Subject: [PATCH 06/24] ext4: add setlease file operation
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-setlease-6-20-v1-6-ea4dec9b67fa@kernel.org>
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
In-Reply-To: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
To: Luis de Bethencourt <luisbg@kernel.org>, 
 Salah Triki <salah.triki@gmail.com>, Nicolas Pitre <nico@fluxnic.net>, 
 Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, 
 Anders Larsen <al@alarsen.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, David Sterba <dsterba@suse.com>, 
 Chris Mason <clm@fb.com>, Gao Xiang <xiang@kernel.org>, 
 Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
 Jeffle Xu <jefflexu@linux.alibaba.com>, 
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
 Chunhai Guo <guochunhai@vivo.com>, Jan Kara <jack@suse.com>, 
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
 Jaegeuk Kim <jaegeuk@kernel.org>, 
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
 David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, 
 Dave Kleikamp <shaggy@kernel.org>, 
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, 
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
 Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Mike Marshall <hubcap@omnibond.com>, 
 Martin Brandenburg <martin@omnibond.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Phillip Lougher <phillip@squashfs.org.uk>, Carlos Maiolino <cem@kernel.org>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
 Yuezhang Mo <yuezhang.mo@sony.com>, Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Andreas Gruenbacher <agruenba@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, Hans de Goede <hansg@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
 linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net, 
 linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev, 
 ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-mm@kvack.org, gfs2@lists.linux.dev, linux-doc@vger.kernel.org, 
 v9fs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1728; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=hlxGHkYb3xkFH9tUolL/syLb6jWJ/uBVgo3tjpiBxyY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpX+W6t0mhuGkERJYbFwmyCbgn+H1ouSbEbBOhS
 BmnbuhF9HOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV/lugAKCRAADmhBGVaC
 FUEED/9lGYU2hYsgRrdekmYbHARu7YG2VzVJ9YJTF7i9daxcdOeAV+CM9pvICZhlQXj7ksl2zyk
 +MlC/fF9o43MeuUs82UhWCwUlrjoQWEHCxkZi/kEGCtyrXZStdPHmGPs/jBMBERxfYcccrVRote
 Af82hjhi7S8o/SeYi72kfMiuEbK+TrD5GIbE/l8Pg07AYvM82MejivNSUusmV3nW9TgqpebQOU8
 igqsQPEsODeiWZHFiXaR5yJjNhDdogUGW+iBWXFcfC9EZTc3nSGO83mSmVqTcFNnMJ3ojOQaOa4
 JuNqiG7LDyYmfHkVs8jgVxjYG/PUKziFr6CYquQnsGZi5E39ZVl8HX4iSqKoPh6FjDpc1PDG8yr
 QYPwrdKSZBX5fr5wwy7yrWcwlZeMlCXzoid+Fop70v07YQPWJ5OmwUD7N9Bg0dxArH+srCGIgTR
 p3f2C5FWpQ05m0xTZ7E7oc6KD34XFgwXIJLCPTEwp3nfRY3+IYLQcH4qfJuCCQSB0waZJ/jDV88
 30C0Sp5Ujwb281ckPPKOaDzTtEThYd9Z6U5y6u/ov+PhxJrsPh9JtyAW4Mq+D1+Ds+b5ysfCvDu
 fGntd6Oj1rEilxy6v1snzESsLykyBBKAn/sMaXn4sW1rixrdAHhQ+hW+SLj+O2Z3iVmdb1IRscZ
 CKvOoSCXs9sf55Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the setlease file_operation to ext4_file_operations and
ext4_dir_operations, pointing to generic_setlease.  A future patch will
change the default behavior to reject lease attempts with -EINVAL when
there is no setlease file operation defined. Add generic_setlease to
retain the ability to set leases on this filesystem.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ext4/dir.c  | 2 ++
 fs/ext4/file.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 256fe2c1d4c1619eb2cd915d8b6b05bce72656e7..00c4b3c82b6534790962dc3964c0c557162b6dff 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -24,6 +24,7 @@
 
 #include <linux/fs.h>
 #include <linux/buffer_head.h>
+#include <linux/filelock.h>
 #include <linux/slab.h>
 #include <linux/iversion.h>
 #include <linux/unicode.h>
@@ -690,4 +691,5 @@ const struct file_operations ext4_dir_operations = {
 #endif
 	.fsync		= ext4_sync_file,
 	.release	= ext4_release_dir,
+	.setlease	= generic_setlease,
 };
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 7a8b3093218921f26a7f8962f94739ba49431230..534cf864101f8d1e5f4106b61c0580c858bc0e27 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -25,6 +25,7 @@
 #include <linux/mount.h>
 #include <linux/path.h>
 #include <linux/dax.h>
+#include <linux/filelock.h>
 #include <linux/quotaops.h>
 #include <linux/pagevec.h>
 #include <linux/uio.h>
@@ -980,6 +981,7 @@ const struct file_operations ext4_file_operations = {
 	.fop_flags	= FOP_MMAP_SYNC | FOP_BUFFER_RASYNC |
 			  FOP_DIO_PARALLEL_WRITE |
 			  FOP_DONTCACHE,
+	.setlease	= generic_setlease,
 };
 
 const struct inode_operations ext4_file_inode_operations = {

-- 
2.52.0


