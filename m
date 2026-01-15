Return-Path: <linux-erofs+bounces-1891-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603DDD26BE4
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 18:48:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsVp70dTNz2yFm;
	Fri, 16 Jan 2026 04:48:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768499311;
	cv=none; b=H67E3Ka2tQCzDwuvPRve4GA8JsObVojrMne663KdLXoPdPTM5ypjK9eD/FKslk1+r4wR8tBiiuuzkPVPyFJoHVsFBQFnCu3CF7bH+TPqX/r+yy2ffVzj9Z+eWJ8SZj6D7h+Xvtf9NRg9B5aSxKX06uFpAP3lYwZWc7lYinBICpQBIxhC+FSbodxaC711FI79b/R5TYiK7JiK44kFyU8Qd9m3WJ5da8SFj5vSyZrazeLZAlcgJrfE/ZGsuzpyJ+7O3A5dgTD8z17w+pjWPx9p/1CS2oSP6bTDRSJDH94GJebfuZewARwh5lZaKOgyh4BvLslq9asnA1KeGslgNBbkBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768499311; c=relaxed/relaxed;
	bh=RCbQDHLcMyh1xfaaKWGZNsnmbbAJtn9HmhCKSaZ361w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AORSjXLIrszV3n0ndhvO6dO8mpuCfFdBXLzZ/L6Ic+k+ad1+19417E9KpLzv4cv1dekMnef7CxVGI9oguv/56dhbTqCTxW7T21/RfnfWrKA7E/0iSsivyD7rDyYc8ibhwEjJ9jYqlljSws9zY2c7bR6OpybXNmnCqin5E5dZJjfUSY/rrCbkezQIXb7ATc5XJhsO0UOruFSXELaT3gscMpUIvLtFcwdbicb2UcyqN0sRu5isnFgSmVDUrJFBVSSrh38gEa0DqAEf5xEV3nJe2sdXmBH6c0XdqGMt7Rfsy+nPUQgvQHUFXEsMIDQaw9H1kEhzCgmfuvvn74PnIBrZDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AyWddbkY; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AyWddbkY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsVp62drtz30Lv
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 04:48:30 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C0A1244073;
	Thu, 15 Jan 2026 17:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4900BC19425;
	Thu, 15 Jan 2026 17:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499308;
	bh=yzPWVHGdY90c9Y0NTbVA+bszZ3BlTU3nheWx/Q0ZXr0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AyWddbkY1+5Bb1BTbzVfuw8e4mTnoB3EX7x0AbvDRHdV9AfbtVjbATCraTP7Zoew9
	 yRHMf3GQH0116BfZFgGjWKABQ2nJKnkYP7k6QNLzqdvo9mVkzmWAweq6oyXAqES230
	 WtCQT5NCXRmsFeuycTaRQl6Fh5Pd9fsK/b1alL8BPGVVL/0DC7ie4l0ZvW9z0bu831
	 9+050J2gyesVCYerBHkdXIgLlrNyv2b7byHHWub7CuCaVAt47zf/Nvtp60kdvEewGo
	 YwOXzlf+1c8VaChPSytGngOQxYetFFU1Ju62W1TTnJFveU4S38+XBG1tbfwNIiTlzY
	 gF1h8u4Kk8ynw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:35 -0500
Subject: [PATCH 04/29] ext2: add EXPORT_OP_STABLE_HANDLES flag to export
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
Message-Id: <20260115-exportfs-nfsd-v1-4-8e80160e3c0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=689; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=yzPWVHGdY90c9Y0NTbVA+bszZ3BlTU3nheWx/Q0ZXr0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShFcdmHlg3Fyhk1SFEGwKylG7r2LGnEhjLsK
 02h8FdsVH2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoRQAKCRAADmhBGVaC
 FbVqD/96kuVCI2GYBHsPIJ3wOdXJQHUv7K7JuvZ9gRVISfe+dKUd8y9Lc5cBgee0AZTty87rl0j
 wIS2HD7eL235/XzinCNcLOkmyX2KF3QrLmvdwYfN2f3BXFWZqsH1rD1ItTGAZsGqN6FvLxExXY/
 N1tdwEHXAZe+MRPWIsobAB8z1hTZtvC0CI6g3UUPpuwjr5hr+/2D3mSznKlLIiMlgltSB60dxUF
 h+zoOLhgj3DzuehgJPc6QoDIXAB2zEG17qxCjXe7mfXKSysVcVCLsevRlK7AofQ/UeLFlagV1qG
 KQNFgmDSIhbXzICLF/w24ziyKzdVJ2rhwydytRkY/qyS2182W74iSU01XJIpUydVBT31aDG+ljs
 H7KyeYjEaFOY7z0a9ToMhFgxZ1eQWcFnn/05oX8jffh2iPx/r1U1WmODokOvOdopr7SMCODLRJ3
 U3VPZMayVACsAOcNXTZSVH54/uDg71SahdfbdPQNmnG6893Q8BegRPut25rDlyv3aatlaHelhQF
 0WKIJYWgWPeynVAmfzMYkhFisxvjqmFG9Oy3ZyAx0IPwpZJOwyXWT8oOUYC/aZKkccxTKJb25BV
 S3ma0QxLJh5JZd8bfsM9BrkOTpcg1WrU7eSUgPsAxCra+a16L0i9ITpWWt7Z310O9l+a5gLLH61
 UkEse/HvsJZgnBw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the EXPORT_OP_STABLE_HANDLES flag to ext2 export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ext2/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 121e634c792ab625d7a07251e572e5844242fc2a..936675f06806d268ded5a3ba5306575c437ca9ce 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -426,6 +426,7 @@ static const struct export_operations ext2_export_ops = {
 	.fh_to_dentry = ext2_fh_to_dentry,
 	.fh_to_parent = ext2_fh_to_parent,
 	.get_parent = ext2_get_parent,
+	.flags = EXPORT_OP_STABLE_HANDLES,
 };
 
 enum {

-- 
2.52.0


