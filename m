Return-Path: <linux-erofs+bounces-2032-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A41D6D3B0EA
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 17:29:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvwsY1VY5z3bf8;
	Tue, 20 Jan 2026 03:29:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768840193;
	cv=none; b=UOrU2XILkk9poX5CaZRCLWLsKPEWgqP4U43Iyb6ozeF9JYjSsiEULwKUiWbSTDmmlr5IJBJEUKKFSRFg984PUbJoDipMLtPadB0WeqG8P7iBDePSThUPAfBJDBLonu0l9YOYNnKxMvp/RbQe0ZrsCAFpLupNtYBcW3eO4hQ80vHOc8sKoYhJ+9r2bPm+/NxA47ORqpgrSp/2kfGs4/WC2mTljtzsSD+tsDsezW+S/Ss0bYlb8hEwVWklB3P06OKYu+SsMFWA8UzMZOnNDOHHUfOlnlmNCd6JXlpza+alHDSD3Ng8lj2h/j80f+mw4PsL5n6zISDuuIE0yR8aO4eYvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768840193; c=relaxed/relaxed;
	bh=E2Nyery+u0820owoJoyV1gjey2JK3/SSkxA2SBnZzqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RfkFTvDHK1gS3vzmC+tWAmEMm6H7ZMxRecjKvgweXwlZTcHa3R/oadm15VxsNjAKR/fMRfcYV+CC15v1HFSS/Tnd/1bHTnO4dq/EMFl5vf99ibHoVdWIjaP6C4JJQLkg955YefzWoh0ZeHGCvBzWOVfptan3lZj2CeMf1TZgQOOpKQOnJ2er1v1vKX4g3njY8cG0wGQQZCbbwxTK4ZZZJ4l5wd42T8CkPbLTm+Yfhgqu6diyAZkoDWWyWHth4c8e8gKes+Um84lxbRnjZB7lnXG7Zm1NqRGjIOb2n/F6o0JVuZ+nBF2CTkDeLoEyM6nVsTBrsbpp47iM1FCTOmxJow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=s2NIXch1; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=s2NIXch1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvwsX2wrkz2xKh
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jan 2026 03:29:52 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5C2B460161;
	Mon, 19 Jan 2026 16:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150D0C19423;
	Mon, 19 Jan 2026 16:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840190;
	bh=Vx1t81IxwVBJSLqIX9vPVWngNZL8liRiNm1RYHvLCvE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s2NIXch1qvgEgJVzeJHUQ/vYQrQNBRHWLVh+5uTV5BK04joiphSTx1rGYkzsL31u4
	 sy/FhwtpHcIaa7AzhWzmP1tuedcD3fA1mIsJbAZaKfMRItyC5XPc0SgEWTOTxw9wSp
	 x9Gbg+hrOA0pd/sDE6jmK9qhWzMpvTNFHG2fFTvutD/erMWglJ3sfK9nQEcmfsdkxd
	 byO8N17f1N+uRU1ccMBcTg89fYHra8qPAl+OamddAUNbEuYWNuIhLhvY7ePZNDr9Ww
	 0bxyA6SjcNDZgRc+BLZh/E871afYJ64+YGs3KB46gQOF5J5UyAGHKPLIlR+1WE9QM9
	 FNrRDOuqBtl4Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:38 -0500
Subject: [PATCH v2 21/31] nilfs2: add EXPORT_OP_STABLE_HANDLES flag to
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
Message-Id: <20260119-exportfs-nfsd-v2-21-d93368f903bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=741; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Vx1t81IxwVBJSLqIX9vPVWngNZL8liRiNm1RYHvLCvE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpbltevFy1oH+9TGZ4tJg4adzFVAm26w57ZlHqh
 gzds6mLNJuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bXgAKCRAADmhBGVaC
 FVk/D/913imOVzFf9dOyb6hCP9vK9aa0EKgm0XGIWuOXDiuJuE8iujL9QyuKBIEz8pjArI6pF6s
 YmQowEsKwGVIOcvA2l5D0cDnY/f1iklQsimK78XdRpHRVsbbjB0dmG9ty+CtlfCQPTf5u2wq0gk
 fTb5+p+BgYd4C1gov9SnxGb0Qc4s1X3PIIbCi6iFVl0e2J41wuqRNY+dYE3SDDNDvZ0i/XeUe2o
 +FuQghmlONCx17pc5ATpLql4aEGf1HlIQsWIlc/zUYlRz59sJC3ed2qWOJc8sXVpRJLv+fBueuw
 ObZYK3AD3rPPmH/K/qkd56Nhauz9J4ubCAJRdsvAyRR8STsFeo+NEOGOI7NtXCQRJl/ChFigFhL
 u3nVj/AJqjqttVBnyBUH6BV2sLtKoJkisZUH5H933q0vje65jZFvfGQJnqW2eUWcjfWMfuA0euz
 yWzMIJwthR6utXHrIE2MQp6D/NJjOLzs7WHdpwPDh0GI5F5lAYljmiW6Vo+gZTrcefXIOl478UR
 kjdq2kHG4hCgZMoibnXQ85diJ4l6S3AGAuqbarYCGwyJ7fboltbKuz/P0yphJTRSTMM3swpMd1M
 P/ZuEbbJhyuSOqzIDCSVviX2aD+SLpGz1vD6vezu8WkPXNdwoXn1mUe67jKXd6KUYm/8yj9I9OE
 /rKaqBOWpNc3NaQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the EXPORT_OP_STABLE_HANDLES flag to nilfs2 export operations to
indicate that this filesystem can be exported via NFS.

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nilfs2/namei.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index 40f4b1a28705b6e0eb8f0978cf3ac18b43aa1331..975123586d1b1703e25ba6dd3117f397b3d785c1 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -591,4 +591,5 @@ const struct export_operations nilfs_export_ops = {
 	.fh_to_dentry = nilfs_fh_to_dentry,
 	.fh_to_parent = nilfs_fh_to_parent,
 	.get_parent = nilfs_get_parent,
+	.flags = EXPORT_OP_STABLE_HANDLES,
 };

-- 
2.52.0


