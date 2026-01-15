Return-Path: <linux-erofs+bounces-1896-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 773CED26C2F
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 18:49:07 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsVpn0FScz2yFm;
	Fri, 16 Jan 2026 04:49:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768499345;
	cv=none; b=Ay+p+k5/txS93Aw90dBc6gRoGxT3c5ViFrHspVvP/JvA2E68ClYI5uGL1pmw+QMnNw1J5DHzy21xbjNeH0Oeyez6vK4q8JHgr3YmPjaSX08PPqK6Zrmw0KcXFcxqEh8CmiMENsgxqON9mHe4cQ8+f7CtFNY572KFeP8pRj7t4EB/b1lJ8NSvP9fRaunBNQUbPL/SQBvJYBm8d/O3XMa0OSCUlhU2W5eOjSJbXKYs/dScVJE3/hf1Q4+i9LbNTxg4/N+xEc0Nll5dQ1/NMQ+S8cA4M+RHc5ghikwmiNTSrQPc5AOnaJwuwJn9Y5GzvliD/xRnv1lu8GciSF8g0EBVrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768499345; c=relaxed/relaxed;
	bh=tbaS2GnYHC3Yw0jcd4OE6CDNnF+8x4KkNvfYkhEmmgI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c1soTZkQs//NRkrEixX1niunvAVUOpKKoyffDoBpwMaWzRii+YiKNJn1dcJUKSTsU1cxwk4l+L8wqwyht2jF7wZL3azE2LmARjGmWcRqCTdjREFMIm3aUJMOtHmE35lA0DA6gpHXAipRJX5ckYj7xdpnVFSSXuvDoX+FfnNFQMspUJ63vfuNw9ywZjJ30y+p6XeQTIm5Yyy5jK3VgpEdxjsOW/ecwSKJn7Pbsk8tz6bmSbRhMFj7Gppospw7DixBV4p4HO3VMYtQLa4Y+4jNazsbeoNWOm33ndRJZbSksPqGEPzAEFCDV+72+1SEECUPHqaBf8C1MA8fDn0Qx1CxvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VhGTowRv; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VhGTowRv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsVpm2mPWz2xNg
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 04:49:04 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3CC976015E;
	Thu, 15 Jan 2026 17:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C9FC19422;
	Thu, 15 Jan 2026 17:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499341;
	bh=kXEhnrEqBGLUfKXF9oxTrDiEyMD/rJY/BOIQHOiqT1U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VhGTowRv1ZdCSbwrP6fIZLhAzqz52dHubpyKszBLI7URAG7W6SPZKGF3KIn0U2zg+
	 5tVYEGsuwDF0mJJELm7H4UgOFOZa8Rmf73fjwJHRZQODsuh4NDe4N42RJqo5k0t/Ox
	 wk0Zyo9z0NB4J2vm9kg+NAPOl3NU2G13g328/x0Ky/AmMH30Duw5NUr8i6JtfOedpq
	 J5Dm+VWr3ls784CODv1E8lo+kwt8rHWrmv7tNk1pSucEBPQyhieOVhKlDaTv3/dxrS
	 mFXsnQgF2g22EioMuqnjQY2fJpwhESYq4WgT9lyV5RHSiQDikgxbfcTKxzQfqZwGW+
	 WoFqmmRBqrJHA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:40 -0500
Subject: [PATCH 09/29] btrfs: add EXPORT_OP_STABLE_HANDLES flag to export
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
Message-Id: <20260115-exportfs-nfsd-v1-9-8e80160e3c0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=678; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=kXEhnrEqBGLUfKXF9oxTrDiEyMD/rJY/BOIQHOiqT1U=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShG89hcHuGwJsd2BxAERNQ67iytfM88cVk1v
 a8CNYB6vTCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoRgAKCRAADmhBGVaC
 FfdyEACPSGL8gQMZBDLdHovcBu5qSm6pu4yGdMYyroq6SWbbG9R0Q5Q2XtDnm7GKMnylAUV/7eD
 76S6FhEf7x/OgCgs8sl5VNhrQ1fFRq2rMYx2v6XOqKiCyRShojkXZw/Hxwof17Gk/IYLjwdZqim
 VUVSQ/pSZy3CqJLm0BXUsMs+kCLPzF5G8ZkLT+BNwDGC3KZwhB0HtOut2eYvgwYxWSnQGjV5v/9
 txa5IckHztnGFocaKw9dBZj2YbgWQs37r7LRAJZsmPoSO08Rqu7zr+Z0BtWAAvznqYRu+cQoycT
 41wkc56BHYvd4UFgUOM+7TjEbXnVfuX0u7VdrLQ8esaCm2oh4x8HfqZ+Zt1Yhzn5xhV+bFqmu/t
 D7mX3Pfblk6hCjPdSYPsj5IwLEIKpxUwKcPwOofceq+p4s8f3HXix9p/EPS7PVP2XzgAebYNNAM
 VJxrqtcHumJplzhU9CGlzT3Kob2C/sZ7FqRoMsZGZMRUoQ5MUQX9iFNSVEhAzTf6S5DsYJ9MYse
 c4Chhe+FV8WHQsMBHumIIWiOuHDgPOEeauU1sQlYQDU6HwaQ/bEdxHShDeA7b+/riW4JH/ASR5x
 OGlR2kuII9fCsvYL2J9mVdHOCwyAWITJMJ1OBaJp+VAyA1otLqh9rgT9NK7BlTdb1x13X84Xofs
 i45vrL1rJ67tEoA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the EXPORT_OP_STABLE_HANDLES flag to btrfs export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/btrfs/export.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index 230d9326b685c4e12dc0fffd4a86ebba68a55bd6..14b688849ce406b2f784015afced2c29422ab6c3 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -304,4 +304,5 @@ const struct export_operations btrfs_export_ops = {
 	.fh_to_parent	= btrfs_fh_to_parent,
 	.get_parent	= btrfs_get_parent,
 	.get_name	= btrfs_get_name,
+	.flags		= EXPORT_OP_STABLE_HANDLES,
 };

-- 
2.52.0


