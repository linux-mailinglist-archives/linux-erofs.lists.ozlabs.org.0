Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A383F4AC0
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Aug 2021 14:37:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GtWvz4vjrz2xsj
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Aug 2021 22:37:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=skxgWCLa;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52e;
 helo=mail-pg1-x52e.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=skxgWCLa; dkim-atps=neutral
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GtWvt4HXPz2xrx
 for <linux-erofs@lists.ozlabs.org>; Mon, 23 Aug 2021 22:36:56 +1000 (AEST)
Received: by mail-pg1-x52e.google.com with SMTP id 17so16523475pgp.4
 for <linux-erofs@lists.ozlabs.org>; Mon, 23 Aug 2021 05:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jLMgwe90MKuYKy9n2HQOVr5LSbBw0YGCHf/lpFHo6fM=;
 b=skxgWCLafKC/34N3vVjI3btKMfy3EuyvBluAigFiCbJa4WknWXHCpXTTh2AQUUgeVg
 F18HuLfyh8It2f75Xcc062KwW4jVoNdqKg95bUcV/6et9fhFMB8YyNLNxP+m4MmIpkMW
 YYjcIl5OSZs5FxYii/ZZ584XV5tlc3s/btYPzeNm26XW0kO/BqsKsvm7zoAvHOeOvnow
 jUjXV8DZtpi0UZ2/AfP4RWNOxVcE3NBRFI6a7OKBXd3/zF3UTQ4oDYA8/A8y4val68Vl
 mI/kIcyJ68v5TxeCZSbJ11rikarg9w3lkbLZKy3lVocizb7nElNXwgFZJJ1QrSr79VAU
 TlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jLMgwe90MKuYKy9n2HQOVr5LSbBw0YGCHf/lpFHo6fM=;
 b=Y41LDLP78GrQTJpi3OC+D1t4ZHxWBW6UVaZNeVR+iFohJMM8GhJvPz71XIKjnoTfNq
 DzTEORC+0JgrFQVQFyp0zzz2Lw7/v6T4u4dxZleFVS8Fxyqdyvu9VsJANwYgIfzNsVTG
 Cqj6cQuw02UaKtNe24Y3bdv+vqX9PUTBp0If1e48+HwUER5ZV/yFxOeDrMFb1rYBklcV
 XE3g6QZwYawptHqZFzzTXH/p7kVKsxm0fXnGo33ykndYHSL3gOiqTASaVRvJfNBj1r2Y
 OFuOYg1tatQiDkFGYL8b1Vr4HPLFZ0ShH79F+W0Kg1hq3CfPzvRe2FRSp6FNfTRMpjhb
 boaQ==
X-Gm-Message-State: AOAM531j+bWy1TFefl0PEm24rrod9V4Vk+3v7BNnIc5CK5owjlWGDheh
 /YcaVA8Khk6D5RyfH+N4cdw=
X-Google-Smtp-Source: ABdhPJwuVjmaaGIdAUMmV3JJPdpmhXCRrbPKfmByFWGXMo8geMfVLfzBFzh0PaH7IiYCcL89Lq/rcg==
X-Received: by 2002:aa7:8f11:0:b0:3eb:47a6:551c with SMTP id
 x17-20020aa78f11000000b003eb47a6551cmr1026047pfr.41.1629722213441; 
 Mon, 23 Aug 2021 05:36:53 -0700 (PDT)
Received: from hjn-PC.localdomain (li1080-207.members.linode.com.
 [45.33.61.207])
 by smtp.gmail.com with ESMTPSA id d15sm16376817pfd.115.2021.08.23.05.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Aug 2021 05:36:52 -0700 (PDT)
From: Huang Jianan <jnhuang95@gmail.com>
To: u-boot@lists.denx.de
Subject: [PATCH v2 0/3] fs/erofs: new filesystem
Date: Mon, 23 Aug 2021 20:36:43 +0800
Message-Id: <20210823123646.9765-1-jnhuang95@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210822154843.10971-1-jnhuang95@gmail.com>
References: <20210822154843.10971-1-jnhuang95@gmail.com>
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
Cc: xiang@kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Huang Jianan <huangjianan@oppo.com>

Add erofs filesystem support.

The code is adapted from erofs-utils in order to reduce maintenance
burden and keep with the latest feature.

Changes since v1:
 - fix the inconsistency between From and SoB (Bin Meng);
 - add missing license header;

Huang Jianan (3):
  fs/erofs: add erofs filesystem support
  fs/erofs: add lz4 1.8.3 decompressor
  fs/erofs: add lz4 decompression support

 fs/Kconfig            |   1 +
 fs/Makefile           |   1 +
 fs/erofs/Kconfig      |  12 +
 fs/erofs/Makefile     |  10 +
 fs/erofs/data.c       | 206 ++++++++++++++++
 fs/erofs/decompress.c |  74 ++++++
 fs/erofs/decompress.h |  29 +++
 fs/erofs/erofs_fs.h   | 384 ++++++++++++++++++++++++++++++
 fs/erofs/fs.c         | 231 ++++++++++++++++++
 fs/erofs/internal.h   | 203 ++++++++++++++++
 fs/erofs/lz4.c        | 534 ++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/lz4.h        |   5 +
 fs/erofs/namei.c      | 238 +++++++++++++++++++
 fs/erofs/super.c      |  65 +++++
 fs/erofs/zmap.c       | 517 ++++++++++++++++++++++++++++++++++++++++
 fs/fs.c               |  22 ++
 include/erofs.h       |  19 ++
 include/fs.h          |   1 +
 18 files changed, 2552 insertions(+)
 create mode 100644 fs/erofs/Kconfig
 create mode 100644 fs/erofs/Makefile
 create mode 100644 fs/erofs/data.c
 create mode 100644 fs/erofs/decompress.c
 create mode 100644 fs/erofs/decompress.h
 create mode 100644 fs/erofs/erofs_fs.h
 create mode 100644 fs/erofs/fs.c
 create mode 100644 fs/erofs/internal.h
 create mode 100644 fs/erofs/lz4.c
 create mode 100644 fs/erofs/lz4.h
 create mode 100644 fs/erofs/namei.c
 create mode 100644 fs/erofs/super.c
 create mode 100644 fs/erofs/zmap.c
 create mode 100644 include/erofs.h

-- 
2.25.1

