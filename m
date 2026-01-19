Return-Path: <linux-erofs+bounces-2012-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1AFD3B0A6
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 17:27:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvwpp2TfRz30M0;
	Tue, 20 Jan 2026 03:27:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768840050;
	cv=none; b=iRN4fznPkUhSUFeZ/QDlre/UBtbZ6WpHt2Rq+aUwWuC4oaPW6k7gJ4wBJNXOFBGlXtc9XUtC+LoOCgW7+eauYHhlE2pV5tNliY1WUIZ5YaacrPPB6ltxaI0xOWDPPpxwUVbOXsUr3xA+84h4U8s7DSifViWYzAqK6dVf6Ae1ZuOBsp+w38q6W26jl4Em+VQ+NM78THc+EJS6qSKS6RNI10qXRgiDvl8u1WDxEYjomcp+TxyOxEIfXW9iPjH6rEXtGzArVWggtKZ7usYyikugIQIylB4CbmK3vAeQGoVoqFyQjAQSYaFV7ZCMEyShhiedwqs0G4zM17WXW14xvYu56A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768840050; c=relaxed/relaxed;
	bh=OdRHeWuTnv3lLxMUOwBSJHWHutyQwfmJkGw3KK+X/ns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hxl55ZaMwKkgthU+zeG/pmFIriYBv0KEJQa6sr09L/za+AA/2iSUcXmRqoxgx89tsRdsvkNNZ/1ZqxGLVH/zKpz8nVjDYHDgUo4/b8N50KCEHo6KQb4T5AhfPfCx3Uy0EdDaYmDvetco2IuH39Ni4JZfNFrEABw8UxWKnqToiLSTRE9LwNrPG06ta0j3OWsrcj1fGeWSahvrSHOxVB7sJzxZaA/LhllYvRlaXpC/P5Y3s1Pk2S5iUp5oJlXE/cNfpmWN0T7l41LnqwYTY+30uR26PaaXkH8RMfy9uCNPW7tlY34q7kKeozktL4hMNJHRlCOBzrAUeulnM1mxiyCU9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EZByvzF3; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EZByvzF3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvwpn3sdsz2xKh
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jan 2026 03:27:29 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8487F44514;
	Mon, 19 Jan 2026 16:27:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84ED7C19423;
	Mon, 19 Jan 2026 16:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840047;
	bh=kHox+Z6m0SGAxt8eN704T4oKG2yhOc62IdYplYhE+GM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EZByvzF31znoQEmDHc3SC4xaf0M/35g4xjcVwooMk1FV61HXxLESS5MiLKX6tWFeo
	 Hv85bBuLMqHqez3qHBscy+CtxbnArxV4QeHTrTHLdSh1NMKPN6CGz094DCBrAFgM+D
	 AjJf/kL6odSToXoYbC0BwY2wXW9BcS3BGnPOFuFUygBqW+EJJ8lAxaO4a8DC3mSQ8J
	 aALSFez2K6qCZWewncoJbLr2GlmdBWTKm66qurJ4sNUMMc6kZedy35j6ubnv3HJVKy
	 Bvebe3CcZHZIgOiFzpF4s1XQUiXn7842k1apwk6XDZswZtqbHhYTTAxje/WAZfxElR
	 uszu+UWz9bfRg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:18 -0500
Subject: [PATCH v2 01/31] Documentation: document EXPORT_OP_NOLOCKS
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
Message-Id: <20260119-exportfs-nfsd-v2-1-d93368f903bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1145; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=kHox+Z6m0SGAxt8eN704T4oKG2yhOc62IdYplYhE+GM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpbltZnWuxHPCsFVnqSKxTO4m+b3RG7VE55J4gy
 EWLrXp3yVmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bWQAKCRAADmhBGVaC
 FVjvEADKTq3x5BhOtt6Qj64fRRaPHGOm6Bc07y6w5GpnNyCiIQM6aVpcn4F9ORvzukxMQVO/XqV
 Gc7pRAymSYI9s+GWvc1x0IU9sGCQpVsndLJ1eMMzaSgzVz8dIezRd7/k/HS4GGz8KNiZ2jDVfnp
 c7wjN+XdRQXpWC2qRBgezSkBBYO58OTuQjDA0xv+b8CbjqBJCbdapflO/lt7ryNb+3XN8JC5dOQ
 YIhjhVdYU3nTYtg8Wq9oRME1R8VCziBOEPSM7OnYvrhhboCQUKPUNwsEEk7C876Ssr6Xwhzg2+s
 rf7n0oAe2dp7xo79Mjf3XuKcCwQcCR0nZmAb0xVbxOvXhbG+BzkFDnwcv6SPu/LgL+Bz3eELxNT
 IvSpL94cTKsI653HKrBxtZAfiJvm/rxot2mjA7pmc+6jWNOm2djCX+Y0VXRCNe8OqjqjcrEnjQT
 IkV/uSXMwte2MxayRUcDLG1rzsUFA2DoS4bR5w6/iwIQIQWtu9+KsQ1oV9LMsta1GV4E2apvumM
 uiSLYCUypySFenb1mq+t71sXvuaLDoDMml58ewc9RqEz+RxUC/4UtXeB2VmTwzcs77p1HyNq6fH
 inBJXCW40vznVwdr14HUSxVYt3p68U3UNWanqZKW2184K08jTVhLuH2KEneZ9ix1b63/moRMZVz
 RNyBzV2Fd0KgbIQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

This got missed when the flag was added. Document it properly.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/filesystems/nfs/exporting.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/filesystems/nfs/exporting.rst
index de64d2d002a204c5460980c898d4ec41fd43d47a..0583a0516b1e3a3e6a10af95ff88506cf02f7df4 100644
--- a/Documentation/filesystems/nfs/exporting.rst
+++ b/Documentation/filesystems/nfs/exporting.rst
@@ -238,3 +238,9 @@ following flags are defined:
     all of an inode's dirty data on last close. Exports that behave this
     way should set EXPORT_OP_FLUSH_ON_CLOSE so that NFSD knows to skip
     waiting for writeback when closing such files.
+
+  EXPORT_OP_NOLOCKS - Disable file locking on this filesystem. Some
+    filesystems cannot properly support file locking as implemented by
+    nfsd. A case in point is reexport of NFS itself, which can't be done
+    safely without coordinating the grace period handling. Other clustered
+    and networked filesystems can be problematic here as well.

-- 
2.52.0


