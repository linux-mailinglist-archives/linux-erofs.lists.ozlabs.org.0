Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4234C5448
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Feb 2022 08:06:07 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K5Hjl5q6Gz3bb7
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Feb 2022 18:06:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=p6dk6ET4;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::529;
 helo=mail-pg1-x529.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=p6dk6ET4; dkim-atps=neutral
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K5Hjf2n7Lz2yN3
 for <linux-erofs@lists.ozlabs.org>; Sat, 26 Feb 2022 18:05:57 +1100 (AEDT)
Received: by mail-pg1-x529.google.com with SMTP id 27so6649458pgk.10
 for <linux-erofs@lists.ozlabs.org>; Fri, 25 Feb 2022 23:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=12pF2J7VBd40PUm9/P8/z1pEuEYwhjfpzTNllR1MSO8=;
 b=p6dk6ET4Fbcvyvu5WHqBCiTebJdb33LNQrnjkl53DesNTYAPqGHKKuUBqHQPh6yv6Y
 CqE+0q2WrjvLp4NdZchXp0xSEsYoX2Djza7UYLEdJungV53Y8+MIdpboPk90sBElzMCS
 Ow/yRNvR+l9tHq8GpTxEOpWR7ZQkzhRgtDIfDkHKanqXXYIWKkZOV237iCPGItuAWSit
 HhFG9RWleGj8w5W50hNNPEjSP7fPix7CsrrfrPY8j0tJ7X0fhgsBcAGg9hLGViX2k6mW
 pllY9wh/TXMoSHdBk/0ZCcqC9qCr83u2xOBBsK+duOLzKZIlr/ByvnWrB0py8OsYkILs
 WCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=12pF2J7VBd40PUm9/P8/z1pEuEYwhjfpzTNllR1MSO8=;
 b=ZUKjsWYLwVw1z+mKXYzVLmbsWbFQJrNnB27id8IfOr0f2lsj8x1Y7OH+E8+Mt2PXMA
 oPXSa0n06gCSZIMjVMaOZacrxStDuDHyoDt2yy2tQJ4DbYN5rCFaU2jClpVp+7uxm/99
 fwGWGj5/VXRVDCbV/0OihejWVstFQc3j67eQ45mWZCrKW1V/dn0eKEjQOAr3n8x5EOqx
 +x4yX+MP+3pEPgJISkj9JdUo45bw5UH7oBEArzGACreOfKyZoJhoGudSQFCNGnJJFhm9
 TqyCozSe2HZi4zs5pzpFoVdMIOHJ3v81Ne3whZB0TtZNtrM6ky7GC1jVKm2KdjOcc9ZU
 P+uw==
X-Gm-Message-State: AOAM530LVYEG6s/Lp1MnUYEIOTOfTn8gvqb0ZY3OgdSam0to4i6HXPhr
 9PrI/OlKkXvDsof0/EouBn0=
X-Google-Smtp-Source: ABdhPJyunwZkIIamynu+s2SqwmhCJLv7G/YpTBi0/PTU1Jj+zmg4jqVacwWpT8GMUt5dhB8eXbnygg==
X-Received: by 2002:a63:e718:0:b0:34b:8596:4a0d with SMTP id
 b24-20020a63e718000000b0034b85964a0dmr9107387pgi.327.1645859156105; 
 Fri, 25 Feb 2022 23:05:56 -0800 (PST)
Received: from hjn-PC.localdomain (li1080-207.members.linode.com.
 [45.33.61.207]) by smtp.gmail.com with ESMTPSA id
 e20-20020a17090ab39400b001bc4f9ad3cbsm11044489pjr.3.2022.02.25.23.05.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Feb 2022 23:05:55 -0800 (PST)
From: Huang Jianan <jnhuang95@gmail.com>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Subject: [PATCH v4 0/5] fs/erofs: new filesystem
Date: Sat, 26 Feb 2022 15:05:46 +0800
Message-Id: <20220226070551.9833-1-jnhuang95@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Changes since v3:
 - update tools/docker/Dockerfile;

Changes since v2:
 - sync up with erofs-utils 1.4;
 - update lib/lz4 to v1.8.3;
 - add test for filesystem functions;

Changes since v1:
 - fix the inconsistency between From and SoB;
 - add missing license header;

Huang Jianan (5):
  fs/erofs: add erofs filesystem support
  lib/lz4: update LZ4 decompressor module
  fs/erofs: add lz4 decompression support
  fs/erofs: add filesystem commands
  test/py: Add tests for the erofs

 MAINTAINERS                         |   9 +
 cmd/Kconfig                         |   6 +
 cmd/Makefile                        |   1 +
 cmd/erofs.c                         |  42 ++
 configs/sandbox_defconfig           |   1 +
 fs/Kconfig                          |   2 +
 fs/Makefile                         |   1 +
 fs/erofs/Kconfig                    |  21 +
 fs/erofs/Makefile                   |   9 +
 fs/erofs/data.c                     | 311 +++++++++++++
 fs/erofs/decompress.c               |  78 ++++
 fs/erofs/decompress.h               |  24 +
 fs/erofs/erofs_fs.h                 | 436 ++++++++++++++++++
 fs/erofs/fs.c                       | 267 +++++++++++
 fs/erofs/internal.h                 | 313 +++++++++++++
 fs/erofs/namei.c                    | 252 +++++++++++
 fs/erofs/super.c                    | 105 +++++
 fs/erofs/zmap.c                     | 601 ++++++++++++++++++++++++
 fs/fs.c                             |  22 +
 include/erofs.h                     |  19 +
 include/fs.h                        |   1 +
 include/u-boot/lz4.h                |  49 ++
 lib/lz4.c                           | 679 ++++++++++++++++++++--------
 lib/lz4_wrapper.c                   |  23 +-
 test/py/tests/test_fs/test_erofs.py | 211 +++++++++
 tools/docker/Dockerfile             |   1 +
 26 files changed, 3269 insertions(+), 215 deletions(-)
 create mode 100644 cmd/erofs.c
 create mode 100644 fs/erofs/Kconfig
 create mode 100644 fs/erofs/Makefile
 create mode 100644 fs/erofs/data.c
 create mode 100644 fs/erofs/decompress.c
 create mode 100644 fs/erofs/decompress.h
 create mode 100644 fs/erofs/erofs_fs.h
 create mode 100644 fs/erofs/fs.c
 create mode 100644 fs/erofs/internal.h
 create mode 100644 fs/erofs/namei.c
 create mode 100644 fs/erofs/super.c
 create mode 100644 fs/erofs/zmap.c
 create mode 100644 include/erofs.h
 create mode 100644 test/py/tests/test_fs/test_erofs.py

-- 
2.25.1

