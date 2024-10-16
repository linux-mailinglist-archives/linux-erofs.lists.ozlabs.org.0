Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21859A0E18
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Oct 2024 17:25:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XTFCx1ZLjz3bqq
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Oct 2024 02:25:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=43.155.80.173
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729092346;
	cv=none; b=nCwfgEIAc1HntoIDkgUIvA5kg7mZ+QTmBvAyyeyUfEjpE5d6hWtOAE3+rBT0P6DHUOisg//ocVHhB4iUVEPzWxI21BBI50Hs2xES0WzVX/beaGAO+jIF5Ib8vWra7VCxUEBh65aHapkDMVQjHlZqIHAAXCRcNQXhm/CNi9J/K/tV8SK39bi939N65S0VFzqnxtvK3+f3mUwakPWBad7JUd7dmpEeZy3wtqoZiStQUGFgV1/boo7Htz6+t0Hn/FkJ10XN/d6I2EeMSbZ/yPExk11Z4CzFJxTXOBPcKR/M9KtTRIMduBqrBrXtiZqMuvuWWANsYDDwlAEgA07J+Xzi2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729092346; c=relaxed/relaxed;
	bh=zB82FGDIZRSlwTU6LrA47k2enlekK9Q2dWwFB2jmb4I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LUm34TT3Ott78roc4eRMJ8olgwjX7KM4Qx7/EojP6KEuLvCzDResftrQ9/q9MNyPdnz1tK8ud7oEZQXP5lJujTZS2ATxSnoPjtu+80+LnmJktGi1QV2MVTCXMUfvGF4fobItwvE+O7LLW/YqUwZDqgRQDIM2eTMMl4GPZemqY4ZbBugycteUYdgfSYkuVb1717bYSWS2E5R8Nie1WFauBrV7Kokl2NBgva7xozJXpLQsBTjwGg+QaHiDe62Euwt+8ninyz2bTKuN6HRXpP7QJ3guqJaQLRpladXL2b5GCpCvSVmOsPpEScCxSEjH8DVGXZgrJeYzQ6xOffxAofBgfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=gIn81/ID; dkim-atps=neutral; spf=pass (client-ip=43.155.80.173; helo=bg5.exmail.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=gIn81/ID;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=43.155.80.173; helo=bg5.exmail.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XTFCr4fpJz2xjh
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Oct 2024 02:25:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1729092277;
	bh=zB82FGDIZRSlwTU6LrA47k2enlekK9Q2dWwFB2jmb4I=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=gIn81/IDe+E0GdLwEAs2Togd+6ylTL6seK2eRGEG5aDfCVutku8hO8BGWS2PsY42t
	 IscwjRcKoY8qsp4nuSqsCap8jUuHl1Wq6T+xMBT6J8XUB1ucPPckO3a7A+31tvh692
	 9BVXTtAI1aozj2moI6GItSEg1gJPhCUaPYWVdbeQ=
X-QQ-mid: bizesmtpsz6t1729092272tgrnos5
X-QQ-Originating-IP: 4MrB3UtA303O6nJ05J1HTcZjMebOzESjmRzYyvDcUKM=
Received: from localhost.localdomain ( [125.76.217.162])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 16 Oct 2024 23:24:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5984523009251058252
From: Gou Hao <gouhao@uniontech.com>
To: xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH 1/2] erofs: using macro instead of definition of log functions
Date: Wed, 16 Oct 2024 23:24:29 +0800
Message-Id: <20241016152430.3456-1-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: N8vItbyl617cu81O/yaOxLEZRsIEu0zG4MbQaY5huTwY/2T/fWvFeG6a
	XDw9Gdm7GRMezg2yyhHnTZ9nW6gShWmDDxxjCPLH9ojHuVwPw5rXGG0/aKNc2Q37I5wJ2WN
	bYAy4ENiNAnJmwn3bEmH+7ijcUYjxKSXLhgHAxdced5pqtfnPXHM+W5wWvUUewI271YC0Ok
	hCZFK5JmGG/nUweI2rY5uzOyJOnwAcEil8cBS7NHJNq5UIFw72kgxAIhQsmAEUrGYY/OYfG
	hqQQSfpzRyqiwzG5fn03oGCGkOjcPdNVeaWjRJrMXRRD1fvnyrOxNfTRNimT3g38Txv+AWZ
	ZjmIv7ALz9sT8uROBWDF+e0Flme6BvjOY7g+46Cq4J8UlI1uNgT5jrrSBum/HN8dYDIceIe
	wbSYDx0EqScfvLmu0W84AlDuVeDy5zZvl3LoafeZv2B0c7OMcW20tQX/ryM8Ks8qMKq5nRA
	hqBDMBzMhTQioSAHp3eo7lu/mLOaz0mDKgsAEpmK/l52l07tYO0amUp2HshANSNpVzt7N8t
	y67XFFbo3wgjuvg2z9CZrhbSnGgBVyFDZ/0jgmeih/dFZrtBffsTrNUKKXETi6gvWqTUZws
	FpPjF5LQ8n0A7Z03+ibuV0MNRXX0y66vnTUufantXKaymfDMBOtcGa2UguRnnaRIzjiMwwK
	BE3hk19/NVX1kXKV+SSllcEsuFHZqfVww7rrgAt/8zpcrYBbL3mwYmA2K3c3BJ7l1M2Fql7
	Dro/5k3qpA/yWMUjTXNgIk4mjVMbHOyl1gNDfRW0CWUe5m8+ysoMG5iwiiAuy56N5OFHF/P
	LYPNkR7sQH0nBL2M/ErzBkZCUvdBQzbZuz3aOgtOo53kvqUGm96Tz1veSyAV3xJ9VgVBnTJ
	YmvgPOH2CP2ByasRGsEoxLMXmcUe/bbuojT2JMtH1Kjf1EDkcQGY3m6h5vuGqmAlwu4LfrZ
	XRDPJUbs5pS6iuPNkfYTzLsMvLSjjNEzrCSiIhek3PcA8s1PQzbtua9zrIzkRSaSLOzMkTF
	PBpZwvDKimK8LmwCEBD6OIc2IOSmM8sVQ9bFn62g==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: gouhaojake@163.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

No functional change intended.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
---
 fs/erofs/super.c | 51 ++++++++++++++++++------------------------------
 1 file changed, 19 insertions(+), 32 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 666873f745da..b04f888c8123 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -18,39 +18,26 @@
 
 static struct kmem_cache *erofs_inode_cachep __read_mostly;
 
-void _erofs_err(struct super_block *sb, const char *func, const char *fmt, ...)
-{
-	struct va_format vaf;
-	va_list args;
-
-	va_start(args, fmt);
-
-	vaf.fmt = fmt;
-	vaf.va = &args;
-
-	if (sb)
-		pr_err("(device %s): %s: %pV", sb->s_id, func, &vaf);
-	else
-		pr_err("%s: %pV", func, &vaf);
-	va_end(args);
-}
-
-void _erofs_info(struct super_block *sb, const char *func, const char *fmt, ...)
-{
-	struct va_format vaf;
-	va_list args;
-
-	va_start(args, fmt);
-
-	vaf.fmt = fmt;
-	vaf.va = &args;
+#define _erofs_log_def(name) \
+	void _erofs_##name(struct super_block *sb, const char *func, const char *fmt, ...) \
+	{ \
+		struct va_format vaf; \
+		va_list args; \
+		\
+		va_start(args, (fmt)); \
+		\
+		vaf.fmt = (fmt); \
+		vaf.va = &args; \
+		\
+		if ((sb)) \
+			pr_##name("(device %s): %s: %pV", (sb)->s_id, (func), &vaf); \
+		else \
+			pr_##name("%s: %pV", (func), &vaf); \
+		va_end(args); \
+	}
 
-	if (sb)
-		pr_info("(device %s): %pV", sb->s_id, &vaf);
-	else
-		pr_info("%pV", &vaf);
-	va_end(args);
-}
+_erofs_log_def(err);
+_erofs_log_def(info);
 
 static int erofs_superblock_csum_verify(struct super_block *sb, void *sbdata)
 {
-- 
2.20.1

