Return-Path: <linux-erofs+bounces-1737-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B47E4D04D22
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 18:15:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dnBPb1YJkz2yGq;
	Fri, 09 Jan 2026 04:15:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767892547;
	cv=none; b=Y8iJXO23mjWFwTJk9mEIbdz7Ayaxt5ipgkcEw1u/fe2B6ADlgKZ80VRvxGux74mIlogsaJRznM11Va7D21XVZ1An0yGFXDIa0/VO/DBP9n+Jc6n77d4g7hggBcdFiAp37vmLS1DawZv92ff9M5jIswo9UR/SQwn2jVwkzQh2QzvneON6fwdp+IzKqw0wPHCneerEUYLwWMjndMZ4Exq3kBeJerH25JojrZiY82P9lKrS1aVAexOo2d3FXhUwTB+KOwOyTN0Zvh+q//iA9fiSFYmBWN6i5Hn2QlgQiiPwUbaNGueUk8Ni3605Myi8isCY28/sl3hF0p/O41qoubacew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767892547; c=relaxed/relaxed;
	bh=ikPkvxZEFqEFOk9dERq4FeObG5IFIQK9n7omq8yijjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V1d0ZstyseLVMCCxXUMwx2r1BET1fzrM0cBOHbo6tYtzQm7JgqlP1EKD40S1KNEErpW3yqlc9PYZZGBOS1JJvE1P9jGzuet1s5+ofBz1FCCM8814rJDtiXdlPeJpfv/Ni7joc0wbp7PrL37FTS7EVKkJQ/e0zSAh/sln5qe8ZDc2NWUXY/in1Ywp4jc0VjlhJBp8GOFdc+0chJzfE8Spm1Z/VGIHncdBiJrft4bLHOHZAw72d+p/VgnqUhGmRnEHAQHY9KgcCEKs4k5tqX8So/C9bTkKf48ieTEQQ0MBz/Mqd0J17gmuWu+bNjreNRxM4WZ38tNVYQy0XxAggIOkoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QUf0x1S5; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QUf0x1S5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dnBPZ1dbwz2yG2
	for <linux-erofs@lists.ozlabs.org>; Fri, 09 Jan 2026 04:15:46 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 15BD860145;
	Thu,  8 Jan 2026 17:15:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686B9C16AAE;
	Thu,  8 Jan 2026 17:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892513;
	bh=LxI/ylJoAyN2L8j0GVIMwgPEgj096EiMNnZ2VE5RMBI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QUf0x1S5Bumga21rP/0u5v6W2RQ4BluTcyv+ihE6zxjqOH4cSdhGIv2a2hWmNwkEY
	 GP82TOP3utzcm7AFsouq9nW5sKotUofmqhH2HblXeYHjAkY53RIkASaReGdUxITEHR
	 CpbVb4v5pnNOvg0fePHXAZs9jF/BSPNoZCdA4BgkfotHBZhgCxh+Eqx7ucO5aAd99s
	 nC4VLK1Eokk+dFaCZRvPgX8Q/2tq7B4zKAB8fli4S/NyxIc0ZjCWnK2HbP00IJ5no3
	 +f+bc+sVTDmD/e9V2p0pp0WJUubi6eMBZruCs3UzQVL6YfG5bgieNR569AeoUsBbXV
	 zyAWDIpezVFJA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 08 Jan 2026 12:13:07 -0500
Subject: [PATCH 12/24] jfs: add setlease file operation
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
Message-Id: <20260108-setlease-6-20-v1-12-ea4dec9b67fa@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1701; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=LxI/ylJoAyN2L8j0GVIMwgPEgj096EiMNnZ2VE5RMBI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpX+W7d87lASYok48UUP86L0PxRicnWCxcwIa2g
 mrjhHHdS8eJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV/luwAKCRAADmhBGVaC
 FRqVD/4mxKu66YoVwGnK/KbDPL6sP7u3c6Fqe/CzabSY/cYfYzAoIK0qove2EW8DsMJoXrFfCt3
 AmH3fJ2NzhyuumNIiCwfp/98d7mGtejKDtNXVvNybC6Jhq5FGUc9JGmOfhnBUuxvv8b35sFNHIq
 PcEMa7D8RqJH5xGJod2txTPQ4bl53O0YlGgolAHJ0gPLgzW2lsGIRrACSKbH1shyiIUw5MQSGbB
 +GUepZAWHQSzMuKtbeyL8am4GHJUfVIt6bdbVhAaNU6e2RqOk0PlRircBoM05Xwr9WHwl2Gu2ub
 4c1jexsIsI5V4AFxKZvMcP7/qBD32Ui9VZOzp7RZX8ts5DZkaKFkP9Hp2aTR6z0lenvWHeaWJJu
 jhsCqHB86EpC+byLIiybWPjlh1UFMOpYDEXuVEWiFeQf9xA/om1XNjgyXxKQNPJ9PtFsi+LL0mJ
 uxFuMtlhX78r62nBwdRMHsaTg92bFaT8MkoCRusNV76fOjKvtVtLxi7dOeAfyBIfC7jt4RhjsEj
 B7rWLAEte6L3EGQ3BCHr2d5EQ1zZNiDlgkhMw08fKmQAgqI1+rcy1K73Ng2NHs9sG7cOSzQg2vu
 BZmdy/67YXC2viG4pAV2raZi5ApCfRPQwFxyhoOw81iQyoQ384mrcmM0Bsl4zpgVZcBA5sw8kuD
 j1Atxo2tHiM6kQw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the setlease file_operation to jfs_file_operations and
jfs_dir_operations, pointing to generic_setlease.  A future patch will
change the default behavior to reject lease attempts with -EINVAL when
there is no setlease file operation defined. Add generic_setlease to
retain the ability to set leases on this filesystem.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/jfs/file.c  | 2 ++
 fs/jfs/namei.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/jfs/file.c b/fs/jfs/file.c
index 87ad042221e78959200cce12a59a3ffd6d06c0d7..246568cb9a6ec144831eb3592712cce323d8cf1d 100644
--- a/fs/jfs/file.c
+++ b/fs/jfs/file.c
@@ -6,6 +6,7 @@
 
 #include <linux/mm.h>
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include <linux/posix_acl.h>
 #include <linux/quotaops.h>
 #include "jfs_incore.h"
@@ -153,4 +154,5 @@ const struct file_operations jfs_file_operations = {
 	.release	= jfs_release,
 	.unlocked_ioctl = jfs_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
+	.setlease	= generic_setlease,
 };
diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index 65a218eba8faf9508f5727515b812f6de2661618..f7e2ae7a4c37ed87675f0ccb3276b37e6ce08cb4 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include <linux/namei.h>
 #include <linux/ctype.h>
 #include <linux/quotaops.h>
@@ -1545,6 +1546,7 @@ const struct file_operations jfs_dir_operations = {
 	.unlocked_ioctl = jfs_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.llseek		= generic_file_llseek,
+	.setlease	= generic_setlease,
 };
 
 static int jfs_ci_hash(const struct dentry *dir, struct qstr *this)

-- 
2.52.0


