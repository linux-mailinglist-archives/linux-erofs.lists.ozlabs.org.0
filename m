Return-Path: <linux-erofs+bounces-2026-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 23210D3B0D9
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 17:29:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvwrj53GWz3bf4;
	Tue, 20 Jan 2026 03:29:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768840149;
	cv=none; b=EPAxCvPpJJt56IQ7kSxXFrH6nhzq2cQgGauM5Ju5tPVWVEs7f/XEKDZZzulv2vJ6stDeV1a5YSDUF6XnXeOvTzfgpjh4sHnFp0udOs2HHHRp1qtPR0GoULFBxBIzfjLpFNlrt0bku7gj8ZTvHrNIsPdhEFt3BKlwRBJMhI/iZPyS9tbI86tPncVGdC894M1U62LodaOsGhwq/25osGFdjXbljLOtskZhD9u1djiKI4zfGBpQVg6Ve77eRRvKmF9hYkfx1IpoFGdEB4TslrbhpP3uZyk2mouiPr0t8ZCgl6T97YlQQNf5Mgiqu1yEn8HUxNrJBH/P/HEdbt/FEAIoDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768840149; c=relaxed/relaxed;
	bh=Re6nnZH5SOOtweYNC6i0xBdtjjagVEySFsoYsbDZ7kY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fE5GkSlKhVOzDIfjQJkznLS1c4pcZUSUYEAteyOr3LlKsIh4zsPBjiQPz26qBRy3d5mCy4/etH1wrYJxDxSH71ZVDV2HLCI2BPGzAWkXPJ9oUzQiWOMIWO6XERP2+F2toa43VPHXsA35NZcjqsbZ0QMTQ+qzjOxVA5UvYr7ENcDlNwqdqCEQntzBUSUL8J0fYBaAenauXkiYquF0r3/vbYL99l70OvKOmFETQIN1ITRHh6EfJRYxr+vIbFwsTnp3LMuZ00byAb1AJ1qFboH5k8IAp+trYN+4k1UBZLuccFRRG88jpr7NN64pfh3RRxnhIcKEBkZBH446iLdTKDJ2rQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JRT/TJNW; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JRT/TJNW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvwrh6zTDz2xKh
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jan 2026 03:29:08 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5D1C74450B;
	Mon, 19 Jan 2026 16:29:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A54BC2BC87;
	Mon, 19 Jan 2026 16:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840147;
	bh=AZAjr5blB9svvv4iy5pFFBzbvOqXSLNmipoZVSEtwIs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JRT/TJNWCbMyt7yIyaTJly6FUhnDZuUxeZSzJVjN/nYS1ps9R0rsJvuhvNTrEk+la
	 1UOENFRaQ+Za0kHHt9AfFI6lZT3tyk/oWRcUSErofVbPjhO/YFqxhdt8WsPnnCiwPM
	 ItMD9tD5V3IaN6AvbQDQ94y0gWWnR60KsH+Y4szRkrmWQvAvN3aoV3uO1I2xGnFTjV
	 bb/zy/OjfmmKh+KLGE1ZQLzascQk+/6G4j0/cFuJri28/kIMIdJDY9BFUEXUnxNhAi
	 KKnnokIJ6qWsyghLwik29BZabKbpjfWWO9IBNOAfp2xo25sBNbzpzF0uEGAuTYvmFn
	 ruklEykJbu/FQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:32 -0500
Subject: [PATCH v2 15/31] squashfs: add EXPORT_OP_STABLE_HANDLES flag to
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
Message-Id: <20260119-exportfs-nfsd-v2-15-d93368f903bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=811; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=AZAjr5blB9svvv4iy5pFFBzbvOqXSLNmipoZVSEtwIs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpbltcugWXdJNtlW+RKXOXYTtYGJsG/ZI/Kgn62
 QwygZmbY12JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bXAAKCRAADmhBGVaC
 Fa7bEADGBiSWRROuSs8J/91dJopWVmzh98rAZDg+3UJE7SHjCQVSwc1En6E7AttfsLanh4BPsdh
 Ey7dJYDTjb3KJReJoWtnBzgjramNeksgxA+e4U65O6gESkPKGSPLVEuByheDKvRtZxmYTtiqgzQ
 Mq2wEtjCZaCAWDVrRQDMllcwjxwnnBpyGy2HIUVdgPO33orBwlEUy5KumpmMk2e+P8fDAdOdqmW
 McggNOU1g1zZKrHp5rGDw/zrD58y7ffoAo0LgxBIwRV/PXjnMWNB/qD9ShCqpQ4BTly2NhUdW9h
 vle0WG/ufE0iU82wXme1sD/eCdiyuDlzLr0gcz/A6spq6D3CzkOznL6gAdqAk2wy39TD8KxPkYs
 Z9/zAlzaWQamQps1uwnyUrZYX7AkWLLLxdX0RYn4XKio+Uv3rfn0hTkvaETy6U2dpjRknebcsJR
 IIRnE5cqH7Z6CylksCFnlCxHsDjnnrBGr2HOdEyX7vZAv4lawkMEFUbd4NnnJC99Y90W1T4O9sM
 lz0DCW67haD9hC9Htrx6MMplYEzK08RQaRhpP0rgNkN7e9hP4YyIFLMikzCI3X34Rdbegi4sDxv
 BV1chOMAWIlFLNKsUt1oXQPpErFamRzH7s+wD9wS+rtnGDO2C95CtPLHJywk32fbpo7UxFjaRsT
 NPjT8Wxn0TBT9Gg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the EXPORT_OP_STABLE_HANDLES flag to squashfs export operations to
indicate that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/squashfs/export.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/squashfs/export.c b/fs/squashfs/export.c
index 62972f0ff8681c798f0b11e17d501373b2145bd9..c6c4d8f1f115c65b6dac29582bb5b447b823d3b8 100644
--- a/fs/squashfs/export.c
+++ b/fs/squashfs/export.c
@@ -176,5 +176,6 @@ const struct export_operations squashfs_export_ops = {
 	.encode_fh = generic_encode_ino32_fh,
 	.fh_to_dentry = squashfs_fh_to_dentry,
 	.fh_to_parent = squashfs_fh_to_parent,
-	.get_parent = squashfs_get_parent
+	.get_parent = squashfs_get_parent,
+	.flags = EXPORT_OP_STABLE_HANDLES,
 };

-- 
2.52.0


