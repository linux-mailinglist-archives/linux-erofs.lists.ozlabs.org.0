Return-Path: <linux-erofs+bounces-1900-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DF859D26C74
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 18:49:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsVqH3D76z309y;
	Fri, 16 Jan 2026 04:49:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768499371;
	cv=none; b=XfA3BMPX2cEVGLsTEfhTFaUr3y/nzXvErupPi3VEvmI8IYC4YCXlMrDHM8P+hrf+gLE9Ztwb6bi2umwOlD+Y0GaGOPSdKeipyoRbW1RPVtZOdr8sclMC2MMsrYxI9nN3Tl+1977JZwPfl5ll8WX8OuWU2uLnEBC2OY/jrsq5e0HFPHMBnJhsfE3+2TmYKvkXd7sm2u1R/b5nQzTwsfeAZfIDjSO3if8AKXeIhneTCRqemUB/ywVncWqCFluj1XXGjh5J4Kb4dYt+LgoYuYmV3+QivW9XYoaeeJ7ZF2vel/eornIIluGytMZ2MPQvsepcPCTeB7LNhlEj0R1RGMseKg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768499371; c=relaxed/relaxed;
	bh=AYWURcqMUxp9DlYRnvKSwe7IEW9L017mImGJDNWH7a4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gt9E/w2gLDOrtFs2W9VEI/dJcS6y+skswU7jRGJv41tQsfwOJ42qtLE5QOCzNwhkxvpeStrtB8a+QsPw1i1Arm63nkptxxwAaUq3oa//+gfFW06MV4A/OX1yF7wT7l12pMtSt0Dgz5VwRND4a4E3EFvePT1QYlzBQ5/wxe8cWck8wl/L84ijEY7U6vlG9msjWxk3DhyaC4A01qbQ6uQhO3cMIn1x0GMFbHBl0+RXRUbEQeeDksda2pbH1aCIYdmtWdVb5JJh/Hp/0f9iXcOaPDCB5BoiKTMP3RuEijbKcJsKalWrcp7t9mKqLlJWn2NL015oOwgI+NjQQbexw3HKLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WrC6gPMN; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WrC6gPMN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsVqG4rqKz309N
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 04:49:30 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B4680601AF;
	Thu, 15 Jan 2026 17:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C14C19425;
	Thu, 15 Jan 2026 17:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499368;
	bh=eujLaXiTUgNyjxHmQdWX3y0IvgSLWTxRgF6WqDofLiM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WrC6gPMNbrPphwr9B2OdMVMQWD3w6Mv/nOHw1pbDBE9bxWiXfLBlumR/OK5kPYvhN
	 apkCGc+VCRQbuTwUzoMWQokSRmciqLfDU1cKQaB0vDgFmguXC/lEKFQuA1jBtQO1aF
	 nY3Vqv/eIQMRVKyVDelnHsTtCA/b3gjlScr6ZDHjRk3uLay+tzhSV4lLC/9YEnS5PX
	 mOoXSwKkjcNHnMBAWgQ1xuVpR4uWZcftB/FcM9PxN63hPvsYuMkuUDkxoOxaS/5EE3
	 hJFC4jBF3M1DIGPw7w+cQqHCLPWAeseUgepLBm2x4n/2+78QiklR79Cs3+JFj4Ixb/
	 cC6zieYF97tJw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:44 -0500
Subject: [PATCH 13/29] affs: add EXPORT_OP_STABLE_HANDLES flag to export
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
Message-Id: <20260115-exportfs-nfsd-v1-13-8e80160e3c0c@kernel.org>
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
 h=from:subject:message-id; bh=eujLaXiTUgNyjxHmQdWX3y0IvgSLWTxRgF6WqDofLiM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShHf9xsknLmtYtQUrLBjji8uf4+uPYffbqfL
 wgOw9E+mmaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoRwAKCRAADmhBGVaC
 FXbXEAC0895+UA8PrkFaOQufVJ/wApB6ITexKHprwSNunNO41jBbrtLkZkJ2sv0koCiZt90R2ZK
 lDcmy1jDGxHDAoeS+2s/+Dj1hyXFroy/xyIvQgDKnouziNx5qID1fnGi5BUM0th5keSDytGUuc2
 t1IfxlsMKP9kq9+tOQHdzMwlju0cH3P5LVsal1qPuxp3wefns1spTXKz8PNsXlSQjqHkFE1i5mM
 rbyG6PTv08LCt/VcusU6PoZ3u1stNRIt6uKT0vzEnO50P+Yj0sHQxEnoX+Bod6emLLeH2eTMEHN
 wuEd/bsRVBogUBGLgr68r57KJxfT93SdeBFK+gHvb1jPbAAhh5cGNAJPqzpumHEbLkKMuLd/Ye0
 nIgKzkZs4U2z5jqviDwSJ6c4wEkvItIzYPZ3PwvGABupEupo5QluuZyftB0AZM0afQWDn08238O
 qbPIrfeH6fKrGYEVVXUuvVJyBDK4LdBJj9OV9OHOHpv8K2WsopPfKfiZgTXTBmXOnJ1302CZH2Y
 eX4T3kDcoEe46PYP5+BtNXT4lpKazM99sT7Qh7ingPdHcFB0kcUp2MYsavYRSaGoYKFQ3mjlIWT
 qXve3+HMCZ60tdt8a0IIZCFnqRO1vasQ9qrLpmhyye3NkmxHM05dXIQjSEO5amwJr/l7RLg/KZt
 t/2RgC4+1Mljlkg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the EXPORT_OP_STABLE_HANDLES flag to affs export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/affs/namei.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/affs/namei.c b/fs/affs/namei.c
index f883be50db122d3b09f0ae4d24618bd49b55186b..edea4d868b5131fa69912655879231912ceff168 100644
--- a/fs/affs/namei.c
+++ b/fs/affs/namei.c
@@ -569,6 +569,7 @@ const struct export_operations affs_export_ops = {
 	.fh_to_dentry = affs_fh_to_dentry,
 	.fh_to_parent = affs_fh_to_parent,
 	.get_parent = affs_get_parent,
+	.flags = EXPORT_OP_STABLE_HANDLES,
 };
 
 const struct dentry_operations affs_dentry_operations = {

-- 
2.52.0


