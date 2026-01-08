Return-Path: <linux-erofs+bounces-1739-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153FAD04D34
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 18:16:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dnBPs5rcjz2yJ5;
	Fri, 09 Jan 2026 04:16:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767892561;
	cv=none; b=ddPQOYpne7oDBWYoL1XglFL/kCpue0MkgXhQDMbahlje8M+TeUhcN7HeOINFv2LfmnnfGSAiJoe1aQx0n1L+4hv09BoqgMKlNV7Glnk7u/Cxgx0V52Ly7hvkLmojEnNPRW+W2w4dXzpXDzBH0f0h9ejWr8N1W2RQsZJervc+T9Wvkxd7jrfx4KrUiPRxdTIXUxqenOCkR4i9OJvBIbZgdhLN8a+BPw3REljvAJ8NRCqNdbi7TEQ4JEOQSI6/5+TpeA7WAPNPs5rcmr4bQ6Zp55oAfafHtr/o0d+294rGV2IUHIoavXhMMJUIqFQ+23y/lGccnOuCtbkdn/KHl0UMtg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767892561; c=relaxed/relaxed;
	bh=UOlou/EGobK7lr+WHPiAS5+sabSAacC9g7Qx8GUB6SE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UmnoinXb/3JAG8CD2zsKUCMwI5YRR7ZZvssSeceKeetYfZHqcFsX1iK9xgtE5RuLVe991J4PIj+NXB1978jPVvEQ3rxa0xiI1zWRnomYJUl7TFNud2rhO5NkDI2Xuu6cE2qjItL6GLEIqazsPs6D3fgtAjRYbCFKYnqWh6iFDVtu9SIg1/suRIr6GRXuku7b+8ic4qGPIt+1rMeKtxAghZnzMhvalfizT4h5Q5PVYe5wOrTgQYeJxnFvIKvPZ1KIvYJ1gGD7eVIlGqyhnMsJOIP6Z00LXHypdGewFhPBerNOobmaYcElO5E5QxzExqS38FvuOP0m32h4PGlwI8/sog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=seVFw8zU; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=seVFw8zU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dnBPs0rfxz2yHD
	for <linux-erofs@lists.ozlabs.org>; Fri, 09 Jan 2026 04:16:01 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 645C340B1A;
	Thu,  8 Jan 2026 17:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FABC19423;
	Thu,  8 Jan 2026 17:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892559;
	bh=9+zOdW5lNGHcGX85wb9WeocgdTAcTrprGG0z5Bzi+RE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=seVFw8zUXzlt4ulIQql8YFbNPIjR9Rf/DPANtIaUVgMB7HrEOnOdJqRINwwlm0c8z
	 AvANMGxK1reP6TvY6s1YHftUbyPa1a4D7XQr5wqGFyxwsTfK+cqKWqN9ST57dkVbsO
	 SMKtfsN9QT6PXI/gKFQrYHJqE+Lk/Gs6kj6Hvg3XgESuxAUelqN0C73lD4B6KPr95m
	 JpqHj+JRZQ0rAggZG1yobkaAZfi3PHEVb3k5rKu0rV7A0tLPvGctl/0eI3eBTKXMGS
	 pd8AFhLZOqZHzJMNSVhNeDhMxSBfrogUoW8EaHeLTlg6D3ZEhNgHnFWQ5i2xZhNPw9
	 lByRPSrHlyiUw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 08 Jan 2026 12:13:13 -0500
Subject: [PATCH 18/24] squashfs: add setlease file operation
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
Message-Id: <20260108-setlease-6-20-v1-18-ea4dec9b67fa@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1734; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=9+zOdW5lNGHcGX85wb9WeocgdTAcTrprGG0z5Bzi+RE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpX+W99/HrvAnnmzGcblpLXD7F4um4fHAJVhg4+
 LzfwmzDW3eJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV/lvQAKCRAADmhBGVaC
 FUmtD/4jEvDoFR4qieUNgn8rr/UtKPrGyvRvQMWHMSrHBhqUd+/caCds+/vOgFJuPUUC8BBPKaN
 PpWJr3+bB+63HgaLFL5kjBBI84UDuHXUsAdKojmsuX46XRIFCdY4HiLsBRwNlCL3EOFRZb7QMNA
 CLXuPKbYzRdJ5vIeg0PfhFnEee9jhOdU7PhkAlUByzRLB4aRTSgqIksyQLdZtEcq43Mt4+08iOE
 03e8Lyi8MUEQ40+6qwWiOrSbb0RVCZtmy3jlJUPmrRBFnaaSbyXBwQ5pIpRC7Zpjtk9XwyatLAT
 bE7MsYykcOYo7FuP+Eeb0IkX1pY5/khOn3jb8NDXsKQG0ExLeybRnT5n4UB74WPa1yl9VN+yqO3
 QlSW3ny4UUjj19ZXN4Q7048K5CeEiAQBfXtwvEd5vIX7ErHKQXL+VAeFjO3jcXrMc2y9UCvEcfK
 nDXsszCFcuM/T6/I/XGZXHHOGA/FUVvHC/oFF/nix3OCXccHGPKgcXJX8tHP1+t0xqnFretZz8d
 5CypPiszzqEX0oF54cIJjyIzVhzWNzjfhi47ao5Ab42Lu1n7ea420e2etzoD35ai1nWJURpgrC6
 9S21HSVhuCfUGGAqiahZXCHQPulLW/N1GNp7FFtV71kFlOoBok5C+bkbkjXp2uz+F7s/PU8fOEX
 9ml0VlbuQF2h4zA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the setlease file_operation pointing to generic_setlease to the
squashfs file_operations structures. A future patch will change the
default behavior to reject lease attempts with -EINVAL when there is no
setlease file operation defined. Add generic_setlease to retain the
ability to set leases on this filesystem.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/squashfs/dir.c  | 2 ++
 fs/squashfs/file.c | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/squashfs/dir.c b/fs/squashfs/dir.c
index a2ade63eccdf38cd7829a1e79efbb6cb607fa54f..cd3598bd034f01c74eb2e840187e14cb05b640f3 100644
--- a/fs/squashfs/dir.c
+++ b/fs/squashfs/dir.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include <linux/vfs.h>
 #include <linux/slab.h>
 
@@ -220,4 +221,5 @@ const struct file_operations squashfs_dir_ops = {
 	.read = generic_read_dir,
 	.iterate_shared = squashfs_readdir,
 	.llseek = generic_file_llseek,
+	.setlease = generic_setlease,
 };
diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index 1582e0637a7ec87c02afee845dce052259e6af1b..4be92206e755dc6b385bc9de456449c5ed4385b7 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -28,6 +28,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include <linux/vfs.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -775,5 +776,6 @@ const struct file_operations squashfs_file_operations = {
 	.llseek		= squashfs_llseek,
 	.read_iter	= generic_file_read_iter,
 	.mmap_prepare	= generic_file_readonly_mmap_prepare,
-	.splice_read	= filemap_splice_read
+	.splice_read	= filemap_splice_read,
+	.setlease	= generic_setlease,
 };

-- 
2.52.0


