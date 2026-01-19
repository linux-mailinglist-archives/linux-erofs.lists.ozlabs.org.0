Return-Path: <linux-erofs+bounces-2028-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B31D3B0DF
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 17:29:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvws04pwsz3bfG;
	Tue, 20 Jan 2026 03:29:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768840164;
	cv=none; b=KmwD99z5m9L1WgrKAKb+DHkhnUr1/22VMS/azpCiawEfsRsmCbDn+28dLywOVdnLrXdOacvMtWrfri8yDfkLX0qLzp5TK2NVkRu38TUujm93hcwYaH5DwKKhr0EbKfNjvuzERTT3KhWts2IsGKedtxcW/i9W6kkbzA3pIILjUiNcBMAvE7zr7RSO6vKd1Xb2Ck8XxVASm4wsxDeRYyT5/R/MJnNoy/y4Kbh07Nmz9GuBSeaI0H7DYqx9T6J63Ikdo16p6GMvJeo5O6vZEyPBNnvHpHm6YILAlXG/kSrb1vbWRFXiHyDQPobEZJhgbsCWclN/9Ko0+lMVfPXM+dBs5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768840164; c=relaxed/relaxed;
	bh=dtHwIbxkzeWlILopqDXGMY9lSWkvAf9n+BQlvlf3Gu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hLYQvlQaPFLovCfAi8wZXwkQ5mVdgdO1BjuHu8IIZua6mZgpkW4MRsXhnqc2gKqjcUkI8oQSWHGHOJ7Ska3o/ILhEB7yxqL/FPQpDbHPa7kB2hxHUKRAiXLzMrqanQtVUNOix0FsbpwJt6R0TLyyfnyrj9jozh+ERTIgmU4dotNmmGici9gVdbqLanZ9ZTlNxo666vUpXYRW6g9HewRsUhWvDL6Unkr4OvZ/qj3iR6DQjZXdMmHz8O8yKPs/AJPNe4+yu9yxcThu2G8b9w2hMVfOttfYcSyHwMmTcqX196Or5EVkzfb5+aUzIZxMH0YBxfIZMvX+oGAdqASuVC7AaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Onl1ff2y; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Onl1ff2y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvwrz5zlGz2xKh
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jan 2026 03:29:23 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B9EFC60169;
	Mon, 19 Jan 2026 16:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97545C19423;
	Mon, 19 Jan 2026 16:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840161;
	bh=xYt2MSPBN08jqB6aoLGRn9g7bVaaZnkp3x/mAo4D07M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Onl1ff2yL2rsRhbon2DKTICt3E0fC7f5rf9eTx08Plj/priMZPiOxyC95fr9OlZ1Q
	 Tj3bc6+F6jeoOP9lW9Omi57BHdrw9hIQi8iW1rYY2TZujDNAKYQmNHfnJF7TQR4jDL
	 XT2TgTAX8bojPDQ4CH/gyDuKnodpDRa7LoecaI7ZGol1EqqN38/2r2PumyMB6E/3IB
	 gMmbVJ5th0wfE7wFSrWJe7lDVaMZmMsDz/ijztbFWZezeG1mnnhpSefOWhWvGutvnJ
	 8P36f5TeigIVo4DvniWSBYfSlTL5nDQeA0+/f1ooF6OXQ+oRCHpAUeCOKIQg6DXWla
	 m3kUCp2qEriXA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:34 -0500
Subject: [PATCH v2 17/31] ovl: add EXPORT_OP_STABLE_HANDLES flag to export
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
Message-Id: <20260119-exportfs-nfsd-v2-17-d93368f903bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=779; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=xYt2MSPBN08jqB6aoLGRn9g7bVaaZnkp3x/mAo4D07M=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpbltdbZC4i859npPwVQCiLrrovPH3Ntgd1inG/
 8UBjD2xxyKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bXQAKCRAADmhBGVaC
 FYjDD/9hgSSTbDWpgx790fD9kUBlypy6yfUjVl/Cwssq2z749eDvf2KH5eMyxgd/6rOZkPqu2+2
 gbdvVNbDvUNY8fz7NspCjYiEDexBIC5tfRA9T62LVeoswQLxGM29wl2ixgPWMPBftcv7lAnPkjT
 S/jzjLHFQyKYcXtCf9pni1rK0jCr3OyBHk3e1lVuA6LafCIrvu6F9+tcmuWu49cVETld5ujnAfQ
 csp0C5d/6qNeeBHIcn/WZrpHMRm9O0eNuS5umBPhLGYss0OC/KOBEcRdZvSuR2kP/ArcVAuAFwJ
 2N5Otod+F4FKciuxVxlhVxmTUtY6RnEThZ3KAP9eUK7KirA4BUgoX4CEFxcARIfClDzwmm53bIW
 EdRuC2b1qkPYYuAWU5Xuu1N3uE8cGu8ytttjPbvB9nR/BBaATi2uwYx179nwZfoBchKvdZ5fGGu
 WC4LLqz6rN2YcqXs4zBkOZJwWzlmTxbob7Ao6GLHKN71Pc7fAWGuHtPXhlCz3lHkPw+aL3hZi/O
 fFRjI7ZBPIzSqYhm8g3W29oI5wMFvKvJjZ/3C16X/0UB/OpbmSgTYhYdc324ukf4fmF8BbqJsyL
 L0Sm7ILgw6KpAnenWxla09O1q8wWMSxHIge9mCAibjD2XvZiStJTbi1YtH8cmAIMhaZwCbrFLwN
 VOQon6cUTc3pFfQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the EXPORT_OP_STABLE_HANDLES flag to overlayfs export operations to
indicate that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/overlayfs/export.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index 83f80fdb156749e65a4ea0ab708cbff338dacdad..18c6aee9dd23bb450dadbe8eef9360ea268241ff 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -865,6 +865,7 @@ const struct export_operations ovl_export_operations = {
 	.fh_to_parent	= ovl_fh_to_parent,
 	.get_name	= ovl_get_name,
 	.get_parent	= ovl_get_parent,
+	.flags		= EXPORT_OP_STABLE_HANDLES,
 };
 
 /* encode_fh() encodes non-decodable file handles with nfs_export=off */

-- 
2.52.0


