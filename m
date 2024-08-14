Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D24951E9F
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2024 17:33:28 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Iwa431p6;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WkXMp5BhJz2yY1
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Aug 2024 01:33:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Iwa431p6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=wata2ki@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WkXMk0vW5z2yQG
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Aug 2024 01:33:20 +1000 (AEST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-7106cf5771bso5144182b3a.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 14 Aug 2024 08:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723649595; x=1724254395; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8CBbdt04VN9MIN6YiVqw6FZADv51lDxxXMU1yp5uycs=;
        b=Iwa431p6qs4evmhU8ikx9/v5Yztrm2N6MxQnVJp/GXbOQg1+hnvf+7dMXN9SFfSp3k
         drG/nUV4dHDET8WdWGZZ0Yeak5IlRsWPTqIFEk6zagepn3k72CgzUoSN9keZrePJSjJs
         uHK/z49aMKqwkxk5UcmQse6+i02PsnSTwJMs1QcapBUDLtjgrbb3tJjF0cNgJLE54d49
         gQygF02I0GyigIVrAlYHkn+YQs1aYYGDLJq20GrgRZyz6VxgbythUFWpDKsKOrkp9GqA
         k7Tgm/1qJCu1aKqJ8pDbWde27Dcd2GoCq278/FB/pNumXQm/j2qBlqeFGxqboyLMuyrJ
         2ycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723649595; x=1724254395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8CBbdt04VN9MIN6YiVqw6FZADv51lDxxXMU1yp5uycs=;
        b=NaSp4Wqh0vsKVo+UzZ0V6F+SpmJfTc7O4rt2mzE1PhCjfZKiPBHEBZxCcemtZ0VHKj
         wRb9xX6yZYSBjAM4VQ7MXbQdWaQTqalRlgC9xovefjpwOx9oJl24VOGpLcNWKyFUNzlo
         2zkNfBg3DyqGQHJnLWtsnl/iZqe5UPKy70hezVR2dmiITwdLjEj90OMfW6HIvlaIWJ9o
         HFcst7Z6gTDqarCWeCt0+YXO1fQCuoR0s8xrEYTTWfZN2UlnMEf+/AQQn8y+5Fo8jpfq
         PRK8cp5U4SKb8YoE9gck3e3z52gOwYiH8tlXrkJgLwC/32S7tDxPYYfRIfn64gCZqN4v
         RxFg==
X-Gm-Message-State: AOJu0YxY9jETBWhAe7L3RWVmJ+IaIIR/qXo3irTR3cDQ14mAT+i88Ljl
	WKErGXTib/cb0/fFG50UUfEHoEFbW1y49zSvaEXQG6QEXIIfXnKQrvG7wBrd
X-Google-Smtp-Source: AGHT+IHmWQwK/5LYG7M1PBU6LchKm5Iw0j3mMqHiC+hG6uuVT1avPGBx3YHQfIZ8iv9eitQlzARJZA==
X-Received: by 2002:a05:6a00:9284:b0:70d:262e:7279 with SMTP id d2e1a72fcca58-712670f6a54mr3613616b3a.3.1723649595145;
        Wed, 14 Aug 2024 08:33:15 -0700 (PDT)
Received: from localhost.localdomain (222-229-106-196.catv.medias.ne.jp. [222.229.106.196])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a8a5c3sm7715641b3a.176.2024.08.14.08.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:33:14 -0700 (PDT)
From: Naoto Yamaguchi <wata2ki@gmail.com>
X-Google-Original-From: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] Adjust volume label maximum length to the kernel implementation
Date: Thu, 15 Aug 2024 00:32:38 +0900
Message-ID: <20240814153256.18230-1-naoto.yamaguchi@aisin.co.jp>
X-Mailer: git-send-email 2.43.0
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

The erofs implementation of kernel has limitation of the volume label length.
The volume label data size of super block is 16 bytes.
The kernel implementation requires to null terminate inside a that 16 bytes.

Logs:
  $ ./mkfs/mkfs.erofs test16.erofs -L 0123456789abcdef test/
  $ mount -o loop ./test16.erofs ./mnt/
  $ dmesg
  [26477.019283] erofs: (device loop0): erofs_read_superblock: bad volume name without NIL terminator

  $ ./mkfs/mkfs.erofs test15.erofs -L 0123456789abcde test/
  $ mount -o loop ./test15.erofs ./mnt/
  $ dmesg
  [26500.516871] erofs: (device loop0): mounted with root inode @ nid 36.

This patch adjusts volume label maximum length to the kernel implementation.

Signed-off-by: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>
---
 mkfs/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index b7129eb..ff26c16 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -151,7 +151,7 @@ static void usage(int argc, char **argv)
 	printf(
 		" -C#                   specify the size of compress physical cluster in bytes\n"
 		" -EX[,...]             X=extended options\n"
-		" -L volume-label       set the volume label (maximum 16)\n"
+		" -L volume-label       set the volume label (maximum 15 character)\n"
 		" -T#                   specify a fixed UNIX timestamp # as build time\n"
 		"    --all-time         the timestamp is also applied to all files (default)\n"
 		"    --mkfs-time        the timestamp is applied as build time only\n"
@@ -598,7 +598,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 
 		case 'L':
 			if (optarg == NULL ||
-			    strlen(optarg) > sizeof(g_sbi.volume_name)) {
+			    strlen(optarg) > (sizeof(g_sbi.volume_name) - 1u)) {
 				erofs_err("invalid volume label");
 				return -EINVAL;
 			}
-- 
2.43.0

