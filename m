Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37189954002
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Aug 2024 05:17:16 +0200 (CEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="::1"
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=TvrtCm+X;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WlRxQ0bZfz2ymc
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Aug 2024 13:17:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=TvrtCm+X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=wata2ki@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WlRxK4FRKz2xbd
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Aug 2024 13:17:07 +1000 (AEST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1fc65329979so15675715ad.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 15 Aug 2024 20:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723778221; x=1724383021; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llKsUcVfiLy+bLojFNR7QaCF92Ipz3yYT3icC8NZfwU=;
        b=TvrtCm+X4UBziABLuEn+ENOA0V0zL2Y9hb83q1e5IPmaVM897Y/M26ZjloZTTLwm+V
         IrolZ2dnnbjipHw3aeOPDVgU1h8NkPu79mSq6O5f+FxTL8DbMMdW5+w5l4o7pzGLx5hP
         kIbOZO6cf1Q3gPDTuO9Y849o6/toPlEPI/ay32xNi/gqnn7wyqgXzrI3x7OWbZAXws6W
         QxUTdYYtieurYI6cDhnnAOcnlsJN5HXBF2D+8cHbX3PK8aGutIc29tTYH0n8mt2+d/Zz
         N31PxJ8853m1b/kuq0/fE1St2KR68inBcB2fQSY6TlzCJ0DdcZTj+7IXdyoj2hQH3E39
         GDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723778221; x=1724383021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llKsUcVfiLy+bLojFNR7QaCF92Ipz3yYT3icC8NZfwU=;
        b=WZ3idhSjKfWfLrGxEfshSSQB38D5vIoExb31/txWIa4tZRLhX41RqUOksrYaLBDTN8
         Vnkb56UjMbjFiUPwWDhtun5/hvLtEL+i6OTQF6bByQnxw2WLybl4Vd7XXh04eog3Wgto
         1UT5X7jGreRnUzrJzEuGJcfuvQ8SMPSLP1eSwJdX95m6FWd2FyTfk2iX5ik4PvP90CVh
         +HCcsN2Nhg4fI4hvSXpMvoYT4mIKOWl7FUBl+AGzh/i2trb4qvWInl3BM8Zk8kb6U9hk
         mZUHYPhGCA8M8QAda9Sz1WFdTW6S90i29pFfbmEym4pynNdEeSU41zRFHIORnlFG9Jd/
         BhXw==
X-Gm-Message-State: AOJu0Yw/nPKFb0ovrcNWXoA2QSBJcg4mtTPw0mgckUvvVMb8v6vrTk1a
	Udnbxx9mA0dIVjwzOik7iMKzhQYyOG3vyhQFhvwa3q2jOJohXtjwQ6A0CsiJ
X-Google-Smtp-Source: AGHT+IEX1zlYd8o4vKcbKt7qYcufJqZYmCYAeo3ufVDs5ZjclgmfJGh9iJRc2CQ4qYKIZnYCLvMPqA==
X-Received: by 2002:a17:903:2286:b0:1fa:abda:cf7b with SMTP id d9443c01a7336-20203e4f2a7mr21805425ad.9.1723778220906;
        Thu, 15 Aug 2024 20:17:00 -0700 (PDT)
Received: from localhost.localdomain (222-229-106-196.catv.medias.ne.jp. [222.229.106.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0378973sm16742325ad.160.2024.08.15.20.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 20:17:00 -0700 (PDT)
From: Naoto Yamaguchi <wata2ki@gmail.com>
X-Google-Original-From: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3] erofs-utils: adjust volume label maximum length to the kernel implementation
Date: Fri, 16 Aug 2024 12:13:36 +0900
Message-ID: <20240816031601.45848-1-naoto.yamaguchi@aisin.co.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <61d8a190-3520-4d5d-8c80-adeb7172a88f@linux.alibaba.com>
References: <61d8a190-3520-4d5d-8c80-adeb7172a88f@linux.alibaba.com>
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
index b7129eb..5cc2778 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -151,7 +151,7 @@ static void usage(int argc, char **argv)
 	printf(
 		" -C#                   specify the size of compress physical cluster in bytes\n"
 		" -EX[,...]             X=extended options\n"
-		" -L volume-label       set the volume label (maximum 16)\n"
+		" -L volume-label       set the volume label (maximum 15 bytes)\n"
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

