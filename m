Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB385F4715
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Oct 2022 18:03:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MhjDY57rSz308b
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Oct 2022 03:03:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=aeEJfeWp;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=wata2ki@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=aeEJfeWp;
	dkim-atps=neutral
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MhjDQ6bhlz2xyB
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Oct 2022 03:03:32 +1100 (AEDT)
Received: by mail-pj1-x102c.google.com with SMTP id h8-20020a17090a054800b00205ccbae31eso19009683pjf.5
        for <linux-erofs@lists.ozlabs.org>; Tue, 04 Oct 2022 09:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=IMlIxpnTn221NIee6N3s7pC9GdPl77Gi2wsRqI13/Ek=;
        b=aeEJfeWpxmK94dTufueO8DJRAu6Yoec8SQ/HezQyFtiJOXLi1wpKiR4zdkS/9hoBgF
         YD6ei6n+PxlGPdVBL6ka+gwHvkPfAu2lHlnMQ89cGkWRDJ49VLm/iwR8N1d/HbooRuHv
         n/w+ad3tlcs12qa2k4Di+EWwIJVDynwfHeBvxIHStJKmMMH8b56plrI9KPb70k1OQupw
         B46PWM6r2Gh71TrHxP+2Ey3QU+lm08j5i55xrmja/xduCF27txpx5BIIGxpBAwoZrTly
         pjh/5Yidf+gDlMYug7waZp+ASalppR3tAzTwqwHg1M8a1o1WcbZWcv6cVCsbij9bTroe
         XP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=IMlIxpnTn221NIee6N3s7pC9GdPl77Gi2wsRqI13/Ek=;
        b=CxdbU+U9g4qGQzBYANYLwHdF2a2QdqA8GgIZLatsrHwMbDQnDsMKEObmp35P68dXCE
         b+vMtvOdqUx6a6ZhR9J5E+oEwG9//1X5oDWz3sCMk0I4DmdgwMiGzcHeZxztDY9HWiVM
         zQN837lzGRMLtB5APxkOLk4F70BqcfjqY+ybxe8oJK9VtxjD6++cb0rJnUnpqoISoi1V
         C9yShiJNu4AfbRavo28j6wyqvIdu/bk312iO1M0JQc7GWteZLNHxJXLV9j52vk06aNDa
         RSpgC9MJGcaGXlo0OPWMyna4UFarHDqkg2nFa94U8laQPJ0ZL0ew5+kragSmT5MwDfP2
         fBjg==
X-Gm-Message-State: ACrzQf2jWLldn6qW/eFQwoNeWvMy1HR1RBx5WqIpNN9xwfbSNmDJTRuR
	cL/FpEeh8+SsWkvUOo7L7w8YSCukJcw=
X-Google-Smtp-Source: AMsMyM6HOnm3OgkbEspfl42TOXqoFhx7y9eKx0Bw3asAPIus1DSZZ/XnIGen4zOhW7HNRYkeFmURrA==
X-Received: by 2002:a17:903:11c4:b0:178:634b:1485 with SMTP id q4-20020a17090311c400b00178634b1485mr26637651plh.142.1664899410513;
        Tue, 04 Oct 2022 09:03:30 -0700 (PDT)
Received: from localhost.localdomain (ZN206210.ppp.dion.ne.jp. [222.10.206.210])
        by smtp.gmail.com with ESMTPSA id nd6-20020a17090b4cc600b00205ec23b392sm5246172pjb.12.2022.10.04.09.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 09:03:29 -0700 (PDT)
From: Naoto Yamaguchi <wata2ki@gmail.com>
X-Google-Original-From: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: Add volume-name setting support
Date: Wed,  5 Oct 2022 01:02:37 +0900
Message-Id: <20221004160237.10849-1-naoto.yamaguchi@aisin.co.jp>
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
 man/mkfs.erofs.1         |  4 ++++
 mkfs/main.c              | 13 ++++++++++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

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
index 11e8323..fb98505 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -32,6 +32,10 @@ big pcluster feature if needed (Linux v5.13+).
 Specify the level of debugging messages. The default is 2, which shows basic
 warning messages.
 .TP
+.BI "\-n " volume-name
+Set the volume name for the filesystem to volume-name.  The maximum length of
+the volume name is 16 bytes.
+.TP
 .BI "\-x " #
 Specify the upper limit of an xattr which is still inlined. The default is 2.
 Disable storing xattrs if < 0.
diff --git a/mkfs/main.c b/mkfs/main.c
index 594ecf9..613ee46 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -80,6 +80,7 @@ static void usage(void)
 	fputs("usage: [options] FILE DIRECTORY\n\n"
 	      "Generate erofs image from DIRECTORY to FILE, and [options] are:\n"
 	      " -d#                   set output message level to # (maximum 9)\n"
+	      " -n volume-name        set the volume name (max 16 bytes).\n"
 	      " -x#                   set xattr tolerance to # (< 0, disable xattrs; default 2)\n"
 	      " -zX[,Y]               X=compressor (Y=compression level, optional)\n"
 	      " -C#                   specify the size of compress physical cluster in bytes\n"
@@ -212,7 +213,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 	int opt, i;
 	bool quiet = false;
 
-	while ((opt = getopt_long(argc, argv, "C:E:T:U:d:x:z:",
+	while ((opt = getopt_long(argc, argv, "C:E:T:U:d:n:x:z:",
 				  long_options, NULL)) != -1) {
 		switch (opt) {
 		case 'z':
@@ -241,6 +242,14 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			cfg.c_dbg_lvl = i;
 			break;
 
+		case 'n':
+			if (optarg == NULL || strlen(optarg) > 16) {
+				erofs_err("invalid volume name");
+				return -EINVAL;
+			}
+			strncpy(sbi.volume_name, optarg, 16);
+			break;
+
 		case 'x':
 			i = strtol(optarg, &endptr, 0);
 			if (*endptr != '\0') {
@@ -255,6 +264,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			if (opt)
 				return opt;
 			break;
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

