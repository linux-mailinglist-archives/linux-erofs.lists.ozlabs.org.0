Return-Path: <linux-erofs+bounces-1914-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D35C4D26D6D
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 18:51:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsVs34Nw7z30Lw;
	Fri, 16 Jan 2026 04:51:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768499463;
	cv=none; b=Ouf1aR5bfDFp/WoRQPktpxBmClq22gxysIAGYKux1QfjBT6i5mVPd1k/CWm75G7yVVCE44fmqbbnU68K6KKAyK5gqQccHcJqgEVDJ0vbSTK4Wa2r1//78VgXBqIyUE0cE/CDksxM9bAFXwbit3dxYKmmF59atVtvenIiPLGLcT9kOPsHattkXNFBYUJQGk+FD/nZwzfhfdLVXJuJRnnk2hivUybDU7kCf5JhyYiuKXouvaIHUxrqZLhR6djGIUt7A3WJhhfmgD6jQB0sixciRaaSpJkkT+t/qObwNOAq1Bu7/EfUl46Wr/rgZHg10XvX8qPRi7LwoT+ebzq8RxAblw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768499463; c=relaxed/relaxed;
	bh=yuTkwBieDaBYfiVvkErhMkdIL4UCbBwNP1dX5h4YmOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N6eDIJxxz0nu6bn7ykVlBSyZFkNBdpsrdQQ3sTUC+GeXpNIhloNZJvdCY8QLBB9dBHbegoSwHo7jgtz4WAkxRgCONwizjtiF15ki3QmjzjN/+Lhc5kDZ5tstJc3X7rsN9J/7WMJUZ6Vc82sBsYqCPEx6TEWwuXak9Pm6G70BbxsjRZBXYuOCwx2w7L+Qh7EujINkiCMDdsiaLgyuCp4jFGaY4dOoSu+Y95aSNjq6POCO+XChDlu+bjUE0PZqvRz2sho5ngohctClj+GHC7SMYkivg/tT7+L1DLgiQ4bZt5qG3IRgkGEteUsPi1NptJ47yKWhwcLf48b9DSd2NUAQFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=I4ocNczY; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=I4ocNczY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsVs26R5Cz30Lv
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 04:51:02 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 43ADB40ACC;
	Thu, 15 Jan 2026 17:51:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EBEC19422;
	Thu, 15 Jan 2026 17:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499461;
	bh=Zmo+do6HqZsZlZXVQKKSsmbSay6qOtqCBcv8Ip3ODxg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I4ocNczYItMV4PCO+hbSpubXFxTOOvRwelQ5iEnGP+dxJfSBdkpaS8BgcPNjtQo+0
	 13X39dc3sCfjz7ZMXaPaDIvAVfQvYuD8rsBiUUssjnbn+CI2LeXh9lW609XNO9pJW4
	 RWosIVWkPRVb32nDlMhCWWWWcgwSn5dwcfPmFsSOyDc8tvb8bAksTdZfwJieQuT+2W
	 oaeOsUCW736bb7SBCyxDve76M1+gzPkiVc2w03g+s5JUvg1tzkRrCMNi0uG2DxZ8OG
	 VNeaPNWMgyHbFRSgKK2V3mYG38tOvn1l0448Syr6c4z7fJRlqPTqYQWDN8yvnUIlt/
	 GVi49NPoqT9NA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:58 -0500
Subject: [PATCH 27/29] fat: add EXPORT_OP_STABLE_HANDLES flag to export
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
Message-Id: <20260115-exportfs-nfsd-v1-27-8e80160e3c0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=978; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Zmo+do6HqZsZlZXVQKKSsmbSay6qOtqCBcv8Ip3ODxg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShL32CLlH4882Enb521JW8XT+IGMo129fioR
 FwAWlYbPrGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoSwAKCRAADmhBGVaC
 Fb/iD/sGhyoeoGw8wPKWzF+cMfVdCztiCASS47/vMz0oiXGV1gCEhqTG9CMIze18Tl9Pk0p+mvq
 lwQsBXayjGP3BD7Enz9ZTXdz7FGGhaKcQ7elWJ6NnDpTqPG61yQ3iPz2tocRnByahbNXFGRT01B
 bDDG4/0lRFn0I0s8tvRGH2GA25WUCRHpQX2sqaeq3HUDDN0AO+NiX35P8nmzTYTIn6azTBEJvqt
 i7m8+BV+qB1SQJsg0wSgcn28i3v+spVZ035ydFW1WchRNsDB/B3h6MvxtR5p7m7ILVITniiPuYv
 3AjUCweM/5jRt5ND1mLrbJrbHRve0L6jhiggdidkpMJ0bZlxgDKXuNiUntjwNb/KzO0f3RYobnK
 R01fL7cRrHYRgu+sda+g9CT+vNULB2SFSivuqhJur7e1BvLo4eO63/TJwnrBm0yi2XuP/C3szYC
 pOGS0FbFrydrLRpRqO/D1JVnhNWaZqp/mJGTH3DdHE09OyqAP6gDvZoCE+ARb0ivdfwKTCf22fv
 J6tbdw+dZNehkFAI9rOCQJvJeTc9RQCChrSxoR2jiz8ROuCCHx6Nh0Fth2yHiCQG0Yu4PgjOzPc
 cMpnCsz/LNIjdu+gfSKzdmcuPlCllwpeWoDOn3Ya0O2qhbEWoKGtgYAnca8FuqgEt3DtWrex0kB
 sG0+GJPuZUBNXZA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the EXPORT_OP_STABLE_HANDLES flag to fat export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fat/nfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fat/nfs.c b/fs/fat/nfs.c
index 509eea96a457d41f63f04480da32aceae75a8a4a..f6a5c8c4f5e8a14e549b5aad6643d490f1d062b1 100644
--- a/fs/fat/nfs.c
+++ b/fs/fat/nfs.c
@@ -289,6 +289,7 @@ const struct export_operations fat_export_ops = {
 	.fh_to_dentry   = fat_fh_to_dentry,
 	.fh_to_parent   = fat_fh_to_parent,
 	.get_parent     = fat_get_parent,
+	.flags		= EXPORT_OP_STABLE_HANDLES,
 };
 
 const struct export_operations fat_export_ops_nostale = {
@@ -296,4 +297,5 @@ const struct export_operations fat_export_ops_nostale = {
 	.fh_to_dentry   = fat_fh_to_dentry_nostale,
 	.fh_to_parent   = fat_fh_to_parent_nostale,
 	.get_parent     = fat_get_parent,
+	.flags		= EXPORT_OP_STABLE_HANDLES,
 };

-- 
2.52.0


