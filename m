Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B86B9FF8E0
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Jan 2025 12:34:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YP4PQ04tyz3020
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Jan 2025 22:34:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=47.90.199.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1735817687;
	cv=none; b=DgCNnLBpoThTVIPQg2RuIkur/XfagIps/RklnwUKOWNBYTvRBUi1pcbszfXctXGl0hi3Vxp+ldB4POZlwuchBxk/T0GTq3MDL2S9cGBX28JD++fCZ5fjLtqziHrCsRdZJoySFUwAuuaWfTyywuCReUeTt92m+X5Wd0AyZZ2jaIqrQUHjXV6m1VDoxcghxwvId0bFJ84uXD9IvRwAdatPOlaGmEBQNqNLt0aU9hYmBywxv5TfKkOOtncHrmkXUyH8cYlZNGKWV5Y6YlZT92cpet1SZ1Ce+sdMIv7UJ8MqvYgn23/8TzlEFtXEszhw1MXrj+HlEKhvskgWQV0H58YsJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1735817687; c=relaxed/relaxed;
	bh=dLIYHBY8LK/NUDhjYzvcP2dV884bwmFWj4/1fchWhKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dftuAL77EShD4IoWNiBiJqqY5y/TxH4MQt+jdZ0U96ZXqpcX1oHbYLmkKosWhaaxQlgx9a5dEdyL7Q40joOx46dg6iwIttC3b7f7BW05jHZyU0XQ5Fs41p986e+9wTQqGoujEhtU79B/WD+K2UucZSlbiXQsXRyI5LJpc942xH0zGxX2DA1d59LTKxzhvz4guh2/S9yWBCc92bwKXt6OjT0Pnw2yQgPJdlVlVhtCw4oHBgYurXO5CTLQANYO/5UBcQSKw9aAmxS9tQIJLRwWnMtgKHIikXl8R5GuU6R12CMLSkgOx0oixs02QwjfPIZVETkWaAbbRShzjIt9I6c+AA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KWTLljUj; dkim-atps=neutral; spf=pass (client-ip=47.90.199.11; helo=out199-11.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KWTLljUj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.11; helo=out199-11.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out199-11.us.a.mail.aliyun.com (out199-11.us.a.mail.aliyun.com [47.90.199.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YP4PJ4jWvz2xbS
	for <linux-erofs@lists.ozlabs.org>; Thu,  2 Jan 2025 22:34:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735817665; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=dLIYHBY8LK/NUDhjYzvcP2dV884bwmFWj4/1fchWhKU=;
	b=KWTLljUjRPnQpqUa8StakREVLpVMj8PmONqtzr2obN8optsyd9aYhfzDQl4mFzt/xnZyimkMp8URopGLFChaaiX0c9+NP7Rbpp/7963eGPz61LxNo/4at2ipWcjUTOaacWhcH2YAcyn1yTboFAaG2X5fMS3TnBaIP+jt5Oav04o=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WMoC2sy_1735817659 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 02 Jan 2025 19:34:24 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fix -Ededupe crash without fragments enabled
Date: Thu,  2 Jan 2025 19:34:18 +0800
Message-ID: <20250102113418.3246744-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=disabled version=4.0.0
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The root cause is the same as commit d9baceba7026 ("erofs-utils:
fix -Ededupe crash without fragments enabled").

In fact, the fragment manager should be reworked in the next major
erofs-utils version to avoid those dirty hacks.

Fixes: fc880e31b7c7 ("erofs-utils: mkfs: minor cleanup & rearrangement")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 mkfs/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 7d559d9..27c333c 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1450,7 +1450,8 @@ int main(int argc, char **argv)
 	if (erofstar.index_mode && g_sbi.extra_devices && !erofstar.mapfile)
 		g_sbi.devs[0].blocks = BLK_ROUND_UP(&g_sbi, erofstar.offset);
 
-	if (erofs_sb_has_fragments(&g_sbi)) {
+	if ((cfg.c_fragments || cfg.c_extra_ea_name_prefixes) &&
+	    erofs_sb_has_fragments(&g_sbi)) {
 		erofs_update_progressinfo("Handling packed data ...");
 		err = erofs_flush_packed_inode(&g_sbi);
 		if (err)
-- 
2.43.5

