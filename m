Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3396AB74E
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Mar 2023 08:56:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PVW9G4VYdz3cHm
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Mar 2023 18:56:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=JuHi9hM/;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=JuHi9hM/;
	dkim-atps=neutral
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PVW9B1f1Fz3c5D
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 Mar 2023 18:55:58 +1100 (AEDT)
Received: by mail-pl1-x636.google.com with SMTP id h8so9323533plf.10
        for <linux-erofs@lists.ozlabs.org>; Sun, 05 Mar 2023 23:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678089356;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXM+F0nCeNTp6Op2aBBfKjMUtWoANY5Axbyzod0a2dk=;
        b=JuHi9hM/KWhW1Mri//QAde/70PgU9JOPU4yDSh9qWdIQdD8fzQGWUiePB8OSSZAnV1
         zT9kyW1GwWMvvo/Zr8C5c0mst/Ch8s3CljIrPvOkGexctWW/m/vJ12+TSDPlSE6at6N1
         MnCrM1NAjW1I2sDCEgFV9bM66E2nTCR0K8SqwYPDCxba5DUcuMmnYrTpMGqa+WUOLqm1
         dHZxYY6KvpB0Ox486ldWbITM5Cb3E+O5AW7d9DLzcnA5671fRdlB24bn2Sl2PMQo/KnW
         iW/1iOojHqoQg7k0yafD8+jSiwgMK0zgRTcQ3ja7w8ajdG0b7u6H/Ey7Z0SvWEJWExzt
         DHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678089356;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXM+F0nCeNTp6Op2aBBfKjMUtWoANY5Axbyzod0a2dk=;
        b=PkP/aYlODZGEMUFfdTiw7Qs80tViHc9lovKTeV2c86wwa2+XA8uxg02IdmtYZ4Fy+Y
         G//6amj6G/AGHdCmR40x+1GDp8ZugfaZFDe/UGM3PtCgeU82wvuB7UNKI/s8q/y2V7fs
         VYed7g57XJAvbSxh1CmE79O4r4f7blRbiFh0DlCalMfYiArYsBjKSj+j5wC5pjXtYm1F
         dDQOqOMBUent3vg7Ggdu3uySQETMpBf2YeZ/JKTGv4nEbDXD0ymVW7ZJCJhOt0u7vgsv
         3jphtQOvtjgS+CYsFlwq8nu2E/Js+t+LoS/wdBX6kDoppnhY/N5MTdtoKTIDAv/VYJJR
         qkRw==
X-Gm-Message-State: AO0yUKX1w2+CKXtZhX1lDq/DpF51tXoCR8mK6YiPc31GM8JgC+y4h627
	M89Y8Q19hw0z7Igh+HOwLAo=
X-Google-Smtp-Source: AK7set81pCf7l04ni0N9M1wStJKHShAv5aKLKdYUmKU14uNwyjDN4qqUNH/yoOsUTw7c7PAana0Alg==
X-Received: by 2002:a17:90b:3b85:b0:234:8c58:c325 with SMTP id pc5-20020a17090b3b8500b002348c58c325mr10160476pjb.31.1678089355951;
        Sun, 05 Mar 2023 23:55:55 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090ac20800b0022be36be19asm5383079pjt.53.2023.03.05.23.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 23:55:55 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org,
	jefflexu@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: use wrapper i_blocksize() in erofs_file_read_iter()
Date: Mon,  6 Mar 2023 15:55:27 +0800
Message-Id: <20230306075527.1338-1-zbestahu@gmail.com>
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

linux/fs.h has a wrapper for this operation.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 5bd0c956a142..7e8baf56faa5 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -380,7 +380,7 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		if (bdev)
 			blksize_mask = bdev_logical_block_size(bdev) - 1;
 		else
-			blksize_mask = (1 << inode->i_blkbits) - 1;
+			blksize_mask = i_blocksize(inode) - 1;
 
 		if ((iocb->ki_pos | iov_iter_count(to) |
 		     iov_iter_alignment(to)) & blksize_mask)
-- 
2.17.1

