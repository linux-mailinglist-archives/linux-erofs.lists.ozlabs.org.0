Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9A46A954A
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Mar 2023 11:33:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PSkp36wj3z3cf8
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Mar 2023 21:33:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sijam-com.20210112.gappssmtp.com header.i=@sijam-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=Q3nX4EEC;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=sijam.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=asai@sijam.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20210112.gappssmtp.com header.i=@sijam-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=Q3nX4EEC;
	dkim-atps=neutral
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PSknx2DqLz3bfp
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Mar 2023 21:33:09 +1100 (AEDT)
Received: by mail-pj1-x1031.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso1806268pjs.3
        for <linux-erofs@lists.ozlabs.org>; Fri, 03 Mar 2023 02:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sijam-com.20210112.gappssmtp.com; s=20210112; t=1677839586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fi+0j+9STZugY46eSLVm9PvCz4mi2EAfoJnGB3oo50E=;
        b=Q3nX4EECfbjk8+/6HGS0Oh83KVw+EXRMPQYkoytHuYI+7URInHwy8N7q/EulUzeUDh
         l4GLFzi1TgJEf/HNS3qR7F7hl9oB5W+qMURUBkpsQWutWRoWOGtmsJM/MLnszhXmzY4R
         mBJ7tUHVk8UFZPvF+zJpHZBJJkb44Wc56Gtv2zSldOhyoNGf69FBdu2UoP02EvPV+FTD
         tM9yC7h2UOrPyvOkoy+C24tN8jT78yeHx2iZI4hHX+G22Qat5OlZWZcek8+gCFU1uHiI
         3/1weIP6WxKIXEuZZT+uQj1mN3q+hoTKfvGgZXEPDHuEJHrKQmFHytI1x364sUHya/sp
         ID3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677839586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fi+0j+9STZugY46eSLVm9PvCz4mi2EAfoJnGB3oo50E=;
        b=eCgA6GeJGDx8ZDih3CJswUqdv1tB8ouvm4/whu+loeeNhNF6QvW1YJpX/TQcCUMcnO
         0nGrJYcW0tDWcEtdHiotn7d2Xb/zxA335mviPZHezgTYLam+SfqVwfFEPtpXNDVUvDXX
         spBLLbfM84coTcG+W78NuHEqZhYAfPkYCThib75Og3BxRfidnWWusgXvjUpasLyRy1fx
         Pi0wC0YS+etexfchW5lPy2cvB+hiTBLfj1KsGSgQeVbus5a4C9XoQRKfZFOQc/ELIhHs
         RUkn3VZ4mu8KjpUx4S9JK+NxR/m+KhamxNB2A0Gdp6nSOrHYOsUIsEAyUtygpfM0M0Si
         FUjA==
X-Gm-Message-State: AO0yUKWTIT8s31DM5/JbTkeOSxvIIeTI2bJc9Sv7qRTB8eCvcDsGAfhV
	Ff9rxfNzAbXAJLOyJFcywYZvdQ==
X-Google-Smtp-Source: AK7set/+8aCJEaqYZvcwmku029DXhTK4srlPGeF5QTVNOqsv5qmnOmXFKCPwK8CnL7iKFHxqYI8GsQ==
X-Received: by 2002:a17:90b:1a91:b0:237:c379:d3b9 with SMTP id ng17-20020a17090b1a9100b00237c379d3b9mr1226431pjb.24.1677839586203;
        Fri, 03 Mar 2023 02:33:06 -0800 (PST)
Received: from elric.localdomain (i121-112-72-48.s41.a027.ap.plala.or.jp. [121.112.72.48])
        by smtp.gmail.com with ESMTPSA id v13-20020a63f20d000000b00502e7115cbdsm1216200pgh.51.2023.03.03.02.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 02:33:05 -0800 (PST)
From: Noboru Asai <asai@sijam.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com
Subject: [PATCH v2] erofs: avoid useless memory allocation
Date: Fri,  3 Mar 2023 19:32:41 +0900
Message-Id: <20230303103241.737502-1-asai@sijam.com>
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
 fs/erofs/xattr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 60729b1220b6..58069bf3ba25 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -80,6 +80,8 @@ static int init_inode_xattrs(struct inode *inode)
 
 	ih = (struct erofs_xattr_ibody_header *)(it.kaddr + it.ofs);
 	vi->xattr_shared_count = ih->h_shared_count;
+	if (!vi->xattr_shared_count)
+		goto out_put_metabuf;
 	vi->xattr_shared_xattrs = kmalloc_array(vi->xattr_shared_count,
 						sizeof(uint), GFP_KERNEL);
 	if (!vi->xattr_shared_xattrs) {
@@ -110,6 +112,7 @@ static int init_inode_xattrs(struct inode *inode)
 			le32_to_cpu(*(__le32 *)(it.kaddr + it.ofs));
 		it.ofs += sizeof(__le32);
 	}
+out_put_metabuf:
 	erofs_put_metabuf(&it.buf);
 
 	/* paired with smp_mb() at the beginning of the function. */
-- 
2.39.2

