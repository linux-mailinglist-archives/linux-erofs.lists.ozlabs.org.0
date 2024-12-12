Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D62089EF328
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Dec 2024 17:56:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8JX86BcNz30f8
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Dec 2024 03:56:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::52a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734022583;
	cv=none; b=nrnfmIj/Cfbz2y6SCE926r0tyNXC5xs1aMyQukNuG07Z+vFIprrggYMfhQ2hEmbwIMPJmmadjyXbVV6fVAJchMrODwC6Vm9UGJ8/CExIQkQ6Lpw6o9CdqgMvQRyqJGB3rmqmH9lL/Dla4eKGC8ddh8PW7hQrIYUK9eFXhpP2Cy29eBV4mVgewkg3z34odfjp/KmYgaWA9ATtqcsuoe6i7LxZEObAK5XdmgMUXR9yuUFHnZeH/t6AqB0lGkDbbC5mbY7neGHr/n7AM3Ogc9N0lrvLTk9a48f2sWeQtODqIer/XvdwbBmqBPQKUxY0e/HLJlxW0+BAzE5/YSqLO6gfhA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734022583; c=relaxed/relaxed;
	bh=am/6otT4dYnTRPEFJkhxCfOv0MM6WrvrX7b6o+PwCiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZDWpNwneWPWvcKPK5wylSlCCraV0LfWGHdLB4xOygIs/BcWMMlOWujRvSkS+NUR4BeSQH+0o+Rrx35j1aRjKsF++rqGqBm6gefs6cYO4zRMb1IbQPnl8rZ5MEBbJwqmcXnuCINblyDIYd2ZjupwTi8SPS6YJXKi6GKhtyr6j+yYZtqZbK0LnFb3969yEaIMpP+eLeAnYZ66zbvr8xewL5AKvueNBwGxHGF6Dv3X1MJJqmC5MbRqW5V0mSBxLtFE2dGc2CRI4XMPY3irkBCACzqgF3Y+BjM5CFESoO8dbX5eKtqe1RejnFZOf5o1c6EmNUnyRCtmJUpv+5PHTMdgpXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FnjEoY+v; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com; envelope-from=katexochen0@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FnjEoY+v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com; envelope-from=katexochen0@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8JX56VjLz30WF
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Dec 2024 03:56:20 +1100 (AEDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5cecbddb574so1417005a12.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 12 Dec 2024 08:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734022572; x=1734627372; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=am/6otT4dYnTRPEFJkhxCfOv0MM6WrvrX7b6o+PwCiU=;
        b=FnjEoY+ve3E+wRozqqGJyf58wvOIMvfz/AbDqQ5T5zRnSBfbVuyEQZqRjVBVZWaRw1
         WOi0P0y2EreRn9KK4iBSx6GhTLYokU1ttZ0jWLuSwmQIERjXsbn/3h2R8Qd0/TSLsEpd
         v8VBTs8YdDyvUBu32BD0iEiXreeK5rCV1/ox6XdDIa4ImKpvwEYqo0IXloPhe+Cduto6
         JuLGfpSEo1i/1qBfqgcc74UJ0Ig/H0znnccS/qnn/wTTFSe7ocbsouG0ez4Ey+cCjNYs
         /IDRHWRZ6KikCmz+ZmnH3FgKwtmKWpdeAj2eIfSmdNUP01ZHPy/hZr3yaA3KuYjhV8xI
         hB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734022572; x=1734627372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=am/6otT4dYnTRPEFJkhxCfOv0MM6WrvrX7b6o+PwCiU=;
        b=K5MdLJOXbWcW8dhvkPq8y9nXiX/qDcH18zJRz5hYgPZIc7FRHgI9Cgd4ytPXw1siVq
         tCbfXfYXm28GHGpUoVbWPF+6PHoMZ4VPhKN0u9oyBGwCSBuKlJvKgQVvcCk0gUM2hafd
         ZjUoJzHbUtTCqm4xOKEcFKU7UdMKNUxEFfj6mViitIovMWWnyLwnnXvG4+StVXil+pjo
         e3QVWLEyaA2EUuuJ+NA4Lh/6TUaXlO9wbeDZjUTvffAYOl4qIuDACRTUyIGT4jKVjgls
         mGHWNJ4+qQxkFvR90ipteHtCVWrEqjSbkmJ1bJ2+8jPJBzrVcbi1l6fsRVXwEsR37ur1
         lYZw==
X-Gm-Message-State: AOJu0YzC4oQmNJtOoBFP2tDW+rh9Gh+lZXY8AunbrCzzYHLmClyZD75E
	WUdy8mVTCoz6mrzZBhTnBnz6sIs5zQtjuTwU4R3Z4szAWgDjOdD9iax8EHNN
X-Gm-Gg: ASbGncsq1jcdXf9kRywFyDWfjV9VwC0/APQWkwmr46v0HMJv8NkIayDiiWQiJn4IVhw
	oZ6ziiPzggagBey9YkTqlRALeFRy04Vmk82xC/GkWI4QJNDZYgd8nX0Uo7RrVSpqxjXffTeKYlq
	g1P+QRkgOp8yNWK276lsFCVA4Axlce58bPbA6lJW7olcl2F12BDfynEtomB+u6TngGg0iXH0wew
	Ym96yJoAdeFiMQS6mNloyX7wFibkRh5dYjwr85u5m8/3Otw2QxTSWKIL7KVfKdMvv8X
X-Google-Smtp-Source: AGHT+IH53mrgmjCcWJu3rcCPQC0BXtP/D7nKJzQLX17dBsjZIX2tMBxbyCSrWIhkWAEHTn7JClS0UA==
X-Received: by 2002:a05:6402:210f:b0:5d0:e3fa:17ca with SMTP id 4fb4d7f45d1cf-5d632392822mr1250618a12.15.1734022571588;
        Thu, 12 Dec 2024 08:56:11 -0800 (PST)
Received: from np14s.fritz.box ([2a01:41e3:29fd:6800:c136:e024:bd3c:259c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a49dc6sm10473451a12.31.2024.12.12.08.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 08:56:11 -0800 (PST)
From: Paul Meyer <katexochen0@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3] erofs-utils: add --hard-dereference option
Date: Thu, 12 Dec 2024 17:48:07 +0100
Message-ID: <20241212165550.58756-1-katexochen0@gmail.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Paul Meyer <katexochen0@gmail.com>, Leonard Cohnen <leonard.cohnen@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add option --hard-dereference to dereference hardlinks when
creating an image. Instead of reusing the inode, hardlinks are added
as separate inodes. This is useful for reproducible builds, when the
rootfs is space-optimized using hardlinks on some machines, but not on
others.

Co-authored-by: Leonard Cohnen <leonard.cohnen@gmail.com>
Signed-off-by: Paul Meyer <katexochen0@gmail.com>
---
v3: Fix commit title and body, fix usage ordering.
v2: https://lore.kernel.org/all/20241212135630.15811-1-katexochen0@gmail.com/
v1: https://lore.kernel.org/all/20241211150734.97830-1-katexochen0@gmail.com/
---

 include/erofs/config.h | 1 +
 lib/inode.c            | 2 +-
 mkfs/main.c            | 5 +++++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index cff4cea..bb03e70 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -58,6 +58,7 @@ struct erofs_configure {
 	bool c_extra_ea_name_prefixes;
 	bool c_xattr_name_filter;
 	bool c_ovlfs_strip;
+	bool c_hard_dereference;
 
 #ifdef HAVE_LIBSELINUX
 	struct selabel_handle *sehnd;
diff --git a/lib/inode.c b/lib/inode.c
index 7e5c581..0404a8d 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1141,7 +1141,7 @@ static struct erofs_inode *erofs_iget_from_srcpath(struct erofs_sb_info *sbi,
 	 * hard-link, just return it. Also don't lookup for directories
 	 * since hard-link directory isn't allowed.
 	 */
-	if (!S_ISDIR(st.st_mode)) {
+	if (!S_ISDIR(st.st_mode) && (!cfg.c_hard_dereference)) {
 		inode = erofs_iget(st.st_dev, st.st_ino);
 		if (inode)
 			return inode;
diff --git a/mkfs/main.c b/mkfs/main.c
index d422787..b94923f 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -85,6 +85,7 @@ static struct option long_options[] = {
 	{"mkfs-time", no_argument, NULL, 525},
 	{"all-time", no_argument, NULL, 526},
 	{"sort", required_argument, NULL, 527},
+	{"hard-dereference", no_argument, NULL, 528},
 	{0, 0, 0, 0},
 };
 
@@ -174,6 +175,7 @@ static void usage(int argc, char **argv)
 		" --force-gid=#         set all file gids to # (# = GID)\n"
 		" --uid-offset=#        add offset # to all file uids (# = id offset)\n"
 		" --gid-offset=#        add offset # to all file gids (# = id offset)\n"
+		" --hard-dereference    dereference hardlinks, add links as separate inodes\n"
 		" --ignore-mtime        use build time instead of strict per-file modification time\n"
 		" --max-extent-bytes=#  set maximum decompressed extent size # in bytes\n"
 		" --mount-point=X       X=prefix of target fs path (default: /)\n"
@@ -846,6 +848,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			if (!strcmp(optarg, "none"))
 				erofstar.try_no_reorder = true;
 			break;
+		case 528:
+			cfg.c_hard_dereference = true;
+			break;
 		case 'V':
 			version();
 			exit(0);
-- 
2.47.0

