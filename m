Return-Path: <linux-erofs+bounces-1724-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D06D04C61
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 18:14:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dnBMq0Gdlz2yFm;
	Fri, 09 Jan 2026 04:14:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767892455;
	cv=none; b=I31dtDwa0l7/aXkM/+nUBW6igzNmtYFGMh73IhGkuEkCb88kl65n70MXcp/KxMR5toyP8D0s0l3XNeFb2K6q9aNJap0VKJLPkFvMD1giCLkhvQmk82iwWUeLR/h4AhrmtaVVKh9tukdcseDMFufxVCLvCeoCHhcdH6AgdZckFXE+zI3iSZw7i0dRWq3m5WRaMmWFBKmH5JTqyHAvd24yViGQzsFy9sLN+q9G83reef8JD81e6Haj1wsQYTfLYur77w0FDScPj99fHDoFW5Pz825Mgc0On3/P7UwwXkl8oucreV/X7PnO/G5wRhJy0OLZXo7jq4ktIbIhb8voR95+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767892455; c=relaxed/relaxed;
	bh=Kkg71EWSeprcImfa5ddRfKn2RSTuMpwmSFgyDbj1AnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kz8y+MRMkhhUS7FZXPSGDeE/0gZNcQjVMtnreqpjQeXibn0g2xmo+5Fpoyk9qwAhzjz75ozv1MIhxiLJgJieu6Jv55TEKV+7/2e55z84t5ukuEq8vheSkz/KEEBxHphMhPKAiO/j1+Nm3yf3SpN2Yv+RhFdlCZY9B0N/LBbFyFW9yRgvI+f1za4zUmSqpGtTbef26NIUaFKJ1ACZcNuQX1Yna54+0J25KiiwAxRDE396U7Ku8QJRvSJxEo89MfRYPVzgB7iWnt54dfKbo86MiB+/3ncpTbgb8N7dZWlUwM/DVAd+PqbHGqtIxMP7d0lSwi/+iNYMDFoiPx36eBskJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=j99SvAIt; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=j99SvAIt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dnBMp2Lb0z2yFl
	for <linux-erofs@lists.ozlabs.org>; Fri, 09 Jan 2026 04:14:14 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AF05844447;
	Thu,  8 Jan 2026 17:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4074CC19425;
	Thu,  8 Jan 2026 17:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892452;
	bh=VftDczW/RHsJtQlFSh7tMNcNMgHiKsCQqbNqeRwhe8M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=j99SvAItuEybJQBvSLRmS84TU6WfiMXcwP4088ncl0dJj+X259KHWw6MyQaVA6kzG
	 oPECA4FMVMlKYCaehvDpXJop8Q5F9GB6xcIpkmXdQfwEeHYkZKRbSQo/tX0X0Vod+F
	 YwJ8wOS73tcNHPzcd/R3k0xGjyff89YBIGM88fZxZiGqpb1rNl4GH4X0MfrQbUz5X/
	 deIlelXnp2vAuxtcCCSrk8BdHKA7r5LVJ4LthrAmFJ6fKW4CsejZe4y3BBnBYmqLEo
	 B5FNDOVl5khkljZAkIaZIcl517lxY8NW1YoU4ftIV+/iXX2kw7jQlQAxoYIM0yzy85
	 WjVk+AL/vpoKw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 08 Jan 2026 12:12:59 -0500
Subject: [PATCH 04/24] erofs: add setlease file operation
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
Message-Id: <20260108-setlease-6-20-v1-4-ea4dec9b67fa@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1708; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=VftDczW/RHsJtQlFSh7tMNcNMgHiKsCQqbNqeRwhe8M=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpX+W5D39raWTfk9/NpmK8oPAiQK6j/fZNQTiK0
 mXiB1deOuGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV/luQAKCRAADmhBGVaC
 FbTRD/9xYLwsFFCpMX2yKeF7C19Mw/69euFVil3d3rGhY6NZgqpWQsWs+JPk6AGiudh1ympKi5w
 KDV+WfIgFEJmQLVRx4btFU2+9X7RuD8uopNt2+hBQ9T04zGegtApypSIVLnGs1+r9L4qJl3HyIS
 uFJEFRe2WEdQMdw75UuDMHDhTG4JauCXcBvhHzNkUJ929nJ2ydpltqDWjFB+0DpLJ7azASrMhyb
 krcESpUqm0OlIHWMdMjbnGjzyPJCqQ8hCoF3VzawdQKOgREhTJjubThh1DEd0yHIp+IHGoZ0wc8
 +u56IZBx9vRkFGSfFplpt859W+e30+UTK6xtuPKcctDAT3jzkQUPcm9U3vHJfCajQkRp1BmCXBS
 WsSqysXEnUswTRGrUYEOXJoyumVWdylrjPfxGAWgI8dFJGz9hlkCzbMkX+HLFcvprO1JUqkpN5F
 QPlVLf+TnsluOr22vHgTLRlGSJ9nipt+5o0qpPTapb+lL0rrnjQYmW66aW7Vo13m0r6awIecRPL
 Ce4ct5XpiPQhWFVrIoB2IgvkQ5jt9+F4VUtIRTXttAYxGyrYjRT/5UwkyQmJgSuGZePp/Ui3unG
 0fryUPfSGOknDKNo1Rkpn48p7/uO4AnZ/pW355qfgq3htYkBkKrNbtxG6WL/qG03/mNBF7dnRxn
 F798ZpjLR9Wc1wg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the setlease file_operation to erofs_file_fops and erofs_dir_fops,
pointing to generic_setlease.  A future patch will change the default
behavior to reject lease attempts with -EINVAL when there is no
setlease file operation defined. Add generic_setlease to retain the
ability to set leases on this filesystem.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/erofs/data.c | 2 ++
 fs/erofs/dir.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index bb13c4cb845563492a616fc000910112b92df555..e2941b4715616528ddede2dbb9c0744db5d11be5 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021, Alibaba Cloud
  */
 #include "internal.h"
+#include <linux/filelock.h>
 #include <linux/sched/mm.h>
 #include <trace/events/erofs.h>
 
@@ -483,4 +484,5 @@ const struct file_operations erofs_file_fops = {
 	.mmap_prepare	= erofs_file_mmap_prepare,
 	.get_unmapped_area = thp_get_unmapped_area,
 	.splice_read	= filemap_splice_read,
+	.setlease	= generic_setlease,
 };
diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index 32b4f5aa60c986dc2acf209960ff6df4077c7aa1..e5132575b9d3ef958a8acbe80bd0d2ddbd865135 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2022, Alibaba Cloud
  */
 #include "internal.h"
+#include <linux/filelock.h>
 
 static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
 			       void *dentry_blk, struct erofs_dirent *de,
@@ -127,4 +128,5 @@ const struct file_operations erofs_dir_fops = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl   = erofs_compat_ioctl,
 #endif
+	.setlease	= generic_setlease,
 };

-- 
2.52.0


