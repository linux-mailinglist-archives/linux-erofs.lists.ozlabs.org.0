Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E52B66A91F7
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Mar 2023 08:52:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PSgDd52J1z3cdb
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Mar 2023 18:52:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sijam-com.20210112.gappssmtp.com header.i=@sijam-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=zC51wvGN;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=sijam.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=asai@sijam.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20210112.gappssmtp.com header.i=@sijam-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=zC51wvGN;
	dkim-atps=neutral
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PSgDW2VTQz3cLB
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Mar 2023 18:52:25 +1100 (AEDT)
Received: by mail-pl1-x62c.google.com with SMTP id i3so1879706plg.6
        for <linux-erofs@lists.ozlabs.org>; Thu, 02 Mar 2023 23:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sijam-com.20210112.gappssmtp.com; s=20210112; t=1677829944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OyynWijV+48R3sg30iOoqEkNvieuyoCQzpum+vJovD0=;
        b=zC51wvGN5dgXQHfUtFemTIvDeKG52+SN8YGJk6hRigx8IYPMenc5gw90egeneDrCZu
         Zid6PSd/22GzE3q+nWebwvkbsXIDZKpO3xYC4cTMXfOOb0tli/TuuODkbQ8aLvHfWBFv
         mgs03J52ydpzsMrP3RkaSWyhTouPHgbkOamrlQIk5wu2GnYNIM54Z1P82i4yyB/GlcCj
         ZHAgEb+0fkogYFQu7DLRYB8c/ZL1jRlrMzR3lXb7tdy02TCNnBTICbHX0ADRZofu/zFA
         MG9nnhOb89jeE7jn/MCiTv5O3Gsxrm3A/iigXqQ2k75xxug9U9RZFeZmo3LYC5RIyK+P
         Io3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677829944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyynWijV+48R3sg30iOoqEkNvieuyoCQzpum+vJovD0=;
        b=NXYXg9i7ApPDytAM5JwYMRybzKIfatxw70AlBjN/g+8D0UA2mcVCYn8feu8RD0sZsr
         nEkEB29+WZ94rQdc5n4uJrCJIH22FHRIU7spbl+OpixMMUJ+2iCOC7SnBZbgbzMp/aA2
         aCm1wOVfol9GLZ2Q+0rTAnjhlUoM+8fgcR+tPjVRRbvzrHUJ7HoZDf5k25Da9D9jpR+s
         kFn7MWzo7UzcWoJBFlMJ7JV5qI/nkZLTecWqUocZPOdOEMYGJV2rDwf+lzZJjbOp6fZo
         a63whjWR9mXvpkckYCi9cQxN9jb3Rxk+x2ei0lX4hFAHD7YMaymnHEuVjNR/rtVzHvqL
         pGHQ==
X-Gm-Message-State: AO0yUKV6Po3XIHDzjbO5YycDwGRbiNnGScTL2DeUwemKFrh5Vvzlcp9j
	bK93rOv4w+xdu5eBB9BdzmaOZstn7N4yqEbf
X-Google-Smtp-Source: AK7set94LyXniiBMd7f3C82UviZ4npPFdxBtzDGhPcURaNhAbWnKfLpK019DYjOH4F1bZunOQt69Ww==
X-Received: by 2002:a05:6a20:bf08:b0:b8:42b0:1215 with SMTP id gc8-20020a056a20bf0800b000b842b01215mr1267202pzb.5.1677829943997;
        Thu, 02 Mar 2023 23:52:23 -0800 (PST)
Received: from elric.localdomain (i121-112-72-48.s41.a027.ap.plala.or.jp. [121.112.72.48])
        by smtp.gmail.com with ESMTPSA id j19-20020aa783d3000000b0058bf2ae9694sm917964pfn.156.2023.03.02.23.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 23:52:23 -0800 (PST)
From: Noboru Asai <asai@sijam.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com
Subject: [PATCH] erofs: avoid useless memory allocation
Date: Fri,  3 Mar 2023 16:52:18 +0900
Message-Id: <20230303075218.675733-1-asai@sijam.com>
X-Mailer: git-send-email 2.39.2
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The variable 'vi->xattr_shared_count' could be ZERO.

Signed-off-by: Noboru Asai <asai@sijam.com>
---
 fs/erofs/xattr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 60729b1220b6..5164813a693b 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -80,6 +80,8 @@ static int init_inode_xattrs(struct inode *inode)
 
 	ih = (struct erofs_xattr_ibody_header *)(it.kaddr + it.ofs);
 	vi->xattr_shared_count = ih->h_shared_count;
+	if (!vi->xattr_shared_count)
+		goto out_unlock;
 	vi->xattr_shared_xattrs = kmalloc_array(vi->xattr_shared_count,
 						sizeof(uint), GFP_KERNEL);
 	if (!vi->xattr_shared_xattrs) {
-- 
2.39.2

