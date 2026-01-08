Return-Path: <linux-erofs+bounces-1744-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9EDD04D8B
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 18:16:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dnBQc3W0Qz2yMB;
	Fri, 09 Jan 2026 04:16:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767892600;
	cv=none; b=Bd0xTi2mWxs2bRv3X/MGMG7dqS3KLRcObSYqnP9Hz8UxaDbeSsMhaFdFuAAB08SiowCCadmDwgsAjeL7YVdCXaDdpEXx26FeL6kC3/OERQAElkTsz8+k7O2D5RzabvYLAL9uszqVoPQlVcd3ZX+dC1Md2/s1Acvpv2ELOv6s0GqjuLN+CZmpMYdVCzLSvnCUrgdGV+sGDIdzWbfN6fn81d5pckkpQwv3FlvVc1l1ivsFI44ceLuzoP0XXJkV/iSyG7ww0OD0V5YsUthAEoEuHLKFNrLsWeeUx3zplLu8JuvID7tPqUD6kuWbsrXBSibsYR6yoZpr6D1aTeQzCuHqYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767892600; c=relaxed/relaxed;
	bh=PwAoht7a3jGi/5dXz5pEQXMhfplROvUnQsiXMkqy754=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=etpDugQnmBZWMrofCYlNpzmOe4ooraVo/VTbVRRTNWKV0MsJR8GKG0YLpWKlSK41SzGqtCCmI8OOh6bmeqYasHkemjTFnGQZjp4kmnTyqBOHpjyZwVoTgixu6uSKIRREOJnVHO5UduTut7ZevY4Jz7KtnBDbZh+5ggO7GsVRRNpMPcH64yxb/jgyy/JNZEDYINVJrdbmfCBHeYWZsLkPki+TIWqCzrux7dCM+byRbuUTAKwDxi09Jnv/copQCmh+cQjaKMrip+V2wWBd7MW814xqxyhQkHh4oEftFbR5T2Eixr4a5ZkzgAPP8WQJFS11l2SdU1TDYuUvsAHR5UYFKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XTcrMvWG; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XTcrMvWG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dnBQb54jCz2xGF
	for <linux-erofs@lists.ozlabs.org>; Fri, 09 Jan 2026 04:16:39 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B851B60152;
	Thu,  8 Jan 2026 17:16:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F2FC2BCB3;
	Thu,  8 Jan 2026 17:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892597;
	bh=NID4NaaK8cNH28A8Rn+v2PbCj8aVd6A2vQHcYBl6XEc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XTcrMvWGmKFvGwAYstJ6dpq7B/a12oideedJX/ThejFncpxpueWE1/8kcHPOQeVZk
	 QFWvIwhXvIK0f0/19xSsSvLDZxcpHacHvMrpL8K57jbA0ztziFoJOozdl4ej7Srsqk
	 IJ0ieRHWcycFHrOQpwYkkWmJEgEeCbWiiqP+kKLCTvF0rMcz4DTKBtnopfo9o+a7A/
	 ALxsVks9p4nDFy19KiMt5fsLyvATj5/h0UOqcjT4fVOW8uedPPmXkZ+k9zyu3Gb0t2
	 f/xnx08CLyXtuwL34A2sbbQNfdmTKLQZ5rLqii0Ytq9MzeBjv1sgSo9/YY+39BK1uA
	 i2jzGPW/BI2AQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 08 Jan 2026 12:13:18 -0500
Subject: [PATCH 23/24] filelock: default to returning -EINVAL when
 ->setlease operation is NULL
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
Message-Id: <20260108-setlease-6-20-v1-23-ea4dec9b67fa@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2888; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=NID4NaaK8cNH28A8Rn+v2PbCj8aVd6A2vQHcYBl6XEc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpX+W+cLBRWxzgtw9xiO4SbRJTFDfCZwbur8vgI
 DrUAdciXvKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV/lvgAKCRAADmhBGVaC
 FWxwD/49jq0dpl0tpEt+oaAFd4j0e/fid44vjg5imuwIhXHfcwsVVI4fUx/pz3UE94Qammox6zt
 upvbtem5sWsRhamPvtqVWrJjw3WEV+gTo/v2UllfbGPmh6jphW2/TcVyvTFMYjQZBfVyWLbN3jA
 3EVALc5vqNlMGchvznz54yLVU2RChzyx1XvCDhHwRAeNSAOGO8/1o9yXbGLyvPjSBJHE/68d6ki
 r/PIpu9JbeJugyz6HygQj/YOpchUfZ6FXD6KzyRcth9Fr3t5To8fhQTanvnQzTpe38PVFpxwy8D
 xwiuSY/o3EnGvPHb5b7HRRKCgKbOlvFEDfJWwiUCM6pZumnUrF7XAH3v52LionbfPxfLmcvOU6L
 gpLLdRy2M3uTOACsZavhy0S9lVZnTo4goZFr4ev0RRvmsjX+YTeV2ow/h8Vg4LKuFXUFR+5H3rG
 W30w4jQ5zSEZduWe5iGwnzyrIHJUB1ZloMPctMrzuCHbdMt2PszPfjsvqBlm7yLyj+EsqcH+7eN
 ipQkLEkHcqrbFNjwLbqEKEjK64Kjp9khIJv4PaXVv685x1D7zSSXqqq2QocKVPLs6RoSmQPkUDF
 N3wB/LHoG5Est1DU0o3AQeWJkEbKY5rRS9DAPXxFfP4CE7C7/5Ho4WFA555yX3b5D55WwWYyXRr
 /Y+/b/w6+wP/HzQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Now that most filesystems where we expect to need lease support have
their ->setlease() operations explicitly set, change kernel_setlease()
to return -EINVAL when the setlease is a NULL pointer.

Also update the Documentation/ with info about this change.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/filesystems/porting.rst | 9 +++++++++
 Documentation/filesystems/vfs.rst     | 9 ++++++---
 fs/locks.c                            | 3 +--
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 3397937ed838e5e7dfacc6379a9d71481cc30914..c0f7103628ab5ed70d142a5c7f6d95ca4734c741 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1334,3 +1334,12 @@ end_creating() and the parent will be unlocked precisely when necessary.
 
 kill_litter_super() is gone; convert to DCACHE_PERSISTENT use (as all
 in-tree filesystems have done).
+
+---
+
+**mandatory**
+
+The ->setlease() file_operation must now be explicitly set in order to provide
+support for leases. When set to NULL, the kernel will now return -EINVAL to
+attempts to set a lease. Filesystems that wish to use the kernel-internal lease
+implementation should set it to generic_setlease().
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 670ba66b60e4964927164a57e68adc0edfc681ee..21dc8921dd9ebedeafc4c108de7327f172138b6e 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -1180,9 +1180,12 @@ otherwise noted.
 	method is used by the splice(2) system call
 
 ``setlease``
-	called by the VFS to set or release a file lock lease.  setlease
-	implementations should call generic_setlease to record or remove
-	the lease in the inode after setting it.
+	called by the VFS to set or release a file lock lease.  Local
+	filesystems that wish to use the kernel-internal lease implementation
+	should set this to generic_setlease(). Other setlease implementations
+	should call generic_setlease() to record or remove the lease in the inode
+	after setting it. When set to NULL, attempts to set or remove a lease will
+	return -EINVAL.
 
 ``fallocate``
 	called by the VFS to preallocate blocks or punch a hole.
diff --git a/fs/locks.c b/fs/locks.c
index e2036aa4bd3734be415296f9157d8f17166878aa..ea38a18f373c2202ba79e8e37125f8d32a0e2d42 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2016,8 +2016,7 @@ kernel_setlease(struct file *filp, int arg, struct file_lease **lease, void **pr
 		setlease_notifier(arg, *lease);
 	if (filp->f_op->setlease)
 		return filp->f_op->setlease(filp, arg, lease, priv);
-	else
-		return generic_setlease(filp, arg, lease, priv);
+	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(kernel_setlease);
 

-- 
2.52.0


