Return-Path: <linux-erofs+bounces-2017-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E857D3B0B6
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 17:28:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvwqT4BNMz3bf2;
	Tue, 20 Jan 2026 03:28:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768840085;
	cv=none; b=egfKrz2g9a9C37v8QZru9gY7lS9xqyEW0FO6u0Qa82cjUyeAh0i6qXIKAxQ5nP9EtRh7iC2gw9kRRZfROtlAur0qYoaufFBnN/vfE9/GwWep+SQqT3VAe471lP7jvvEjgPrzN79hu65zRzpOc35gJnrrg+3PmkctoxXP7cMvLDGdLMMlgT+WkwidjcwKISbUGFjBc2ZIcs4Y2fPWHhMBGsCigdywWqHaGfL1ux6le3f6uxEo0pW4zBsS1/0QsVxv4wz+4J1bIWgOH4IdudbpMmER4UhGINYt9/pXfeO1kOIckpGHkv3UNvwxiG9wdGyY/P0hzXsm2l/gIEBGAnPDcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768840085; c=relaxed/relaxed;
	bh=iN+TqZC4HgENZZKB8bo4zGbsDfjfItmjIIecQeBE1wg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Iik7ZwgaqqHTYwiJ0Ahayb1z6jAcOQ0s35rob+MQuu4HIAvpbfFbl4nvzwZYIQBJzqLoyDLcZm7JV9VlQ6tMypLU+AEvO91gJAINn1fRWqaSxr6ZM6AFjbwmIZnQx0L1s8BYDR0k3IVhnHqTpfJKsrizX+nNKs6B4mnxcBgC9OE5WAdaqlxmNYW4ifeg9N4CnubwtzUosf35hpcaSBa6Pwe7sjH0mctD3aaDPgNZm3id3ACZtkdunaRaBehEgiN/Rv6+/guhAnBNSFtaz94D1U/jPnU5YYa8/wYzRwGgOJDuBnB+DnD8bTQCt+z4czx1KSlEm4jpf1IrMi98a1n0+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GONKFU7S; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GONKFU7S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvwqS5tfsz2xKh
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jan 2026 03:28:04 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3AAAB44516;
	Mon, 19 Jan 2026 16:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F91C19423;
	Mon, 19 Jan 2026 16:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840083;
	bh=oaRkoY75Ujoq1dtI6aOA0DBBPdbXoxvn8BccRGOLbSc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GONKFU7SBdZJKpEx/+RyIiOJlKzpw3wad5XygHCQ6SMdbFsR8UygDcqhklmkj9xxa
	 DoT6QN0R/2LJRtNAltzb09X5JNXTy6dQB3iI+MgQwCPVrcE66h660Mpm0BQ4JG8Osi
	 1VuiKBmR84INye+Bmqe0VouGphLzEaWWZ/of0z2iH7Iwlv3+apcs+X8vO54dsCxOC+
	 5OqDr3+O5xIEGAiMqQqigHd9/dgExp99/46jSgaQEIyDO47+mlUpcDbop0KIt/3IDR
	 8hwKx6Cno5+vI3d6qqieguhx0KdAqoai2D7nD+ROJ71Ab9hESQgP9QPViDekXMPGb6
	 smRbLidWH1LeA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:23 -0500
Subject: [PATCH v2 06/31] erofs: add EXPORT_OP_STABLE_HANDLES flag to
 export operations
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
Message-Id: <20260119-exportfs-nfsd-v2-6-d93368f903bd@kernel.org>
References: <20260119-exportfs-nfsd-v2-0-d93368f903bd@kernel.org>
In-Reply-To: <20260119-exportfs-nfsd-v2-0-d93368f903bd@kernel.org>
To: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Amir Goldstein <amir73il@gmail.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
 Chunhai Guo <guochunhai@vivo.com>, Carlos Maiolino <cem@kernel.org>, 
 Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, Chris Mason <clm@fb.com>, 
 David Sterba <dsterba@suse.com>, Luis de Bethencourt <luisbg@kernel.org>, 
 Salah Triki <salah.triki@gmail.com>, 
 Phillip Lougher <phillip@squashfs.org.uk>, Steve French <sfrench@samba.org>, 
 Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, 
 Bharath SM <bharathsm@microsoft.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Mike Marshall <hubcap@omnibond.com>, 
 Martin Brandenburg <martin@omnibond.com>, Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Dave Kleikamp <shaggy@kernel.org>, David Woodhouse <dwmw2@infradead.org>, 
 Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>, 
 Andreas Gruenbacher <agruenba@redhat.com>, 
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
 Jaegeuk Kim <jaegeuk@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: David Laight <david.laight.linux@gmail.com>, 
 Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
 linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-unionfs@vger.kernel.org, 
 devel@lists.orangefs.org, ocfs2-devel@lists.linux.dev, 
 ntfs3@lists.linux.dev, linux-nilfs@vger.kernel.org, 
 jfs-discussion@lists.sourceforge.net, linux-mtd@lists.infradead.org, 
 gfs2@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=749; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=oaRkoY75Ujoq1dtI6aOA0DBBPdbXoxvn8BccRGOLbSc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpbltaC973DLaT/MM7zKoBAyQm0Vj7HgbhB6Sm/
 nlnrklYVq6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bWgAKCRAADmhBGVaC
 FaenD/9BHrGQNmC+s2kvQNgwfP6EEm92NTII9R9h8Ix57czFYsowChpSlIRo0A9Xd4xRCRPGS7L
 HkWGT/3paJqWpLRClUV0PZMel7V5AFRHzEpZYdoc7G0DY1+7NxwSSWsWzFQsSDdiFd5s2qqfldB
 uus4+aXE5PIKQbdjwm7sTXnLZPP7wkWvDbFW15W34xpjLx0dIrUIEiPIyGYcefVklynKBB87PzK
 lVynQnQJPhSUu3hxEXGz4CD3K62WemAfpoXA8elC2tKDt10kqGNU9H+1zmLINg1EJ5bSg3j0rcy
 CcBd6gYBpqnogMMHL4705I2BFm7iVfExvhAZMDz976RnwglpW3txwmK2EFjUPjsIRfagBpSBpGK
 Rli9TAK78IR7UIc9VRFAsIXraY+cgSTnMCPbBl9RcHwZZrKIkr+9cP5A10JLBJRPIw74fXa6gkb
 UYw8P28UY2bXcWrDM/Ji1UKPCyWTG3k8rSLwFdR1dh+MJBLt5EwUbVsg5NNIQN+vLVsAhRyhd+r
 fj3nyTP5t8+DCC1N4v5p5uMqzJ8bCxXrtDQyn1CzDkA3vfg4QrMNApleEXDx1M8TID4oqKVuLMf
 hbo6t/RUnLwizZZh5g9JrEQZ+yXChodcWH0W05XM8ZA8MYIkZntqbIMaslGrsEAClHDBqWhRqV3
 YjtgGIDgn8onLmQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the EXPORT_OP_STABLE_HANDLES flag to erofs export operations to
indicate that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/erofs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 5136cda5972a986dece863290d20ab103791cb98..7b43ad2dd3eada8c132b26f851394492dfe4bfe3 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -608,6 +608,7 @@ static const struct export_operations erofs_export_ops = {
 	.fh_to_dentry = erofs_fh_to_dentry,
 	.fh_to_parent = erofs_fh_to_parent,
 	.get_parent = erofs_get_parent,
+	.flags = EXPORT_OP_STABLE_HANDLES,
 };
 
 static void erofs_set_sysfs_name(struct super_block *sb)

-- 
2.52.0


