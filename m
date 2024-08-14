Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A39951F2A
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2024 17:54:25 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=XT0MBFDy;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WkXqz3PVqz2yYK
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Aug 2024 01:54:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=XT0MBFDy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2001:4860:4864:20::2d; helo=mail-oa1-x2d.google.com; envelope-from=wata2ki@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WkXqw054Mz2xbd
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Aug 2024 01:54:18 +1000 (AEST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-26ff21d82e4so21063fac.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 14 Aug 2024 08:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723650852; x=1724255652; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CBbdt04VN9MIN6YiVqw6FZADv51lDxxXMU1yp5uycs=;
        b=XT0MBFDyxvLqSA5ItWgdksnuRttRKV/ca7LVJ+VrO/aMBxRaj4boJEOVkPKtQwOh9n
         WzxiN76NKOHtO5W00Nv8jL7RWOZ7eNOfmvcKhW1HDUDuLozW15ulWlo4e0yMIqGjj/tU
         0IK+3FRXqVjIOUYnzXEYCQUkZ77YPMEERHMVyRtAWC0RTUyq5ldmGaFshRD2RWHb1/Yb
         sn8qq9lO36lEKaK1hCcpGz88jvyvyueP7MvE5daKAWXgwr1DLyQ9pcQ0ODEZ68fIWzEw
         jZ6PIaFg+hQ5oFZKFKljyQoCE93F/n/I2hbWDFqPsvjJZ6l5kBiwNWSbacQBlc+xv934
         C8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723650852; x=1724255652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8CBbdt04VN9MIN6YiVqw6FZADv51lDxxXMU1yp5uycs=;
        b=bYDgYVY8FDeLhtY7A5wMA334/ohwYqV7jvTre0mtBjTgC04sE5EELl4dBdjKGtM1Yp
         FuoJGoI/wE0+DIAvoEdsuXwNmsep8nKcYbFIHNV+T7/1WM/a6h/yDeJ937g/AMBL/wmJ
         syLNtrA/6HhkA5JvMk0/W6cjyNCkN37eaX/D5f3muJAw7xJRAGMjfe5rYO1B4vp8YhEw
         GXwxrzzbLcMJ9AVeRrmwuG1549JAMtkv4u2i1Dc4o7IYQFj79xdDLNxNYVkPYs97kTPP
         L/5DZ3CU+QXI2agDJEZTnpu0lSflYteubMH+9oBrQFlp/blx1HZuoUrSD4UpNbo6I6+j
         hRXQ==
X-Gm-Message-State: AOJu0YxcNNnnTQjb3O+BwXfxs1gZA/1I8m1XfHdLhAw2k+5Aukl1PUWC
	061rESmtehs571qqbeb8+SpUbDb3uz0pV4YIsTh+sjlRczX5bcR30N8/Yf74
X-Google-Smtp-Source: AGHT+IGv70UA0xncFwbu6bOywyyQg4s0vtPQVsPTKCm0sxAB6ojUxIQKGZUsVq0N7ZlShsNfwkh4Gg==
X-Received: by 2002:a05:6871:297:b0:25e:24d5:4d6b with SMTP id 586e51a60fabf-26fe5cb1399mr3188730fac.50.1723650852406;
        Wed, 14 Aug 2024 08:54:12 -0700 (PDT)
Received: from localhost.localdomain (222-229-106-196.catv.medias.ne.jp. [222.229.106.196])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5ac46edsm7501744b3a.220.2024.08.14.08.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:54:12 -0700 (PDT)
From: Naoto Yamaguchi <wata2ki@gmail.com>
X-Google-Original-From: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: adjust volume label maximum length to the kernel implementation
Date: Thu, 15 Aug 2024 00:53:30 +0900
Message-ID: <20240814155353.19076-1-naoto.yamaguchi@aisin.co.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814153256.18230-1-naoto.yamaguchi@aisin.co.jp>
References: <20240814153256.18230-1-naoto.yamaguchi@aisin.co.jp>
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

