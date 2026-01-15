Return-Path: <linux-erofs+bounces-1894-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3256AD26C0E
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 18:48:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsVpV6pZlz309S;
	Fri, 16 Jan 2026 04:48:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768499330;
	cv=none; b=eTVYG+xv0HzVsQ7SU1Ks+MrDN06FbrUiloJBnok22GAlaQtqqayZN2nR6D8qUMtUCXczZzAlyCukrORuYD8u1HVoID8B1FlpQBVYpGZTxdMlN95+USyebLwuBVxnelqXTUkBhBcd6NxP0mcEV/MzwsswFJnioJyBN9F0u7uFCUdOpVX+olsU29GgLAuWvMBkpaUGKVdCSqma/mn1PcOvyFUGV4KLnL8K+0w8fLU9mwTlWrgHhzv9VWIRuy+0AIh1X1OmJfGv/88NkqLWKzjXol8hYMlcH83tAxo5dAzeUe+K+HGYGKQe+F/BhrgyS5ob/ndw558xas0qLmNxysYJIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768499330; c=relaxed/relaxed;
	bh=5tDRbj5Fxnvu6c0vddUL7gT1ZEgkO2T0V5oWM2pNPI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YntdeYjybYLKo6vY5SJO9JgHgCOxPlUY8LRjaNS5RvvVqIbbtlxV6WaYHxcTQ5VcWVK3chLREZODe10lH/OxPW/4wZmcS9JgmRufaRXjp4bJUAj2L8hqLqx7L7oFsbwKrh5/QUzYVLqcq4cZtnlDeghk2qjHa+DmiSLG+mSsbEuqqnGUigooy/g2HTAXMkSsO80gGdZ0AwrjSTfmxwia0jbN5MVJgynqBcOxuKzTfs89qqexTEa3nBRFKwkOzo1i0V4paCIIXMPppXbYGqNgZVkQb1bPPsJk+h4GTVOZqWVMb+btGrc87NXCL6FaysWXRmbDxNiA++voIZJwy6XWVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=K6+XHbKx; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=K6+XHbKx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsVpV1tPYz2xNg
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 04:48:50 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A82CD44448;
	Thu, 15 Jan 2026 17:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A39C16AAE;
	Thu, 15 Jan 2026 17:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499328;
	bh=vuk9Wvyv5ES6VnJs/c70quqpIAbNAzCUaJcxJKcbQlw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K6+XHbKxqod1uaKNGVLt+q96dw+BOnbjMcmu+xcP3xiYddgG/sJuefym6nZHrJfKi
	 uH5dyVS/KTA4hRUnraDib1V8YEkjK+G8GVjWdIm826RobU7wYg6pDfMglI8V+Xq9Bx
	 9pJ3DpoKFcm1Eq0APjx7imRbBy13g0E356azB26lJtgh0O5ScUdhZNVC/YkdtYSgi8
	 gmVhqy2XaaZjGGOepgCkNZyeiVv3OKETq63VZjHg0LQALYupnIm4QywOci9P10oDbV
	 pLqK1LQxhagszUU/8zfOn1rer6rnz7Rc+MW2csK90ADeRqcyCjpM3Gf8344us2SQbD
	 qJhmn1Zj47U5Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:38 -0500
Subject: [PATCH 07/29] xfs: add EXPORT_OP_STABLE_HANDLES flag to export
 operations
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
Message-Id: <20260115-exportfs-nfsd-v1-7-8e80160e3c0c@kernel.org>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
In-Reply-To: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
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
 Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-ext4@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, 
 ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-unionfs@vger.kernel.org, devel@lists.orangefs.org, 
 ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
 linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
 linux-mtd@lists.infradead.org, gfs2@lists.linux.dev, 
 linux-f2fs-devel@lists.sourceforge.net, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=676; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=vuk9Wvyv5ES6VnJs/c70quqpIAbNAzCUaJcxJKcbQlw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShFUCOUlu0HwA0s7NudpYH2UNvJincQ80Jwg
 sEsHA/DeX2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoRQAKCRAADmhBGVaC
 FSd7D/9HhL3CQRq9CDjJOgHiepYVXs1Z9+kqO1P1hOhsl8D7DDIrPttx5CuWUkhGAcKXXvzcPmi
 9TKdrUzG50aTMKrqulpKqOunGLLFir7B3FcVywRapPfJUqx0KLTsBaCdT8xUU3osoXsoeb3CQbX
 1KMKEJ/pU/MqyHNy1iKPHPkElMxX0QKsgVM69UadFRWjn2R3skLcJHutgI8INVYsrewANQfW4uS
 MscVfjtjTEcOZNxyFRYwlsCfSFUpDGunv543PqvRAVyvv0BQ+SFeO6U2aMErnOE7r56FTfvMOl5
 tuh937foFGakhJ8nJP9ZQy45v4wE4+/hQzwc8EVn3HWLC195i1O8tt+ewt74JopOTmYHtw9HWTd
 xpQiYgGhx4/DEAijagS/DXh1DHSEFxfNDJ0I9ale+NfJBNUS+zgavkkntEAPOI45FfOYcw0yIAp
 +JGVnw9DNGE9V/hefG0jVOiPj9uu5/A/hwgV5sHzf/Ck0PEZIPTmxsZbDRGdzyIzdk0Ht3Fh39p
 tYyLDOLZCOgznQbY65l6VAW/cvZI0oARSGpZJRy4OudPobv3MM1rd0m77loet1e8lq+9V7Y1oxM
 Q4C8bVqfBvhIO/ANW/XxX4fqO06IwLdqLVvdgppj/GI0MovVq4ZgjfwW9cKZ2xEQTiqm4AFJg9j
 k8Hn27V6ZD+gXng==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the EXPORT_OP_STABLE_HANDLES flag to xfs export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/xfs/xfs_export.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/xfs/xfs_export.c b/fs/xfs/xfs_export.c
index 201489d3de0899af34f0485e00fb8b36842d419d..1be2de3394841a2960c1b2791897067b83cc7763 100644
--- a/fs/xfs/xfs_export.c
+++ b/fs/xfs/xfs_export.c
@@ -248,4 +248,5 @@ const struct export_operations xfs_export_operations = {
 	.map_blocks		= xfs_fs_map_blocks,
 	.commit_blocks		= xfs_fs_commit_blocks,
 #endif
+	.flags			= EXPORT_OP_STABLE_HANDLES,
 };

-- 
2.52.0


