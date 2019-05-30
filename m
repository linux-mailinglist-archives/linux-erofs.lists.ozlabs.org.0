Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBB72F9EB
	for <lists+linux-erofs@lfdr.de>; Thu, 30 May 2019 11:59:30 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45F32l55Z1zDqV9
	for <lists+linux-erofs@lfdr.de>; Thu, 30 May 2019 19:59:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="I5nm9ScC"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45F32b08zQzDqS8
 for <linux-erofs@lists.ozlabs.org>; Thu, 30 May 2019 19:59:15 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id r22so3626592pfh.9
 for <linux-erofs@lists.ozlabs.org>; Thu, 30 May 2019 02:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=qzIbLiCRL98C+Is9VPHCUX9eAcf2jcqEb0V0H0mLEZk=;
 b=I5nm9ScCDK0l/3eKL1/WseMpypzH8YrlzmwWHkkZnqHtGgE6fKm3xaGC2Xm/mUhFLN
 ediTFuJisIkJw02fgCeLFPWhsPiIG+ZWOR6uV0GtXwj5d89tMbsgXBNA46anvBzIYY7P
 V8PmmIqrbGz6rB6ncs182o6l4riwJqtK5Rr0bpfWWa5fyQQM6BQ+eKALMtUVP1WNAs1U
 SoWLOvSXrwV9kEYQGTmVz+8py8r0B7NHz9iORw5OQIB62vGaujE/LN6jT/Tc7xwos6Hj
 3B8YLINDnp61bhPKV6cw4SwqouIolgHwmZ8kXzsufk2piLqvDzrJVUPQ00Va9tvmQQtX
 Njfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=qzIbLiCRL98C+Is9VPHCUX9eAcf2jcqEb0V0H0mLEZk=;
 b=DRnpHFPrB0CHz3LeOe/LyGbeAZGnmzkys5afeKjTb5NM0KNXQFdVJ2m5+qLakUo/wS
 Ay/7RWIjBT2jZ4o9sEaCg+eNGgQYJMSXu8QVcY+z+9GZPWVD/ftipGuLLEIchBv0/RhJ
 ZT3gVRFIPa9Yx2xoFrNEg9bXhIYmHPOKEbg1PMV81Advaf6zgZd3zSrPM08ZNIHnQFTY
 C1opukSDouvE2ao4ozzJjhZwxoYt5JMRYlZBfXKAmuvUca537M33DHvp2pMyIjqYS3Qq
 mwZdRrzsstgAMsR8k2SjcvTbGidl5qIjrq3Zxeml/CSoI0wWUCpwDTcnkYigGRig1/g7
 mUtQ==
X-Gm-Message-State: APjAAAVm6ClqVOxe6+zKrkm3Lrp97bMVOtAMgB2+xVqA8x83gj+SfTYy
 mjr8Vwupdxes4Pb3RlNknzk=
X-Google-Smtp-Source: APXvYqz8IluOWUzjcrNew3H49k7y3fGcaJWfaUZu4FPYljfyap5VocUqVS6X4ZhX6yvhlBd9SUOBsQ==
X-Received: by 2002:a17:90a:332c:: with SMTP id
 m41mr2247569pjb.1.1559210351706; 
 Thu, 30 May 2019 02:59:11 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
 by smtp.gmail.com with ESMTPSA id f11sm2528102pfd.27.2019.05.30.02.59.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 30 May 2019 02:59:11 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: bluce.liguifu@huawei.com,
	miaoxie@huawei.com,
	fangwei1@huawei.com
Subject: [PATCH] erofs-utils: remove AC_FUNC_MALLOC check
Date: Thu, 30 May 2019 17:58:50 +0800
Message-Id: <20190530095850.5260-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
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
Cc: huyue2@yulong.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@yulong.com>

Below erros happened when building for ARM64, rpl_malloc is not
supplied in that case, remove AC_FUNC_MALLOC can fix the errors.

mkfs_file.c: In function 'erofs_compress_file':
mkfs_file.c:600:2: error: implicit declaration of function 'rpl_malloc' [-Werror=implicit-function-declaration]
  inode->i_inline_data = malloc(EROFS_BLKSIZE);
  ^
mkfs_file.c:600:23: error: assignment makes pointer from integer without a cast [-Werror]
  inode->i_inline_data = malloc(EROFS_BLKSIZE);
                       ^
mkfs_file.c: In function 'erofs_init_compress_context':
mkfs_file.c:874:17: error: assignment makes pointer from integer without a cast [-Werror]
  ctx->cc_srcbuf = malloc(erofs_cfg.c_compr_maxsz);
                 ^
mkfs_file.c:875:17: error: assignment makes pointer from integer without a cast [-Werror]
  ctx->cc_dstbuf = malloc(erofs_cfg.c_compr_maxsz * 2);
                 ^
cc1: all warnings being treated as errors
make[2]: *** [mkfs_erofs-mkfs_file.o] Error 1

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 configure.ac | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 8e3f703..40ee765 100644
--- a/configure.ac
+++ b/configure.ac
@@ -98,7 +98,6 @@ AC_CHECK_MEMBERS([struct stat.st_rdev])
 AC_TYPE_UINT64_T
 
 # Checks for library functions.
-AC_FUNC_MALLOC
 AC_CHECK_FUNCS([ftruncate getcwd gettimeofday memset realpath strdup strerror strrchr strtoull])
 
 # Configure lz4.
-- 
1.9.1

