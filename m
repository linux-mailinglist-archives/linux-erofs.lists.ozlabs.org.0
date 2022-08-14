Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9C2591D96
	for <lists+linux-erofs@lfdr.de>; Sun, 14 Aug 2022 04:29:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M51b51lYYz3bXG
	for <lists+linux-erofs@lfdr.de>; Sun, 14 Aug 2022 12:29:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=fT4LvHHt;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=wata2ki@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=fT4LvHHt;
	dkim-atps=neutral
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M51Zx3vg8z2xkP
	for <linux-erofs@lists.ozlabs.org>; Sun, 14 Aug 2022 12:29:44 +1000 (AEST)
Received: by mail-pg1-x52a.google.com with SMTP id d71so3885238pgc.13
        for <linux-erofs@lists.ozlabs.org>; Sat, 13 Aug 2022 19:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=ohCBfjbW1158zTckuo5g2td6nA+gK0D+g8llsM5w8ZU=;
        b=fT4LvHHtA9v4Ie40SKUSWDr9oZJgAyeoVeyr2WpS3e8fhNVNyQ9QlAzsMztNKGl7Yi
         ZjgVRm4tEaxSBAE1FIfDgRshinbe2qlbsivqJI9eohtdwl/MRgbqBQr6BvfBj/FpVQrI
         XgldspiOE+ylb+nqwR4PkFm9QK7KGCRrGHJ7NHZqPvYV4blCdB2ygkeijp/oR6GWzJ3H
         WqKMvfB7LNfOuQHdOo5nf/O117qikiQuuBmD/tpFkFZ7Avobn5qa+2i2Ly1WJtlrjBDt
         7H5jDIsQSnH+HwXTMoKZuY5A0m8ppOWNPT1xmTukO2anY/PbD0mIyHUIVfSXf/VtDi6n
         pJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ohCBfjbW1158zTckuo5g2td6nA+gK0D+g8llsM5w8ZU=;
        b=jUVJLJuil1+ZHuiPvh/IZkVqrUkpC0PXdkvRPLxD6ZytThfwdR0lzNZpAPuGGlpQbD
         rVg7N7kTkrczFVzJRqZYlJSv/ejXAck3VTatmAkA91JwCxOTadSDUAgUdZpEDwwCd5C6
         ypqQ+N+GQ9UzDu4A5bzqpaewsb9j359XHTv0YNIrsA+2rjaekj12AEqtuot8kwfOWeAW
         KOs8aiCiSBl6Y8oYqn0Vn9aRim8FgjNfw2A88X+z5Rk+05Tjq3zIm5L57ZXj5HeQmNdu
         hGz1t0lbYsLaVeFSpiwplr7JPLHaZW5XzmCkIkKw0SQgGdWnhZLs8nHQXR4ZlJz5ICh/
         zheQ==
X-Gm-Message-State: ACgBeo0hFMqcpL3h7kcPMUzybqlwpGf72BkHE8fnwzpaEy5VT2HLlliH
	iYa9Vou6Ql/rMzia0Uqdgz2B+1jNcFp7ew==
X-Google-Smtp-Source: AA6agR4uMhyTNXJrLEWavC+Bw35k9UHKGJo2QcRoLVNRxjEh0w2lvgR4iIfcnOI65eL9V6g5JgO7zw==
X-Received: by 2002:a63:2008:0:b0:41d:7ab5:ca31 with SMTP id g8-20020a632008000000b0041d7ab5ca31mr8723538pgg.17.1660444179749;
        Sat, 13 Aug 2022 19:29:39 -0700 (PDT)
Received: from localhost.localdomain (catv-219-118-139-126.medias.ne.jp. [219.118.139.126])
        by smtp.gmail.com with ESMTPSA id j8-20020a170903024800b0016c3affe60esm4428074plh.46.2022.08.13.19.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 19:29:39 -0700 (PDT)
From: Naoto Yamaguchi <wata2ki@gmail.com>
X-Google-Original-From: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: mkfs: improvement for unprivileged container support
Date: Sun, 14 Aug 2022 11:29:14 +0900
Message-Id: <20220814022915.7964-1-naoto.yamaguchi@aisin.co.jp>
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

When developer want to use erofs at guest container rootfs, it require
to uid/gid offsetting for each files.
This patch add uid/gid offsetting feature to mkfs.erofs.

Example of how to use uid/gid offset:
 In case of lxc guest image.

 Image creation:
     mkafs.erofs --uid-offset=100000 --gid-offset=100000 file dir

 Set lxc config:
     lxc.idmap = u 0 100000 65536
     lxc.idmap = g 0 100000 65536

Signed-off-by: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>
---
 include/erofs/config.h |  1 +
 lib/inode.c            |  2 ++
 mkfs/main.c            | 18 ++++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 0d0916c..19b7a67 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -67,6 +67,7 @@ struct erofs_configure {
 	u32 c_dict_size;
 	u64 c_unix_timestamp;
 	u32 c_uid, c_gid;
+	u32 c_uid_offset, c_gid_offset;
 #ifdef WITH_ANDROID
 	char *mount_point;
 	char *target_out_path;
diff --git a/lib/inode.c b/lib/inode.c
index f192510..cc72c01 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -836,6 +836,8 @@ static int erofs_fill_inode(struct erofs_inode *inode,
 	inode->i_mode = st->st_mode;
 	inode->i_uid = cfg.c_uid == -1 ? st->st_uid : cfg.c_uid;
 	inode->i_gid = cfg.c_gid == -1 ? st->st_gid : cfg.c_gid;
+	inode->i_uid += cfg.c_uid_offset;
+	inode->i_gid += cfg.c_gid_offset;
 	inode->i_mtime = st->st_mtime;
 	inode->i_mtime_nsec = ST_MTIM_NSEC(st);
 
diff --git a/mkfs/main.c b/mkfs/main.c
index d2c9830..819b1f0 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -51,6 +51,8 @@ static struct option long_options[] = {
 	{"blobdev", required_argument, NULL, 13},
 	{"ignore-mtime", no_argument, NULL, 14},
 	{"preserve-mtime", no_argument, NULL, 15},
+	{"uid-offset", required_argument, NULL, 16},
+	{"gid-offset", required_argument, NULL, 17},
 #ifdef WITH_ANDROID
 	{"mount-point", required_argument, NULL, 512},
 	{"product-out", required_argument, NULL, 513},
@@ -97,6 +99,8 @@ static void usage(void)
 #endif
 	      " --force-uid=#         set all file uids to # (# = UID)\n"
 	      " --force-gid=#         set all file gids to # (# = GID)\n"
+	      " --uid-offset=#        add offset # to all file uids (# = id offset)\n"
+	      " --gid-offset=#        add offset # to all file gids (# = id offset)\n"
 	      " --help                display this help and exit\n"
 	      " --ignore-mtime        use build time instead of strict per-file modification time\n"
 	      " --max-extent-bytes=#  set maximum decompressed extent size # in bytes\n"
@@ -323,6 +327,20 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		case 10:
 			cfg.c_compress_hints_file = optarg;
 			break;
+		case 16:
+			cfg.c_uid_offset = strtoul(optarg, &endptr, 0);
+			if (cfg.c_uid_offset == -1 || *endptr != '\0') {
+				erofs_err("invalid uid offset %s", optarg);
+				return -EINVAL;
+			}
+			break;
+		case 17:
+			cfg.c_gid_offset = strtoul(optarg, &endptr, 0);
+			if (cfg.c_gid_offset == -1 || *endptr != '\0') {
+				erofs_err("invalid gid offset %s", optarg);
+				return -EINVAL;
+			}
+			break;
 #ifdef WITH_ANDROID
 		case 512:
 			cfg.mount_point = optarg;
-- 
2.25.1

