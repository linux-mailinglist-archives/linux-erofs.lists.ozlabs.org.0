Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB1D47C17A
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Dec 2021 15:28:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JJJjY6mKYz2xv8
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Dec 2021 01:28:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1640096929;
	bh=DMrErtHi5MonYL8dQYxSquG+q1c2qTnpjf2pkhqRma4=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=bD+QPytl7v+FnT6+4kXZtTruT9k8xfOVJkZaR7AQYGgXglOurPJMFsGrH5RBzqpTI
	 QePPtLwIUsHXm6qJjULiYZn7NDZ8wHTip5rqLs+bdAuaR8D2LchEjBrLDP1Xd5V6VZ
	 Pu8+MmrWBRGawBy+s8I0QcXUleX+LPTc9eVz7NCViOu5o08QyMSCuColgETlSG+ycA
	 MrXP7Hp97PU408O0gX7E5qxUAggQZ6tRYvQWRQHahHJP77AfuA+qWLo4X3qqy90ciT
	 s7rhN/3/Xfa00B8BYcj/RUQ9WsCabBN/X+7+Ylu8qBLwjkmx8G2RL5+k37cIEjMMqc
	 Sdkl5UULg1LJQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--zhangkelvin.bounces.google.com
 (client-ip=2607:f8b0:4864:20::749; helo=mail-qk1-x749.google.com;
 envelope-from=3k-tbyqskc3gvdwjcgahrejckkcha.ykihejqt-ankboheopo.kvhwxo.knc@flex--zhangkelvin.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=SbKA9Py3; dkim-atps=neutral
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com
 [IPv6:2607:f8b0:4864:20::749])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JJJjN4HkBz2xsk
 for <linux-erofs@lists.ozlabs.org>; Wed, 22 Dec 2021 01:28:39 +1100 (AEDT)
Received: by mail-qk1-x749.google.com with SMTP id
 bj32-20020a05620a192000b0046dcca212b6so8397807qkb.6
 for <linux-erofs@lists.ozlabs.org>; Tue, 21 Dec 2021 06:28:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=DMrErtHi5MonYL8dQYxSquG+q1c2qTnpjf2pkhqRma4=;
 b=ox3MoHcNkas2J8OJjZVdtW0Tfk+iy2Aza+v2qNk4zRoixyra0P7xny+Jcs12/ioWLR
 NEt433Pz0HIz//H7MkyphHNoT1uSLPLLdXqM4YKsh9yU9rh+IFTL24AYgOdYJI7CUyy2
 n7XQGA1TnnfsJQAqHW911yPe4ENnr9NuLrZ8dF13QkznS40KHphaw/ebVCVTyssQKqpD
 GHNCtXUQBsAEGCuzvKPIHCTUzFMckAJNghOFrG0n9cbo6KAFaK+lC8k9SpxVcGQTJ4i7
 6DQ9z5mgLSp9VsYV1kTHFUkx/qH5unwTFTU4RpYLrQmNQk7a/9LtjhRm+1bxQ9VeCYrh
 IIcg==
X-Gm-Message-State: AOAM531DaIUtbsvJhShy5ihjzLtoMOn/ZlE2Nafaxmc2qfkPpUiTKDUs
 /cHFv8V6+sQE7E/cDlrYEaN4CxmOmTWHaWxr08h0OJk72qzBp9gsu4BuReJLf512MFpP5CSr8c+
 OMh0so0Fp0BOlcjqv63XbBp5TEv1tShw5ebLyBBU0b4LkL7iDiM0ijd6apnGQGm3FcgOhIrKShf
 8ixet4dDo=
X-Google-Smtp-Source: ABdhPJw4xsdXARFg39cQbKwWg4pYbqfYyNr3261PzaQgDDuHr/dzarMCaEAKuKnhR57VXlaRNOUq58TvIwTaEjapGw==
X-Received: from zhangkelvin-big.c.googlers.com
 ([fda3:e722:ac3:cc00:14:4d90:c0a8:1f4a])
 (user=zhangkelvin job=sendgmr) by 2002:a05:622a:64e:: with SMTP id
 a14mr2366429qtb.496.1640096915925; Tue, 21 Dec 2021 06:28:35 -0800 (PST)
Date: Tue, 21 Dec 2021 06:28:29 -0800
In-Reply-To: <20211221142829.4123631-1-zhangkelvin@google.com>
Message-Id: <20211221142829.4123631-2-zhangkelvin@google.com>
Mime-Version: 1.0
References: <20211221142829.4123631-1-zhangkelvin@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v1 2/2] Add API to get on disk size of an inode
To: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
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
From: Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Kelvin Zhang <zhangkelvin@google.com>
Cc: Kelvin Zhang <zhangkelvin@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Change-Id: I60fa9346737b14418bd3fa1d12f760aaf0a0cca5
Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
---
 dump/main.c              |  4 ++--
 include/erofs/internal.h |  2 ++
 lib/data.c               | 21 +++++++++++++++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 71b44b4..cdde561 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -175,7 +175,7 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
 	return 0;
 }
 
-static int erofs_get_occupied_size(struct erofs_inode *inode,
+static int dump_get_occupied_size(struct erofs_inode *inode,
 		erofs_off_t *size)
 {
 	*size = 0;
@@ -291,7 +291,7 @@ static int erofs_read_dirent(struct erofs_dirent *de,
 		return err;
 	}
 
-	err = erofs_get_occupied_size(&inode, &occupied_size);
+	err = dump_get_occupied_size(&inode, &occupied_size);
 	if (err) {
 		erofs_err("get file size failed\n");
 		return err;
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 947304f..8f13e69 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -320,6 +320,8 @@ int erofs_pread(struct erofs_inode *inode, char *buf,
 int erofs_map_blocks(struct erofs_inode *inode,
 		struct erofs_map_blocks *map, int flags);
 int erofs_map_dev(struct erofs_sb_info *sbi, struct erofs_map_dev *map);
+int erofs_get_occupied_size(const struct erofs_inode *inode,
+			    erofs_off_t *size);
 /* zmap.c */
 int z_erofs_fill_inode(struct erofs_inode *vi);
 int z_erofs_map_blocks_iter(struct erofs_inode *vi,
diff --git a/lib/data.c b/lib/data.c
index 27710f9..92e54b5 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -320,3 +320,24 @@ int erofs_pread(struct erofs_inode *inode, char *buf,
 	}
 	return -EINVAL;
 }
+
+int erofs_get_occupied_size(const struct erofs_inode *inode,
+			    erofs_off_t *size)
+{
+	*size = 0;
+	switch (inode->datalayout) {
+	case EROFS_INODE_FLAT_INLINE:
+	case EROFS_INODE_FLAT_PLAIN:
+	case EROFS_INODE_CHUNK_BASED:
+		*size = inode->i_size;
+		break;
+	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
+	case EROFS_INODE_FLAT_COMPRESSION:
+		*size = inode->u.i_blocks * EROFS_BLKSIZ;
+		break;
+	default:
+		erofs_err("unknown datalayout");
+		return -1;
+	}
+	return 0;
+}
-- 
2.34.1.307.g9b7440fafd-goog

