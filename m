Return-Path: <linux-erofs+bounces-1890-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E7582D26BDB
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 18:48:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsVp03Ybjz30BR;
	Fri, 16 Jan 2026 04:48:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768499304;
	cv=none; b=fp6K2u8ImwlEj26z4iWsTIINBPcac00mll2CYFdrBPvFfPm6LPFfCjwCzid0e5w2VsLusSEl/OotmfU41jN9LBiOJ4BmFXDCWmD/BS6UOsVAjKKVPsnY6O50TLqa22eEv37LnAByM3W34tDnA8Wa5rGCIjbcDkTCpFlVfhR0McYtmYv0kEQFLj/c5dcoDiXawBlNiPL5Nrrln8ryd5TP+q7D/Wv4odGz7u3wPpZEI6g/xx8oZxEWcNOeOSVvb9USDZAwiFqy1NJw/BOMaFGtL/1vcsS19Zd2NRTI2MYQRUcK8R4hp+rDitbXXshgjJXVHFirZNOA8zcDzuDt2WZ5cw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768499304; c=relaxed/relaxed;
	bh=zt0OOY8HyG5hoN0E0x8SeNq+jwTJvLea9QHt4A47vpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EZh/AWd5wPHEM0lLU1Id7fkwJCH+6t/0sFIQbQNVchepHO0QEK17+4GXIIrOBG1Voygl/wkiL0C7nLiwSXDkHaxpg4wCfbkk65xn52m7/5NaZ/iAGVHJLTYRELUxvXY+x9pH4CCrpw+0Emlp5EASEpvZAzxgpy5gTgQ8hVEmFyEed1gunI9v3lsgTJZBRlJjI6x6D8AeaY7fRg5hIkHB8aVrJ500ebDAgDY8vNdGI9c89XgfXjounF/inhmNKSgPz7rlH5bI6W8mLqAoc+3c3OaGSBIRC31ow75ub6HJguxKV52qpj7TExehvrB9ozAv7H/RlXgvvgUWQyxs//mLBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fu31I0C1; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fu31I0C1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsVnz5dP9z2xNg
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 04:48:23 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2DFF143C8A;
	Thu, 15 Jan 2026 17:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F22C2BCB2;
	Thu, 15 Jan 2026 17:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499302;
	bh=cRlpRhg6xvxKE1542vTz8cBp9dDE4OGqd+9j2b595OM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fu31I0C1mcdk48lMcGV6EtvSTJtTvS7viT/oyZx3ky95KhA1IgSibc8Tcjmzk5uog
	 JhOfSN0w8eh5Z08O9hxA03062iTTRyFy4/ENNq/6sLAeHiEPsDHmsbAIgQEI0IjWpV
	 T/St+kEHBMhdyyRL/SqavuasePDHiTIF3g2iGd/j+IqyY/GUdWdAZidh6pKv4L+QqD
	 OMgBs/gdxX2ELQ7SDfAgshPh0CFXbDJQc4/Tduuex3ApWZoagP4zA/NahKjB8yVq/x
	 z2ul5X5032MbJsxbTe9zc46WwFLwjcxopwaev5EqdvJLAaXHPOxDwVojVBE/xr7G9f
	 0k+rR/8yf65yA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:34 -0500
Subject: [PATCH 03/29] ext4: add EXPORT_OP_STABLE_HANDLES flag to export
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
Message-Id: <20260115-exportfs-nfsd-v1-3-8e80160e3c0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=701; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=cRlpRhg6xvxKE1542vTz8cBp9dDE4OGqd+9j2b595OM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShEgnrZ5MvNZeLKEb4VrTRZtcLcYgm2Rrva6
 3/6K7cxfryJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoRAAKCRAADmhBGVaC
 FVmlD/9gn1qIb6YReb8Ce9KEi8lP9mKlXfsYUelY1yljVioBDtrsj6dPS9mWtSjm8Uo0e8RBQUw
 3u+AYBYfiZztHHSK5RCTNlUjYWpIOmHSfhaFA+4R6tA1I1k+wi7KMOlFd56rQZv6qHSt1ux4hQV
 fOQZ4dgdIp+5Y02KZSKXCJO8T49s7NnWaTpmoqrRPKxAITVwK8tY4j+dYksoEjkWEYlmEseo48A
 hdWLdh0SSUK/KUBfEg7RBnvNnLiGIhzgdB4vbIZuQnGL7grlU1sE3BKU17GNyLtiCggOZi+ZybD
 Fw9/2DcXJRON+wjA49hKtjHtEfKG1Y8qAaH3idaqGpnoC8r+m4b79j8mE0sXsSd27plq8MRIOuF
 pMlERSHj1ExH6xOwzd6jpuVJkfOxWw/bBUNDlNsX+gw041SuiwHaGaMSyESM09G/84gr2guNJkB
 7aVdZndIARxy14e/XPziyJG0nJ2et7ls7dVfhAkrcFjxtqtS1qBZDCH+O5EojKDDoQkHXF/56fA
 kYYYvjqZCke8Jga71v8k+MdprNGd0kb9Cc+lhK3Jw+k7EbYR3AhygOt0L4FjWbOKZNYmJIxuENm
 J7q3k6kEC1/G0mhmtZHabQpfhJkZJRdW6fzCMS5Q4y3EE9WnfYwtVOrERWZLvlhEohG7qjkztgp
 GZ0EXfbh6QvTyTA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the EXPORT_OP_STABLE_HANDLES flag to ext4 export operations to indicate
that this filesystem can be exported via NFS.

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


