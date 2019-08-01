Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 725AD7E33C
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Aug 2019 21:18:58 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4600TC2T6mzDqkx
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Aug 2019 05:18:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="F1lHj/SI"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4600T538rQzDqkc
 for <linux-erofs@lists.ozlabs.org>; Fri,  2 Aug 2019 05:18:47 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id m30so34632122pff.8
 for <linux-erofs@lists.ozlabs.org>; Thu, 01 Aug 2019 12:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=CKixCSvDYnIKvV8ib7cbwbQ6Zq/CVPeBAEqJ9HEwkic=;
 b=F1lHj/SIyjEIRTmIMwL6Sps0xjWPc9mfVhSnfcdEIltc+p+ws00/UTNoTLIKTp3LOO
 IQQK2AA7wnxCvu3kJArgGO/labORXNvDz+VXbbsTUrV4ZgUTBPfJrceYhtYYlegGeyWu
 /3BvE+hUsMKcfkTiw7ZH317wFRcsqFf+yLLHfgouhpLwlLfSa+YAPwxLo/1vo6jvqxgq
 RCYNhefz1/iDObv4MasUtcrfg7JngnpRUy7vYGAF8Xpf8K2SDwgM3+8dbaNBqpZhIlAE
 nu91rNPj4SGkoMY6V97SMuLPthZZkw+rx47QgSKgNH6A+JUm1zVY4QUwiNjN5zzPFpM7
 hXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=CKixCSvDYnIKvV8ib7cbwbQ6Zq/CVPeBAEqJ9HEwkic=;
 b=X22x9sa6f09VpqKM/O2s8V62RKZshx0fLdySZrjA0hhiy2lpm8/X1CYTddiWCmV3I+
 0BfTEzKI9KjuPK/Bko28wFY9cjmGKcnk3jz/qE94ql1NP6dkPxhN+tUCQF3qlzw5QGoI
 O6+KzzY1L2A2+/muZwz2w+Aj4Hw7A5UXO37DY61gGDBg7Tr8F8LaX74A3pxEKBgPVe1d
 PlU2zqd2eqe6uQoUEZxSSiYR1ZuOMItTLZVYp4yuQ8mAp5HUP37i6CFItO2NUvpo8hWu
 JUIp+QOQjpZmWsPo0jx/n/dTGa41v7ISycgVvryNjXsuvQUNsWoNqAugUN7IM9SkGx9V
 H6Ng==
X-Gm-Message-State: APjAAAVizBoYzhRSH25ZBzIOEMw8D3SrBXlo35dtRkXJ1alGFibHy8Yy
 wlQqUQWVPPRl9soGYZn81+kbgBEH
X-Google-Smtp-Source: APXvYqzfLIvLY+WOx+CLu4wMvl3VjRmBseJeHjyWz2tfzizD+rIiFi8OJGo67lin9oJfeSPFQivyUA==
X-Received: by 2002:a63:2148:: with SMTP id s8mr117985775pgm.336.1564687123090; 
 Thu, 01 Aug 2019 12:18:43 -0700 (PDT)
Received: from localhost.localdomain ([139.5.48.149])
 by smtp.gmail.com with ESMTPSA id o11sm126312358pfh.114.2019.08.01.12.18.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 12:18:42 -0700 (PDT)
From: Pratik Shinde <pratikshinde320@gmail.com>
To: linux-erofs@lists.ozlabs.org, bluce.liguifu@huawei.com, miaoxie@huawei.com,
 fangwei1@huawei.com
Subject: [PATCH] erofs-utils: error handling for incorrect dbg lvl &
 compression algorithm
Date: Fri,  2 Aug 2019 00:48:09 +0530
Message-Id: <20190801191809.13675-1-pratikshinde320@gmail.com>
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

handling the case of incorrect debug level.
also, an early check for valid compression algorithm.

Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
---
 mkfs/main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mkfs/main.c b/mkfs/main.c
index fdb65fd..4231d13 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -105,10 +105,22 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				}
 			}
 			cfg.c_compr_alg_master = strndup(optarg, i);
+			if (strcmp(cfg.c_compr_alg_master, "lz4")
+			    && strcmp(cfg.c_compr_alg_master, "lz4hc")) {
+				erofs_err("invalid compressor algorithm %s",
+					  cfg.c_compr_alg_master);
+				return -EINVAL;
+			}
 			break;
 
 		case 'd':
 			cfg.c_dbg_lvl = parse_num_from_str(optarg);
+			if (cfg.c_dbg_lvl < 0 || cfg.c_dbg_lvl > 9) {
+				fprintf(stderr,
+					"invalid debug level %d\n",
+					cfg.c_dbg_lvl);
+				return -EINVAL;
+			}
 			break;
 
 		case 'E':
-- 
2.9.3

