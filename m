Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE366559B5
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Dec 2022 10:43:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NfJyp2TLhz3bdl
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Dec 2022 20:43:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=H4U1d9T2;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=H4U1d9T2;
	dkim-atps=neutral
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NfJyj70vrz2yZd
	for <linux-erofs@lists.ozlabs.org>; Sat, 24 Dec 2022 20:43:40 +1100 (AEDT)
Received: by mail-pj1-x102c.google.com with SMTP id v23so6910802pju.3
        for <linux-erofs@lists.ozlabs.org>; Sat, 24 Dec 2022 01:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRZzeiP4MkEYR6xkLstq2qUZnwE3WgqG9Y8tHmT4l+A=;
        b=H4U1d9T2hyiyv5DW3UB0jJMgdwR50C45Mc9+GS4TUu7p7jle5C8Ik8Iyp/jA2/E3m5
         X2zmY+ydGfzoObET1ezSIefdqca8jxdwd7cWqQch18z4qdsXiTnaLa3GK+IrwAm23WuW
         0PE7gfwah+7BSqJ2prSNTxPFMolPfMx8XjJVoouXbk9D4Cxxmkr5c8XmyLqmIT78BPD7
         Iev+1jThTrfaoPwZg2w5/CrdyW+DqW19HwPU4yfhEujcRtIe2nBXq+Mi1A+3EcryO4XP
         c59eI+wjQ+Mpd1Bsm51nrdUvaMMstCPp783gabchY57TIHd8/TWp57sNvARwcpXx1kY3
         gF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRZzeiP4MkEYR6xkLstq2qUZnwE3WgqG9Y8tHmT4l+A=;
        b=ex5KoINWEB5+u5fS4yMPZPeOe3PqK/7gsOSQZDLGVhT4ShgelFETcnyEKMJ6d+BT1p
         /bP5nQOrx8+m9iptrlMxva+ui/d/BS9w/oly0SGALZKCwy/cHAQf1dnwYbop5tipgXwn
         lMBovbeUzx78OCqhSQ3/opDoqxq/oYFIUSZFWO2kGYNqLpYExUiuex0GgkOFJ31oZ690
         FXlgPPAtar3gg4+A2yqWQaWwvTt/TCNCNqfVNi0Ch3gjK+lHJwlkxZk42cwsVuIUqC3V
         kU8hrXr75m1SicvkdVGaUL4gP/yoQtGH4V1m7qntZB/6rDpYs5AmRqidg1BlHHyBswAB
         9Yvw==
X-Gm-Message-State: AFqh2kq6YA2KiHMVJiQbc2NbQov9G/vDDPqkLezI18JOAcub4bd2lY3j
	pxmTJfiTzUT1Aa/3w8L04yXe96uyRBtNtw==
X-Google-Smtp-Source: AMrXdXvGcg6wIClX5MJgi6XdnH/cWEzYGnEH7OkYBs1BleY6PeD1nIW4QpAA1XFihDu3Jk3B6AjlXg==
X-Received: by 2002:a17:902:e809:b0:189:890c:4f6f with SMTP id u9-20020a170902e80900b00189890c4f6fmr1082245plg.64.1671875017714;
        Sat, 24 Dec 2022 01:43:37 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id g15-20020a170902868f00b0018b61ecf36fsm3631570plo.287.2022.12.24.01.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Dec 2022 01:43:37 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH] erofs-utils: fsck: support fragments
Date: Sat, 24 Dec 2022 17:43:19 +0800
Message-Id: <20221224094319.10317-1-zbestahu@gmail.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

Add compressed fragments support for fsck.erofs.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fsck/main.c | 41 +++++++++++++++++++++++++++++++++++++++--
 lib/zmap.c  |  1 +
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 2a9c501..9babc61 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -421,6 +421,31 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 		if (!(map.m_flags & EROFS_MAP_MAPPED) || !fsckcfg.check_decomp)
 			continue;
 
+		if (map.m_flags & EROFS_MAP_FRAGMENT) {
+			struct erofs_inode packed_inode = {
+				.nid = sbi.packed_nid,
+			};
+
+			ret = erofs_read_inode_from_disk(&packed_inode);
+			if (ret) {
+				erofs_err("failed to read packed inode from disk");
+				goto out;
+			}
+
+			if (!buffer || map.m_llen > buffer_size) {
+				buffer_size = map.m_llen;
+				buffer = realloc(buffer, map.m_llen);
+				BUG_ON(!buffer);
+			}
+			ret = erofs_pread(&packed_inode, buffer, map.m_llen,
+					  inode->fragmentoff);
+			if (ret)
+				goto out;
+
+			compressed = true;	/* force using buffer */
+			goto write_outfd;
+		}
+
 		if (map.m_plen > raw_size) {
 			raw_size = map.m_plen;
 			raw = realloc(raw, raw_size);
@@ -476,6 +501,7 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 			}
 		}
 
+write_outfd:
 		if (outfd >= 0 && write(outfd, compressed ? buffer : raw,
 					map.m_llen) < 0) {
 			erofs_err("I/O error occurred when verifying data chunk @ nid %llu",
@@ -486,8 +512,9 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 	}
 
 	if (fsckcfg.print_comp_ratio) {
-		fsckcfg.logical_blocks += BLK_ROUND_UP(inode->i_size);
 		fsckcfg.physical_blocks += BLK_ROUND_UP(pchunk_len);
+		if (!erofs_is_packed_inode(inode))
+			fsckcfg.logical_blocks += BLK_ROUND_UP(inode->i_size);
 	}
 out:
 	if (raw)
@@ -732,6 +759,8 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
 			ret = erofs_extract_dir(&inode);
 			break;
 		case S_IFREG:
+			if (erofs_is_packed_inode(&inode))
+				goto verify;
 			ret = erofs_extract_file(&inode);
 			break;
 		case S_IFLNK:
@@ -767,7 +796,7 @@ verify:
 		ret = erofs_iterate_dir(&ctx, true);
 	}
 
-	if (!ret)
+	if (!ret && !erofs_is_packed_inode(&inode))
 		erofsfsck_set_attributes(&inode, fsckcfg.extract_path);
 
 	if (ret == -ECANCELED)
@@ -822,6 +851,14 @@ int main(int argc, char **argv)
 		goto exit_put_super;
 	}
 
+	if (erofs_sb_has_fragments()) {
+		err = erofsfsck_check_inode(sbi.packed_nid, sbi.packed_nid);
+		if (err) {
+			erofs_err("failed to verify packed file");
+			goto exit_put_super;
+		}
+	}
+
 	err = erofsfsck_check_inode(sbi.root_nid, sbi.root_nid);
 	if (fsckcfg.corrupted) {
 		if (!fsckcfg.extract_path)
diff --git a/lib/zmap.c b/lib/zmap.c
index 41e0713..ca65038 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -639,6 +639,7 @@ static int z_erofs_do_map_blocks(struct erofs_inode *vi,
 		map->m_plen = vi->z_idata_size;
 	} else if (fragment && m.lcn == vi->z_tailextent_headlcn) {
 		map->m_flags |= EROFS_MAP_FRAGMENT;
+		map->m_plen = 0;
 	} else {
 		map->m_pa = blknr_to_addr(m.pblk);
 		err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
-- 
2.17.1

