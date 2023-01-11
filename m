Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7319E665141
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Jan 2023 02:50:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ns9c22WSrz3cCF
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Jan 2023 12:50:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=VSi98dx8;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=VSi98dx8;
	dkim-atps=neutral
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ns9bg6H7Xz3c65
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Jan 2023 12:49:51 +1100 (AEDT)
Received: by mail-pf1-x42a.google.com with SMTP id k19so10281430pfg.11
        for <linux-erofs@lists.ozlabs.org>; Tue, 10 Jan 2023 17:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+somNYB4QjQh87fmh5RL0427NfaPhPDoM4PgorryzSY=;
        b=VSi98dx8ltYKaqcE5Od8sKSBAAHX1NrNP2w5qu7ESmAJ9h3J5Hsr0Qk+PhKxKHtEBz
         k13aPukM3CZO/AStMp0ZZaueO7MxyUgrl6x0hP6WwUV+mPLIrwk4J3fNprZY4xedDjR/
         CiGBIMP1K9FZg5ziJUBFploycKNvMbrE4XbEQzary6rbTQbtqXArf7/pa1QQnWgDe0LA
         5KraXeVIrzV35GZFX8ViCalCT7Go6YzIU8pipvSwDwoPtSN+4R2pX8jaB4do95pFPtXQ
         sX9sSjYjjdJUaDKuXVuBBNsBPaF/+IeLknGTRG9FcWjBAtDnYPIKu8vHtZoEaiojFPV6
         mcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+somNYB4QjQh87fmh5RL0427NfaPhPDoM4PgorryzSY=;
        b=YmklR5ZX8cpUUebzwpAmi5mthGlxxXL2SZiN2LH5X8uTGuEc6yzxMDK9P8xPYGmd4W
         Kd/kAGJfuSCeR51crCxFti/kGlVh2QKj0WmnPFKTMEPzafavlqiCABzN166z3Rvju+ji
         mQekVpDYPuKSxJuMwMf2dSafa1xpthjbQpPmuthK1G4438XG94k3LtCQooe+Xlm8+bT+
         uKHngSRNtCAh4jgyl2LtFY2zLd3/ApiNBVOwz+xlxGVMZvLFw6nZoB+LrxIm0PI2fury
         nhix/LtqikZIrCRZBjG+UbcmeRDGXTtTfrf3xRKY/cvI0c1OGSMHMM83nNDWRXNIrHLO
         ZCbA==
X-Gm-Message-State: AFqh2kpDbmxy1piL2VbhS1nm4Up2Kh6O2H8nnPGEZGuiBfXrZv/qu56u
	o76KP1ClCZGVev3sfsRMr7+B+SNlOa4=
X-Google-Smtp-Source: AMrXdXvPVvTRIdyVZliPGcK280sHma6j+1kNEk37YZD9xjb7oLrjvH4aZbcz2/FEKhe83GMtmle4HA==
X-Received: by 2002:a62:1c8a:0:b0:58b:3168:4d53 with SMTP id c132-20020a621c8a000000b0058b31684d53mr2038318pfc.24.1673401789364;
        Tue, 10 Jan 2023 17:49:49 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id w2-20020a623002000000b0056283e2bdbdsm8669847pfw.138.2023.01.10.17.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 17:49:49 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH resend v3 3/3] erofs-utils: fsck: add a check to packed inode
Date: Wed, 11 Jan 2023 09:49:28 +0800
Message-Id: <ce29198d32f284c19589877c4c9e4e1588ad77b3.1673401718.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <ff560da9c798b2ca1f1a663a000501486d865487.1673401718.git.huyue2@coolpad.com>
References: <ff560da9c798b2ca1f1a663a000501486d865487.1673401718.git.huyue2@coolpad.com>
In-Reply-To: <ff560da9c798b2ca1f1a663a000501486d865487.1673401718.git.huyue2@coolpad.com>
References: <ff560da9c798b2ca1f1a663a000501486d865487.1673401718.git.huyue2@coolpad.com>
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
index a01ca76..6b42252 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -450,7 +450,8 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 	}
 
 	if (fsckcfg.print_comp_ratio) {
-		fsckcfg.logical_blocks += BLK_ROUND_UP(inode->i_size);
+		if (!erofs_is_packed_inode(inode))
+			fsckcfg.logical_blocks += BLK_ROUND_UP(inode->i_size);
 		fsckcfg.physical_blocks += BLK_ROUND_UP(pchunk_len);
 	}
 out:
@@ -696,6 +697,8 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
 			ret = erofs_extract_dir(&inode);
 			break;
 		case S_IFREG:
+			if (erofs_is_packed_inode(&inode))
+				goto verify;
 			ret = erofs_extract_file(&inode);
 			break;
 		case S_IFLNK:
@@ -731,7 +734,7 @@ verify:
 		ret = erofs_iterate_dir(&ctx, true);
 	}
 
-	if (!ret)
+	if (!ret && !erofs_is_packed_inode(&inode))
 		erofsfsck_set_attributes(&inode, fsckcfg.extract_path);
 
 	if (ret == -ECANCELED)
@@ -786,6 +789,14 @@ int main(int argc, char **argv)
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

