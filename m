Return-Path: <linux-erofs+bounces-2029-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E22D3B0E2
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 17:29:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvws80TVFz3bf3;
	Tue, 20 Jan 2026 03:29:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768840172;
	cv=none; b=VbvECRrESnoo7wYV0GdcNGuC3uHNLSpcg03h6n/AbBNddIgZImA2yW/lCtS5Z71ZAI7ZlQ26QH4uyzi3Go4s6Olv428yf82KxKQAIrRZ+bGFBfFYsWkdGJd8mbldNmlpkHwIMXQKzE4RBa8WOd296jTks3+qZYD5hdgQXnaaN8Uu5O8rl6vmc9GpwgG8ErDc009EC5RjUyQW4/LLgkj6EXZK//3bvuVZhbmpu5qYfUB9uaBrCW6i2LI3Q9dICid1l+eIx4xYafSwuulWcNcJEv/+cxyHu9Sep3CpOw71InZfBnd5yTpqbZ0V/VOfhltVRptcDQ3hZPmb+YnDTY5bKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768840172; c=relaxed/relaxed;
	bh=sNRXqgtLINsO2LjaYRvHXTTyfbuwIc2N3jXCIBuI6EY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wagop8QcFTNqBoE3zxrN5lls1EilI0UDLzlBVksCt75+3/JCTXOx2OytU+i7452ZJTAHi46s0YyWv6JEntqfxPyJzadhqR+J8eU/PUDrtkKVlQ5gFdEeX2qWAjezmUSNo2dK2v2BQSGCq3EhCvuvrB6iTxkx0/1weltI0LzE8qbcsxMHQjjCKKoXwgvzHibhCkdeYU5qbT51iKciI7PBaWO7b0k8WnO7ADEnz9Ovod8WOdVJwPFXnfRJ1nQ3rvqd/uhy/04swUWh/Pp6Bmztr0PUtnv95uUxh00rDSaSZ0mF7IJ2PInWCRFVTi6WD62qPWF1sp0gnyzG26qrlAwvTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=s0+VO6sV; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=s0+VO6sV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvws70fhnz2xKh
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jan 2026 03:29:31 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E0BF860140;
	Mon, 19 Jan 2026 16:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DA3C19424;
	Mon, 19 Jan 2026 16:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840168;
	bh=G8L9z3jgn4ZzCiBzdCY6syeE/KUQa76p5EoRG21yt4c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s0+VO6sV96AAayqW4HXC57FxZusoD4Mr5w8orM2wKOHjCe4I1o88b2JDzVMiBf77Y
	 pDDjACRlbOlveBnJiQcXYVA5qpw+/sU2t9cL+ik+kbcwUdNnDmXocOzTjFulfYcHI2
	 x2A4unujL8OvOlpmgw2+OIu0I9FPLARZ6mdAINLrqA7eln2pZpKV59z8M/E+gT0xkw
	 xUrOTL9ynJB2DvZABkuZtdOF4x5IHc14IzGdRINZFy5mpXXM/x3ukRBMnStp2InutK
	 CQpw9K34gzMddctLV8apZ7g9I5NucGaI5vYJYjUgfl4BotibidZnZ3y8HmNY931YWC
	 N6Dy2SFiZXtTQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:35 -0500
Subject: [PATCH v2 18/31] orangefs: add EXPORT_OP_STABLE_HANDLES flag to
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
Message-Id: <20260119-exportfs-nfsd-v2-18-d93368f903bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=801; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=G8L9z3jgn4ZzCiBzdCY6syeE/KUQa76p5EoRG21yt4c=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpbltdXD5/4/NEvshZqyvt1InnFNA2XQmYrmnTp
 pyWIY7yRpGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bXQAKCRAADmhBGVaC
 FcL5EACKAKVsfzFMfTk2Rxl44MOn7Jxmx0HGw2TNaLjhEixH9/SJUnhSyAZxEqPlwKij9mWLRg9
 egLOfPv4xhcGi23lAB865UgUt64WvqFfyfMMdYy71SNI1xeODPqIf3wifOxvwDu9L+U/jmLnQio
 G5WhwpXxYDtE/CTJQQIlFIhjbwxjo1/FLRxETOlt3wlERGLD+guFUoBS51K0YtAjvLB0UHSsQjx
 JLr1J0KKtVdeSSPF5aie8eA7UzNRko1ECjRTHdljrDg+uyV1//gbZ9Is2UZmJyRBbzlfi5/sIGE
 gwjA4Ud0gOkvn9MVFLyc5IXIvO+GkhZJ5oa++NC1hmG1o+rzBleXhb7KyYc6GBC23tJM3YQicN5
 zzau2UUB0ypQ4uefiOj+ilvYE9bQcyjR9dNPSxO3f52aJOYpLd61ADVfJ2hOSylDBWcJrY/qtoh
 xJ4rCxXYQvqZE4cKULYWIt98FrwfMhaLc0pBN0bWK6V8yL6Epj61iw00IWkT8zRPIVrjGCqdHpV
 KoylaD3lxPgCuGO/e0wwO2wU/h2UFpO1o66DZgVouEhyp8OSQtNZIdkFKLVmACRR+k5YCVSDKdT
 I/cC1UslVadh57kMMm+xS1iAZvb9WWuJ2bMgDRybN1wR9LY39O0TPBVl4/YilWCVBRz26kgARRz
 jQUOMwDTLocp+rA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the EXPORT_OP_STABLE_HANDLES flag to orangefs export operations to
indicate that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/orangefs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index b46100a4f5293576549300ae9050430c3f07969b..140f27f750939cf5538eb68501dd60012bd2daec 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -377,6 +377,7 @@ static int orangefs_encode_fh(struct inode *inode,
 static const struct export_operations orangefs_export_ops = {
 	.encode_fh = orangefs_encode_fh,
 	.fh_to_dentry = orangefs_fh_to_dentry,
+	.flags = EXPORT_OP_STABLE_HANDLES,
 };
 
 static int orangefs_unmount(int id, __s32 fs_id, const char *devname)

-- 
2.52.0


