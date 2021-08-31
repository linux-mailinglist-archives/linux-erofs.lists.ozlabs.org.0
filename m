Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB473FCBD4
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Aug 2021 18:51:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GzYB53Ln2z2yNK
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Sep 2021 02:51:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=e7BFYaSi;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d;
 helo=mail-pj1-x102d.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=e7BFYaSi; dkim-atps=neutral
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GzY9y4LXkz2yLQ
 for <linux-erofs@lists.ozlabs.org>; Wed,  1 Sep 2021 02:51:34 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id j1so12251596pjv.3
 for <linux-erofs@lists.ozlabs.org>; Tue, 31 Aug 2021 09:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qO5CMNW4XaR9NiEtFFrnR0NDM8bY6E/YApQSRyIL1zI=;
 b=e7BFYaSi+gYqiXmfKsUYSw5hBfr1Z7UTPkwiBpwU0UWUfy9iJu2RHF5anScXDKL/yY
 bAOd9xhpN8fWeCf+nzf9FBx9j5V17aOBEptIza2Cl5ki5sj51HGXjUm6y4RaYeAvSrNB
 0mPnYeNIEVQIx5chFnLZsWTPtrCZGVHUKyL/yG5D14ezUxDavnpprm+IpuygWUXH54cl
 q3XhggVm/IkOsxEVT/iNwaoLst2pIDX1V5M1afs9APazRBjQbs9oVlS5aQD0mGWkPCHH
 n8XGiLZIrlnzb4gl8OKxDSxbXxfo1NoEl7Z/HeTX15I+dEie3a/MSsk/ehsARPGJ51ly
 2V7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qO5CMNW4XaR9NiEtFFrnR0NDM8bY6E/YApQSRyIL1zI=;
 b=DjH82XB9Wjr0lwOHSenyQvl9eMTNnx5kt0lYIFb1u6NtMNjwiqJ9hb6xDXGD05PQNv
 ZLE3/VbyAt4S7wZG8/lPEW7iHL6gFc2OCIBzOo8Y40c5dx9epkz9quT0HGfNqY9f7xDY
 3dBW9A7MllvqL9ul3x/T7YaTwt369v+/TEsEf3Rx0vgN2V1m1IvCNpx4ERt2ahg1nPzo
 Jij6T8iabuVrsvxuhyqpQeAqAFQmwC9uRzeV8brjTjBxZJMPvOb3Oh6wSKzARvNbBCP2
 z1qPCujynKXh3YeB3K1ZqcvJkIeQT7WVj6lRv7nb3cUGASMixeTbAtTcsgT51XSxvlMv
 e/OQ==
X-Gm-Message-State: AOAM532QJxyXe2W8HJndUQaGlA5tkSP/zCvL69AAUKzk8Y6m3dQqpzwZ
 livO2sGSAl2xun3i0QUP15d7NiemQK2UFw==
X-Google-Smtp-Source: ABdhPJzd4Eq73QevzeunNdHsbHr7v1+GkaVIi3lWLPnEOaLm7nvY7Zc2PaPq84HtXP09owzUeE/MZg==
X-Received: by 2002:a17:90a:5285:: with SMTP id
 w5mr6427736pjh.78.1630428689944; 
 Tue, 31 Aug 2021 09:51:29 -0700 (PDT)
Received: from hjn-PC.localdomain (li1080-207.members.linode.com.
 [45.33.61.207])
 by smtp.gmail.com with ESMTPSA id u6sm20697487pgr.3.2021.08.31.09.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Aug 2021 09:51:29 -0700 (PDT)
From: Huang Jianan <jnhuang95@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/5] erofs-utils: fix SPDX comment style
Date: Wed,  1 Sep 2021 00:51:13 +0800
Message-Id: <20210831165116.16575-3-jnhuang95@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210831165116.16575-1-jnhuang95@gmail.com>
References: <20210831165116.16575-1-jnhuang95@gmail.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Huang Jianan <huangjianan@oppo.com>

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
 fuse/macosx.h              | 1 +
 include/erofs/block_list.h | 2 +-
 include/erofs/xattr.h      | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fuse/macosx.h b/fuse/macosx.h
index 372eba6..81ac47f 100644
--- a/fuse/macosx.h
+++ b/fuse/macosx.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 #ifdef __APPLE__
 #undef LIST_HEAD
 #endif
diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
index 5127b23..fca476a 100644
--- a/include/erofs/block_list.h
+++ b/include/erofs/block_list.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C), 2021, Coolpad Group Limited.
  * Created by Yue Hu <huyue2@yulong.com>
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 5086b54..f0c4c26 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Originally contributed by an anonymous person,
  * heavily changed by Li Guifu <blucerlee@gmail.com>
-- 
2.25.1

