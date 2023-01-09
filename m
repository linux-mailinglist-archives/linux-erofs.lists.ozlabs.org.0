Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2737B6623CD
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Jan 2023 12:06:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NrB366rsVz3c9T
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Jan 2023 22:06:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=YR26oVKX;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=YR26oVKX;
	dkim-atps=neutral
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NrB2v0TcKz3bT5
	for <linux-erofs@lists.ozlabs.org>; Mon,  9 Jan 2023 22:06:30 +1100 (AEDT)
Received: by mail-pg1-x531.google.com with SMTP id h192so5596250pgc.7
        for <linux-erofs@lists.ozlabs.org>; Mon, 09 Jan 2023 03:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=psLhOpF06jkxTrHXvY6FjZureClS5UFirpcgjup5NIc=;
        b=YR26oVKXldJzrQp1LFfIg0nj7NLdwXq4sb7hA3l8Hszck8aD40F+Ycuzha7BEOyTbT
         PgsjOSA39Bc2jR5yA91qY8427LMHsIo8UPtqsLgqBtpLeeh3YAkUi7QbaRUGuh8nK9Uv
         jQdefllpDrHgai1pHdRuV+k1jnYUt8GYR/7sK602HOtLTvmv3M/6UBsF+M01Xm160Kne
         86KriEfHQp2u/9CjgKuZXjhNRjhJUPcNTg5Kkh21qd4ZZvaQDVuOSnyua47VBezhMOHM
         YTtzbo8ZXClBn1ItOKxi8Z0NyoBcM7FdREuEtMmbODsFXG9Pkwb3khAHx3QNz0KJroMB
         w90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psLhOpF06jkxTrHXvY6FjZureClS5UFirpcgjup5NIc=;
        b=SHkcv1xVIDM7jGQ0d5obPUkI7GlTQxascyKBtZ2jZyiYGV5ef3Bq1JzqYP80S5vOwb
         de+O7L/A1rUFpYv+efdWOtRGlVJYoHwRl1OjbglfJSzdpNPoxN+EZmfpwhG2PnZIyv8L
         1WHxK8yewPvmkee/ZhViaNNA+kROpEbhoW/C+lx+LY/PBONFlfOGUQMFcMEARaNzDRl8
         jwMb2pSh3ECAgGSL8/xqh6zoeud5SP1OkDEfSBf+FzIRP4SmUWUDJijLDUzasQc2jHKz
         4/2qomD4pwfhbabvZGo4HDPxq8xCbC7kWzjWnlrCqvP8TOPkW8saPILVaXJM3kTzL8nX
         hUsw==
X-Gm-Message-State: AFqh2krKDTodjTmPlEd80agL2FFjXIT2rqxteDANzgAzU9MoRgoXF8OF
	4xEJ1L2sUhBxWz+LhJKeP0k3HNBntjg=
X-Google-Smtp-Source: AMrXdXuIv5xexo9rnebB0PGRZuOLWmLG8fw8dHOaT5xDtZEpfLyN03KSzY1garLCbVXurRH0NVawoA==
X-Received: by 2002:a05:6a00:4212:b0:583:fb14:ddc1 with SMTP id cd18-20020a056a00421200b00583fb14ddc1mr10685151pfb.17.1673262388670;
        Mon, 09 Jan 2023 03:06:28 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id g13-20020aa79dcd000000b0056bcb102e7bsm5790134pfq.68.2023.01.09.03.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 03:06:28 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/3] erofs-utils: fsck: add a check to packed inode
Date: Mon,  9 Jan 2023 19:06:12 +0800
Message-Id: <88e599639173d9ff6749fc68e038204319072673.1673260541.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <678c4bff815ccebe61977119e0516216ba5f2abf.1673260541.git.huyue2@coolpad.com>
References: <678c4bff815ccebe61977119e0516216ba5f2abf.1673260541.git.huyue2@coolpad.com>
In-Reply-To: <678c4bff815ccebe61977119e0516216ba5f2abf.1673260541.git.huyue2@coolpad.com>
References: <678c4bff815ccebe61977119e0516216ba5f2abf.1673260541.git.huyue2@coolpad.com>
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
index 71abbdb..02352aa 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -451,7 +451,8 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 	}
 
 	if (fsckcfg.print_comp_ratio) {
-		fsckcfg.logical_blocks += BLK_ROUND_UP(inode->i_size);
+		if (!erofs_is_packed_inode(inode))
+			fsckcfg.logical_blocks += BLK_ROUND_UP(inode->i_size);
 		fsckcfg.physical_blocks += BLK_ROUND_UP(pchunk_len);
 	}
 out:
@@ -697,6 +698,8 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
 			ret = erofs_extract_dir(&inode);
 			break;
 		case S_IFREG:
+			if (erofs_is_packed_inode(&inode))
+				goto verify;
 			ret = erofs_extract_file(&inode);
 			break;
 		case S_IFLNK:
@@ -732,7 +735,7 @@ verify:
 		ret = erofs_iterate_dir(&ctx, true);
 	}
 
-	if (!ret)
+	if (!ret && !erofs_is_packed_inode(&inode))
 		erofsfsck_set_attributes(&inode, fsckcfg.extract_path);
 
 	if (ret == -ECANCELED)
@@ -787,6 +790,14 @@ int main(int argc, char **argv)
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

