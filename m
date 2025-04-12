Return-Path: <linux-erofs+bounces-196-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 211BFA86D93
	for <lists+linux-erofs@lfdr.de>; Sat, 12 Apr 2025 16:16:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZZbFP2Cd1z30hF;
	Sun, 13 Apr 2025 00:16:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=5.199.136.28
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744467369;
	cv=none; b=KHaCTOpjuIRsbLLWlFfvH2TDopBtyy2kQKgl04qY8gWg3lIEYm26LTQHEwZQtCSnriE/t9yDuhWEpMrEONjVlT2kbVrMC+nSeJuzK/KQtgv0+eZ8SgZDGiRYjZKXUsoP7d5jxGbg88ihwXpvSlnv2ILk6a9KfKMLV8wakGRKNENbmAAETO0017lUU1oRjhV2ylNUeSIZ+ABpLqhyIfIJ+TxqV1tw9kVhQ0WPWZh7p2pWHRqJBBU+uwHz1m+PfY3lJbww/mVadDe91Vqdnm1fj+iE1p2fWkqhM/zu4JkinTQW3Ouml4xuTx+f2kA8SfmkfRpoyWMLNy0wpe8H33CHBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744467369; c=relaxed/relaxed;
	bh=2eYcc9iagiRSkffTNOH2pp6v9FqlkPr6nivkhdioa8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BHYaFzomjMf0ZKxRDBfV9o9RtnyS/7v23ynB02YXEyWKOI0EcX7xaOzUq8vXkvie6x9yslTjgkmTricGJnXQ5iM4BDpVe1BQbZ27b+uLoYqgVMDzAm59KL5WQQ3UGtNZUgW1SAIgeAKgIX1Yrr+aPzP1euL13z1WkGv8XCmvKYXxB7uIuJGGQ/CYrBu/E4KYk3/sOecGj9zs2+FNYFrD0lI0lwehyqtb8wWXwQsuNxcVPf8u0BfLyT9ZgWnwZRRDKJ9cIGaQZEvLOxmTntb0jtZhfg/lEs6tKNh9yUHpI7f3hmcQ8mcmgUUIiYDSNMC3Pl7g4FePWsZ+Brtuft9YcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=envs.net; dkim=pass (4096-bit key; secure) header.d=envs.net header.i=@envs.net header.a=rsa-sha256 header.s=modoboa header.b=ngpbSQsc; dkim-atps=neutral; spf=pass (client-ip=5.199.136.28; helo=mail.envs.net; envelope-from=xtex@envs.net; receiver=lists.ozlabs.org) smtp.mailfrom=envs.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=envs.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; secure) header.d=envs.net header.i=@envs.net header.a=rsa-sha256 header.s=modoboa header.b=ngpbSQsc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=envs.net (client-ip=5.199.136.28; helo=mail.envs.net; envelope-from=xtex@envs.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 354 seconds by postgrey-1.37 at boromir; Sun, 13 Apr 2025 00:16:03 AEST
Received: from mail.envs.net (mail.envs.net [5.199.136.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZZbFH2Lxlz2ypV
	for <linux-erofs@lists.ozlabs.org>; Sun, 13 Apr 2025 00:16:03 +1000 (AEST)
Received: from localhost (mail.envs.net [127.0.0.1])
	by mail.envs.net (Postfix) with ESMTP id B1B1038A4037;
	Sat, 12 Apr 2025 14:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=envs.net; s=modoboa;
	t=1744467002; bh=2eYcc9iagiRSkffTNOH2pp6v9FqlkPr6nivkhdioa8E=;
	h=From:To:Cc:Subject:Date:From;
	b=ngpbSQscUUi91IuhWlnnrkToYEqDFqGEK3cC1dhn/1ZZq6IfKjkQcAcndeCtXwN3v
	 WwxXdIlTAs18Mda0LSwMnxI7/PZTjl1KMgmImuBl8+vtlE1JltpTZKYZWKj2x9MNGV
	 jQo0YM34r6ETZxO5WrM28nFzup+A7DsRCCLmdESNJhyFrOKgciFemaeWZQkIZSiOWw
	 RwtfEZPe3h9GgKN+K452F1hHLpG8a7aorRGdJF62DLBClRTsDVW9eGIeJWbRyY6G60
	 Dlin4elW4G9wAVzvfRXJmosdSOrh6K7gTwuqf6FgTlfUFnUpjtAGqMH5uG4+9OZZGO
	 9ISfwH0dgsQArxV0vx3qXVAai+G56EUFoYGeDpCAr+8n/hoJGveNvRmhM0VoEBQnT4
	 bgTO1ImoR4XudIUXEXN9QqdBSV9tlMmOBg1P9X+sE72NQllRIuppqaFifE9DOF8+Oj
	 pVd28tDsT5+oP/sFxBrfG/2rAio24vsS3dQBa7dODf1T7v2Q19DZKk/BXJ0AduuCLZ
	 8qyg/G9GDiqR1MamHKuHjq6v8McRqGIF/mHBg3V7UgRyR/M7LxkrBQ40bcv95WD2Nx
	 N+wG35rJ9qy66o3lYCKON2ZfIDnchyv4EbkKJnpU/2H3rBTpK6dZ8rt5HIs2rnQAA+
	 85ThQcXmdokAR9gEGWl/v0gw=
X-Virus-Scanned: Debian amavisd-new at mail.envs.net
Received: from mail.envs.net ([127.0.0.1])
	by localhost (mail.envs.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id h359pY2B7BK0; Sat, 12 Apr 2025 14:10:00 +0000 (UTC)
Received: from xtexx.eu.org (unknown [223.73.102.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.envs.net (Postfix) with ESMTPSA;
	Sat, 12 Apr 2025 14:09:59 +0000 (UTC)
From: Bingwu Zhang <xtex@envs.net>
To: Gao Xiang <xiang@kernel.org>
Cc: Bingwu Zhang <xtex@aosc.io>,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] erofs-utils: add contrib/stress to .gitignore
Date: Sat, 12 Apr 2025 22:09:38 +0800
Message-ID: <20250412140940.88303-1-xtex@envs.net>
X-Mailer: git-send-email 2.49.0
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Bingwu Zhang <xtex@aosc.io>

Signed-off-by: Bingwu Zhang <xtex@aosc.io>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 33e5d30a9cdf..348896103d66 100644
--- a/.gitignore
+++ b/.gitignore
@@ -31,3 +31,4 @@ stamp-h1
 /fuse/erofsfuse
 /dump/dump.erofs
 /fsck/fsck.erofs
+/contrib/stress

base-commit: 3689cbc2349bff05807d2f939146e92eb1bfaea1
-- 
2.49.0


