Return-Path: <linux-erofs+bounces-1023-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE11BB55F29
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Sep 2025 09:48:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cP3Lw2dTFz2yrN;
	Sat, 13 Sep 2025 17:48:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.83
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757749704;
	cv=none; b=Qm+PnTinubNUXrwZ2Z0rCfnkcneXo1JJ7mc4SPwUK4tqSF6FoimApxgRfI+KtwoEtUFwICsLOSpdQR7TjdlcHejdm0wHhpRlDE140OPoHPN2zrOfWECjFyRNRLw9koeCJcEjPPAQF9FVrHflGP8aoIBaPKR9PuhPwmSqNuuOavKq90xqsVEK8zh6uy5/mZJPGXdp0hAfGlTE3DhMQ2XsqrDAnaokcmhU3tnMnjT1uU0Mb8c5iLcWVFrKXAB5sq44yvruphEr7GtAovzwuzuqabJHsBohvE5HAdHW4Vp4VGu4WqjZiygSzTQ29OKj4l1qsJvvE1OoLY3JMdG7T5UMWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757749704; c=relaxed/relaxed;
	bh=A1mfPw7+jqtCr8XaKeVT6MyIrShxFbTrFzCtDJq3m+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iJmqP8RcOZLsfwZ/LUASBuNSXj6bSTmhMb1kYOGRX6A0t+bKIaYMnG0N9xsAHFH59mlcPEqO2iWylknXenlnUxM8RSeZlj0TWBQxKk3PkR+HaEmPzrSoB1HAPRrQ7ZNTzqK10RdPdD82gv4jZ0QSvqHtJMwQoUmCkIYmHN3Z3T+bJzBwyU/ZI15SjTc1szUOtHUT/agjSa4HrXKGIxVijQRphYtTkidZToIDxcbQ9SMSDlwj/jNxbnEPmjBpj0U7C5wRYsJ1wsQQxXOcFmZNVZjHafsBsBEb/PO36uKdPeMjXtrekAIXBWkB7is5Fs26EBQKTRoXaOwy5WPgLvSyaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.83; helo=out28-83.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.83; helo=out28-83.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-83.mail.aliyun.com (out28-83.mail.aliyun.com [115.124.28.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cP3Lv0hcHz2yD5
	for <linux-erofs@lists.ozlabs.org>; Sat, 13 Sep 2025 17:48:19 +1000 (AEST)
Received: from HUDSONZHU-MC1.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.eeEpWBi_1757749690 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 13 Sep 2025 15:48:11 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v1] mount: change oci layer option from "oci=X" to "oci.layer=X"
Date: Sat, 13 Sep 2025 15:48:08 +0800
Message-ID: <20250913074808.62500-1-hudson@cyzhu.com>
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

Make the OCI layer index option more consistent with other OCI options
by changing the format from "oci=X" to "oci.layer=X".

Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
---
 mount/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mount/main.c b/mount/main.c
index 5677031..f368746 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -82,9 +82,9 @@ static int erofsmount_parse_oci_option(const char *option)
 	struct ocierofs_config *oci_cfg = &nbdsrc.ocicfg;
 	char *p;
 
-	p = strstr(option, "oci=");
+	p = strstr(option, "oci.layer=");
 	if (p != NULL) {
-		p += strlen("oci=");
+		p += strlen("oci.layer=");
 		{
 			char *endptr;
 			unsigned long v = strtoul(p, &endptr, 10);
-- 
2.51.0


