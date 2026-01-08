Return-Path: <linux-erofs+bounces-1730-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BC0D04CD1
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 18:15:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dnBNq6g8Lz2yFm;
	Fri, 09 Jan 2026 04:15:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767892507;
	cv=none; b=OlktBn894bm2oclmNBZT81SM0jY5xAzuCWfE70JU+x+/kjgaA+P3H9FX8OLkzjrKLoYTT5RZIItQiS2G4ljBmOnTFTzOpOurGP/6YKDon3mnMU1eU3LQ7qHudiEIIOnEFoeHlraH7nejLDqSVwopMTAQ5x+Jizgmhs1pPqKGuCylqa8LQ1Kvi8n4913mNp8HbPIygP7jnX13i9g+gvlavcpiX2K5807F4Hirs3qYFF9Dv36KoxtIY+J/7xk08UqOK4oakSLgPBzrbVL8HGWFwQjEeLJKzoFFAMuEcFyb7/VUVfNv5phFI9vSb5oBZ5tGBHusvmuST5UtHF+pqwGRjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767892507; c=relaxed/relaxed;
	bh=3OlUsuC3/tNLYn+8rD9Zi3/RFls3AiER79V4RwQ4nc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I7yms4oB4nUpmsT2UQMC5cy0BVZHLzgbyUwBG/lT0JxId3ShsAV5WISv8p3kzGqgcIN2jr2d2nDhql9JCl7mJEUruUrp93Eye20Yeg/K7SiYeFuhKGP/wlNwGOw9Czz6WOpplM2O+lNPmwDy962EdBACK5hydTVMf4rymWmvepMPdrzGseC5TRfAadefbHnkHSgPJ4CPLTE42w0fnC2Feodw/sZ2bal7nRfR6gRJvYMQIgNtb/0HgZDpHPTu8O0cI6T6/GYYgY3pWJ0zHm527imjf5Ynd0vxmD3c3nQtVNQa2XUF9Dj8oX09dPi/uoX27TYQXBw8c0As+wTEoDfPTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oU0MEVns; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oU0MEVns;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dnBNq1cr8z2yFk
	for <linux-erofs@lists.ozlabs.org>; Fri, 09 Jan 2026 04:15:07 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8B6A54098D;
	Thu,  8 Jan 2026 17:14:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B1DC116C6;
	Thu,  8 Jan 2026 17:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892475;
	bh=U7S0etaEv8XbcYfILfSSuzi+P7a+aG4oaPVvVEC0yKw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oU0MEVnsPzUmFg1DgiNPR9jxtVRsEn7l/25FyE5LGlckCNBp+ENrt67kCjhVH5n/E
	 zUaOzKc9aREGF9AKTJrNr0Rftiq++U8TGZnZjznWIv+syt5eODEn4APKEj9dNLXima
	 7JJb6r/6wJUoQd73NcJWDUf+NlabMWRg1s7OqO5z5oMjUirzXGHOCnCcD1RQGcZ95S
	 vRocEgo2x33kwDf5L4xrumMgBdS+trBbwKddwqrRjYW6GkjFg8dy1NsDv8/ijKxawe
	 fOByUQkqqB9sk2qDeQ/9eAZ5pVn10R/SRrQJmjhnIo9XuAXHFwfyfUzybWFtyBWa8o
	 0MPK2Xd8XRorQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 08 Jan 2026 12:13:02 -0500
Subject: [PATCH 07/24] exfat: add setlease file operation
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
Message-Id: <20260108-setlease-6-20-v1-7-ea4dec9b67fa@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1804; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=U7S0etaEv8XbcYfILfSSuzi+P7a+aG4oaPVvVEC0yKw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpX+W6RfUKKljQL5Cerh3GnT9/0uP0/MXv1o7St
 HVKnAUnvHCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV/lugAKCRAADmhBGVaC
 FZDVD/oDif45OVfg9r6Fnp2duoc1ElrjVnT9zhMMN8e/dccZgQ+m2endixk1Sa0MscAhPTCtGcu
 x2/DO4X2z41Lo58GZ1NyL5KfL9P/+EOjWPIovpdUVxwwJy7jnZeNnvUz9tSI1aDM7h8A05j4M9p
 fnODqkW02HUKmsM4OggWTlkZ/eQz/FdjIBOKtaFRMIhjK+B/cGbDRxYGCgr/xh9XEMuBXjqUhAo
 mrY76LpHrL5qFr3AqkA8ZeffDzbIoojosSfBAMyJsmiFRP047IjUUogVtqBiZafCWpcXwUVqvEZ
 VZwu0yqPzEolFeWhrCVXFMddwXwwx4yzt+4FcC14VloO5z+nisM9tHC20UHl1I3+MixDfeTRm1d
 hvRgAsLtnlBX7+R+3wEYS+aaR1XzsZkp9UnKpYzDHbnDbTEwn5x7lHENLDa4AIkZUAsxPxjsuC6
 oYzrCHQE9DU840ojM1nH/xuau6QN8GKVRP2gmEJvN29+aOm6SK0Awz6OlXcY07tAsaa5bbgjINN
 kEqi0Ihm/y6NAkhwuv4500UIgyZCvqWAKA195H1vaFW5iPkzwEGsClkorDQP0y+1pk4EzakLSh2
 gKuFpo0wSckYsBecgX4VD990C+dTmOYHY11wmjH5dsqaYfgHtUIq/gKbzngZY+T2nQmxrVNd58f
 ENhaby327F711/g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the setlease file_operation to exfat_file_operations and
exfat_dir_operations, pointing to generic_setlease.  A future patch
will change the default behavior to reject lease attempts with -EINVAL
when there is no setlease file operation defined. Add generic_setlease
to retain the ability to set leases on this filesystem.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/exfat/dir.c  | 2 ++
 fs/exfat/file.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 3045a58e124ae0f193af2caeef7261b20fe42e00..2dbf335eafefc5f51a5c70598786c35b85e2118d 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -7,6 +7,7 @@
 #include <linux/compat.h>
 #include <linux/bio.h>
 #include <linux/buffer_head.h>
+#include <linux/filelock.h>
 
 #include "exfat_raw.h"
 #include "exfat_fs.h"
@@ -298,6 +299,7 @@ const struct file_operations exfat_dir_operations = {
 	.compat_ioctl = exfat_compat_ioctl,
 #endif
 	.fsync		= exfat_file_fsync,
+	.setlease	= generic_setlease,
 };
 
 int exfat_alloc_new_dir(struct inode *inode, struct exfat_chain *clu)
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 536c8078f0c192688eed5f5ee86dd1bc738be84f..b60ee0e1bec9344145a6328cdd727e35b317c08a 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -12,6 +12,7 @@
 #include <linux/security.h>
 #include <linux/msdos_fs.h>
 #include <linux/writeback.h>
+#include <linux/filelock.h>
 
 #include "exfat_raw.h"
 #include "exfat_fs.h"
@@ -772,6 +773,7 @@ const struct file_operations exfat_file_operations = {
 	.fsync		= exfat_file_fsync,
 	.splice_read	= exfat_splice_read,
 	.splice_write	= iter_file_splice_write,
+	.setlease	= generic_setlease,
 };
 
 const struct inode_operations exfat_file_inode_operations = {

-- 
2.52.0


