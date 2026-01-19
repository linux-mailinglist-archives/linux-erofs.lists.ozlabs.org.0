Return-Path: <linux-erofs+bounces-2038-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A5222D3B0FF
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 17:30:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvwtP1QVTz3bfZ;
	Tue, 20 Jan 2026 03:30:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768840237;
	cv=none; b=Wev8jvil1k1bwCLaRSXiqND8sqIHMc9u4aSduOihJ6QJaRM4NQFmQHu/oVdWh069ntGjDnBDHKo38HfW24hh4hme+0GqDLlz8RXa3h8u9975qHr4ZIf5bW1wRfTFcEQp1OTjZJOoY9JI+GeogAmLTaj93Mci/248oPP4Ivu7km3mqSz2+I84+2F/Vx33gHijd/IeE1JoqtPvr+XV4TQ8CaVc3sHwHM2s6SxbJ0xso3yW5C5Z99c7iBBdpZnvLE8rIzsio30HxSjcI0O0iQX7BGP+1VrSI6GoQym+dflfxbiofowhZ9Q6mH6ep5ril7V9DbIKtqInIhxz6Pp/V6dugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768840237; c=relaxed/relaxed;
	bh=WuwnkLUgDQXbd/SOy/5k80yei661iYq3HAqCi2vEuXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kmXvnqhK74ujU26Aapf0t4JQEM5t6B//8kZ27tL0b9H6dZOWWyST4XV7wOIrNmNCb3RYT5PfTop4FsiZFK2J461SH6DER4WAir64jTbViM6gIqr/fsojR8gQN5r5cn1R4/skuuzfvsMNXA7zsiH4t5UYVVhCBHq1q7045Urn/mJV+fWORgy2Ecm7FgSXbUb5AkLKJCVrwgnlVQTQkfbDyebrfHytY6awjUO75q5tf0ywKtS/hU4TJYej1PDRV6myBmMqEy8L1IaqRyYFLEzrmYYUOwiKPIG6dDVMoRC0SRXqNjV3SbpvzD3r6E5XOM8dZqDy7Tg49nscsceiIKZdqQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N+/nI7pA; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N+/nI7pA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvwtN2r93z2xKh
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jan 2026 03:30:36 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4C5B060167;
	Mon, 19 Jan 2026 16:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22817C19425;
	Mon, 19 Jan 2026 16:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840234;
	bh=tb2VPLHr94Dp22tk5fzRHLdxd/4iteNlVo/o/3ilPx4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=N+/nI7pA5qB+2Wz8qmSRVw4ZurFxnPM9ckLYAe+J8efO1KKkatPx0ewmIZNlxvWXb
	 ehSxxq977A1EuK8KJylqhf1esVoZqPGBZhoZJcBoA3mqYaLaW9B30srSQpH9hhu8Hp
	 PhKT/itkrIVlWPv18zFYArEJrHAxv5Hh5hdum9w4ASu2Koqkh2R0ETKB9RjvkwvnHe
	 ZsPzKT3ukVUd5DpTIIKnZ/kWFchLil9blOQXOgHLTeyPwYzf/prSDarZt0MgmoTCQ3
	 1WFKnzQCCnQHor68WzbSce1iBiR3KYVLHyBpGf+FocFkapRxQcbWCo7gewPvNqKVbB
	 RYKYSblZfnPuw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:44 -0500
Subject: [PATCH v2 27/31] fuse: add EXPORT_OP_STABLE_HANDLES flag to export
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
Message-Id: <20260119-exportfs-nfsd-v2-27-d93368f903bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=749; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=tb2VPLHr94Dp22tk5fzRHLdxd/4iteNlVo/o/3ilPx4=;
 b=kA0DAAoBAA5oQRlWghUByyZiAGluW1/IaPfueYIufakRk1Wy7VajFvE5Mi0rJeiI8SyJNibea
 4kCMwQAAQoAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJpbltfAAoJEAAOaEEZVoIV1NgP/3Hx
 4TQHJF/6t36D5pyiFxAckKtnLQWuKxq4WEPD5FlhEh6Ptylt+qeF3wJM2gvcXH2VxwirFBR8cjd
 6bOvlXOHQH+nhfO1lRSkytQlbq6UxY0vPkg30u3xphifyBZ5UaEOu9j18/mTiVDYtgOjthfRJMZ
 ixd2vn9fIZvVGyjLubw8BKozpjyEV42epDShz263DxizQ9ckGpQvOd/lNNLM00tT+zhK1rYHDRN
 uAqizwREj9nMJnsCwEzqbAGURMWTq7KKRWlVJSAU7NcmZsCO06+eW6E00PRDYFP+SqsG2ALbkZ3
 0rdBMRTbkJnt8WWL6dwrqSZnGFnkJhVeyMXXqHaieZau2yPGuevBcMUnHmJfUAcZMZLK02tC4KZ
 BfRCYFjEorMqchCziN1COr5DxREd6c09F5IYSy8V6aRDl+OIhwzO/BVZegkxZI9XsUmExpocSoE
 D8kpU2BZ3GGA+GD6NuzTDTyzE3kbEB+2rbIMCT29YSv69mYy8L9D3tCmVEVSKG1D/amCfPatX/s
 xYwgFAsXGOSnsGGzgCLoU4p/mXsV2cdq0yj5uYa+h3U2/yQIu3OEeNDdsXCTSZJ4XzcSdg8wM36
 DVfZqz28XNdL0SYvbvvCiuQShuu9bYTFT639GxoqXNPIKhIKveBMs+6uqXLUqbbYBYUdDy1RDVd
 kClwI
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the EXPORT_OP_STABLE_HANDLES flag to fuse export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fuse/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 819e50d666224a6201cfc7f450e0bd37bfe32810..df92414e903b200fedb9dc777b913dae1e2d0741 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1215,6 +1215,7 @@ static const struct export_operations fuse_export_operations = {
 	.fh_to_parent	= fuse_fh_to_parent,
 	.encode_fh	= fuse_encode_fh,
 	.get_parent	= fuse_get_parent,
+	.flags		= EXPORT_OP_STABLE_HANDLES,
 };
 
 static const struct super_operations fuse_super_operations = {

-- 
2.52.0


