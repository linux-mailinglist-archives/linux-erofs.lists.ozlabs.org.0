Return-Path: <linux-erofs+bounces-2024-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D9AD3B0D3
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 17:28:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvwrR32gdz3bf3;
	Tue, 20 Jan 2026 03:28:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768840135;
	cv=none; b=i7qjPuZJYxlxmDNIzHojJJ45JPKL9ch3MmbtejgS0QkDdSY9ce9yeFw24h45//wys3gi05rTc1fT9NcDfOulKR5J5J1yaIVj9vUWjcycWIdHiZVYFRvWEYlNpxOyoWUI/3RVV5c9orjK7gZM9pXlCaLBx0k+iqDu+c7Yzj2IrURZirIYkyOxDNNvdoeZkWro5F2JhVDDUyVWd/ruEq9DGkd9rvAUmbA7uIC6wGpIYqOpKJd3nSwS4HdEy6enni1nJG/a2jVII4qE0J8Vob7D9I31Z60khXOgqA77Ff9vDfAqYm/8cHiGezOLK9KCgd/nP3ioF4DSyhlsg0UJdfFA9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768840135; c=relaxed/relaxed;
	bh=7KH9GAMr/eWsf2mOE7iYyuOGJooyfONtnMuRkvbB1nI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DcZEUiYdP0hJb+PndM2RuEDeya7LwdYdZGUNtvDQmcM3lkA8LIZQXo1LaIO8m6tpnPNQX2c98ZArWZNj7Bxr4TQSpoCWwtcHnUfKtcGh7cMzx1ag7rTzGFqpPa5Y1Dtx58vGsXQBKuu1Nh5NtLj8MwMFRJqp6go//gc8Y8cNwfB+24g6hod+rF21PHTFCgjoZFXVqMdJo9amXODDunw+/QgQGCuu50I3lDltcKhl6CIBXL0BTs1pKtc76dXai5Kc83H1XeBDkCuBdZK4ptoYTuo+33bISgrXeFgiwxu4EGJZMUluqb5pqDixYJcR4indR15sHrBG42XeG0htkYPUIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gLSidMGq; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gLSidMGq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvwrQ58pMz2xKh
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jan 2026 03:28:54 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 215E543453;
	Mon, 19 Jan 2026 16:28:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27114C116C6;
	Mon, 19 Jan 2026 16:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840133;
	bh=DOe7Zr+SC0SYYE7gHRN3EzdcslwerK27BkcLvt/YLFc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gLSidMGqIduwhhiZBRl97kiG2r0WSem//2Bu5eDamZwGlTsr9LrpoWaTD9OIQfiWG
	 PIcjpOsrKsKKoBTdH0RVx2h9oNObYSeGccUXe0tJOExLbMz6brRFhHfwX/xW4p00iT
	 0Aapwu+EBjx7X/ebQKY2u7Oc8Xm18MDBtNma1ZzvpgTWbbE40PXPlZWrfrPbUzljXx
	 ti2hbcDLHS2Mtd0BBszkVSvql1u5IKlKWMkfPiUeXlny3aVa3EZJYwuW6qOP2hLnJa
	 Sg5Vh/88liPis+95Wn+gdIj3gOvrNfxxM7In62NU0dbDOMh6+HROaUGGYnEd+tPfR/
	 KjdC6A4vI7Quw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:30 -0500
Subject: [PATCH v2 13/31] udf: add EXPORT_OP_STABLE_HANDLES flag to export
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
Message-Id: <20260119-exportfs-nfsd-v2-13-d93368f903bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=773; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=DOe7Zr+SC0SYYE7gHRN3EzdcslwerK27BkcLvt/YLFc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpbltcB67I3Cfm08JpbcXHGEkrLfaJbcvd3qnwq
 BhDRd4AN+OJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bXAAKCRAADmhBGVaC
 FbS8D/432THFEGWROgX8dP/qCEuSNPHNLeycBv+YXQdISlJtiHD4iuhGoQ+OgERyuJmu3TcYkEQ
 P0eYFomKXV8jqpqGO2/2SDRE8CSame7BrqEo+F6vqJ6h4aVkE6ufeuJybyvumep1nUmlsIk2DsU
 u0fENt3ExKeLea7brus3iT8xHM0CItU8XQS5RVMuiU/SxqPPEs6Gb5NrQ0Nb/yKLHlN0JpOjBD1
 u5kv+v0F3ZlB9nG8fp17BTBsCD/QSUkuv/VXguesgG1a1OdU1QlUIJf1bvZTI1eDySl/V1zJ/ys
 pB7kAyYPYpDzTxPmSOSrYVzGbRdfgIfCzChXnUTHchfvlYDkLqmoNjSVx4VcTmBHGy0wZq+p3Ij
 gw4LUOedWkbXdEWCD1VLGQ2lmsKA6KzmNxKG2DguLX57oTKI9hKSx1QkPTgioRhhpjAffxxzZzK
 YG/0f5pV4d15jKegKxjp7WbBOW2h9cYTfkca9b3NtC/IUE/cP6DzojeN7GJRXhtM/23HU+stsUF
 PYmwauk2mN1n1kuL/EXO+pG81cd36tlZ+q+6noHC81NKX6rfqcujUI2rrAH+gabLD5BcxHCkrQM
 nn8xl4i9spqRbsniTmZPDusVh+1BEp/XL0fHi6MMd2JHyHZaS6gOgg4V3V4ygHuuECMOaIqJVcC
 YlFVQwsgmBIRBJg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the EXPORT_OP_STABLE_HANDLES flag to udf export operations to indicate
that this filesystem can be exported via NFS.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/udf/namei.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 5f2e9a892bffa9579143cedf71d80efa7ad6e9fb..7b8db8331c77bb43d9a3c4528aee535eac2bbd37 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -1012,6 +1012,7 @@ const struct export_operations udf_export_ops = {
 	.fh_to_dentry   = udf_fh_to_dentry,
 	.fh_to_parent   = udf_fh_to_parent,
 	.get_parent     = udf_get_parent,
+	.flags		= EXPORT_OP_STABLE_HANDLES,
 };
 
 const struct inode_operations udf_dir_inode_operations = {

-- 
2.52.0


