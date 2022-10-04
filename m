Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B625F47D8
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Oct 2022 18:44:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mhk7K3gHbz306m
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Oct 2022 03:44:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ls3k4Qm4;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=wata2ki@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ls3k4Qm4;
	dkim-atps=neutral
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mhk7B001Lz2xmw
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Oct 2022 03:44:05 +1100 (AEDT)
Received: by mail-pl1-x62e.google.com with SMTP id b2so8252071plc.7
        for <linux-erofs@lists.ozlabs.org>; Tue, 04 Oct 2022 09:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=bPBvIiMgfl9eKo3sZct7rFw/YDnr+iXWZI1FIFPOrJU=;
        b=ls3k4Qm49IVQPBpBiG7zPaIIJg+A8tVNRssPa8Aj0cVFznbwRUjsTzBFg7LngkmLZS
         3mPDV7MS+eUfoLvmMtpJ1VgezbtSmpQ4THgZnDegsqK65x/wO9BF84bktYJ20S4b0D8B
         nIy2GI0KLYPokRgrhFhR9MWGmm8nUX/FHobR/fv6Ul6tDxJ6qHqERwaDJFsb1UnVl6XO
         Lo+5n9hW3ByTmjlsIhVRun4rQB8HnqG3pYdqhSotVT/ZMbE96GTyi+nIEMXb4M0AfDJy
         8N8PVfQF9+cwNJWYNz7gEHqRM4ycjhLONeiVC4ipFD0/9WD4glGGooQf/n3f21JDOldu
         SyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bPBvIiMgfl9eKo3sZct7rFw/YDnr+iXWZI1FIFPOrJU=;
        b=T0gXtLZN8RYvpfnN8YSyoxQ+mZnMWCKO43p4slxhSHKlB8/6cmaELMPZ+W+/Gv2+NI
         uTUMiQz+eb4MLqmPzhNgl3aR3DUtLqxopm4yj50bQwc8YWlDUJFdUnGW1yjjyOHdCaVX
         d8aRYabFOGQEnyeyUycah/T0uOQimQ43DpxvVQXPaaszluTPiR3EKCKy3/dbtJorQwOH
         LniEslS7SdYwxzlEoXfzZk4ThMmrlBQsArv/M6nAeh2YMEwG+QCWGo9ZuWyY9ffwc8Fw
         RBGsEitQqK9L+1s/Y9G95WIwBY00rWa2GEOrFPWb8pglfsP7AZnT5yedohkTyM697Myk
         Ft6g==
X-Gm-Message-State: ACrzQf0luPjJ4d45VVkmJmZCrXNB6lTJDt2Y5PLDy/rUBY9n7lALS4xM
	YkD0magUuUu3O6Djd85wCFwfV4LfDsI=
X-Google-Smtp-Source: AMsMyM4aSQ+bPYFvXmcZNQGzIkbtTBY8+QhTaiC4xCGJnVIAgoeatswZQBK5GXWnPJyt4hzEHlXzcQ==
X-Received: by 2002:a17:902:ce82:b0:17a:234:cae6 with SMTP id f2-20020a170902ce8200b0017a0234cae6mr28283793plg.174.1664901841913;
        Tue, 04 Oct 2022 09:44:01 -0700 (PDT)
Received: from localhost.localdomain (ZN206210.ppp.dion.ne.jp. [222.10.206.210])
        by smtp.gmail.com with ESMTPSA id o2-20020a625a02000000b0054cd16c9f6bsm9378415pfb.200.2022.10.04.09.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 09:44:01 -0700 (PDT)
From: Naoto Yamaguchi <wata2ki@gmail.com>
X-Google-Original-From: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: Add volume-name setting support
Date: Wed,  5 Oct 2022 01:43:24 +0900
Message-Id: <20221004164324.11481-1-naoto.yamaguchi@aisin.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YzxgPKoi9Q1scK3N@debian>
References: <YzxgPKoi9Q1scK3N@debian>
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
Cc: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The erofs_super_block has volume_name field.  On the other hand,
mkfs.erofs is not supporting to set volume name.
This patch add volume-name setting support to mkfs.erofs.
Option keyword is similar to mkfs.vfat.

usage:
  mkfs.erofs -n volume-name image-fn dir

Signed-off-by: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>
---
 include/erofs/internal.h |  1 +
 man/mkfs.erofs.1         |  5 +++++
 mkfs/main.c              | 13 ++++++++++++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 2e0aae8..7dc42eb 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -92,6 +92,7 @@ struct erofs_sb_info {
 	u64 inos;
 
 	u8 uuid[16];
+	char volume_name[16];
 
 	u16 available_compr_algs;
 	u16 lz4_max_distance;
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 11e8323..b65d01b 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -66,6 +66,11 @@ Pack the tail part (pcluster) of compressed files into its metadata to save
 more space and the tail part I/O. (Linux v5.17+)
 .RE
 .TP
+.BI "\-L " volume-label
+Set the volume label for the filesystem to
+.IR volume-label .
+The maximum length of the volume label is 16 bytes.
+.TP
 .BI "\-T " #
 Set all files to the given UNIX timestamp. Reproducible builds requires setting
 all to a specific one.
diff --git a/mkfs/main.c b/mkfs/main.c
index 594ecf9..08a4215 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -84,6 +84,7 @@ static void usage(void)
 	      " -zX[,Y]               X=compressor (Y=compression level, optional)\n"
 	      " -C#                   specify the size of compress physical cluster in bytes\n"
 	      " -EX[,...]             X=extended options\n"
+	      " -L volume-label        set the volume label (max 16 bytes).\n"
 	      " -T#                   set a fixed UNIX timestamp # to all files\n"
 #ifdef HAVE_LIBUUID
 	      " -UX                   use a given filesystem UUID\n"
@@ -212,7 +213,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 	int opt, i;
 	bool quiet = false;
 
-	while ((opt = getopt_long(argc, argv, "C:E:T:U:d:x:z:",
+	while ((opt = getopt_long(argc, argv, "C:E:L:T:U:d:x:z:",
 				  long_options, NULL)) != -1) {
 		switch (opt) {
 		case 'z':
@@ -255,6 +256,15 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			if (opt)
 				return opt;
 			break;
+
+		case 'L':
+			if (optarg == NULL || strlen(optarg) > 16) {
+				erofs_err("invalid volume label");
+				return -EINVAL;
+			}
+			strncpy(sbi.volume_name, optarg, 16);
+			break;
+
 		case 'T':
 			cfg.c_unix_timestamp = strtoull(optarg, &endptr, 0);
 			if (cfg.c_unix_timestamp == -1 || *endptr != '\0') {
@@ -483,6 +493,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 	sb.blocks       = cpu_to_le32(*blocks);
 	sb.root_nid     = cpu_to_le16(root_nid);
 	memcpy(sb.uuid, sbi.uuid, sizeof(sb.uuid));
+	memcpy(sb.volume_name, sbi.volume_name, sizeof(sb.volume_name));
 
 	if (erofs_sb_has_compr_cfgs())
 		sb.u1.available_compr_algs = sbi.available_compr_algs;
-- 
2.25.1

