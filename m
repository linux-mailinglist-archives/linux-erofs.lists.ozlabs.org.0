Return-Path: <linux-erofs+bounces-904-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 558DDB33B63
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Aug 2025 11:45:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c9Qrs2tcsz3cft;
	Mon, 25 Aug 2025 19:45:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.78
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756115133;
	cv=none; b=RbCiFnTkQqlOWpMajISUQWfp8FwkF9VQsWx+i5OhfrcdHRctFvYdP1Om7gVkeHNevg/XwP4O010zKY1ROJFWAXbcJpj5fpqTSGM7zrgGArD+nJQSsXsiIzAwcfNoTuX3V0aixbOD4SxuVQ8jVMd4q0HalNxz42Olmq5uhibsowAR6qiqUufiRmw6hvwxO+6ilXDZtvvruixcuGMmVJNX5kIyS4QQi6B7KhuF0R/U+NKqj1EJLMgA7QTZQlHHRBQVoCNFlQbZAgQjOnZ6mzLBd1MDPsC2CgZa512CCIsA1a2tH0HZwiPEBh8HszLP27bch6kpmmQgeonch+MfP5sHyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756115133; c=relaxed/relaxed;
	bh=jDMOYKbMpB/xdf1ncApt2JamIeUNCb7Hni2GjlOmVmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HuIspwTWvzYD03IZiIVWlDBIk7kA61cXtdCDOxgMgms5dP+5JK7K6y79y/wFPHRZg6Ie5GH3x/5zHpmoOPRelxcdcbgTobWN5FCXiSLvgA87hBxfSGhK+KcTYukpkJuMcgkMJxwIfL9HjvA1oagVN3KWhBO3+pRMkZEh/F1LTq4jN+YNnH1ODgd2rG76qLULwIKbAm9dTKaKDRvm5op/77EWSCuJte1ctJpfAuM7CM9ssu9wuo4+HNK9f7NwTzu2SERn2Gjof1N8WmVDHufCB4v5Onwp2MR0LDequotkJvLIEFPwJ+8Wyo7yPSZXrzKQB9lXfWiqytC2NpxfaVXNfg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.78; helo=out28-78.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.78; helo=out28-78.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-78.mail.aliyun.com (out28-78.mail.aliyun.com [115.124.28.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c9Qrq72kGz3cZM
	for <linux-erofs@lists.ozlabs.org>; Mon, 25 Aug 2025 19:45:30 +1000 (AEST)
Received: from HUDSONZHU-MC1.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.eP8MMnP_1756115124 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 25 Aug 2025 17:45:25 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v1] erofs-utils: add my email address to .mailmap
Date: Mon, 25 Aug 2025 17:45:22 +0800
Message-ID: <20250825094522.17754-1-hudson@cyzhu.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Chengyu Zhu <hudsonzhu@tencent.com>

add my email address to .mailmap

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
 .gitignore |  5 +++++
 .mailmap   | 13 +++++++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 .mailmap

diff --git a/.gitignore b/.gitignore
index 3488961..cc1c72c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -12,6 +12,11 @@
 *.so.dbg
 *.tar.*
 
+#
+# We don't want to ignore the following even if they are dot-files
+#
+!.mailmap
+
 #
 # Generated files
 #
diff --git a/.mailmap b/.mailmap
new file mode 100644
index 0000000..b00bc8c
--- /dev/null
+++ b/.mailmap
@@ -0,0 +1,13 @@
+#
+# This list is used by git-shortlog to fix a few botched name translations
+# in the git archive, either because the author's full name was messed up
+# and/or not always written the same way, making contributions from the
+# same person appearing not to be so or badly displayed. Also allows for
+# old email addresses to map to new email addresses.
+#
+# For format details, see "man gitmailmap" or "MAPPING AUTHORS" in
+# "man git-shortlog" on older systems.
+#
+# Please keep this list dictionary sorted.
+#
+Chengyu Zhu <hudson@cyzhu.com> <hudsonzhu@tencent.com>
-- 
2.51.0


