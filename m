Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2190C58C202
	for <lists+linux-erofs@lfdr.de>; Mon,  8 Aug 2022 05:21:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M1M1l14s4z2yn5
	for <lists+linux-erofs@lfdr.de>; Mon,  8 Aug 2022 13:21:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=At0PO7Xg;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=At0PO7Xg;
	dkim-atps=neutral
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M1M1d4cqDz2xHb
	for <linux-erofs@lists.ozlabs.org>; Mon,  8 Aug 2022 13:21:40 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so7938072pjl.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 07 Aug 2022 20:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=xWqU1CUxBzwNlWJmqSaxVGCknLH5wxQf4k70uurvIsY=;
        b=At0PO7Xgmseo7199OhPHIEgwneMtDC19yvAKzj1AVdF1DStiZycJPmD2g16NY6W+td
         QN5ic6spyLOo5IIh9X7hq9dqwNDjWrR6HnV2JcmEijF8nTSduioLlDtLh6qd7cm7H5PS
         2mKtylY4DDxZvu5VhAquzh5y8udFCixH+NCPwf+MPXUg3cbAMW41a2b+lSqdgdQ/wkhK
         imiigS8rhlv5WmfnCq7AyZ4Kyv1D2Q5Q36eDlr5eLaVDas8/tugFUMf/30wiS1fOPxrV
         qVydfTRuIWyf+mPy+MzIyTQOMtysEEBfwxTTqM50eEyo+eqS5ElFiceE95vP54iOFsoq
         avAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=xWqU1CUxBzwNlWJmqSaxVGCknLH5wxQf4k70uurvIsY=;
        b=EkoK3VRjU1adP2sAp1/73NIToY1iki0sds/b9CN2XjjBwlggAlj+ERXyqNLyS0KLxe
         RqXWJyeEEeTIBfC/xZ565LjS0Oh7dq21pDzerF+2EBU8+96qAPPoEqIicC0j7hxUd1W/
         DrdRSR9H/0vMRBSZZslb0wuk2rzH1x8lft17kHU6y490db32PHqYTX+91GLcGTxZH73T
         6DX2eVeIJRF0z5A9OhD4bH8eD0pL9QK5UpGnFETuWHl5jixrvoUmZPB1FZeTieKXr3zt
         abC8NAEGayiTYl7lEfQOliNbuwUntkIdhvCmudrwAXquasNXt40+Zd4V7RXt40tz5vbv
         EY4Q==
X-Gm-Message-State: ACgBeo0bm4LkY20/sZjgw/b0sLD61HPhyFtWsUXv4yxkZdwBRa0+HNB8
	KqIIXZK8vAVl+fdFG33lCwxevciU8Xo=
X-Google-Smtp-Source: AA6agR7CiqR05upG9EUTZfcw/gpi8P5FxFc8K7Uw8u3dAt7BSKzQuA2M3zdFGH0+Dfhkt8dEDUJUgw==
X-Received: by 2002:a17:902:ce84:b0:16f:1d69:ef7f with SMTP id f4-20020a170902ce8400b0016f1d69ef7fmr16246860plg.63.1659928897956;
        Sun, 07 Aug 2022 20:21:37 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id b10-20020aa78eca000000b0052dce4edceesm7278850pfr.169.2022.08.07.20.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 20:21:37 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
X-Google-Original-From: Yue Hu <huyue2@coolpad.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: use the BLK_ROUND_UP directly
Date: Mon,  8 Aug 2022 11:20:49 +0800
Message-Id: <20220808032049.31120-1-huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Just simplify the code.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fsck/main.c    | 6 ++----
 lib/compress.c | 4 ++--
 lib/data.c     | 2 +-
 lib/zmap.c     | 2 +-
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 8ed3fc5..410e756 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -483,10 +483,8 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 	}
 
 	if (fsckcfg.print_comp_ratio) {
-		fsckcfg.logical_blocks +=
-			DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
-		fsckcfg.physical_blocks +=
-			DIV_ROUND_UP(pchunk_len, EROFS_BLKSIZ);
+		fsckcfg.logical_blocks += BLK_ROUND_UP(inode->i_size);
+		fsckcfg.physical_blocks += BLK_ROUND_UP(pchunk_len);
 	}
 out:
 	if (raw)
diff --git a/lib/compress.c b/lib/compress.c
index ee3b856..4bd0958 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -303,7 +303,7 @@ nocompression:
 
 			tailused = ret & (EROFS_BLKSIZ - 1);
 			padding = 0;
-			ctx->compressedblks = DIV_ROUND_UP(ret, EROFS_BLKSIZ);
+			ctx->compressedblks = BLK_ROUND_UP(ret);
 			DBG_BUGON(ctx->compressedblks * EROFS_BLKSIZ >= count);
 
 			/* zero out garbage trailing data for non-0padding */
@@ -584,7 +584,7 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)
 		u8 *out;
 
 		eofs = inode->extent_isize -
-			(4 << (DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ) & 1));
+			(4 << (BLK_ROUND_UP(inode->i_size) & 1));
 		base = round_down(eofs, 8);
 		pos = 16 /* encodebits */ * ((eofs - base) / 4);
 		out = inode->compressmeta + base;
diff --git a/lib/data.c b/lib/data.c
index 6bc554d..ad7b2cb 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -22,7 +22,7 @@ static int erofs_map_blocks_flatmode(struct erofs_inode *inode,
 
 	trace_erofs_map_blocks_flatmode_enter(inode, map, flags);
 
-	nblocks = DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
+	nblocks = BLK_ROUND_UP(inode->i_size);
 	lastblk = nblocks - tailendpacking;
 
 	/* there is no hole in flatmode */
diff --git a/lib/zmap.c b/lib/zmap.c
index 95745c5..abe0d31 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -325,7 +325,7 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	const erofs_off_t ebase = round_up(iloc(vi->nid) + vi->inode_isize +
 					   vi->xattr_isize, 8) +
 		sizeof(struct z_erofs_map_header);
-	const unsigned int totalidx = DIV_ROUND_UP(vi->i_size, EROFS_BLKSIZ);
+	const unsigned int totalidx = BLK_ROUND_UP(vi->i_size);
 	unsigned int compacted_4b_initial, compacted_2b;
 	unsigned int amortizedshift;
 	erofs_off_t pos;
-- 
2.17.1

