Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC3830B76
	for <lists+linux-erofs@lfdr.de>; Fri, 31 May 2019 11:27:53 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45FfHq0w13zDqV1
	for <lists+linux-erofs@lfdr.de>; Fri, 31 May 2019 19:27:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="XUE4D9Lm"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45FfHk17d3zDqSM
 for <linux-erofs@lists.ozlabs.org>; Fri, 31 May 2019 19:27:45 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id v9so3704892pgr.13
 for <linux-erofs@lists.ozlabs.org>; Fri, 31 May 2019 02:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=eqvczh56z80IAIWYhpklLd0hOhPPXrvRL36R83fSdDI=;
 b=XUE4D9LmdOc9vZ3Nso5Mp+EZEeoAPytuP9UCjh7oQNJT3oBiyOkHiDwfZzuZyHs3GH
 u8JMRWPZr8iNyDjL7GtGjpQpboEtN6xpGh63o3HEP9PKYCJVwTE3N9vLEk919rDJck6x
 fcoC9gPCHjShI58QJw0Ug1myIuDLdp+eXwslLGwINt0wE+rxRaSimghCXpf8k+LqZvhL
 qK2CDXV7NlpjIx78rlAmJGplptbiRLZ5y7dzOdlGfjhSNkJCJtNx4G/Htj9puy1CMsR/
 1G3kw/dChCVaBxLtvOKs8JlqaUjI/SX91HJWfIJS7pCzjShA4B0wGzctrNEforDlI/V0
 y3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=eqvczh56z80IAIWYhpklLd0hOhPPXrvRL36R83fSdDI=;
 b=JkKIHD8mP/pYnSFF32e1MbKv5VitQ+4Afa2wm5K3tGygHzRBcnvIydIdqFZIeKXhuo
 gpripOupuW2r8hKy12faTnwGUgiozBtVJemEdCuUivFlFR4+vjfon0puN4SRrfORNqnd
 zS1glqO9v1xKYLE15RuBVZUhjRWj10iH/2eVstYRa4bwlTvAnEA2QgCdadJj2ZWYB/mL
 u/sY7srxBWtQgM9yCj+pVGYrVKvzUKx1wKOrU+lvXvhPAwqjV8J+LF5eYCjTLqtBx2U8
 xDyY5PoPoHCaATRw7IxiIa7tTVLY7WM970H6mYxnzEHAdf+vgOh+UGMEsYa//K5DIx5J
 dSgQ==
X-Gm-Message-State: APjAAAUy5ZgOnO4UMokLmWZeP8nLjxm02jkP038Ujg9BiKl0PpFNQS/l
 bKRdBo0qpQDpHxm2Ww0Mn/E=
X-Google-Smtp-Source: APXvYqxADRkj5t4GokxSikLtYBUdE+j81m9NVGQ4Q8STJ0pluQFUmtcXSS/MwoI3EPitbFSFj9Lg6w==
X-Received: by 2002:a17:90a:f48f:: with SMTP id
 bx15mr7873258pjb.85.1559294862085; 
 Fri, 31 May 2019 02:27:42 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
 by smtp.gmail.com with ESMTPSA id k36sm5418963pjb.14.2019.05.31.02.27.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 31 May 2019 02:27:41 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: bluce.liguifu@huawei.com,
	miaoxie@huawei.com,
	fangwei1@huawei.com
Subject: [PATCH] erofs-utils: correct --with-lz4 example in README
Date: Fri, 31 May 2019 17:27:22 +0800
Message-Id: <20190531092722.6708-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
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
Cc: huyue2@yulong.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@yulong.com>

Option --with-lz4 means LZ4 install directory rather than LZ4 lib
directory. We will meet configuration error due to wrong path if
setting --with-lz4 to /usr/local/lib. Also stay the same with LZ4
help in configure shell script.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 README | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 9014268..97eb228 100644
--- a/README
+++ b/README
@@ -19,8 +19,8 @@ Dependencies
 
 How to build with lz4 static library
 	./configure --with-lz4=<lz4 install path>
-eg. if lz4 lib has been installed into fold of /usr/local/lib
-	./configure --with-lz4=/usr/local/lib && make
+eg. if lz4 has been installed into fold of /usr/local
+	./configure --with-lz4=/usr/local && make
 On Fedora, static lz4 can be installed using:
 	yum install lz4-static.x86_64
 To build you should run this first:
-- 
1.9.1

