Return-Path: <linux-erofs+bounces-1901-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A26D26C83
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 18:49:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsVqP3X2lz2xNg;
	Fri, 16 Jan 2026 04:49:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768499377;
	cv=none; b=Rg6RvQzBQSDprQEqpktbjB7oNIcueJNPtfjx2e2zUXPV7VMSzOBOj8cwLIiAq1fjBbsOCid8rLB23ce3Oo8ec41xRWkIc1yKUjmTmhRYp+Hycwnhe6lBMdiPfo8sLzsLQgJ7kXnLa+Wkv9CzjALQhf5AGqMb5Q2CXlamxLc4PkrjdeCX+V1CsmkKk9++CXaTJlCi2xkKLf0Z4Hf7U4l0ngYRFGOV9S7o3WcoY5IOB7tsm1/rV2XsydBEXl+ZSBK6Vwwyonfgf5RXh6HDBzt/m5MwoagEGWwjp3ZCH0HQ8m/ufn0zlslh6a4EwwqzK97l4nxqKMzPIHdMo3+9MCWzFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768499377; c=relaxed/relaxed;
	bh=nGE+/R+xr2ssRJ8nfYf9SyWSi8dZQdz+dJrmGvlYUOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q7Jm2BQzaNqpvEuFAduTwPo8ghbuU0hC+8v4JwvgRKRYZyobq87CvYCCNuIrnWLMsCI1MdqLL8VaG/NUKVnqTmC2SwLhfIfJ8242JwSp6uOFoZ2BZVM7RG0xFCEINGcYrGz5GMYBSkbS2HUsb+XhXktn3pR7yLofJ8+8vbUAOcjEIEsRBWByi1mbwFZWMvnzNI+w4w7iOdZaR+v4jG6A64EZza0zT4LggHPkpkWY1BvWn/Mn+ZIjxRMdhzmQK0JQxb2YnkBFiQHpJJkzQWtJBUae/f9++Uz1+hHQuwLQIEfQA3t4mHueMwImEHdLC1NBPDcQn7rAxwIzOyQ7pWPeMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MtzuIh+j; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MtzuIh+j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsVqN5WYvz30BR
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 04:49:36 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2F0304054B;
	Thu, 15 Jan 2026 17:49:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9781C2BCB2;
	Thu, 15 Jan 2026 17:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499375;
	bh=KwuPM0JvOV2Y7neKzi/ub00ol0HUZ0d+WxzE/R5Rb58=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MtzuIh+j84bstKjsgPpleVDxRrs1Yf5No8647Evhx0+iM9Myj1+TDlreUc+fbCqBP
	 5POihyVqnyL9Volk7VBvPm0/1F3iFmpnjbbOwI+SqmEdVivQdCS+MgI9LG/l+BlUaK
	 s2w0ZUN5s2N4stTvz/OIoHSrJaE56oxacHPgAwx8gYvjlMQzSuK8OOzGzUiSJWMZZ3
	 MRvP0xqpBu2v0w9vX7/03YRHxPKRbLGxTO5vEWauXJXlDZ8OFusX39IAWOaBMvO2vy
	 2vkWgH1aet1K/R+NA8ZxavFbBVWjjNWwv/K8qdA5ux3uxtidjH4R2cuEr7aZwDRcXE
	 aBOyx9ONydY6A==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:45 -0500
Subject: [PATCH 14/29] squashfs: add EXPORT_OP_STABLE_HANDLES flag to
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
Message-Id: <20260115-exportfs-nfsd-v1-14-8e80160e3c0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=811; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=KwuPM0JvOV2Y7neKzi/ub00ol0HUZ0d+WxzE/R5Rb58=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShHm9fevfEQHe49RNxKFnfPTPGVBoyOXaDhl
 y0a/1EhSbWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoRwAKCRAADmhBGVaC
 FbOKD/4kLyr4rIIQt2zl2SLHntE3ibyDMzGdKD4l3jfUvNu8RNcwRqaHjDzCQnoUnEOWkAFt6gm
 33YDsabLYaWiwW3riPKtFsXi+UQZdkhwL5/trI0nehU7Dd9LQ1eV7m9FsKmIGrwbVE19B3FyWfA
 bB8YGR706Suce0iR7ci/0z0csTdU3zTqvzojqtOu4/OYtq+GkC/6k7OgOCU4RQ6c55fR/+e0LLq
 P7jqv+QPhK6GTz90SDHxvtmhoW76vzDZEqlFGILfq9vhyQ6X+CQP1RydBtFghIztt/Fz4TSK6xi
 hiG8xV3hnRG3+msGx4O8Hfmv1h7y9kE0BNFh4PEgpSrxWF8l8kRg9tc+IGQAWd89tClvFXR/qOL
 5uc2lTR8WHlctE4PlAiIOVQJRqkco6HxmjKkUxxTHRj8OKbUXkM9uy2Mch+bRr0fMdMSkR2Kb9O
 /aFPzGpZYTjIgXYdoSkMg0UGAW2KMIw06oZ44xNvihqtJoAFLOQy6ZgQgA1RF13eSt+rYrSuLHc
 kqP10SY3GyJjPWX6vVl/KMoQwB0QXqbK/jcVTMJEZB1lo9YhkitLhi0dql0G4OjUno9IwKh6FB6
 RXkcfJpR9KghiraL4CmDZ0y9W2AK9tGoeeBqEAY+os9Qsu0tT+NRnEzgdJK8mcu9lBOPOe41Yn/
 pBpZrQXTJWrMkzQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the EXPORT_OP_STABLE_HANDLES flag to squashfs export operations to indicate
that this filesystem can be exported via NFS.

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


