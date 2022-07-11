Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3999056F9E7
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Jul 2022 11:10:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LhJ5B23RYz3c00
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Jul 2022 19:10:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Ev5wMINI;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Ev5wMINI;
	dkim-atps=neutral
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LhJ532tcYz3bf5
	for <linux-erofs@lists.ozlabs.org>; Mon, 11 Jul 2022 19:10:29 +1000 (AEST)
Received: by mail-pg1-x52a.google.com with SMTP id 73so4197781pgb.10
        for <linux-erofs@lists.ozlabs.org>; Mon, 11 Jul 2022 02:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=sWHLlvMnzBgraN34zttD07EQT9FTI83jbnPlzCAVa6U=;
        b=Ev5wMINIOXbV8SGa/066bl5vuQUqRRIHywZU2SU61ly5VDI7I04cIf85ASkhsRkH+0
         iP0FZ+bCBTXEAWXKolidHLW3Hp/SWQQ+seNOC44BqnbtCxH3NUaHNfP3ZetgqJKj+7yz
         bBzCcZWnSuSU1o424u4iZZIS7rdcAIjtQAMmE3Ce5JcxtO2HjI9pD7bPjRclqZWjWrRf
         mt6mfc64Nyagyde0IsfI7CSLWzin0QiWi11FNUrtW9+opG3PpsRkSv6IJ+7XtBPK0TaU
         uCHUkF9pePqLWaXNDYLSUfCeRAHJNmlFqSr1iFxvoO5twFgVfRauCX967uNfj5dFca5/
         XREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sWHLlvMnzBgraN34zttD07EQT9FTI83jbnPlzCAVa6U=;
        b=NR5fiRW7Ypza3EdUmX3aoQS5KMIA735q1xQ5MPsiepaWUgjxLba/g8F16EZ+mlVA2r
         rPdWT6i5Y6KLVPBGG+0zXz+KuGb9U+RwEbClFExLd0AlWAqIZwoQeyBsrGkTuAhhaLrb
         O6ndL7ySPhCSCWL2g1gvsuYiGBJjDlmcv9gsYYdKHT66HXIHTk36r6AI7mWA8dSvXDvM
         qN9Vb/NaAzUXLMiTnWCvWooyGPuRrBm+pFEk4QTbUAHW8WiiWotY31UqH6A8QJz2vsL8
         drofETb0JC45hoHjcB9Zzkieo1MVlsHha69FCQR0I1QtTOs6ohRo3z6FTutInyxOk7mN
         +lxw==
X-Gm-Message-State: AJIora/+yQrrRI0IXbT8+T0COS9YfJl4eGltrSqEf4oDRZtSq/5I26NF
	9gK65db8k6mSCy5MNGFFHWWwluNAU6o=
X-Google-Smtp-Source: AGRyM1sBRkPU6DeIoIe/PVFoFqtYizfoe3p2vyzffXWDetMlHM3JMBvkDAhVUs58TV51CYIS6ISLmQ==
X-Received: by 2002:a05:6a00:852:b0:528:c669:ad65 with SMTP id q18-20020a056a00085200b00528c669ad65mr17393141pfk.75.1657530626117;
        Mon, 11 Jul 2022 02:10:26 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902968200b00165105518f6sm4145052plp.287.2022.07.11.02.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 02:10:25 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
X-Google-Original-From: Yue Hu <huyue2@coolpad.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 0/3] erofs-utils: compressed fragments feature
Date: Mon, 11 Jul 2022 17:09:55 +0800
Message-Id: <cover.1657528899.git.huyue2@coolpad.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, zhangwen@coolpad.com, shaojunjun@coolpad.com, zbestahu@163.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In order to achieve greater compression ratio, let's introduce
compressed fragments feature which can merge tail of per-file or the
whole files into one special inode to reach the target.

And we can also set pcluster size to fragments inode for different
compression requirments.

In this patchset, we also improve the uncompressed data layout of
compressed files. Just write it from 'clusterofs' instead of 0 since it
can benefit from in-place I/O. For now, it only goes with fragments.

The main idea above is from Xiang.

Here is some test data of Linux 5.10.87 source code under Ubuntu 18.04:

linux-5.10.87 (erofs, uncompressed)                1.1G

linux-5.10.87 (erofs, lz4hc,12 4k fragments,4k)    304M
linux-5.10.87 (erofs, lz4hc,12 8k fragments,8k)    271M
linux-5.10.87 (erofs, lz4hc,12 16k fragments,16k)  245M
linux-5.10.87 (erofs, lz4hc,12 32k fragments,32k)  228M
linux-5.10.87 (erofs, lz4hc,12 64k fragments,64k)  220M

linux-5.10.87 (erofs, lz4hc,12 4k vanilla)         396M
linux-5.10.87 (erofs, lz4hc,12 8k vanilla)         376M
linux-5.10.87 (erofs, lz4hc,12 16k vanilla)        364M
linux-5.10.87 (erofs, lz4hc,12 32k vanilla)        359M
linux-5.10.87 (erofs, lz4hc,12 64k vanilla)        358M

Usage:
mkfs.erofs -zlz4hc,12 -C65536 -Efragments,65536 foo.erofs.img foo/

Yue Hu (3):
  erofs-utils: lib: add support for fragments data decompression
  erofs-utils: lib: support on-disk offset for shifted decompression
  erofs-utils: introduce compressed fragments support

 include/erofs/compress.h   |  2 +-
 include/erofs/config.h     |  3 +-
 include/erofs/decompress.h |  3 ++
 include/erofs/fragments.h  | 25 ++++++++++
 include/erofs/inode.h      |  2 +
 include/erofs/internal.h   |  9 ++++
 include/erofs_fs.h         | 20 ++++++--
 lib/Makefile.am            |  4 +-
 lib/compress.c             | 94 ++++++++++++++++++++++++++++----------
 lib/data.c                 | 33 ++++++++++++-
 lib/decompress.c           | 10 +++-
 lib/fragments.c            | 77 +++++++++++++++++++++++++++++++
 lib/inode.c                | 50 +++++++++++++-------
 lib/super.c                |  1 +
 lib/zmap.c                 | 14 ++++++
 mkfs/main.c                | 63 ++++++++++++++++++++++---
 16 files changed, 352 insertions(+), 58 deletions(-)
 create mode 100644 include/erofs/fragments.h
 create mode 100644 lib/fragments.c

-- 
2.17.1

