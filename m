Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 230408FED2
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Aug 2019 11:22:33 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 468yX656YnzDrBG
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Aug 2019 19:22:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="AGrdvvJ8"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 468yX14Nl3zDr8s
 for <linux-erofs@lists.ozlabs.org>; Fri, 16 Aug 2019 19:22:25 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id o70so2845959pfg.5
 for <linux-erofs@lists.ozlabs.org>; Fri, 16 Aug 2019 02:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=jPaMMT8mIhg5i0UBjcbBG2bnsVlMEC90CqdU+xanGQo=;
 b=AGrdvvJ8TxGRfKL07GbGgKJfdNy0Lo1wxopHQst+jiRD8OnLfuiOrcguLsAXko4ced
 2NMdF+vUH2AYzDWq7J+DJzpmncTPv227E1dGFramhyEZZCJUg0kicqH5UqnKX9Au82vc
 fUL+enuqenGddpZ5BrY5Dnokq8dQImQZSsD0G49W8vqlijdcVjGobqOa+W45d5+xg3j4
 qjXdBxpkCE0B53RSs4JHNOfY0uFKYiegcMwfWtlhiEgG4MtJwpj6cZAK9AVt7H9qg58y
 FC5r9X81IqBHOs0GKADRKlqLYyFgjSFN3kByhOu/ddy29t8HO5aXkzRDXGzWNL7P5m3z
 JCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=jPaMMT8mIhg5i0UBjcbBG2bnsVlMEC90CqdU+xanGQo=;
 b=nCxykRLOJvBWkrnyrlnRoksR9gmOHNlxHTYlFYrgYe4fvB0yey+Inl2yE4jVYkqUhV
 KAnpYBXvTGbqtGsA3/Wh0bZ8S1KtpBAGb28ZvVIPPFM9ZZlXRSgPscjzR5l0ZrjxllGH
 pU+k4QAr2c2DAV+Ax1whHLtN4J1x2eze7t/3DYMPYJP+owJ1PN91267IiEKi8bolixWV
 s2XmOo8V02HQI9NXYShaxtYxcAthixXBRvdY7056NfRgJvbgF/vR2gl1FYFmYChanrJ/
 V877AC4pdrpSxTFSJVsJKtyUwRdsg2fUMx8qqGCOkt/S9+hWTkg5PvZDQdzx60rVlgLm
 W9Uw==
X-Gm-Message-State: APjAAAV9H3/563YADe7y440olk87Zrfm/6B8jvTDpcDh1dxHGJM46AGA
 Bb6vfGIfxZW70Ig2fGO/Q8092rT2xF4=
X-Google-Smtp-Source: APXvYqx45ZXfnfXlpLGVcHgmbeUUzRjV2NST0JfM2adpEEU7zQNf+mA0zqd5yS4OLw3VbbxFOTvvew==
X-Received: by 2002:a65:63c4:: with SMTP id n4mr6851667pgv.44.1565947341232;
 Fri, 16 Aug 2019 02:22:21 -0700 (PDT)
Received: from localhost.localdomain ([42.108.240.223])
 by smtp.gmail.com with ESMTPSA id y194sm5929439pfg.116.2019.08.16.02.22.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 16 Aug 2019 02:22:20 -0700 (PDT)
From: Pratik Shinde <pratikshinde320@gmail.com>
To: linux-erofs@lists.ozlabs.org, bluce.liguifu@huawei.com, miaoxie@huawei.com,
 fangwei1@huawei.com
Subject: [PATCH] erofs-utils: Fail the image creation when source path is not
 a directory file.
Date: Fri, 16 Aug 2019 14:26:20 +0530
Message-Id: <20190816085620.22266-1-pratikshinde320@gmail.com>
X-Mailer: git-send-email 2.9.3
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In the erofs.mkfs utility, if the source path is not a directory,image
creation should not proceed.since root of the filesystem needs to be a directory.

moving the check to main function.

Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
---
 mkfs/main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mkfs/main.c b/mkfs/main.c
index 93cacca..8fbfced 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -12,6 +12,7 @@
 #include <stdlib.h>
 #include <limits.h>
 #include <libgen.h>
+#include <sys/stat.h>
 #include "erofs/config.h"
 #include "erofs/print.h"
 #include "erofs/cache.h"
@@ -187,6 +188,7 @@ int main(int argc, char **argv)
 	struct erofs_buffer_head *sb_bh;
 	struct erofs_inode *root_inode;
 	erofs_nid_t root_nid;
+	struct stat64 st;
 
 	erofs_init_configure();
 	fprintf(stderr, "%s %s\n", basename(argv[0]), cfg.c_version);
@@ -197,6 +199,15 @@ int main(int argc, char **argv)
 			usage();
 		return 1;
 	}
+	err = lstat64(cfg.c_src_path, &st);
+	if (err)
+		return 1;
+	if ((st.st_mode & S_IFMT) != S_IFDIR) {
+		erofs_err("root of the filesystem is not a directory - %s",
+			  cfg.c_src_path);
+		usage();
+		return 1;
+	}
 
 	err = dev_open(cfg.c_img_path);
 	if (err) {
-- 
2.9.3

