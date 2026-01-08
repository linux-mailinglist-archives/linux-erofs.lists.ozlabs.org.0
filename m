Return-Path: <linux-erofs+bounces-1729-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D184D04CB0
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 18:14:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dnBNX70Dwz2xGF;
	Fri, 09 Jan 2026 04:14:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767892492;
	cv=none; b=Z7t4k0HSDNyov507NQFoVcVOa6FPL6Pvtr+D9REZG4XH8DHTXj1HRk8VyvgBkdX/vAK8VFc+8w1YQncXdw9Vb8uaDAjfQsShHIGVrr7Z1VdAJSUUyd7iqLObM5+onkT0rvjEK5FNY2zJr/PnHoD4aabfpcj8Z0Qa0e2pJCB8tYl3ob8TgpWj5eG97jtJou59K93KYgY/59CJb5blXWFsErYrrCdJF/bZNlCI1jOlBqfPAUzTjZ/wkSODVziaTTurk/Cb3A3cdVr6qV+flojNWrZOiFOMhjdhr6IBw+/8Sq9NaWMuifHAqq7tLJU/ftMH46rowpTJ6p/Iy7UvFMjyjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767892492; c=relaxed/relaxed;
	bh=HFHk+jGYiYNdAMGXV5WQR542mqPeU3BzqR3Gc2vQLoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aGmqAzwl/gXWTwDtGYq5f7xNLcysPNu1SZKThadF1h7q9edkLe1DW6wnQ8DwxkeMV/5/IhvA98RpVNbzTYSL6h3ZHfSbT84vuyIRST3kvM6r/bP8fqsdsdEYRalVpPB0FwOa+2fdyiszweFkd6xOwPnMvZ8/Xn/2ftG3n7q3LH7tbNTfZ+aDUK7CBeRyqJJ/9rFUQInhzRSlbsv9UcPF9b2phAA/C9G8CE1RNCP6AbL5RMemrjdRxGt5hZ76DSfZKaHii3IKxiUP+fQbk+RjHq2QyMUtSUqg64TOcmSxboIOStJeQIfyZrntjx3Bg9CmyCaZqexPW0QerfNUtD7PQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EE2gZbpw; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EE2gZbpw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dnBNX1sxGz2yFk
	for <linux-erofs@lists.ozlabs.org>; Fri, 09 Jan 2026 04:14:52 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A6A1540847;
	Thu,  8 Jan 2026 17:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C48BC2BCB3;
	Thu,  8 Jan 2026 17:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892490;
	bh=dYgR/946dJwV9AewaF5e0d1y1o9rSJR9ABQBhS2Sc1E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EE2gZbpwilK+p65zJF+DVJq4MFRPaZe1eMYvJUmFsGZDgMyF9n/0nbfU8VldhCR1Z
	 ig2YvmBFJpERXaOR1YuP8VA85WDlJx1s5XTX9JaCi+k8TeGUUxrgEFvZcgCNcmK4jM
	 zUWajICcygLLxU/fnv7Bl0PM/k0sAGhrvfexl8QZcHgN41M0I+dTkt3cpSxxsgsmlm
	 8VMU/MUbvQcy4wKiuCyibQqAQFhRM8TAJqiPwzb0h9MYwLHKGZXNeFJJU/dHSWsMCt
	 hthHXEtbuWS1TAGQjZX+0TQBu0a5iqkHqTAFklVluh7jPWvQ1npZjrBYPStgmQMhhH
	 tLNIRSDSTwisA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 08 Jan 2026 12:13:04 -0500
Subject: [PATCH 09/24] fat: add setlease file operation
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
Message-Id: <20260108-setlease-6-20-v1-9-ea4dec9b67fa@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1802; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=dYgR/946dJwV9AewaF5e0d1y1o9rSJR9ABQBhS2Sc1E=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpX+W6tow5eWlg3d9LlE4JzeKYs4qhQrQSZqLyH
 28Sqlg8Yd2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV/lugAKCRAADmhBGVaC
 FXExD/4+xtepcLHtJswdWEgDrfCU1l+JV7R1ZY6za66bEWKzixlzEz5aEKjLNSkfDp6latYm0WV
 nQmECaiV0baGSZOSWYMEDHJxt8XCYei2h8uIIVVGTLuh19g8JU4y6ZwbvI6IbIWBZSML25ObG/k
 BGNBwe/I+4nGuNM4MAI6DzSKz0cnW+TQv9wtK27EfsFB9aE8xFNHtQBXrfbRKkMsFHlt8nRnWgL
 0CZlHx3wVern/FfuVElMRYXy0j8AVkjyUJxjWPvou9n1slugfh22VXcVn485XauIBxfx5F0+oJF
 Rg7mIbM5ZKrWl8BlLK4Nz24ikHNS+GO6Pl5zNOULmo5Avxq7WPmb6fIIotCODNKWbgrZ+WInbFr
 J2Mx450orrxaXQQ+ZxHv/FzG/RCq/jhW5on4+b/h3zDTBMbA9x+9eFRX3r4gmgQazMA3tL5LKmc
 dam7IMlqI1d0VjMQVGvcVYcanw4zoarKDKQoBd2lwX6SpSc4nSezLKBdMQirlmjJUQIF6U2l04P
 nbP0DomAF2vMA9H5kiyvMnMt0ojouLw/0ANYcWfJ3QIB1anSGvKDmmIiR9GgacsdwFbwJOTNCjQ
 xaaBKflgwoM3KB7kjLzZpogI65tiWTabuagt5tmxM4laxXId94a5+ZfJ8v0Vr9W8dJFWBx+K7G4
 +olNbY50fwTUfZg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the setlease file_operation to fat_file_operations and
fat_dir_operations, pointing to generic_setlease.  A future patch will
change the default behavior to reject lease attempts with -EINVAL when
there is no setlease file operation defined. Add generic_setlease to
retain the ability to set leases on this filesystem.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fat/dir.c  | 2 ++
 fs/fat/file.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 92b091783966af6a9e6f5ead1a382a98dd92bba0..807bc8b1bc145a9f15765920670c6233f7e87e55 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -16,6 +16,7 @@
 
 #include <linux/slab.h>
 #include <linux/compat.h>
+#include <linux/filelock.h>
 #include <linux/uaccess.h>
 #include <linux/iversion.h>
 #include "fat.h"
@@ -876,6 +877,7 @@ const struct file_operations fat_dir_operations = {
 	.compat_ioctl	= fat_compat_dir_ioctl,
 #endif
 	.fsync		= fat_file_fsync,
+	.setlease	= generic_setlease,
 };
 
 static int fat_get_short_entry(struct inode *dir, loff_t *pos,
diff --git a/fs/fat/file.c b/fs/fat/file.c
index 4fc49a614fb8fd64e219db60c6d9e7dd100aea1c..d50a6d8bfaae0c75b2dbe838d108135206d0f123 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -13,6 +13,7 @@
 #include <linux/mount.h>
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
+#include <linux/filelock.h>
 #include <linux/fsnotify.h>
 #include <linux/security.h>
 #include <linux/falloc.h>
@@ -212,6 +213,7 @@ const struct file_operations fat_file_operations = {
 	.splice_read	= filemap_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= fat_fallocate,
+	.setlease	= generic_setlease,
 };
 
 static int fat_cont_expand(struct inode *inode, loff_t size)

-- 
2.52.0


