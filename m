Return-Path: <linux-erofs+bounces-2037-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B75E4D3B0FA
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 17:30:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvwtF287Cz3bf8;
	Tue, 20 Jan 2026 03:30:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768840229;
	cv=none; b=U4uVFqiCRyttYhgcCBH0v97+7rwpeguyjr6QxCaGTX0251AqSvPS50vSteSBU2duWyCVU07SnDoXe0vwHXDxrJgozfQ7tB4E/v4WUcJSIaT3n+U+YXYKja7P4QjBNyea1FCuzEYyHFczWHvKuaOwPO/7zDQ6i+2AWYWeZZXJu40dEWcBhpXVop0MRSyvn/ILXhz42l/dB0KoJKV3f0qX8ZpHaM6hYwANz+KiMjV2NZDqJll1rnZBTmQmdvUDt1c0s6siSojpxVu306aZKVY6Ly2ck5yg19Irso27RlcaTTuUedJDFAYiqVFwHVCA/OnFJCg+nWRQJZMClhh1XYdOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768840229; c=relaxed/relaxed;
	bh=ehBSJ++W2cPkB0J1WK/qzYleqmCU+xmhuZ52acFYXD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D0AYWZ1WHWbJXs8Nsf+Iz2laW0+4p6gnYKcIx8nYh72RWsLG+nSO9I8AwWnvYFtl+29FqMpXlLZer0LGd1yT70CXqJFGTC1fgzvf4UMSXmh0/vXmRwdDgRlQ2GRau0u2Yz8BFCvrOyfOwK3WDfuUchOg1HjEbETOgn81IkXa1A01lyUMNuHYFbWiSioPRES/DzlxjWnc6L1IZtSybI4QW4IfAKRkv4yZ7ciZ8DA8TBpkRKJuFJ/OW8BaRDOXRWsCmWz3iuz6csLIFZW2ui8O6n932PVnULlMsZvpIIPtA6U7S7qKZuoekDJstP2Hwd2977v6yKM7Nk59lB+z4hvlbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Z5mgImMY; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Z5mgImMY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvwtD4GnBz2xKh
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jan 2026 03:30:28 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0479143394;
	Mon, 19 Jan 2026 16:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD2BC19423;
	Mon, 19 Jan 2026 16:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840226;
	bh=Sci10TD3wPs0X/nu0ytauQ8Ud8Tj5YY+K+HKIyo6zgs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z5mgImMYuu+vDaC5OsfyoFU4eAFJAkeUyQjSB6CRWktgD4KibfHiZ5CUg7Ays48l9
	 EjX1kGAqQQ+zZZ+UE7TUs/w3PWzjdeI3SjHaQUfxMbdJQjJNZGwYgqnowTGdH9AvHx
	 HdNKl9RxTyhrRJRxujGvwNkZ/Ifho0GuYndVwdirg+j36y+QMn0GE/ZUUpUPsm/s53
	 6Q3Rt2Tm7RurcqvI08fLVS7BsOgFE8BKgiHmQBA4X/eT+4hE4wfXAxn5WbcVQwMCyX
	 vSUrwRUb76V4rU/VmlnCa1I+cPShEEdWszkToxnNVTYZmhAyoHZLsmqagjwkUUQ9IL
	 vBJ2dSWQ0auqQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:43 -0500
Subject: [PATCH v2 26/31] gfs2: add EXPORT_OP_STABLE_HANDLES flag to export
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
Message-Id: <20260119-exportfs-nfsd-v2-26-d93368f903bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=670; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Sci10TD3wPs0X/nu0ytauQ8Ud8Tj5YY+K+HKIyo6zgs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpbltfAB1NrPj6vyLXaIZcARRV83kUQ0X6tnkqr
 rSH7KQc5nWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bXwAKCRAADmhBGVaC
 Fc8YD/0T6/loL/0QUUXJpbqWAX29+wqZxsSH2ChHCMfmatnCljrw6rJW3ydd07PbCixgYxwa7dH
 zSI0UF2LvqlhJ4mr0JxiBXQN7XS8u4Lo+ji3M/Bdy7P9S2bcTQ01P8NbN7pWDALsXrOr4UwH/O5
 eIGCDRIvfIgg/JtilUi5Xw9J+WnBRW2/K6XL++bUEq7yaQpKuM3ExrBRnr/pLhRRW8KEbhOaXjk
 niizneAenTAevWvDRARxsjp4DCTlaVlWjnR5NKvqzsWbG8yNALPj3vH3g7tXi/JMieDIoovTugr
 zXQbQCushHy74btLy45zEvS0yxgoctX+LagcmgmtXgvYi7tksxbpXuTkNIpjTVPubcoN1wK5lVG
 0f4yqTtexJUdRyM6ZQSxbaCuvTulJy9+m/X0PvdfOBbH60lbjJfdkrY0CPVfwbzPiGqA7MzVo5u
 1is7wiL/+kvOlN4wDqKpE5hDJGZ7rlEOp+CAjjGKBYuWUsfMEcZ2aNC7ux1WmiW9qSjYbit4/Ua
 qnexquVoCAxIWVeOuXSEcbt+cpR3DW+9+uBYKgAINDiLSKyVAZvtG0z4IyOHVSCZ8BqpFOD1OEd
 pYVBEwtKLQpy/jKqBhtFB4GzhRaWAE8rKVayjBX06AYj+r+wYbEdOiHXCjjVbuo0EaMrsZrTArA
 /DiBfK7BTM2dyIg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the EXPORT_OP_STABLE_HANDLES flag to gfs2 export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/gfs2/export.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/gfs2/export.c b/fs/gfs2/export.c
index 3334c394ce9cbe26969809874a94e79bf068b11b..43fd2203b34fb0894d2b71e50278e5cd68216ce7 100644
--- a/fs/gfs2/export.c
+++ b/fs/gfs2/export.c
@@ -190,5 +190,6 @@ const struct export_operations gfs2_export_ops = {
 	.fh_to_parent = gfs2_fh_to_parent,
 	.get_name = gfs2_get_name,
 	.get_parent = gfs2_get_parent,
+	.flags = EXPORT_OP_STABLE_HANDLES,
 };
 

-- 
2.52.0


