Return-Path: <linux-erofs+bounces-2015-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C511AD3B0B2
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 17:27:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvwqC2RWJz3bf2;
	Tue, 20 Jan 2026 03:27:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768840071;
	cv=none; b=dN+yodoVtWXnm7exuI6V5KTpdd4V51Dq4U14cE0lJLEzSq/ot0JClP6I5mljtKn7Sb076ZClFw9WSRx4D+wd1ygucmNY+C8S/2S/+s1u5Dvc8kzo5F7Ob/6cBF+YQcbSut5NV4HvHKXjsgsr/9Z138WqqSBZq23DAQ5rbfnU9ZeiYExuDGZL7yULd6ay8wuSuKauLnTnrxeQk1c/+f9GHKMp0MG3h8HwISwKd20FOAgfWNNHOf8ReGRmfu5U+ookstAWV2V3pO9yT7gM2POYPB6miZH9RW5eRMOEVb8RAlMKqDsY/Utvw+1DNhBKR93kt1DJujwQYFRCqr60crmWvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768840071; c=relaxed/relaxed;
	bh=NdUVfYLWR8cpz4FK1LdEeOsfAM8FP/V1NlpNec3IH6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=deFiRR+h/WxqvQi/G/7uK8TjQQhFtW+DFT2tn7f1mnn7MsQZmCUZJrqKj7I0na9awGh06K5ww3g2iDC9VQVy+XZJtxhEa4cTgQyDfZfSTiEDFXNxei/F/ilf98h+f9q4jRb1+zXTJdcT/r2EKbVD+vFnO5wNnhNlM5l3WhNyv9mWyMcDzyp6kr9/feRnB8eze1BJSTovNtFTc7s76/+06iQmj2OVGPXVfoBoziKgw19kJmdmEivb07kcvNQZs722irpA7txxZvTECorS2ElLhrxPKOJZNOZ7CnNvNdRJ77+KGBCYevZCS6YKg9eXCE22JdwSsIUiXv48hVEknSGovA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eSVUryJi; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eSVUryJi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvwqB4XlTz2xKh
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jan 2026 03:27:50 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 07097429E5;
	Mon, 19 Jan 2026 16:27:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13C1C2BC86;
	Mon, 19 Jan 2026 16:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840068;
	bh=AjWutM65jGFPUYxo72jA+Ij0HC7LS8R/VDQO98k+B+U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eSVUryJiGgJALG2ypJ4Yjr568W28w/8A+eXZrbsI4+hMfQOAzJdZQRV9oe+T3lPi5
	 4mMm87GheTCUUW69mQQVVSKcxiZ4TOh5VdvYEjNSP49v96zd3u2tkg8lkt9b8MPF60
	 AVhGJPZm0T5VDPMCYbVqD1onR6BQ2XhtS7tCp6xAW8IKiFKx/n7v6WobsF/eTJtxjA
	 Nd2qg/+nfdwpq+DqIytb+gszW5PETsTfZ44XEt0Fp/CAMv8hCj9bv2Z1ZnVwuMRGLt
	 B+ukQbLNhB9K9qN6/51qLpBXKria1HuayrhCMAS5caVGwiDxOhazJhCpK9AMP+L1Zt
	 /GayDKKSdC88Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:21 -0500
Subject: [PATCH v2 04/31] ext4: add EXPORT_OP_STABLE_HANDLES flag to export
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
Message-Id: <20260119-exportfs-nfsd-v2-4-d93368f903bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=780; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=AjWutM65jGFPUYxo72jA+Ij0HC7LS8R/VDQO98k+B+U=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpbltaIQXQCdDNYtxGH3/N2irOpG4/iK5HsTT1Z
 4iHLiLUl8KJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bWgAKCRAADmhBGVaC
 FbcrEACGpRl8GOPGkb17ykMrM5G/nRGznE7ZxuOH6ewcr6iKf0fOYadqPEBuyp34Xv2zArXNlNf
 459udNfZ2Blhwbz6pQWEwgTtXq3CYdske/+FYkdg++6FgJPzN7mBg76oRaCGCiL+xi4Q6Z+AaZD
 3K4u+njqrYntZw9j30opGiylxImbwjObkXvc/ZNM6L8pLOmEiGGT+ZEis4o1k97QZs3l8XOCmG6
 k+n+j7uS/3v/pHy3SWNTYBWq7OXzS4vn5YGu8nwBXymjuNdX/CijVLY2oV6Pgib5WS46Qvm6WqI
 OwvgpfxqmTcbN15+7Ypr7ATodGgOgeuroQo2DzlZ0JnZ4CVuSGBm6hkp7jnpGmq2q3Hs5TEREaI
 LA4cuyj0BVpV8rDNZAu1OKN+Vi4Ews3TcD5lIl/ZVyu69jsyh4ksqHFfhWmfkx37TnOivChumlO
 1DDGI4PZloQEDOExjfTtn+1xTF5ZPFgLMR69FJyDpexvcN+5uYEO277e+vMFfH9gDhJysYzFjOy
 jCxWdSNLbBll9mFbb3tbLoSV8e/ikoUzSk+vUn+ePpr6l/kwW9EC7NOdrEwECBcRqxpIjioa/Ea
 At0n0Ja2iF2ptFS/RPVXB5xcfDnEZveIInEcsypAva4ckDFGPFoT8TsrJLLrJsPvagzaaa4HHWK
 KsSCkMjtEOBxyZg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the EXPORT_OP_STABLE_HANDLES flag to ext4 export operations to indicate
that this filesystem can be exported via NFS.

Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ext4/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 87205660c5d026c3a73a64788757c288a03eaa5f..09b4c4bb8e559da087ec957de3115e4f7d450923 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1651,6 +1651,7 @@ static const struct export_operations ext4_export_ops = {
 	.fh_to_parent = ext4_fh_to_parent,
 	.get_parent = ext4_get_parent,
 	.commit_metadata = ext4_nfs_commit_metadata,
+	.flags = EXPORT_OP_STABLE_HANDLES,
 };
 
 enum {

-- 
2.52.0


