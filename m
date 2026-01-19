Return-Path: <linux-erofs+bounces-2025-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A25D3B0D6
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 17:29:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvwrb1HFNz3bZm;
	Tue, 20 Jan 2026 03:29:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768840143;
	cv=none; b=Bzd0x3dGCduRUKW8s/l2qw69TRZmRMU5KszVzzuC8Qkvy2WBBvq6gKr7NchXCinuolEH8L7xcgM7mcImBtKKLbg+95B6ahiucW3nSAwFTnTf+g92DfvVttVdYLRC9L4BgmwBGUb9T/00ZM7MspSxkCzOQvhOWnwVXOf9Ics2k22BvTZDP37IzUm+RyxLohtsS1HkLZJePPrb6IyeOWeKlntn0UnR8q5eKH1VXNVNb2Q33sUem5rGlhShsF4SxtkGZeXyCFLn7oCdIIGY7B0YqyFxkcM564CCBY9mF0yBbXBy3T2/hHtHM8TrJl93NeeEYFiKPPYG8wJAJEazhTcbUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768840143; c=relaxed/relaxed;
	bh=AYWURcqMUxp9DlYRnvKSwe7IEW9L017mImGJDNWH7a4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aAcHOWZPbAh0UnjmS+EF6hJoVhVndW3BQl0R5QAq/Pv55akwK2B67axWU5r7OkPl26qGvd7ob+U7iqCjfcVTOr39VpmGFluhKNEuijMWJEPBPyL1rQpPILdSryW6eGT2FGh46/6keg5x1ormUAo3cWH4iFYRFOC2mgtWlax0GozK+n4UJiZCkMlG4BTvyyB3tliNTnIdWJSo28RzrnWieMSsm96N2kvch3z+e+nJsVq7J4ab3Qf2Cm7LR6dSzunhNtjy+HRQo0/9ELCSEeZe7v68bpweoQ+V0CgCurePaBxgSRhKHQZdZaR2o5IfOMqN8Mt7Y7Thvq7xsIV28r6mow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GbZu6FSO; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GbZu6FSO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvwrZ2VJPz2xKh
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jan 2026 03:29:02 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 65B9660161;
	Mon, 19 Jan 2026 16:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF63C2BC9E;
	Mon, 19 Jan 2026 16:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840140;
	bh=eujLaXiTUgNyjxHmQdWX3y0IvgSLWTxRgF6WqDofLiM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GbZu6FSOp9WcyI754uBOhgiC+hjbrXb3PEhujTocCOkmPvnvAp4bCQ51iP9+gkdW8
	 B4a0JL+gvg9zK2migKuOwwdvrS3+/frWzLC3e9RUxOa57kczpOLuGHvF+9UoQO+7GH
	 CS98+DwnQ29MfmcJDLTXTBDRw9pFlkHHKAeT6cQ2crbJry9uJuena0SneoU3gr+yWI
	 qE9fhRj3q5X1Z+wQYlsf0PHhw7hNi2jqRuQMj9GiIBD4pd0zhhzpuoKfcs8m6hwxUx
	 a16UuQnjs7UT6hSVV5xwRLY1Y7ho2OOQUOkxAhejP7/sILT14iJoJ7t8DA1CNNdnx+
	 U9nZaR2wlvxjQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:31 -0500
Subject: [PATCH v2 14/31] affs: add EXPORT_OP_STABLE_HANDLES flag to export
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
Message-Id: <20260119-exportfs-nfsd-v2-14-d93368f903bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=733; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=eujLaXiTUgNyjxHmQdWX3y0IvgSLWTxRgF6WqDofLiM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpbltcWN14PEo1Nujn8uyUCyf+Ml83lXSAsDawe
 D9CEC+RNLaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bXAAKCRAADmhBGVaC
 FTJtD/9D134+/6m7eqi2XFu1Ldt3x6QxfDXalFHVzNVlyX155Qtn9qZi4UXAEKjVe2ODkcTVGpO
 11UPI11wgMKn6loI94fVibr9SKlYAahySdpRnTFj/gaHvNSE+0XntrP+Wr3YvA8n9z0qPcqDSTA
 UvgajRyM61rTAYFsGEgtMaq0cRaMlLr3lpA09Pj1xLSFMI4kNUW4+WhSca7PAth/rIjGubVUIrg
 o3LTy8kWsW+ssnz/G3HXpjXU0sa8z5kUrFymZvow2N/5DOHQoOOPMz2tYopAhK+wA0WMiHlPYEP
 V7QKF5XNckiHhNp0sVvNHLOWjppYh3i0G7B5YINXh/Gdt4IcBYvJCzqXNcdqzXAxycgZ/J+YMqw
 5NJw7rXYzFjI997ZGd1XI7m6Y6qSX/cpBEHF+RNlLEYs24Bl6WF2B/EHAJdG/41L4XVIYd2XJIb
 00nVd6iFRkEAPdwVvfHBaBhF5wJfx7QlX3ei/4zp/5Lx0u31MQzjOsirPhW0DNwTtPE0y6enzFg
 Oj/GgrylYOHwkrdl3HHAXJpgMynZVpMDPuVtBuMeKYUDE0ZyXgLSPE8/dd0B5zNW77fNX0kNFET
 gLNm9ggSsGI4QKY1GLxYdtW6d0d6wArslnUBsgla+v/Z4YfNSBPrvAKrXiRE3zatrUAolw2mThU
 euoEInqbxcQA6UQ==
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


