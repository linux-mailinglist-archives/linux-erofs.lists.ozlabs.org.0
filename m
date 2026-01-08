Return-Path: <linux-erofs+bounces-1745-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 046C6D04D9B
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 18:16:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dnBQt3nTzz2yMh;
	Fri, 09 Jan 2026 04:16:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767892614;
	cv=none; b=ae7I1738hoiGuFdwL8Hhq0b6EWM5jCZo74y0ndQZx/OG2mFmAKIF8IHhRqWbvFsYlClKPl4VGWKK5JdBfNWF2tdH2O2nC4QwebOYcvHmnx2CgeL7d/tVGaliIg4YSWaB9HbhTEO5AmLlgLwrNKRE2r9IsoS6KeE5gseNwYffQ3PjITCQGuGTKUDGuOS1AT4ypxWyB3EXwQoftIbi+Y1TY21N6qwiUZ9H4zc5hSV/3LpffKQ8ejcUmpOfzmwDvVb9NBeiCEwQcOtb72fPcz6pxa6MoFxzW9zSRGkHe2aEPyX6iMJK2rYARrTPviL20wazNoihH4AHFIaZJOg4Dp+2ng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767892614; c=relaxed/relaxed;
	bh=YxI57s6/K+xSGvKm8JB2Aq9p64eelY1MHz0jZWF74oU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=et6AXH0qkszRd+Co2bHSrOGDwuXhNboUoKErPPW4ZMI9FPAARAkirEvV5xemhkfTihKkdJE81IoXUK7pMOFpqUYcNUxE5i7ZJZGYWIvAOIzdr9W8dN3ED1gf+D3NOQZBTfNpWkXxw2M/AjbCIRfJXbaD8u2VON4UIBxGN6oHZ66e9p1G5MMkMclUpUByc3ehpnEX3Xg+WfMhatmcLXSeryZ7ez4FsBtvgXS6e6JrXySVKvKF10xgLujUpNhNuBl6ITvCijM3icBHx6VBmrlPvu4pFXjC92h60i/oqwrZlSLLRC5qqn+SyYILgR1o29C25TQ4lHwnbfDBzX2zEgmHMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N+KAwUSN; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N+KAwUSN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dnBQs5x61z2yMJ
	for <linux-erofs@lists.ozlabs.org>; Fri, 09 Jan 2026 04:16:53 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3859A42BAD;
	Thu,  8 Jan 2026 17:16:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9066C2BCAF;
	Thu,  8 Jan 2026 17:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892582;
	bh=uKAoYiUzb2k4mWk3DPDn1qw2MlMadC9ZK+Ro0COSfEk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=N+KAwUSN5aLOeh58U18x1Ce3wnLpBZV5zhe4kxwBm8fPRX5wOYoSQkrqxYodHIYXJ
	 aw/tNdkO6s3F+xmbKKmGdGwZPQ7OcAFF6cZu+pkYIBzXkHIXu/l1HGZ9m9oVzb233T
	 pb1QsAcwbdSOEG0g3hYn9b8h5rMA3FQ1auQxixaZPSb3Gnid38yhHfa7DN45lRpFNy
	 HnYLVP3j5rN6nuQ5tFXKqOBNLvl4XnhrEDVD/oaSpKYeACD6sLQ5WeBkAwtRRf89Oj
	 Mszb3PGelES2eFWGjjvA1vTJCZKTNjzsErMgOooBsTzqIDIIX6sREpum3rJfPfbZjq
	 ncrWyVUiaiNNQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 08 Jan 2026 12:13:16 -0500
Subject: [PATCH 21/24] ufs: add setlease file operation
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
Message-Id: <20260108-setlease-6-20-v1-21-ea4dec9b67fa@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1554; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=uKAoYiUzb2k4mWk3DPDn1qw2MlMadC9ZK+Ro0COSfEk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpX+W9x3bW7J65LYqA4RAoS8vIXUjkwwPn2jjsp
 UmXLATAbCmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV/lvQAKCRAADmhBGVaC
 FSNEEACZcBsWRq9qFYTe80h8vRRw2k3rdL23HiT2BsxfSAAZFyBsEvwK9+kuhY3wgeDrU4j9WnH
 /GIsJmvdTFgf55rZbEZRkM+UjSpTNkca8KYJYfCKqOUpyDrGNxHkRKAibGXOuEhKan0kUm3i96K
 UpbDBsdke1UPupTK3TAK6QO1LnUpZROD/waUOPEAqTpxmgOGUircRjljFXwTtS4WNtwDpwaw9/v
 59rhsifvhQg50TiVS3DGlyav9p3uOTznw2pu1n016JFbPDKtUHQQTKWCFllVRGBBN0SrVjUZCvZ
 ysFLmyL6FEXsBc06lpevB/4OZTOHEMAKH6GCviniXzi/Q9mNaGzw7SywSs2UpLRuBEl1F0o2nC/
 gSEYJYJtSUyPrcLRO+sqctPdB0z0c9N5ja1qbzwPysDOGONbqHHZRAwl+/fAm03pvjcgj+Ek4y1
 z4l9I32yHoGA0elIfZ94CnUbSLjHhHp99E6+gneCtLeJNF/V2UdqW8YbC7syjZmYsL9/32uBR+F
 Y05Bwybcvu6omNnCSV8mOat6qwJVat/Xp9cczO7bcMz5ufYYpeQfx8tSA4zKqAhTV7fCQ+3WbrC
 B4bB30ktO7leILwAVHcE6hs0zFGzhxVYBn5+WP2mhpy5Eq42GL6xsEhdCeW6GB9eJoBmuml53dB
 1zKY0MNAGgIkj8w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the setlease file_operation pointing to generic_setlease to the ufs
file_operations structures. A future patch will change the default
behavior to reject lease attempts with -EINVAL when there is no
setlease file operation defined. Add generic_setlease to retain the
ability to set leases on this filesystem.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ufs/dir.c  | 2 ++
 fs/ufs/file.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index 0388a1bae326ba41bc03471fcb7ed01098a707d8..43f1578ab8666a9611d4a77f5aababfce812fbe4 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -19,6 +19,7 @@
 
 #include <linux/time.h>
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include <linux/swap.h>
 #include <linux/iversion.h>
 
@@ -653,4 +654,5 @@ const struct file_operations ufs_dir_operations = {
 	.iterate_shared	= ufs_readdir,
 	.fsync		= generic_file_fsync,
 	.llseek		= ufs_dir_llseek,
+	.setlease	= generic_setlease,
 };
diff --git a/fs/ufs/file.c b/fs/ufs/file.c
index c2a391c17df7f34d9961973909d1985f5f786e92..809c7a4603f863025caa947b2e08f0c2922ad619 100644
--- a/fs/ufs/file.c
+++ b/fs/ufs/file.c
@@ -25,6 +25,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/filelock.h>
 
 #include "ufs_fs.h"
 #include "ufs.h"
@@ -43,4 +44,5 @@ const struct file_operations ufs_file_operations = {
 	.fsync		= generic_file_fsync,
 	.splice_read	= filemap_splice_read,
 	.splice_write	= iter_file_splice_write,
+	.setlease	= generic_setlease,
 };

-- 
2.52.0


