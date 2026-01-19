Return-Path: <linux-erofs+bounces-2031-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F8BD3B0E8
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 17:29:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvwsP20Hwz3bf4;
	Tue, 20 Jan 2026 03:29:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768840185;
	cv=none; b=Sw2onyAjKbKmiw0tby5S2+ngjOdUCsO+TzHcNx1Bzldv8v4tqzGm7bsnUHWzsZWD73IwTJCDCoq89pIt4ex5nVMiwOEfW5G8ek1ebVWic4RSE0/ySzN+0Ti5GBt3DkTU8PGDtxh+Gl2hG2rrnDLMIn4vLpQvCsOBWjfdU7tEuThlxY/KTpBb+l0DYoksOa0127U5n6WGD9qzkbKkTePC1u5Lmpbyx2K8vNWxXjAr1loJaYYliePk7gCh7mv9GDlBIAg9zHG+E3ocapO+ADMNsChxsPbcLZO1bgL+XLUY2+odmPsmQLYvNNjqzyDYG6J2BD3osv+Q7z3F7IKU2U9/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768840185; c=relaxed/relaxed;
	bh=mmGy0v4cBQeUCOJSxeLRPx7PKr1iQvHg+Pi6E7hov5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YkMZMO+cpDNbPndxApCwY9FVX2xQCewr7RWB/O85l6Ao9XPdKHSSvjXRx22ChUa1QdVowaROP8TVqZ+PAkLZ/m8+AZnVl9oa0o/m0NjXV8PmptcfS/3HcTDchJJCg+StFbroma4gzDzPz6E+P9bsNcwvX5XEQ89e8ILS/IYsPXRjbjImXdFfSwwNil+3tUjhGKhQWnLH2sJno/onLAT0p06XJpuvxDC0nueU9/cFH/5NKhoIG1/xGzIwhQ0yEaV4/+c1VGoPNek4WKsoQMwXZFNo6O+kGPdRXP25/yJn3bRcHQYNtBWVIcIjldMmn/snUNQu+RpgzfVkpduWB6ZKyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EWpRmCRl; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EWpRmCRl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvwsN47vTz2xKh
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jan 2026 03:29:44 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id EC10D442E2;
	Mon, 19 Jan 2026 16:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED218C2BCB1;
	Mon, 19 Jan 2026 16:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840182;
	bh=0pjRYIsnDRpw9eCc428hMJ+RmLNOXECTiV0TzjyGuWE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EWpRmCRlLqA7JIm8OHKhCrXcT2ln5vA63b0sZyoVI3zCuqdcFLzc4lORDKTmNYPgE
	 68L/MldcRNmq7VjXDoYJoCDFOIAMCsTPNrQQrWwbaRzw8R/DojiRLpEhdab0Mokr2b
	 HCN7YzXCa6Kb2QMc/Fv0AhxCHNWSJd0MtERaTQkcJWqox9B6q7Q4nS2xcysS4axClP
	 Q5SrX8dLhllK86laqesoQ2aGFtn7PE0Wq8rZ7mWf7BWEXrhaUv8U1gHj5gz34zE4Ur
	 LdYxuZHS7V0X5KEMOfWN4bc+BgVBojyIM5X2h33jNR0RIocK7OyyiZWPrJO9p0v1Kt
	 /1xXtEu+1aQmw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:37 -0500
Subject: [PATCH v2 20/31] ntfs3: add EXPORT_OP_STABLE_HANDLES flag to
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
Message-Id: <20260119-exportfs-nfsd-v2-20-d93368f903bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=702; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=0pjRYIsnDRpw9eCc428hMJ+RmLNOXECTiV0TzjyGuWE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpblteUCie9VgtOBk7k8KPcwYUjg+5e3aTiLSyz
 pedHEvEigeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bXgAKCRAADmhBGVaC
 FXDrEADXMOqneHOXazrfXcU6SEaFdPp2jgcDyKlpcouTHeHL7JMG75dMhNd8/tZpaqBBFh8PXPr
 m/R0lXt0HXYZD/WowEUdI9wfb8zMEoSXka6WUnrgA2qLKI2K5EoYLcUDlB2f11F39Cg42pXIv+Q
 GwIpJ81OsYk8AMTKSlmCBneF4heHmiUP3ceLQEd77l8rNMaM97BuExMkt6/FAXyx7QPMM90orOY
 5ru14ROv12v5JtsocjudqdzZhUkNVJq4qQ8BSksvhOzGrEHyktSKKC/4qF54Q/AGTlU2IsSca5G
 YlLwjI6/aLM2HkJ07JS8Tp8XQHW6KktCwDkz5gI8cfWiOqfSZhhBxicjQd20i9XzXSfixWitcGl
 2OuYprkJVsaf3xiPIOluLq1RZBodScZOje3zQS1b2pv6jm4BlgqEyd77HzLudAmpYNo4wwLvEql
 KPtVvl8CASGIRsPK3aDKAi1HNbzKPgSUIA29eRhvzlLbWTBlO7pxqeYgHhJZiwsMJCRnsWm/144
 39yZpmFmTHkZnPTT80fwG3j9E36XUg65OPrPlv/9wGEjgBA8PH/4Uowj0JPGJSQr67iERPo7rr6
 i2wOrIsCiT+ItGJOWG1dfznfv2LMHa0wNrDOimgp9zKPWyOD+8E4Tup3ekZmosQr7//lt8Ry8kl
 38O1cP6Qlg6j2ug==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the EXPORT_OP_STABLE_HANDLES flag to ntfs3 export operations to
indicate that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ntfs3/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 8b0cf0ed4f72cc643b2b42fc491b259cf19fe3b8..df58aeb46206982cc782fad6005a13160806926d 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -889,6 +889,7 @@ static const struct export_operations ntfs_export_ops = {
 	.fh_to_parent = ntfs_fh_to_parent,
 	.get_parent = ntfs3_get_parent,
 	.commit_metadata = ntfs_nfs_commit_metadata,
+	.flags = EXPORT_OP_STABLE_HANDLES,
 };
 
 /*

-- 
2.52.0


