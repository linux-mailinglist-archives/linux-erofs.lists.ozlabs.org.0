Return-Path: <linux-erofs+bounces-2035-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8450DD3B0F5
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 17:30:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvwsz0lhJz3bfY;
	Tue, 20 Jan 2026 03:30:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768840215;
	cv=none; b=WVJm2ysLLwYKBi+ALQIOgPHAjsjFHAZPGC5jL0gQsfvNrSFTbDzIbfbnFRxnN4/e0L/9+31o7iWIjKE1cTW+/eYVJSctBzaTZiGtAI7lufeCsPsKgu4MPMKez81Kp8pJSHp3derBNQarh4SRiKvA2hy+NWYWud1D2MQOeTjYDtcBUH7g2AYyCB6RaTtHOV2k5GsV/MD7Y5tcfaf9W55usDa61QivTS68JImvrIFmi+RmRVZ38e+4G2d/GkcNOL24sjsx3tkfal5vLXaH9M09K/psggzIqaoIEParwzHEAQX5seVTC3U8JWMKzdhoIYlMx0DCH8yIjreaDpBDUqxoGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768840215; c=relaxed/relaxed;
	bh=VHIKlgaWBu+aT3gm/Wqmp51Q8f9pgnyETXcCHEv7n28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XsPMNLFGhsnHDgOyIp69qh0szKpDtv+SVeIC4AihyIvXoeeCJF9BZ0mVn7zBS2aLk9e+gFxjenPX1lmf9sPCrFgbozZDR9+kIn5Q28mq3aUThsbQefVbbJMCZU7kRx1Y0uBT8FvH3TnfovPmD6I5Ga+yurFhwA8pg3WiJY+dwS4n1BK6GwaPjCTZRGfPiPA43XH72+OJ/8FPyPDwKoP8gR8dNKWpBou7pZYMbMV6HxSvU6CaHbutASm+kGfPyLml/DGgVZKFa1pGaU9I+TX7Fxw58/ySVXDKg/oofc84G3G0iajORkvG44KK20XYl9XLXGnPRxBvUD/NkSQ6DRVmlw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=a81wX7CH; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=a81wX7CH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvwsy2kyJz2xKh
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jan 2026 03:30:14 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AFAA641759;
	Mon, 19 Jan 2026 16:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A639EC116C6;
	Mon, 19 Jan 2026 16:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840212;
	bh=n6o2QP6G+vRALjzLSnRDRDjCb5K6Xo6hC7kQYuLTnag=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a81wX7CHFaMcWABGqmtr3bCnnlSH2+QJW6sj7Z5s+YHeHljRLrpmkrFPCRjArvVgi
	 /XaWZDcbtZpLtK/pb0aJ9GWE2dfijyEGdXqoSe4kJcGmsC3eNBKhUb35dBWA4dCtEc
	 77ftcJ2FU6Tb+BFuvMrPAHF5ksnWZxqJCeiOxur4Fk+wsxTxtj6qRIBFJvKmFmm5Ow
	 UEr/+uPLfVxiPt8W0cv/zj+rZQ7Uig3djb9n8GUKAJXwvu3yF1ovzkjetfwCRoq9cN
	 RyeS0NSJuTN3iyYs8sWrdDC32QcczPIYJiZcC7xFlpSM9IZl63faxJ+zmMU+ot8Oee
	 cu+IW2ZApdGdg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:41 -0500
Subject: [PATCH v2 24/31] jffs2: add EXPORT_OP_STABLE_HANDLES flag to
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
Message-Id: <20260119-exportfs-nfsd-v2-24-d93368f903bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=742; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=n6o2QP6G+vRALjzLSnRDRDjCb5K6Xo6hC7kQYuLTnag=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpbltfI0USivroSaPnKybgkczOShKdRT9HZraZF
 OxjWyUMDF2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bXwAKCRAADmhBGVaC
 Fdz3EACbzDFYvTKaT6J+G9ta/KSD1FSJsg97pPf4Pr3Ovq777BAZcpKmF2NX/mQBaUKyOfBzk6O
 YM2Mx7K1IT8iRZuJywzH/PH8fL6L8dR790PYOZDjz0wl8jnfobiJ50BB7eJo9iVgrOjb3Xz4Gqf
 NvgQamJe9o8ouJuUZpBhkwICfWgKMap5x92NL/4cf2tQn4YgWtqeHIHbIQ0NaSoWZ11w994n84B
 iCVAfMocfV7h0qZ59VS7Fc/HdaFQLwFSmKvlz2GS0kHbsMKeVZFrzdL0zC0ebJolRow9hnZF+1s
 vJQWpBh4SVhgwNLgc/AZXq3vReL4GvAM8Ha8+MgA8p+nuqL7zN18lFi3vNwJS4yjMwYq0qFafWk
 65zGwA+xIKY1uOIbRdtgwrxH74ptBWZQVD26VlmtB1qrelYciadJWV3+tsAOhKXxWh8yRP9BNEc
 C1b1Xh+XJz+3AM7myF+l/Nohzwy8tkkJCU8Ku2yAFJcUpHeBwAjEub93HM99JQ7xWgM8YLSNPx4
 QcXXD2LE5fN5WBuLbdlC0LRYHgeFmq6zUeFGmZZVkbD/CLbtdblGJ7E8YRrOZBXDE46lPOywZ9O
 5MT8vhgYocG2wgiTbTHDrtM+8LubBwz81EAvtnTITbIWXmDSYYmocdD/0l3AaXEplO1s2iJkWR0
 F/Tqn/AjaU/GRUQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the EXPORT_OP_STABLE_HANDLES flag to jffs2 export operations to
indicate that this filesystem can be exported via NFS.

Acked-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/jffs2/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 4545f885c41efa1d925afc1d643576d859c42921..80ff5a0130603f94c9bce452c976753c85314c3a 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -155,6 +155,7 @@ static const struct export_operations jffs2_export_ops = {
 	.get_parent = jffs2_get_parent,
 	.fh_to_dentry = jffs2_fh_to_dentry,
 	.fh_to_parent = jffs2_fh_to_parent,
+	.flags = EXPORT_OP_STABLE_HANDLES,
 };
 
 /*

-- 
2.52.0


