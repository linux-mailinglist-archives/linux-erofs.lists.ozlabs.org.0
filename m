Return-Path: <linux-erofs+bounces-1916-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE33D26D7F
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 18:51:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsVsJ66B6z309y;
	Fri, 16 Jan 2026 04:51:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768499476;
	cv=none; b=US0TjG9rCEJuhm0nP642VAloI7IhWG9dMuuNDw6qtlmZgtUMIwDYMIPCMklZzQN+LuWhpo8z1EqilQY3RvZH/ks7XyDBqTcBSf/Vguqrl4IcWk2KofowbHkh2IWkWdo8LPGfK4dNpu/j0b9YGrLMEZXRjuYKs7QHDCK+BhKhVth95unKQxaiYznoTkJIeqbmQr9R6+nJ5gMOIl6tavQwAOKBRqpoKO476Wa51yO16GEtvOG54GCTvEs+XB75jtlHgpRGRmfpX7X3bASkwyWn7gFW+FkaR/pTsxRPIbFLQcrikW46k4s1wuuCHyCNlTZ8Nze7o8zpdQXcxCEJO0ARsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768499476; c=relaxed/relaxed;
	bh=xNSjgsgRtyIw/iC+tCBD49WoY/riJf+CPAjf9Te8tA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SMDXrPG9N9yVDfOELR6lSfo7034lLXcE3vCE2U1m0Z48Wf/02inh6c/fcWhWAn/0n9SYqiWbOpQTHu6PrUoksvGMEKTV/EkQa1iYLYIHiG5WgIwEF19mFGu2D8Df2GimyoXnRGcdeGO1siSlVFVp/Jut/oHcioVF+PUnH+NapilFTMP4t4B7rAt+w/BgB+e42yh1yS3kHxmh47e1zn18qP5pE6yqDQy0qC2OHgcw03R8SezHRvMNZcaQfna+zKfRx68m5SY7nGJLUQfbR3IgkJW3p9QlYfMaPAqat2s50aZox/DPTqaLYOvjBhTHLs6psbzl0WTZBXuMzamnzL8YWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=g7YSb1/T; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=g7YSb1/T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsVsJ0v7Mz30M0
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 04:51:16 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7DD7B43830;
	Thu, 15 Jan 2026 17:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28E0C2BC87;
	Thu, 15 Jan 2026 17:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499474;
	bh=3Lesog+saJIE7fVwXxIqzocDbbL7seXSBVcQWCAEylo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g7YSb1/TODzXkcIP6p9/wwYu2DGdEGs5A1xNbEaa6YXpXHCkZo75dKOhpzbEnke70
	 tFl/wi+2L9R7juokN9RrAO2hzFkzOo1UolYG7PTrgtqycoumg6wuMYanMSAiGEcL5+
	 rrebzmnse1W5h+gJbvvkGvabjn0w4tpVTl+YkKEq2+zyxzqIIVNGyGxTNWXPGgnVDI
	 yas38IdE9VvF4iPsPwJa+4aGhd++bDzX+ryoJ+6LAed16KiFtr8ZpWA0uQW4o4J8uj
	 O85No7vo/UQXZUte7vVLWFrrfWkgy2ib31R9cgJpIQxJgqj9Q4vVS5rQZcE6nkgtGB
	 bWbKRQtHDsekw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:48:00 -0500
Subject: [PATCH 29/29] nfsd: only allow filesystems that set
 EXPORT_OP_STABLE_HANDLES
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
Message-Id: <20260115-exportfs-nfsd-v1-29-8e80160e3c0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=933; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=3Lesog+saJIE7fVwXxIqzocDbbL7seXSBVcQWCAEylo=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShL1IWuANGZmRgu17fA6ieKmPdFRTw+kdOfE
 T/UW6Eb7tSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoSwAKCRAADmhBGVaC
 FVMKD/48eycQzLl5j5B6HkE8L1FfwXraMaTibRGf1ZUUO1tdf5xaliTxEmmTz245juQt2kJL6vV
 t3v0tmVInLOvhNl5Gml0VNKIfoY4DHYYDMqab3/BhWW52OAXYuFC1OHvNjVSOItR8sbZ+iJfdmP
 cpCABU6fsvW2RanNoGDQLVF2gHpTCVktYbUOx2fTqCClkLlPc7eyiG53QS9imf2Af1jR9/MObU2
 UJC8aPGoFg29JP+VBrJ7+K+uG/qCZ+4Lk8yD3Hb0EdyY0XHb70hMV4VEfQq77MoCSoVGAWAYq+b
 sydLKAPVS0MlM6fWB5A+y37+o3lo+1bVTlGmwslQVeTQiyGkKAYNQNCMygOJQ75i8hJBaJ3Ui0r
 wPpANaw1oBzTALc2orq3uIyZ2m6Kc8WXMOVdDcT86U6pBRMdATdTLzeEaNV+i+eRTrA8gCkrAXq
 JtaYC4ihJzgaSo8BPtxAJdlyFFkmEA8kw/Eg1fhJwl9r88x60VPSbw53L7sBrhYiykB4xsS0Yn0
 hW4FHIe8yJXugnlD+0XpRgz9ejnjAuydomhlSsmB109/2pn9NyuzvVEW6QO6oIhAsH8y+nYAm2O
 zDhKSTd453A4Zb1cz+XkXonK4dyl1yN7vyzDar6cQ/2BJVoC+1C7e3OSHy/2knx1Qt3EFlycS5s
 GPaWvnhRUrWOAkg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Some filesystems have grown export operations in order to provide
filehandles for local usage. Some of these filesystems are unsuitable
for use with nfsd, since their filehandles are not persistent across
reboots.

In __fh_verify, check whether EXPORT_OP_STABLE_HANDLES is set
and return nfserr_stale if it isn't.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfsfh.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index ed85dd43da18e6d4c4667ff14dc035f2eacff1d6..da9d5fb2e6613c2707195da2e8678b3fcb3d444d 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -334,6 +334,10 @@ __fh_verify(struct svc_rqst *rqstp,
 	dentry = fhp->fh_dentry;
 	exp = fhp->fh_export;
 
+	error = nfserr_stale;
+	if (!(dentry->d_sb->s_export_op->flags & EXPORT_OP_STABLE_HANDLES))
+		goto out;
+
 	trace_nfsd_fh_verify(rqstp, fhp, type, access);
 
 	/*

-- 
2.52.0


