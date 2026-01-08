Return-Path: <linux-erofs+bounces-1741-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351C1D04D6F
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 18:16:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dnBQJ6x7Dz2yKn;
	Fri, 09 Jan 2026 04:16:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767892584;
	cv=none; b=VNwVPpXRvZ4gS2ruPvAqwWO5BWOru2c41TVlvtvxqa2zckjF0fY29gbYgg3zyFmgF3vnfU3aKwIjcuEaIuYIWAxi2n4ScspE2Y/ZJQu5cnFrQjnO1tT3hG6jzaw7g4kGQwTNDVz6PXr4HmNR/5LIxOcn5AjTk8k688HIWkJSQe6eT6cKx+iQsJrKM0nSi+8i5jGn9jLP02TrfKGO/fszmWxmaLhubiqt2FNx5Y93CD0QINlYxvXYPeLEccRms2iB4e0+JJai3FoNUbpaCoSYLI0cuu+Y9ySIeqpx8UHt4/UDrx20LaeiWCVvtQnyAuXJ/+1WYiiZorfjRZuyD6W85w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767892584; c=relaxed/relaxed;
	bh=GacgX3gma1Dc93Uid85Rw+Mr1nuhJfogW8HRstIGR0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KfoWtvZltLAyzO5XgEZyRun0I/Ub8xEieO5+2f0X6M55v0olsvKFJOG/xsdpMOiQo0bEDPZ5PquOcBsRlGt0FZ6mm+VGxU7JF5+rpEEn0DiAxZXguQ6nOhUekB3YT37lvHJE8TOhg+U9DFWV8Zc89GHA8vjSbJRyPkmYojB8N3+FCc2vnGJ2IQWn5+RqmrVLdGtrwQx9lqjb5W7VedX3yN3l2sjFAiuqbxXsAyGePHMjh3YSyH38f/YH7BxcBvreYV3oSpsLFLLUBIZJi6k930Vdi8HRci1ltOLJxD7376l2NieHjl+jHErna8CEixOXrNrgx1LaMgDnLTqfhciVFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PEjw0/vg; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PEjw0/vg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dnBQJ1HDsz2yK7
	for <linux-erofs@lists.ozlabs.org>; Fri, 09 Jan 2026 04:16:24 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 120E06014D;
	Thu,  8 Jan 2026 17:15:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74598C19424;
	Thu,  8 Jan 2026 17:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892551;
	bh=/QjFws5fePN18OBYa8bISKhX2yIiYoWbwKUyTsCKvi8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PEjw0/vgT6GLsQDvxChTEJJWrZnAQSwT/oOYtarnEr1mnlXneb12dRn/+E7ODlH3e
	 lEscuNaICbpX+q+/6dO9siSu+ISv3W0K9wwdJ/mDEw92/56eNocyUzJjpaC6QdgIyG
	 TXJksMFDlSytDs24skqoMve70gF6oZNa7uvLK/sesVf1BfG3jX47nbuodaLg5SaXh5
	 LmcwS/E2mZY6CTlzB8FWEcmq3mPVRu19tuFt5HFUJmWTID9UfJc3ZPIB70pwGbpr4f
	 vHcBl/oxvixj+KEoGwXKpq84pv0rNzyvfBOZbbD9Nf9EOol0+LhwcwkX8AyEiOq27a
	 b5nd9nZ8BtLsg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 08 Jan 2026 12:13:12 -0500
Subject: [PATCH 17/24] overlayfs: add setlease file operation
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
Message-Id: <20260108-setlease-6-20-v1-17-ea4dec9b67fa@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1800; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=/QjFws5fePN18OBYa8bISKhX2yIiYoWbwKUyTsCKvi8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpX+W87k4FcETAMephFZz/qe7wC4C41gmjqLLfA
 Q/kBv6HQmOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV/lvAAKCRAADmhBGVaC
 FYTHD/9CJrqt0jlrMR3MPzOXX6TESjSMY5U+1+dwGCcCtiGwGSBiK1ZY1GBC73psRJ+mYjVfSic
 MNCosL0YefLDvCp7QfNs9/ejLx7RUtyNCes+plJwrTahfnVJZ1uNYdK5DEZ44L2DqTFmrzcD4wQ
 oy1zj93AjNBYypMHV/k+qL1usyMtFr3jPnged5fSSsBkJ0C5Si0L3ZpP6TqWEWeOleYjDy2urwR
 fGkQUW+9Y6Xar5xRYHpGJwt5PKYAatcXU+SveMXOFbp35GKe+fnfNWZiABMI8W02Qp4Mf9CV2ZS
 45JLWGX1Hhj/0H/KewEpFamsXAQz298u+NwRFRypHdABGYAFB1wzK1r/D5p2LnmLKqrTaQe5bmi
 9Jgmywfj0M6wILCz2dDyEET+5PE0sipM9aPV9cHp/v/kpE/99FxGIVlFijqG1YuygTZ3CnEMEJu
 y6HITTLBUusNTrhTU0Khne6zJzbhrbr4Ank1yRCl3u3cBFZxLvFFUf7YuQpp9L+6yqXasB7W63h
 VKAGaSoSzMKxT87yMNEdOlgZcotY/MTm6wihQM7wiAsC80uzL7LVT26vWynyqiZeva+dO6UcZet
 rUCqoy4q+/P7Ir1xCA0rQQCgb99iKp2pznNbBKq1+cYFA4N3yihYKFOnTD8jO/9X9fRvFIvZWGS
 bhGnYs9Awrd5yCw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the setlease file_operation to ovl_file_operations and
ovl_dir_operations, pointing to generic_setlease.  A future patch will
change the default behavior to reject lease attempts with -EINVAL when
there is no setlease file operation defined. Add generic_setlease to
retain the ability to set leases on this filesystem.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/overlayfs/file.c    | 2 ++
 fs/overlayfs/readdir.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index cbae894572348acb3ba6c2b6e7f84558379110c2..8269431ba3c66d49d2eea24c4ca63a3d2879580a 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -5,6 +5,7 @@
 
 #include <linux/cred.h>
 #include <linux/file.h>
+#include <linux/filelock.h>
 #include <linux/mount.h>
 #include <linux/xattr.h>
 #include <linux/uio.h>
@@ -647,4 +648,5 @@ const struct file_operations ovl_file_operations = {
 
 	.copy_file_range	= ovl_copy_file_range,
 	.remap_file_range	= ovl_remap_file_range,
+	.setlease		= generic_setlease,
 };
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 160960bb0ad0b0cd219cb2d8e82d8bda08885af0..7fd415d7471ed58849710da9f8a414b2b7aca1b4 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/namei.h>
 #include <linux/file.h>
+#include <linux/filelock.h>
 #include <linux/xattr.h>
 #include <linux/rbtree.h>
 #include <linux/security.h>
@@ -1070,6 +1071,7 @@ const struct file_operations ovl_dir_operations = {
 	.llseek		= ovl_dir_llseek,
 	.fsync		= ovl_dir_fsync,
 	.release	= ovl_dir_release,
+	.setlease	= generic_setlease,
 };
 
 int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list)

-- 
2.52.0


