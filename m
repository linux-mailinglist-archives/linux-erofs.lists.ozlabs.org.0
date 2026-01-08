Return-Path: <linux-erofs+bounces-1731-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB9AD04CE6
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 18:15:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dnBNz6Gpbz2yFp;
	Fri, 09 Jan 2026 04:15:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767892515;
	cv=none; b=Dak7wO4O61HuiQkuzPwELvvmUjaa72ktNPIuInWmLiwv15wUwO9Bv1XW5PSIp8QcFjI3Q5/z+qNuh5REvrvRFxW3FFnPiB9oTEd7QE17Ex2QIfQZUGneGaVaEp61W/VyT/87vp7TEgkr5vCE2oH8RUQklwTior6GBT5H6GLHJ8FGajZfOzSqlWNkWDk2u+N6q6sXJ6zizChcR7rqKYOrvCAcWGMnsT2otov/2TNcMshtunzsAOf8QUY+K9tOGrHZgFfdpQqqy434EDv2ZrU5ZOW3Nznvjtiquf3idR6I1S/hpIze9a4LwHhIWu+nT4BMKRFQSOwI4sJFqGT1HkVy6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767892515; c=relaxed/relaxed;
	bh=z3U3DfC95ROrQkINJU85Gnclf3BoC6EeZB3d0ZTTyF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=elZQL39/fEZMpCFVpXBRDJFpMt8+iuq3rPxXahudAGVQTC1ej24HYqSKqJq/sKXGkDJzd+hQEKXh34jgiMY21i9foGSw1fpe00fYPH4Bm/411SDh1mnnFWJRAsoatCn4wprvtCrS4gsZPqqFX/jmQGxAV5Rv/fvbAem6AE9jUds5AExZASk3/uVrZhgAV6mHw68GDuIuy41CjX7MJtDCRFSj0V/8qX+dOSRlj0FEeZbDId3vyoZkdI2xUJSzMZ/vC+Unv+P+p9AGCXfAeji6MsANToCBUDUA8l1ezlTiDLX6EpKW08sVdZ/9Ro4bNcrB0dtGgSVroxN3GuLbX+ggiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UYNgBgcZ; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UYNgBgcZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dnBNz0sHxz2yFn
	for <linux-erofs@lists.ozlabs.org>; Fri, 09 Jan 2026 04:15:15 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4A8BB60148;
	Thu,  8 Jan 2026 17:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92A5C19422;
	Thu,  8 Jan 2026 17:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892483;
	bh=94xq5tNwwGdVFEbsY7qMy4HxVAW7YcdB4S8NrCMz7tI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UYNgBgcZejmmXe9+DGorQt4RzpRE+LAfkhZHZp2epE14mjVE0kdPbmDA9FBeWHjMv
	 u9grV7ZUhfGqgp292cdxMQ4ebVh+7j4zYMeVX1AUvqsmp+m4hG8sTJKXY2bL0uXnmL
	 OIxyKXSpQg2ocYvNdp4AE5BMRYSlBgMdQrdbza/DISv7Cy76VCfxYvp5i3I5TcTajk
	 YJOEyp1ppteph8H2ZBkKGtwhMld0tUqpbaGdbkBKjsRPR4g/kFdS9O8y8483fi2fAe
	 qoPICRyBKGoVVHyK9qAZiaZUwXNNW3OJnBSiavsAbReAdv/Zgh89GbNfcesC6s4T0d
	 QFBYXqYE9Z5vA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 08 Jan 2026 12:13:03 -0500
Subject: [PATCH 08/24] f2fs: add setlease file operation
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
Message-Id: <20260108-setlease-6-20-v1-8-ea4dec9b67fa@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1702; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=94xq5tNwwGdVFEbsY7qMy4HxVAW7YcdB4S8NrCMz7tI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpX+W61b/MyUzbdcdSmodRmXRKd3YgHTA99dyp1
 aKrHFL8B/qJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV/lugAKCRAADmhBGVaC
 FZP9EAC/KfvgDBVB+iOugVAOgIuiH2lLp5UGHRZYXoccQ7RsLXt40LrXwHbIuUnBnPTDl6Q24dk
 c+qR4vCzUsvTs6ZoB/hQgF5t7enFKO97X64gMM1cI/L5SVv9wJHkr+SlWYrN0ZRkMYbYkqh6Qvn
 YdDpzNnL+2CHJm6WeWY9m3G6MP5VpD6AFQcWS32/nlYcAiAeE8U5UDm6yRPub2BRgLrQMMLwo0F
 gT5ML+oeaRwNhBAtuUc2ywXWSazgnDwe9Nl4vdX9hsgfjqEd5ByGvhbHi5apdnDTqT/qbVjXKig
 +iWXByE7jJlTpLGiOJFwwFEPTEukug/2WKCgwXoSbYea46YVqKLq9pUVapamKmSCjXPDr9DWfYQ
 r8y4tje1jnoLB4Fp8cn9lRtS3Y4EXDQRY0n7L7VKSOtOvyFI4VGIHpsTF+SCJY+VcgswGTMeqVU
 kDjGI23wvqX81gZd7GFSgWewsEYkwNit/sgV7LOVnfE4EUSCygGym8eAfR0jWZ24zMWCeUcEGZn
 03QVAgVIEkYdmz52qL0NWwbiUb8fhK7fLvEUD/dMUt6q1Ot/7vl/H8/z/LaCO2baW1UpCuaPnIY
 maDRAn3wF963W2+JRVkZWEzuiaXz7m2dr0S/XOxltRGXHKRIM0xY+sla9/h8+M3PIOmfyRFvtqt
 V+typZtw20n9PeA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the setlease file_operation to f2fs_file_operations and
f2fs_dir_operations, pointing to generic_setlease.  A future patch will
change the default behavior to reject lease attempts with -EINVAL when
there is no setlease file operation defined. Add generic_setlease to
retain the ability to set leases on this filesystem.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/f2fs/dir.c  | 2 ++
 fs/f2fs/file.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 48f4f98afb0138aefabaa10608961812165e2312..be70dfb3b15203d6d92c80b4bb64fec879864988 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -8,6 +8,7 @@
 #include <linux/unaligned.h>
 #include <linux/fs.h>
 #include <linux/f2fs_fs.h>
+#include <linux/filelock.h>
 #include <linux/sched/signal.h>
 #include <linux/unicode.h>
 #include "f2fs.h"
@@ -1136,4 +1137,5 @@ const struct file_operations f2fs_dir_operations = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl   = f2fs_compat_ioctl,
 #endif
+	.setlease	= generic_setlease,
 };
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d7047ca6b98d8a41d69ea79bcbab3e4ae4cf30b6..cd4b1d3c90ab8114533d939e8dc129cbefc85c15 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -11,6 +11,7 @@
 #include <linux/writeback.h>
 #include <linux/blkdev.h>
 #include <linux/falloc.h>
+#include <linux/filelock.h>
 #include <linux/types.h>
 #include <linux/compat.h>
 #include <linux/uaccess.h>
@@ -5457,4 +5458,5 @@ const struct file_operations f2fs_file_operations = {
 	.splice_write	= iter_file_splice_write,
 	.fadvise	= f2fs_file_fadvise,
 	.fop_flags	= FOP_BUFFER_RASYNC,
+	.setlease	= generic_setlease,
 };

-- 
2.52.0


