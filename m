Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D57D077CB1A
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Aug 2023 12:24:38 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=oRF4JTLc;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RQ6nw4tQTz3cG1
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Aug 2023 20:24:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=oRF4JTLc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RQ6nn6Fbyz30Jy
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Aug 2023 20:24:28 +1000 (AEST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68859ba3a93so115007b3a.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 15 Aug 2023 03:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692095066; x=1692699866;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Edq1N0CL7JoOw+DTMfsXWAgtFyBFvFT53ymguLCnbM0=;
        b=oRF4JTLcaDR9AlEb8HbK8R+9+dQuOMqGpgtJT6gIM3rxzME6FHEUWb2yLlExJevOct
         3sbKi8nVd2yv/eGLKfWneUULBukjhAQjD6IxKI63OIHmsyHMjHESHIbfIg//eyx2/g9X
         hgS+Avd0fgAyNy1O7mRe2pwXQD1n9ijQ1zIUVqCmAqE92M/p0ZwpA+r1Pa/cEVZMufya
         8EXJbLeOs+wHaF5PaoD5dIUxK3kHlzgLjjFZigHBTRuWgMpi96RSnMNXigk45rTyIF/t
         vkRauLJykGMZn5fdCFLLoJkLI8MZUuQddXZk7TzNwQ/+BJNpwxXWjgXiKYSofQHWv+oG
         S7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692095066; x=1692699866;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Edq1N0CL7JoOw+DTMfsXWAgtFyBFvFT53ymguLCnbM0=;
        b=A3x00VLCUBzalBSRcKBmMqAic+LID2qKxMcu3tMWgba7Gl0nuM4H166XdDsZzEJrLL
         aY5Z+jQicatbIutPDXde80Ahc/d23NBzHA5GMcwAfDjdzGQ+V2uN3YAJxmGlW+LB+MA+
         bA0S6j0yuxEs3UAnHmTy3NmZg9zGJnzFOSEmd0in03/kP4DZaSMnxpWBsazvpodNQDFl
         QC8hUcXh2kX3z2urxJzaOtr322KgOxSZY9UG9jyu5htfqFsg12xUl1KNx+J1DxoFPI0P
         /k0z/vUnCS1hiZNG/FplIo1ZqtSX7O25WHl28Lgl2BUtPTEewR4/iwrnvkTvMe5h3yHW
         Hefw==
X-Gm-Message-State: AOJu0YwLIt4yRUva4I95+gyxf6mIXhB03gKyLRWcrCUtP1Ao2qStwky0
	MFVNarzrZTQiMZy9uxv/I9tX2PweNDI=
X-Google-Smtp-Source: AGHT+IFx4UqHf0tPYpkeBUOsANymaE+toPU1aR2csaYk/s1WfriKQ77BbPKEi8Ke3d9P6Iz3ZmBFiw==
X-Received: by 2002:a05:6a00:b4d:b0:668:69fa:f78f with SMTP id p13-20020a056a000b4d00b0066869faf78fmr11281218pfo.1.1692095065601;
        Tue, 15 Aug 2023 03:24:25 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.163])
        by smtp.gmail.com with ESMTPSA id s82-20020a632c55000000b005579f12a238sm9885351pgs.86.2023.08.15.03.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 03:24:25 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] AOSP: erofs-utils: add missing sbi argument to erofs_blknr in block list
Date: Tue, 15 Aug 2023 18:24:05 +0800
Message-Id: <20230815102405.19486-1-zbestahu@gmail.com>
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
Cc: Yue Hu <huyue2@coolpad.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

Commit fc30780ebf90 ("erofs-utils: lib: avoid global sbi dependencies
(take 1)") updated the macro erofs_blknr by adding sbi argument.

Fixes: fc30780ebf90 ("erofs-utils: lib: avoid global sbi dependencies (take 1)")
Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 lib/block_list.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/block_list.c b/lib/block_list.c
index 896fb01..f78381d 100644
--- a/lib/block_list.c
+++ b/lib/block_list.c
@@ -95,7 +95,7 @@ void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
 		return;
 
 	/* XXX: another hack, which means it has been outputed before */
-	if (erofs_blknr(inode->i_size)) {
+	if (erofs_blknr(inode->sbi, inode->i_size)) {
 		if (blkaddr == NULL_ADDR)
 			fprintf(block_list_fp, "\n");
 		else
-- 
2.17.1

