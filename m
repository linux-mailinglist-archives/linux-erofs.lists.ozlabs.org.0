Return-Path: <linux-erofs+bounces-1904-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A528D26CB1
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 18:50:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsVqn72JSz309y;
	Fri, 16 Jan 2026 04:49:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768499397;
	cv=none; b=mZiY3h7hQQbeB8nx9gDrG/mqXuN4GdTbsPCeDhIA8IRYVJ0Cgm6+pAImZpioRCEvaEJiO72PyiEYGqYRpbMNqzY7Mmpe9USlnSWkTA0Pq6hRTnQoz3ScVviFSJG65R+qS+HEbR1lpOVEBEDPg044BRe3gkCMPd13IZhm4c7OXummTdwrFMegUzKv7nt9jHn0h5r7sZRWwTIbwUywRYKNBtRrvze5AyCKdwzexZQc5Pn8rHKM/8ZLPOFWThiH4GsfuieBt9bChDzrFoke9+3vCjxcckG4EuZ01UtiluLtW1WCRa5BYl6KEMCaIyO2xrTX7bFFi4ZpiJO14Z1LkazL8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768499397; c=relaxed/relaxed;
	bh=7alxoteVO3R/zH873ahX2WwdsTpmrn80lHOvMEo+NwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a2OTER6I402YzPKp5UFZEiOxg54f9N0FPynoLuz8BmD7f977qM2W+SUo0JqTezUV/bsnGUIpaYbVUZfEfy7iKfOOrnUW3kyeVidjYDs1WT3SCIudQvfyXyQJjVlLO2B1Kk6WxvgmouAqY9+Of/B7y6Ti+pLsnbkg9itfmBlyyIw4d1YxrLI6pfJNomMamWEYYhF0piJRCxRYvaX68OB8PVOfxz1LCZR5xwtO2JCMvGdtp4gZ9Pgx8b0EUf6EEJDrxguq038JuOdhTlHTvoMcQT1xNyPeeP4ef1w4Ucrnz4FrcDCqirM3ZBIXo3CLEms5YeQIrFC1wIsp/mXIFv4QFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PYvNCKEm; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PYvNCKEm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsVqn1N2Wz2yFm
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 04:49:57 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 30DCB60193;
	Thu, 15 Jan 2026 17:49:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BD1C2BC86;
	Thu, 15 Jan 2026 17:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499394;
	bh=uje1SB5ZiQFb1nZ8cBWe/zh7xTuwWFv4kYXj9kW+shY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PYvNCKEmybxkHf/xhYZRJA1JR3gi7hwzBl39gO6WcRa3q4IORVrO7YuHny7TQpgiy
	 zl17QOknyAtYmsTiWLBB8kQX5MvY5wrTFagloc02WkBy4em6uCkvDjKoFHPKgA23OP
	 emXGk9XryVRw6nf06RD9Jk//mYkLce7bxq8Ap9KaZVFkkVfi2UtR1Ay7+9pJigW2aV
	 gCp0wp4jlq5kzP/U0dF9wDDaTjGEPnvHrsy5L6bYYDJnpDGVchHD6uaUI+z8KRqcQP
	 iGrph9vhwR67PUaiR/AGoZY8mbdpeRYHcNNaXtUEfUA6tSTZqAxqkmZ6b2KyUgQrbr
	 crJ/YdcNWu9Cg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:48 -0500
Subject: [PATCH 17/29] orangefs: add EXPORT_OP_STABLE_HANDLES flag to
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
Message-Id: <20260115-exportfs-nfsd-v1-17-8e80160e3c0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=801; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=uje1SB5ZiQFb1nZ8cBWe/zh7xTuwWFv4kYXj9kW+shY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShI7iVykyDXfFrTuLTz0reyANBqvVlG7B0Uu
 1Vj+ckj+QSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoSAAKCRAADmhBGVaC
 FVnED/9f0D1oqBjCgp3CIeAScQlnoGQ8qajHoqRzOI6pjd4BeqJxdTpgcQ9spfu5wEwf8/uW168
 AsidtnL65hfLo5B2jfzmYVtN8khTkYlu7o+v30HMwhrc+TdP8MbPt5uENZxqhYc6IzHalGQ+sA6
 lO6ebPCT7OSx0kc8KCnNrauxgw0r2yW790BGEUUOd5rdNkOWFNANuL6cCsZ0iGnWS5HgN/IIaXn
 pSuaXSn5yI8kTwKbcq+UQl26zHz2XAH+8XaabHQwV1/1tqbprihc0VIjA9ATuJ3el552cA4P6t7
 +mUkygIX/9E/GK/b2xR7rQdMtzwrMXfwYMKX3Dm9EIeRBKaUAkYDju/jIZ1r7fC8zReSpsp55KN
 nm9vynzH9R1cpP/fVn/Mi47dNwrypVVxyaeHqDW6OWQQthOCT5LIHs2LyeLStN7qpqPQElynuXd
 LyF0nnucvGghbceqM1JJps5jcNg+YM6f7tLgSJMUW2tieWOWIL3y7du3CI3YXeeHcFJE4AVp9Zf
 v8PN25mGlu9MyKpPWG4vF1MEDrCXJHoFgL9Pwyd/UTE88RjgfrbrP4dd6dGwiq04F6Z+Hyy4wsO
 CBxXCdkbZP3HFIUX0kWTbzYM0yKyBotEBElD6owLCSVU9rv0PLz3JL1vHgYObjL5Ke/6POBKGIq
 72Kjn84TseU7iGA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the EXPORT_OP_STABLE_HANDLES flag to orangefs export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/orangefs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index b46100a4f5293576549300ae9050430c3f07969b..140f27f750939cf5538eb68501dd60012bd2daec 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -377,6 +377,7 @@ static int orangefs_encode_fh(struct inode *inode,
 static const struct export_operations orangefs_export_ops = {
 	.encode_fh = orangefs_encode_fh,
 	.fh_to_dentry = orangefs_fh_to_dentry,
+	.flags = EXPORT_OP_STABLE_HANDLES,
 };
 
 static int orangefs_unmount(int id, __s32 fs_id, const char *devname)

-- 
2.52.0


