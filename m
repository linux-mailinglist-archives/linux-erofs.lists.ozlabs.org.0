Return-Path: <linux-erofs+bounces-1893-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F363CD26C07
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 18:48:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsVpR5Qy3z309H;
	Fri, 16 Jan 2026 04:48:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768499327;
	cv=none; b=GfshlhxKkoZyZZTADb5zwu0lO4q9wQb51f79C9MhVMtI2i1vInDe7EV0lzlO3VlPq8IUndTSs0rYeZ1DF6dvHHN33nETkdbPO6hU+k04QGG81FcW5eIrKiMhjRlmvo2X2aAxVKDvA61CZe2TLhI9ALnmm/neGp/30/m9TGTOrN91spI4rmHH+rDGC3iVvVHX/W1Bt1n05khXan4P87b3Vkqhw31G778C8SBxn3I37ZtdTUR97jLxkSXAo8UuEfF1Hs8wis2w2B0Zz5yrh19Ia2NKRGTEMtG0jbHj8lNGVDk1nuMFlWc9PsvyNl4y32iKPS0V4cc/VPXEGqREmTSYQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768499327; c=relaxed/relaxed;
	bh=XS0lvYRK5tWOgGjuWzlfHcgoUbS7YsM+rIkpLdRDJDw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lKVZVqq2NOzUzpvQsbSnkm1OC1RrMuLJF6Ff2gZc1xQcpBqHilByqIpBqbRVUxcL/stFGq10H1OeLbMXf9+2n9lkVbAS6kzJarTDl+7tfiBpAM93Uwe9FF/Ym71Nff0XPmyJvL9i+QWo4OrGEOBy6V/S55MT7usrt814xmTBYeRlv6KtmMoOfQIC25Ky8X5eG0wpkUPsUGu6qTasNVZkAAFQjURg5gAkh0169HjDseSrkbJFgiu4gSSvIfj2ma/q0hmTLL33bM/cXEzYKW348CvaaqUwY90ng76z315jI0cRCsoixpbJi9xIlWT5YSKOGOyFNWYECam4AaqTW6E9uQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=P9k1aj11; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=P9k1aj11;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsVpQ6pRGz309y
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 04:48:46 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 43267601B9;
	Thu, 15 Jan 2026 17:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E96BC19422;
	Thu, 15 Jan 2026 17:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499322;
	bh=W9kQ6JHsR2ZsjaldNXy1YA0G8roGFhpDKq8DlYvicUo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P9k1aj11dtUjVmoJ2JkOIxQxD+Lh9HX+4PP4xeaiCmzMsGQQIofAxmN0kwephynVn
	 jgEFAZdP9VCeEM4+lyDrU9hFKtyTvDnuJcMFOj2OBrjJbruUs2gTh4OplQXmRdPFWM
	 y/WtmfJtSDHkl17CbGZ6JPMJHqPthmUnl/csIzRttoW2UlHIntHlS1E5Rnde4PXZqW
	 PgDdvnrYn47ZyQuoFtbs1ukRa24C8rf+drsvuUM7wKZ4EE6Lql+TCbjhRaZL9EX7ud
	 GXY8NtwMda8Oq/h6MItTeABo+X1ixha9jgKSR1HNVdiLAS/2m+SbKJ2jDIsEAaqNWt
	 Ipbx5URfWOUeQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:37 -0500
Subject: [PATCH 06/29] efs: add EXPORT_OP_STABLE_HANDLES flag to export
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
Message-Id: <20260115-exportfs-nfsd-v1-6-8e80160e3c0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=711; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=W9kQ6JHsR2ZsjaldNXy1YA0G8roGFhpDKq8DlYvicUo=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShFOGCeudhFSnNU5LrX3LBX+RZplJUZv4gNk
 R+Gwt3h8dOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoRQAKCRAADmhBGVaC
 Fb1uEACvyte6Uvy9mHwX87tjuyi4RsPEm4K1/E8jJNDj5Zi+574qjjwkKsFEVJY/H6jxPn1y4xn
 PbLLYqQrd9EtydaJ4vWQ9843FC3nqO7/SX3eALSNaseH1ryUYgOoGO627HNQRsanv3azVVKGDLa
 G93+OiYF0xM7Sn6aZGD7VGWl6h7R8eaLbMilwCopjF1rdy6+BgSG+X9Anf9cmZnxFNQ+1WbuCy7
 ue7/yrUYG7h1Th9lsN8hPXpJ80IZOZt8yyTtBH4ZTQb+PDWjJV240MAJMixKUhwPLV0rEJh0p3e
 YoUJl40N+SqwcG2HSUH8e5D/DqhXB1mBTLPM+KagG4DHcJZbIfN+MgTT6mk2EgkjMo3zfEvhxj4
 Ic2nlaRs/8vPSb3e+LFh+7m69YyNHMI8cBl+6oqSgvDdeuPHSkVEIqj8qPaYFUQFpbaqzyHwBkh
 GqW1XkAYc6fjjh9BVHmdlfk93kjoGn5Ar2sORFoPWSSO43FP2PVCrZ1R+P81bF8EFaYGMF0+X6I
 azx+Nmx6fMSuwp8IMzaMUoms0XpTf6LnULVjgzmwTbU0FExZk7LbX2n15X1OywAi3CRU1eItkjw
 So8HzuzU+Sio8FHHPHu6CBquAWoySow7mPaViwxkdytHNY8n5Zh1Nw9WTZ6j5I2MkNaAVWRSG3N
 pjvjCBbT7TxDhGg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the EXPORT_OP_STABLE_HANDLES flag to efs export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/efs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/efs/super.c b/fs/efs/super.c
index c59086b7eabfe93939d06f36826aa91838e41ba2..5e06acdab03b6f30bfa469e48463cb0e8a3b32a1 100644
--- a/fs/efs/super.c
+++ b/fs/efs/super.c
@@ -115,6 +115,7 @@ static const struct export_operations efs_export_ops = {
 	.fh_to_dentry	= efs_fh_to_dentry,
 	.fh_to_parent	= efs_fh_to_parent,
 	.get_parent	= efs_get_parent,
+	.flags		= EXPORT_OP_STABLE_HANDLES,
 };
 
 static int __init init_efs_fs(void) {

-- 
2.52.0


