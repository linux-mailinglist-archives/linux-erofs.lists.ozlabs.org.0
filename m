Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 1514B2C67FF
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Nov 2020 15:35:10 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CjHGM2XWVzDrgf
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Nov 2020 01:35:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=AJZqimr/; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=I//Tn3Ec; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CjHG60Y6FzDrgV
 for <linux-erofs@lists.ozlabs.org>; Sat, 28 Nov 2020 01:34:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606487689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=xMR1e74cQ7Fu3lSwQgxGkn5J/jDyljHgi6wsjzM4+Zc=;
 b=AJZqimr/tpU4ILTOGLcxmr1V0nfDw6coGmLE9OHtcdN6OzwpdiFQykIQXvgnhjUC50s1OZ
 ZrV4l8oznGt17T+eysrdBlcP/K5mO+gazsRppGpvRxkgPtxNBp55rCOakedKXFG2COobI0
 hthwHpFuBqJ0iujxoRyfm63wzW2wmyU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606487690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=xMR1e74cQ7Fu3lSwQgxGkn5J/jDyljHgi6wsjzM4+Zc=;
 b=I//Tn3EcBtFoHX/W5sxCyDwkMq0/uNXqWa6bQfgA0dUh+g69tWb2O25uq/EY+5EXsjAKmS
 xxgkvBw58IAOq/uITizJNq9RkNRUdDsjmoTnjKaB+IbrQpmEmV6/9LTfCIo9Nm5YApqj7l
 FonIAbAoih0zzvGDb+YVxBPV1okXM4o=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-QGQ4Wx5uNjOxBCiJzBaqyw-1; Fri, 27 Nov 2020 09:34:48 -0500
X-MC-Unique: QGQ4Wx5uNjOxBCiJzBaqyw-1
Received: by mail-pf1-f199.google.com with SMTP id q22so4095959pfj.20
 for <linux-erofs@lists.ozlabs.org>; Fri, 27 Nov 2020 06:34:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=xMR1e74cQ7Fu3lSwQgxGkn5J/jDyljHgi6wsjzM4+Zc=;
 b=Q0SpNxkr8g0hdEJ8oy1DgQ0Ghu/S2oGVUIhIxEoD3eYt4NDQo6vOAtGSX1n0a9k0xE
 IRS3Izo5aQ+bYkPIiqlctzPkKf517vTi6HULTxk2klqUMu6vaoiPa7Hg8SBJxgSrQo4+
 T9j+Id4ydIZubiVV1kNF4M8EChEYB5vWAfBD4xVqKDfX9nxWH4ruTaKqXh4qG+JD+5WE
 sRN6brTrqpbTSlhGNEbQ80iYNHXthKCyH+Wk6p4VEFHItrQCg52dOyM+gqLrwZhmaIV0
 1r6Jimu1YlTp14rfvBjQuvYOKbTjKe+AF0w04Drk7jY9iRBVt2vtUawzoh4F05TTcyM8
 CREg==
X-Gm-Message-State: AOAM5336xHv9qAv3YwSortzc0WDQBXT5CvMlJGLqYapEmX2Ljyda1piI
 HClJjS1bOCmXhf5NT1v04stk2+VXWWQ0lK2E34wN92Pa2UN+edju5Ip3+Zrw9EvlpMPfJRIb+dv
 ZZKZ0MR42g6ik+9TUDqCHmofW7iUBxA6Xl393/FOdjTPe5AVU79EozHjdKloSYXqXQFIqhYN5vM
 LggQ==
X-Received: by 2002:a63:83:: with SMTP id 125mr6958964pga.423.1606487686815;
 Fri, 27 Nov 2020 06:34:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzfjADfpvHeWa03hdxqJOYzhZyGY5cd1upHB3llcgVQ57rPi3rWBRaBqllhWTx4/dsyUkg55A==
X-Received: by 2002:a63:83:: with SMTP id 125mr6958949pga.423.1606487686518;
 Fri, 27 Nov 2020 06:34:46 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id ge21sm10374664pjb.5.2020.11.27.06.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2020 06:34:46 -0800 (PST)
From: Gao Xiang <hsiangkao@redhat.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: xattr: fix OOB access due to alignment
Date: Fri, 27 Nov 2020 22:33:59 +0800
Message-Id: <20201127143359.667374-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.4
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
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

From: Gao Xiang <hsiangkao@aol.com>

erofs_buf_write_bhops can only be safely used for block-aligned
buffers, otherwise, it could write random out-of-bound data due
to buffer alignment. Such random data is meaningless but it does
harm to reproducable builds.

Fixes: 116ac0a254fc ("erofs-utils: introduce shared xattr support")
Reported-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 lib/xattr.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index 2596601..49ebb9c 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -18,6 +18,7 @@
 #include "erofs/hashtable.h"
 #include "erofs/xattr.h"
 #include "erofs/cache.h"
+#include "erofs/io.h"
 
 #define EA_HASHTABLE_BITS 16
 
@@ -522,6 +523,21 @@ static void erofs_cleanxattrs(bool sharedxattrs)
 	shared_xattrs_size = shared_xattrs_count = 0;
 }
 
+static bool erofs_bh_flush_write_shared_xattrs(struct erofs_buffer_head *bh)
+{
+	void *buf = bh->fsprivate;
+	int err = dev_write(buf, erofs_btell(bh, false), shared_xattrs_size);
+
+	if (err)
+		return false;
+	free(buf);
+	return erofs_bh_flush_generic_end(bh);
+}
+
+static struct erofs_bhops erofs_write_shared_xattrs_bhops = {
+	.flush = erofs_bh_flush_write_shared_xattrs,
+};
+
 int erofs_build_shared_xattrs_from_path(const char *path)
 {
 	int ret;
@@ -586,7 +602,7 @@ int erofs_build_shared_xattrs_from_path(const char *path)
 		free(node);
 	}
 	bh->fsprivate = buf;
-	bh->op = &erofs_buf_write_bhops;
+	bh->op = &erofs_write_shared_xattrs_bhops;
 out:
 	erofs_cleanxattrs(true);
 	return 0;
-- 
2.18.4

