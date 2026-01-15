Return-Path: <linux-erofs+bounces-1909-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38060D26D1C
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 18:50:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsVrQ6zdVz309y;
	Fri, 16 Jan 2026 04:50:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768499430;
	cv=none; b=cdqScLdhB6b589ASznxWc97N6L8Ml5YI3YtkghrrLWHMaBfViwOg8Nsa0NfriSlekvWN8qeSSaNErcMtcMeW00xoAN4a5gfuXGkSBsiAgZ2XzewL8GY8E6Qnc74OaLmwLMVoT8h0xADV2tOORn2Nc2dz1TZ95M76Eu0S//D6hfh7EZoK1H5qJ3bK8yeRhzNO1FMS2ccnWx/bwMC7G65N6Xl+ct8V7voRKgvM6BAuPdPrqdx6zuGhCbJa0NudMoCjiXhJ/F0teyWR4jKSbL3jlDCJw6qF5quS8HIgpLJ6fudj9CkyTZkxiEC5LBks5kmgyuPORCfPUZ18IsttZI6MUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768499430; c=relaxed/relaxed;
	bh=Xp9C0iSm3vjcoVN+J/acwVOJxS7zKjbIu6neF02xM+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P3PDoF8cfZcjs5QKSyBIymfJ+SP1vCTvcIDnievze6gDxYAO8wweE7i893nqOIZiE5K7Vce1Dw5W+0gRgFqcWc+wvtZS83T6M4uqCH9Ln+6Ag+5dDdJ6D9Jf7/maKGn303DEYdY0eTsw5OpkfK3uLBfU/djfNmXe3/CGPG17GYIcpIZ5PyXpiaslbb27HYHAsKkDoX8TeITH64c4PbvkFpnZAmhN9gy1jeOerumMygzrCstKZcdeDFzqm3IE06AOnr8fopfB9C1wGkemLktgQajv68WO7eEq9sYrNDI1ipV3ri+5auNiTynQ3KmUyFlJmCf20VnVXWA2GGt/G5H2XQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rR6P5Mqp; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rR6P5Mqp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 106 seconds by postgrey-1.37 at boromir; Fri, 16 Jan 2026 04:50:30 AEDT
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsVrQ1dLSz2yFm
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 04:50:30 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 44C146016F;
	Thu, 15 Jan 2026 17:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C287C19423;
	Thu, 15 Jan 2026 17:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499428;
	bh=5qGrvcoNEaqzKsbFBudRQKuxZ92uiJhY9hmL8JYVNwo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rR6P5MqpIlAhNzf8XuUwzeR0k2ADAPvlltnRtEUjrMxi0Zo6/8Dt3CKUWLqfaVqvV
	 maTTucLjmIvOZJyMtOcHtPzt6gfk4sFH0sIVdzS4AOjzTwdHuJW2+NNgGCEeGGbUIP
	 xc7iAujPGz5+g2OVzeGgRMIgHvoijHlHKpfBOdlpOLRHePm+BIhlb8/Vo8w3rmKm1t
	 vk8WW1Fc3rJyG1JzmOsyAJU1y/vEW7lVmeFFbX+4Wv68qN8/jR85ltMp9LCmeh8+ki
	 /R6lpmzQU6cIvNz1eR/VUPClQqtbJUSUkqmxN7SiK1wm91O0nOO0CL3G5RkpSnrTo6
	 Xb+1xdin+Tpmw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:53 -0500
Subject: [PATCH 22/29] jfs: add EXPORT_OP_STABLE_HANDLES flag to export
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
Message-Id: <20260115-exportfs-nfsd-v1-22-8e80160e3c0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=757; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=5qGrvcoNEaqzKsbFBudRQKuxZ92uiJhY9hmL8JYVNwo=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShJ6gzq/GdauLk+afGsy7jPLT6yVwaC0xixs
 lrpnTh5X6uJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoSQAKCRAADmhBGVaC
 FRUSD/9ByBjb9qL7WUXU7eQFvtHwFTejj7UPRv9G2yA/sCWJnOY4XI4+DT5LXXjPDJ5WfzDmY0h
 1631R1kksFTmTI4TTr1rMQ3DsyUNANdSFEjmbnoMKjUUf0Gb26G0Zhtehcvah6MyRo4hnuEgO3N
 j9fY2jmqmR+Q0SjY+g/ZSFgJieIZJ1bPG5kGaGg9nys+m/JtMDhKFOib64DAQfBEcdBBtMlYe8L
 asyygrgU0nQ7FjX8gT+iV5Q7p8xHDDDQyIQgzC//m6aacF4d5KuNYKHrTyaMSIo4RugSJslAQV6
 +FMpHhadZQqkN7GDghRXcc0YTmgv5dCyjpWHgS/39eN+IVT9aes5hoc/QI+zkvskn/epPcE+tp7
 lbmZFB7ApvXUyeAEy+EogpQ2GX4AVZ4Q7zRb+uU84rdoX6xNMPAOGQ3UfhGJjImDrAXZaskyOTD
 dg/X43DE4ERo6Co6EL65AGek+DaXlZo1bc+y8QfodlH3bQm3dOx+RrveNSGyjrosX/LjBkT1dO1
 HkBNWR+339Wi7nHQTnjmr0x15tUe4rPHVHW41nMi9vwSOprdFNaG/Cx4O6JmaWzkNOVBkTTOGSb
 FnGwyWVBJgq/a+9nZm67mlnZ919xA3ikbxMmTS4jtWnsmR8eQIsuG+eAMLgmGcjgULQ1AJ8OHd5
 KEtt24Sqjm6eBDg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the EXPORT_OP_STABLE_HANDLES flag to jfs export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/jfs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 3cfb86c5a36e8f0c46a2734a24fba6ffd36c7ad9..ac9b6d754f8c203baa7e91362aeb0dc9b3ce209f 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -864,6 +864,7 @@ static const struct export_operations jfs_export_operations = {
 	.fh_to_dentry	= jfs_fh_to_dentry,
 	.fh_to_parent	= jfs_fh_to_parent,
 	.get_parent	= jfs_get_parent,
+	.flags		= EXPORT_OP_STABLE_HANDLES,
 };
 
 static void jfs_init_options(struct fs_context *fc, struct jfs_context *ctx)

-- 
2.52.0


