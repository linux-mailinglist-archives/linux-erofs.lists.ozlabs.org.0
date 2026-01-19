Return-Path: <linux-erofs+bounces-2016-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B635D3B0B4
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 17:28:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvwqM1H3Yz3bf3;
	Tue, 20 Jan 2026 03:27:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768840079;
	cv=none; b=XHL1afgWZ1HKy7YqKY/WXvjamKJg+ZjXApawsGoxR2r0cdv9a9Q1/NlkSIygfuuQn356L+GcRJPZ9/sOfJFy9WYBGn1M4JqxYPGRKdYT+qGvs6hO3LSXsXRo8vhuFoYySSC704i6N29BKKqaWDWAg2rGWuDGyu9s5ZAX0vOiIWq9y7nyHPbCca0etLXr2jyXapnOSz4X0bTfZR3sktkwas7QMoEFrTIuvTu+aPd8v5sXrkHdReYsrpUbgVMh3I7yh2Nk30RK1LSgreyQ0Gp0962YZzyGX5zcaTTycKRYDEjydNxL5yNn+WNdNKZl5yZZDdhZIcAtU/wzdjL53R4xjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768840079; c=relaxed/relaxed;
	bh=u0eD/Hla4s8rmMuwNVa4cHjRWxSkSOpPy65dqqDTfHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f/ABn83Bw2noxzLM7cq5f2gJ2cZPa1N84Abf+3H1QkgrNbY6Z4xSW6jTwqDzI3fhurkxAcll2VG4L1pgbwDUu/dJCzVm6YoEgPUvDYUVD5NflshI9X4u6VuICFC3d08ixoml5sdDmLvqGiFmDIBvVI4z8uIXCo4qaofCFXwvuHGtq5nRf6TIttj2r6Tl1tn/xCTrTvQ6x/qQFp+RtluIcX21nFPAU2Nk9weul+eJOCnFMBz3u7fpkeIjokYjrm5LSA5mozumM5CHghykG3RphdUunf2T/cz/ND1t2slTz98d9/Iq/vaBjQdGTTA5OrRGqBRokHLhJvnqbKblRIEfQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JOwo2Tlf; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JOwo2Tlf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvwqL2hF5z2xKh
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jan 2026 03:27:58 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 432DC60135;
	Mon, 19 Jan 2026 16:27:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24386C116C6;
	Mon, 19 Jan 2026 16:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840076;
	bh=NlLYDWzXRW6rnfbCFw7xB95B0dQtUpjhcx2qza1jF5M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JOwo2Tlf1wQVs4rSpB2cvGoIOQu3++5wLoibt1o6KyCZ6NKRs/dwpL3TtvXLTtrMB
	 tcIaKEiJB0U3JEg62ukqgO+wVVLQYHHpZNPMEnMj2cASfeZPDaFPGaRc7/g2tpJcZ0
	 8LEN/zxj39delP6+H9fBw/GfNqeS2kAbT6wazW0CnxR/UsD6zosr4yvOKKXG9kGRu6
	 4h/YQ+A3NcydJEguRgY5PVyIhfCvfttE6K3brApDuPGezWzApDC+TxFB7SnFWAzMSt
	 Kh15fMfIViRm6TDmNYiveV22yjV/aUpG7PhBWedHMlXAGIDOIzaDi9XFZRhQSvf7NA
	 31z/5XUrmsu7A==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:22 -0500
Subject: [PATCH v2 05/31] ext2: add EXPORT_OP_STABLE_HANDLES flag to export
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
Message-Id: <20260119-exportfs-nfsd-v2-5-d93368f903bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=727; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=NlLYDWzXRW6rnfbCFw7xB95B0dQtUpjhcx2qza1jF5M=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpbltabE2Jm7JAwFuoi4xvjHPIjuOTxYjIQNa1G
 qwefu7ew4uJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bWgAKCRAADmhBGVaC
 FUaaEACos0NEKrzptD1SfGjP3BtYKRG+pK3ttXeXq6A9Khy/WctcfkvCNKlgDFmyTKEKtSgK96w
 fzujSdx3zZDxGdKH/+NfIFJWsLGoSjYFRoCEHLoa9JKb507JGYtKM4z049+lfDx/zFh1gT9kCfp
 T7A3LKYI+1JZKk+IEwacJMVGpxciEHIGyd16ecTZ1UXjzMPn23/CbMbugOgyDz+yiq716Rss7/B
 Y0xqLA/b9InbEXlKHeA+TEzc45zeyVJLmqPcVSjw4sVDN2pqtawY3culsHQVOTqQtCI/Ysd/MGt
 Z2oT2COgY9CtFgUnHYwfWuyOGEy2Ct/pKDis48+kr/t2+13V2QZ7eZC39OINqIFttqV2erxtigs
 DxUKY25Ebtr3SLjtdIxPKO9Ae6HtzWe77tux6Yj+uk71h7u4U9wkox2xobuV/erBgRIA8YWhjxx
 nPv8KrXqjz1AugEzDvmceU3KG6j3KaTRuxbDGLbK+0xzj4Rq95qnuvPdcDUCGXLlgdfQEoGBZZn
 BN9cjA9xZ2JHPSRr7Ihx9qp6jKSfdkrObAmq7B1iBkwVpP3nm7htFDPMNp7u9aC04BG9aOdJEuw
 5XYI9GJTUGAorVbchUP0mSCCLwZzDppIbGZZQWY+lr0lTugsXHeG/m5lsFZnn7brwTTaobTfpWU
 AnaMFB6Wxbzrcvg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the EXPORT_OP_STABLE_HANDLES flag to ext2 export operations to indicate
that this filesystem can be exported via NFS.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ext2/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 121e634c792ab625d7a07251e572e5844242fc2a..936675f06806d268ded5a3ba5306575c437ca9ce 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -426,6 +426,7 @@ static const struct export_operations ext2_export_ops = {
 	.fh_to_dentry = ext2_fh_to_dentry,
 	.fh_to_parent = ext2_fh_to_parent,
 	.get_parent = ext2_get_parent,
+	.flags = EXPORT_OP_STABLE_HANDLES,
 };
 
 enum {

-- 
2.52.0


