Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C867E0E2A
	for <lists+linux-erofs@lfdr.de>; Sat,  4 Nov 2023 08:00:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SMpRK4C68z3bTN
	for <lists+linux-erofs@lfdr.de>; Sat,  4 Nov 2023 18:00:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 578 seconds by postgrey-1.37 at boromir; Sat, 04 Nov 2023 18:00:40 AEDT
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SMpRD1HDcz2yVv
	for <linux-erofs@lists.ozlabs.org>; Sat,  4 Nov 2023 18:00:38 +1100 (AEDT)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 8B91D1008CBC1
	for <linux-erofs@lists.ozlabs.org>; Sat,  4 Nov 2023 14:50:48 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id F3F9C37C94C;
	Sat,  4 Nov 2023 14:50:46 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: fix potential memory leak
Date: Sat,  4 Nov 2023 14:50:41 +0800
Message-ID: <20231104065041.129680-1-zhaoyifan@sjtu.edu.cn>
X-Mailer: git-send-email 2.42.1
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
Cc: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Valgrind reports 2 potential memory leaks in mkfs:

    Command: mkfs.erofs -zlz4 test.img testdir/

    4 bytes in 1 blocks are still reachable in loss record 1 of 2
       at 0x4841848: malloc (vg_replace_malloc.c:431)
       by 0x49633DE: strdup (strdup.c:42)
       by 0x10C483: mkfs_parse_compress_algs (main.c:287)
       by 0x10C483: mkfs_parse_options_cfg (main.c:316)
       by 0x10C483: main (main.c:936)

    34 bytes in 1 blocks are still reachable in loss record 2 of 2
       at 0x4841848: malloc (vg_replace_malloc.c:431)
       by 0x49633DE: strdup (strdup.c:42)
       by 0x48FFE2B: realpath_stk (canonicalize.c:409)
       by 0x48FFE2B: realpath@@GLIBC_2.3 (canonicalize.c:431)
       by 0x10B7EB: mkfs_parse_options_cfg (main.c:587)
       by 0x10B7EB: main (main.c:936)

Fix it by freeing the memory allocated by strdup() and realpath().

Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
---
 lib/config.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/config.c b/lib/config.c
index a3235c8..2ad0122 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -54,6 +54,10 @@ void erofs_exit_configure(void)
 #endif
 	if (cfg.c_img_path)
 		free(cfg.c_img_path);
+	if (cfg.c_src_path)
+		free(cfg.c_src_path);
+	for (int i = 0; i < EROFS_MAX_COMPR_CFGS && cfg.c_compr_alg[i]; i++)
+		free(cfg.c_compr_alg[i]);
 }
 
 static unsigned int fullpath_prefix;	/* root directory prefix length */
-- 
2.42.1

