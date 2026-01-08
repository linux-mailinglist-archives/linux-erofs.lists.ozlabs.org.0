Return-Path: <linux-erofs+bounces-1743-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C2ED04D88
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 18:16:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dnBQb1zkJz2yFs;
	Fri, 09 Jan 2026 04:16:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767892599;
	cv=none; b=R/b8/U9lxETFv6IW6THDmXmavO5UtMxnw/gAs9f4um0bE9P6NP9VYCGCEJJQHGkajsbOaNXQba6SRHwKtDS/WpzADjlQPkBO/viRMX3lRdQ1EV/cVvlwa4NwfMHY9vRn+W/hEFhCBpGUMFZmFVHFded6+8sJ0jB36OrjPg5AxLgt4tkKsImzJO5FZ12HUIRcaj39O49WffC0USB96oN6h0KbYgBhBGP0DWMj3G9dqylD0RNjv53pQB1YOmDSscgAfiDl9s0vkrYMPzR9BgX7YckvgHipS2o5gD5PvwGREyBZmc/ETC78UDBMnGBbd4CXdo56m5jHM854X6RfhhQckA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767892599; c=relaxed/relaxed;
	bh=lqBcLfl2WphGXAUeYg0RsVdiZ/sKtC0U50Gg9uwBBi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cVnfNtLcwh+V+tuUC9gUPW1lS6yv3m1c7fdk0ZmRbSEN5QIzzFUvV4u8uDR6fa5OS8sReu9mVZx12kvNIllD28oehkfOG9TvX6rcqB42YuPIuBUgZmnNYeFakkM+SViQuOY3NEV8SWYF7bgtIq3t+JIj8ZtCtNIHeLm1WqUistrB60OBSKoCCipQ+tGewh65/47GkVRcf2juMQwjBCRPJNS8XBIkG9fZQkEF7UnHl6Ag/7Idi3ZjkKpCrtpt84FNre9R55t3cQLIFMm19x79z9catIiUTBVMeYGiw66OOaLYntD+EuKSZclVyovlV0dlLKzRMjT9h074HBlnAtT0Jw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=O3j/8ZnO; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=O3j/8ZnO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dnBQZ45q4z2xGF
	for <linux-erofs@lists.ozlabs.org>; Fri, 09 Jan 2026 04:16:38 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id EBAAD43A12;
	Thu,  8 Jan 2026 17:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A71C116D0;
	Thu,  8 Jan 2026 17:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892566;
	bh=JE4GNVPNVKkNcA1jpqmX8IvYzHB+7PmSrfcDyeXRZLs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O3j/8ZnOjlQ0r4lnYmPtsUkuQLHckXO+a7lG3tqb9TexBpJCI54gOjdY+y8cCsSsQ
	 IxvwGEq3OuP4iFsa+dfO35ddGb2HgrELjQ3ao8l3pK8jjF+Rjy20EonfaYh8Llt5bn
	 /RB0tjx0w8p0Z73/B/w0EDupGFZC6EL5Ujzfd5x4fov1xGuwtJQ2yYnkADQmROHfwj
	 vsL2HbTZgjFTrxJnnt1JgX9uon1ZUYyi2U3LH7fBkbHEoUA/5KeCjcqPEx8Q1c2XKb
	 ox1Hu8zNl8p9EtF8EvUx/ekvx2wfL1yY6MIxC64QcUBwdDJOmA+8NHq3bU3g6XawLT
	 nDl4cYMCkWQAw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 08 Jan 2026 12:13:14 -0500
Subject: [PATCH 19/24] tmpfs: add setlease file operation
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
Message-Id: <20260108-setlease-6-20-v1-19-ea4dec9b67fa@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1763; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=JE4GNVPNVKkNcA1jpqmX8IvYzHB+7PmSrfcDyeXRZLs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpX+W9gK75PTtPWqOZdqkgSnHiF5/+OLjav5BQh
 LQ6WSLzNoSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV/lvQAKCRAADmhBGVaC
 Fc2MEADKg6yklkAvCj4E7HbZuYhukcahYUkhiJr6s9Cmx08ysx8VeUMh6v2VkTsecYbC4+70tAV
 l8nv4WOUsUTDowp1tvc0/sz7/2Hzf+BrQ+/oLXazFQWMU+qAIDE2KG1fZ4eXH5/RziCIzTjsyVV
 WQfLt52vOVUhkx2Q9O2OsO8mq0omg1wvLgAwAtHGrvKOAP9KLOriK/cA5dyUAchlKMIgFpuo3UL
 naSDa/ODULEppeZRcUSiegKPxpZHgpJUzekiHgNKO1ef1uGJWyPmadrRMQTxDKgHU3d0QUBFPRy
 e4vMD3bsfS/hnKP+Q3YGKp4vT8pZBvAp3S0nY7TbIF8Gno7YQ6wLMTrwNRF7Ksus564DZpikQyQ
 Z1vp/C0eCi6Y1/9BACOuv/AaxipBGDR2sU43QFy7S3g1dFlmiokwOIZFB2+jvgiptQ+2Kqv+OkG
 2Et3Hg81At5S+sSz/MRyswGtr///ik0I7sPxkuHS72u0fhJxRBf92xon93aDj6aTIs+psF2EefR
 HUU5h7Km3+IAmuCDehZFAfanpbV4j2wEDY2a6PvPJ6QpsGWA7AB5705Oh8k3uV4EThmdpqmcqJc
 aSve0hv+Cc2HgVoaAFhypkfr9I4QNt1+P+/3feGfcoYp9R1OzGlgDJE4iURN4iMA6uvvliMP9FA
 /t5jn5rkkAqVo3w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the setlease file_operation pointing to generic_setlease to the
tmpfs file_operations structures. A future patch will change the
default behavior to reject lease attempts with -EINVAL when there is no
setlease file operation defined. Add generic_setlease to retain the
ability to set leases on this filesystem.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/libfs.c | 2 ++
 mm/shmem.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 591eb649ebbacf202ff48cd3abd64a175daa291c..697c6d5fc12786c036f0086886297fb5cd52ae00 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -6,6 +6,7 @@
 
 #include <linux/blkdev.h>
 #include <linux/export.h>
+#include <linux/filelock.h>
 #include <linux/pagemap.h>
 #include <linux/slab.h>
 #include <linux/cred.h>
@@ -570,6 +571,7 @@ const struct file_operations simple_offset_dir_operations = {
 	.iterate_shared	= offset_readdir,
 	.read		= generic_read_dir,
 	.fsync		= noop_fsync,
+	.setlease	= generic_setlease,
 };
 
 struct dentry *find_next_child(struct dentry *parent, struct dentry *prev)
diff --git a/mm/shmem.c b/mm/shmem.c
index ec6c01378e9d2bd47db9d7506e4d6a565e092185..88ef1fd5cd38efedbb31353da2871ab1d47e68a5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -29,6 +29,7 @@
 #include <linux/pagemap.h>
 #include <linux/file.h>
 #include <linux/fileattr.h>
+#include <linux/filelock.h>
 #include <linux/mm.h>
 #include <linux/random.h>
 #include <linux/sched/signal.h>
@@ -5219,6 +5220,7 @@ static const struct file_operations shmem_file_operations = {
 	.splice_read	= shmem_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= shmem_fallocate,
+	.setlease	= generic_setlease,
 #endif
 };
 

-- 
2.52.0


