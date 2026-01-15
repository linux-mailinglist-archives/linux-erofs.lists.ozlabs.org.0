Return-Path: <linux-erofs+bounces-1902-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 536FCD26C98
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 18:49:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsVqX6Cdlz309y;
	Fri, 16 Jan 2026 04:49:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768499384;
	cv=none; b=K5lyBIupwWcyeRoXSRDBMD9x606Pnv7FsEISPrBxMexwLTaVEt0kinqhJrQzRmuYyKAD5MBG0p0U9b4KEZQu6hYIfobEu+iHIrw5tTZ4f6da+2//hDAv2Mqt7UwKTYSISwUrbsTsVt9fDe9ruf5AYHMBt6So3qzhyTZMvE3fMy0GwJJWGY86UnBtt0C2LElpjBgsZXDAOkVOItQUx7p5prakKUC2I9oR3kkJ6Wuwi5e7XfgRAebJeij4exjoQnP0RocxtVKzERbbSo+tW8ep8fCRBDpPU45n1KvO/piZyWGLSLCiK+bRLQbUy5l5m+A6eenNSaCHJf7dgVPueORyWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768499384; c=relaxed/relaxed;
	bh=62aIKj8tqE3sD4tyHvRw8zo3NxgE33Br/5r/nClLzsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eGptypSh28ftHamW085ahMmyAaljiPhjrcokW657cXk4H1EU+oGIRHu/aWijyI7+EJQf0TLX4K1tVVyGpEx0TIXJ6V4gyfHsclvF3Yp0jDUwhzjplOvRXmIykZsnMkvR5umngnGI8YKHIF8SvPcRDSIlln00rV9TjP0ELUNZX29nXrviO3bRt75QAn+RTwgjjRu7qQamgo/EOth1eB3B2jvjYkuNENTlqB6iL1Jm2jgsD0W23XZ2X0Hpy16lFDy9ZYiwRdiUZRu92/lqjKFY2kqM+6W04hjOjsFN4BwdKkFNQXbTdue9aaJZk3OjBy/YK0LMwMf8Dxu/vTYJr1aMXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HpFXXnu7; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HpFXXnu7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsVqX0RTFz309N
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 04:49:44 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id ED4F9601D3;
	Thu, 15 Jan 2026 17:49:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA99C116D0;
	Thu, 15 Jan 2026 17:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499381;
	bh=3GhJ/qRusFZtrc5r83Yz5fW+XL13TprQK4YWfiaNH7c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HpFXXnu7ERkPUAIQm1ZPAcxGId6eeLxlE0JRxT5UA4b8o91JC6MhQ6hmR8WhJIGya
	 u0ZPgVTfRojyBSEkyDYI3DwAmQo9WILZExRwe2UwHFCiNlmisjZ+6bSd+aE7ib61oJ
	 kNhQchrck1aUUpJ+OwOj/fCqXIwNg0ZxkdeofNkXA7xP2g7DfotgAEoSVqgkuY6SM5
	 Wpz8EZYj9+4Xj3LStuJyRf3j5Keqh7naAgj8vpr+lOmqqV4kroZVB7N0Bl859ATYgI
	 uzM5fmBJ5J7caSvvjP71MlmxnFVv4DuzFN9zwjzsgrw+/9iNkIATGHL5NAfE8fKRC8
	 k5qPRrxpUVgbQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:46 -0500
Subject: [PATCH 15/29] smb/client: add EXPORT_OP_STABLE_HANDLES flag to
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
Message-Id: <20260115-exportfs-nfsd-v1-15-8e80160e3c0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=733; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=3GhJ/qRusFZtrc5r83Yz5fW+XL13TprQK4YWfiaNH7c=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShHXNqSO0AaJtAQ6e0iebWGL9gXuZogZL4NQ
 nd3994d03SJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoRwAKCRAADmhBGVaC
 FcJZD/995y2baNrZV9uOL0TNknTnSY1b+KmL3xbwd6ELV1X5P9GTRow0w8qgNhTp6DEdep17Xnl
 lV5nNz22mRp/8t/3leQwRnNobdVyWDmG+86VPwmUWRp3avVeIoa2Hq0+unljlviLLfMZvqyYy/P
 Kxs6fTJykAgSKjLX6C+rJOV1Mp3siFq7qgMalb81NvBiX9zHp1owHcyMqSQLk6dnRVhBpwvq8Yr
 HCE92A8xDJ3Ip129dtLuJhd2DRJMhmD7P0OezVt522x2tAQ1uGW9+y22/6QjAyty5uFASKCHvSI
 w3UV0CUln2DLh1/ExYGFtAVStJTrIxdzaoVBW95Wv/hqgnHPTA5ZPK9Mb7x6p1hGhTPsJyTJD+D
 ZfwxsjYG9BWi0T9CmUy63xFCzNqUQ2yS/5IVjEWwR90w95fFyvbdRWQqfBLXJR7156JlOwG9lmm
 LvYK/T5yQAN1YkPNeGXb/ojuDS1Qhax9xPuYWlGmJhpq9kmhgnNhCBrmeRxuXoSdsL8s3e0HFVx
 wPMeDrxdnCq4FIgMAjIVmEOYsxOVRowPOzVRxqVmY6La6z0MHQ1RC9VLmEOUHKcW5IQjJLDb2ld
 98lJr3+W1h6zW0rigSWwt4z1k87pChOwiG5A2qRhX7v35TRycTLzvQDQnkxDqIXyxoiRfeYXqGm
 8SLFEajMop9ifew==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the EXPORT_OP_STABLE_HANDLES flag to cifs export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/smb/client/export.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/client/export.c b/fs/smb/client/export.c
index d606e8cbcb7db2b4026675bd9cbc264834687807..c1c23e21bfe610f1b5bf8d0eea64ab49e2c6ee3a 100644
--- a/fs/smb/client/export.c
+++ b/fs/smb/client/export.c
@@ -47,6 +47,7 @@ const struct export_operations cifs_export_ops = {
  * Following export operations are mandatory for NFS export support:
  *	.fh_to_dentry =
  */
+	.flags = EXPORT_OP_STABLE_HANDLES,
 };
 
 #endif /* CONFIG_CIFS_NFSD_EXPORT */

-- 
2.52.0


