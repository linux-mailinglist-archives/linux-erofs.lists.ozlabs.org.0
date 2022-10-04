Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F035F47FF
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Oct 2022 19:01:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MhkWj1tbRz305p
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Oct 2022 04:01:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=nUSHZagl;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=wata2ki@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=nUSHZagl;
	dkim-atps=neutral
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MhkWZ15Bhz2x9C
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Oct 2022 04:01:44 +1100 (AEDT)
Received: by mail-pf1-x433.google.com with SMTP id i6so13666940pfb.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 04 Oct 2022 10:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=dxz2QFHwJ+dEQPCpgJlqBh90qAA9wVOu3dWJcE9i0v4=;
        b=nUSHZaglpFWyIDUDLclsWW92zCVcuiqM5ACQlKASYXQ9uLiR8p49t8nV2ChwoKuJDr
         Qc253MSxO0E47mxSTKPacHrwLoRUK94GcESeaO3LSlH1MK/P8RYa8yKnLxfutmqzgL6V
         SuKitBTfvcbGBgvLShQLZI+vNYWjsYz7eQII2g92z/r1NcX6PCqi+4ClOA9OD2LaJkXv
         OGIQzX8QR7+x/nvRLYooIVjf6h6MFm31lMDNCu3+4qHNwIGWUBUQOAUBlO3eHORVNe8C
         u+EDr//zqwROx9ygvK4tG7ty5GS2OpWo8lVLbUr/46wSTsKd8nBumulcsIsOJhz75Dro
         hubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dxz2QFHwJ+dEQPCpgJlqBh90qAA9wVOu3dWJcE9i0v4=;
        b=jBePJt+HmJBZxmBE7U1Z+WmA5feBAOeO4GG2dwX6IXsFuURI2H6NL3gz9YisjBgOcm
         moWkx++TuZaFVSL2+5irbFXhsOJ41wnPjVmklMWd/uIhz6/qqcGB8uCHXXt3iP1pa/HP
         NodG0IYztbn15KvcCWXU/OsHH4HLiRs9cgK8lV8R9pfRtqwZfMn8uTyKVytae8R9Xju+
         BFA4qUJpE+tcJGm57DkfpL9m2A3FYgyujI/9JfVXrFd/QQIAamkEu5vJBOvESvzKpKaZ
         nSK94Y8PO7fT+ONHHuiCfdemJbUL0tKt7JKSfw4yDwFZu4fEwmcrfKHPmWkF8Jiqna0t
         yixw==
X-Gm-Message-State: ACrzQf10srHUHjslv8QQSwYu95Tei7wb7+oIgzbkHtBlVR9Fl4oyope1
	6Qh7VUAW2BuZJ9YnnFOpL2lx07kJR6E=
X-Google-Smtp-Source: AMsMyM7E2TrYMRDXVGD93blpeLpR6E+OLPegI7hYtofF7I77jIs5qGwrcSkKhhdLjMk1QJ7QDsegGw==
X-Received: by 2002:a63:4f19:0:b0:43b:ddc9:387c with SMTP id d25-20020a634f19000000b0043bddc9387cmr23444493pgb.333.1664902901955;
        Tue, 04 Oct 2022 10:01:41 -0700 (PDT)
Received: from localhost.localdomain (ZN206210.ppp.dion.ne.jp. [222.10.206.210])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090a804500b00205e1f77472sm8274854pjw.28.2022.10.04.10.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 10:01:41 -0700 (PDT)
From: Naoto Yamaguchi <wata2ki@gmail.com>
X-Google-Original-From: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3] erofs-utils: mkfs: Add volume-name setting support
Date: Wed,  5 Oct 2022 02:01:15 +0900
Message-Id: <20221004170115.11622-1-naoto.yamaguchi@aisin.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YzxkE6rN1KcZmF09@debian>
References: <YzxkE6rN1KcZmF09@debian>
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
  mkfs.erofs -L volume-label image-fn dir

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

