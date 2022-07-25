Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A35557F91A
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Jul 2022 07:46:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lrptw2rj9z3bmK
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Jul 2022 15:46:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=KCr9g/Ha;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=KCr9g/Ha;
	dkim-atps=neutral
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lrptn3J87z302d
	for <linux-erofs@lists.ozlabs.org>; Mon, 25 Jul 2022 15:46:07 +1000 (AEST)
Received: by mail-pg1-x535.google.com with SMTP id 6so9397889pgb.13
        for <linux-erofs@lists.ozlabs.org>; Sun, 24 Jul 2022 22:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=0AgySdOYVSXqJQUmS5s5ac65EtO0kNbbhLzvKY9tB6o=;
        b=KCr9g/HampQWfl2IvVldPcUfF4TrgronkCXtegp1H1eSCJQkVZTTo05XU/ZHQtfS+s
         7nO81GEQDcDc2WxD/dudevPfAn3bsgwor9r52cYH8UECYEhxe4nAWwY16rc9qV+zRjSq
         mcPI4oWz78SUz4FwKZEcpiRinPWR04OO6dECuu9hOM8YrioBHDNLeDMdGsiZf3HthWrA
         8MbOyDZpxYk/z417ohs99HmSfcVw1SASBC+CZgOVVdgaqb2BK1iYv6mGdmhqP5/LYoLy
         I/pQzfqouMH5JWP3nEG8vGPd9BX7cJcLEjEEg/wpAGycOUDiNvrbELH1Aj8SuwhT1fD0
         oTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0AgySdOYVSXqJQUmS5s5ac65EtO0kNbbhLzvKY9tB6o=;
        b=Jz8lwXoaBiZMtevqreKfwQeB7pW2KMzFGmuN/bLIPNoQBJRf3cFK+1FHVrNcl4BVKP
         G8ORj0V83phH7TzJdXKnVTy3682N9FN9hhHwHxjOyQxrVKpOpd5MmpnerE96naM5z77R
         jH8a6ZLc2gDhRz8PqG5Ylnrh+zNUIoNEzys6wMHtvZo6qIeJcBQvYk0YZ2ui47/3XTmZ
         DqSj9IlqZrWluoXMnoaVrnjoWP8MdKQ0L2zbeL+6SL9UBQ7ALB6pAA5TDoLJPMtGKORH
         BvdhlSbyyXGHWqPWc45DN81Mg0W4fGzp7Ah7ieP5hmI/6dkYHpnvdlGuDxCDpEwxPydw
         xacw==
X-Gm-Message-State: AJIora/ab9RYmEOfLEIuECbb+sPOiLvfyr3nhy3ypMxSFiUtdnqt97W7
	qwSOFSEI3jidaiJR/bkz07z4u+ISvHk=
X-Google-Smtp-Source: AGRyM1sFHQw6Ci4wk47xE5q32HukF/BuGwtFf0Qv6qRTpdVrBfOP1EzP/CdIvVTzAfibzrA1msuKwg==
X-Received: by 2002:a05:6a00:140d:b0:52a:d561:d991 with SMTP id l13-20020a056a00140d00b0052ad561d991mr11356592pfu.46.1658727965076;
        Sun, 24 Jul 2022 22:46:05 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id w2-20020a170902e88200b0016be96e07d1sm4931945plg.121.2022.07.24.22.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 22:46:04 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
X-Google-Original-From: Yue Hu <huyue2@coolpad.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: mkfs: fix a memory leak of compression type configuration
Date: Mon, 25 Jul 2022 13:45:49 +0800
Message-Id: <20220725054549.23562-1-huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
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
Cc: Yue Hu <huyue2@coolpad.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Release the memory allocated for compression type configuration. And no
need to consider !optarg case since getopt_long() will do that.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 lib/config.c | 3 +++
 mkfs/main.c  | 4 ----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/config.c b/lib/config.c
index 3963df2..c316a54 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -55,6 +55,9 @@ void erofs_exit_configure(void)
 #endif
 	if (cfg.c_img_path)
 		free(cfg.c_img_path);
+
+	if (cfg.c_compr_alg_master)
+		free(cfg.c_compr_alg_master);
 }
 
 static unsigned int fullpath_prefix;	/* root directory prefix length */
diff --git a/mkfs/main.c b/mkfs/main.c
index deb8e1f..9f5f1dc 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -212,10 +212,6 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				  long_options, NULL)) != -1) {
 		switch (opt) {
 		case 'z':
-			if (!optarg) {
-				cfg.c_compr_alg_master = "(default)";
-				break;
-			}
 			/* get specified compression level */
 			for (i = 0; optarg[i] != '\0'; ++i) {
 				if (optarg[i] == ',') {
-- 
2.17.1

