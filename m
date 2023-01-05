Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA5565E7AF
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Jan 2023 10:23:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NngyB1Jnrz3c4Y
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Jan 2023 20:23:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=gH56m1M9;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=gH56m1M9;
	dkim-atps=neutral
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Nngxv5LbZz2ynB
	for <linux-erofs@lists.ozlabs.org>; Thu,  5 Jan 2023 20:23:29 +1100 (AEDT)
Received: by mail-pj1-x1033.google.com with SMTP id c8-20020a17090a4d0800b00225c3614161so1419856pjg.5
        for <linux-erofs@lists.ozlabs.org>; Thu, 05 Jan 2023 01:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nth5qk97YKFDPPUYZcHlMng61la9S1ks345ePJR1m1s=;
        b=gH56m1M9Za3IPau2ZfhoA0rZ3ccygvqyLjOaCzHTNkDck85uEy3ugx4OH2tl/El4pv
         s28fWGB8YKMCoQsQE/kb0NYTOcFgRJzBuW35y5GQ290PVpTsLL9HQuMsJx3aBHoT6bUS
         P4f4pv/zZsmSzzRV+OkLC8Z4m1WTLagZQbllfNWMULLzviDFrIGQ7Y3HYdshPmtS+1Ju
         IQWcBBx5AfqG5u+sgie+CMiOHP+80n8tFexaZtPW2TyDpkjhWPrAAEuF2GonQ1LevrQB
         kcqvCjJQytrLNadJd/nmt9BJWqthYvpHAN75grl5M5UEUhA0YfgMImOwIu0oMOPaUB1x
         1z0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nth5qk97YKFDPPUYZcHlMng61la9S1ks345ePJR1m1s=;
        b=tOLNtZLZgJuIQnG+LRr/9FZXfp4trLgiKdDx63kN1c/WjE8vkUa/wZs0OsHII0pNHl
         zRGQlctPPohjowOPsJYLv8Yj+4XB3U5s5QUqP1R6m+JwM7SOtFr/pEkx0PMK+gmz2dZN
         8vHSAEMXYc9fhlC6V+uN2SIsQ2ivnBMKJZ61GhGDji1pTZNK0f7IjWYiPul8fM+z7R/N
         2GqD3lWwWXTjZBKRbAtbOBPOrnlpSDuw2C0xqW6HVUalLu+XIAv2N53wgayId0gGv7iN
         oRc+rJE0UqpjheGQwojjX1B5/ok3JAd3Pj7jaZ94jelUAv0jbdiypo9R0pHhuzxncWd0
         LlfQ==
X-Gm-Message-State: AFqh2kpgO8J1SpVEamwTtyWHffrjv+5MBarjJ7OPj5uuXOd4F89LqkYY
	yBpIsZAZdgwe5xNu3EgGTTEpeIXUYw0=
X-Google-Smtp-Source: AMrXdXvodFhcDicWO2PMKAmvE1gf8ncIo0T8oaoUmi2LR8W3nOLufrN4AxC69z44Qz+a0VEeRa/i6Q==
X-Received: by 2002:a05:6a20:b29e:b0:ad:48b3:c5d1 with SMTP id ei30-20020a056a20b29e00b000ad48b3c5d1mr52670097pzb.47.1672910607285;
        Thu, 05 Jan 2023 01:23:27 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id w2-20020a626202000000b00576145a9bd0sm23847285pfb.127.2023.01.05.01.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 01:23:27 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils: fsck: add a check to packed inode
Date: Thu,  5 Jan 2023 17:21:57 +0800
Message-Id: <08cde366fc3a5dafbcdde0c0f904e045daeb0bab.1672909705.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <9d6764beb664af4cbe70869e7e45bdab57357e59.1672909705.git.huyue2@coolpad.com>
References: <9d6764beb664af4cbe70869e7e45bdab57357e59.1672909705.git.huyue2@coolpad.com>
In-Reply-To: <9d6764beb664af4cbe70869e7e45bdab57357e59.1672909705.git.huyue2@coolpad.com>
References: <9d6764beb664af4cbe70869e7e45bdab57357e59.1672909705.git.huyue2@coolpad.com>
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

Add a check to packed inode for fsck.erofs.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fsck/main.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 6c43816..e60b6c1 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -467,7 +467,8 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 		return ret;
 
 	if (fsckcfg.print_comp_ratio) {
-		fsckcfg.logical_blocks += BLK_ROUND_UP(inode->i_size);
+		if (!erofs_is_packed_inode(inode))
+			fsckcfg.logical_blocks += BLK_ROUND_UP(inode->i_size);
 		fsckcfg.physical_blocks += compressed ? inode->u.i_blocks :
 					   BLK_ROUND_UP(inode->i_size);
 	}
@@ -709,6 +710,8 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
 			ret = erofs_extract_dir(&inode);
 			break;
 		case S_IFREG:
+			if (erofs_is_packed_inode(&inode))
+				goto verify;
 			ret = erofs_extract_file(&inode);
 			break;
 		case S_IFLNK:
@@ -744,7 +747,7 @@ verify:
 		ret = erofs_iterate_dir(&ctx, true);
 	}
 
-	if (!ret)
+	if (!ret && !erofs_is_packed_inode(&inode))
 		erofsfsck_set_attributes(&inode, fsckcfg.extract_path);
 
 	if (ret == -ECANCELED)
@@ -799,6 +802,14 @@ int main(int argc, char **argv)
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
-- 
2.17.1

