Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA21A133AA
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 08:23:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYZ8t3v0lz3c6n
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 18:23:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=43.155.80.173
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737012205;
	cv=none; b=Lvt5ojAwO8rbc4MAZ3Nss1BvA8jHKx6d8qtM4WGGsxKXf8D7aoOxrMl/1v12or//3KnOpAAW34gx6LPBi6bCj6fIJfL1eRWxKsBBA8VVFkQvq1RHsY+KldrBGKvkYB4e6+jTwe9kb39pXD4f4JypxOM6cAJBofC+KkifxKyKm9Qdcbn6ph//Ok20CwDPcHRUnM396PCuaB6AKKplvFhagGVH7Mv3UnoutzAqKLLn+vGztz+Etxh7PYu0ft8bgHdp/GI27wieprNcMQxlsbhgfEKixVcMam2gdruaVMpYFRXBU8jP4UO9Gd+Vt/iQYIZ6f7RW2SmCam+UyJFaRbCP8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737012205; c=relaxed/relaxed;
	bh=AdWzOTY6w7RvGayoavDKbI4N2wMWk2TvLEaUIO3pF3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CFNt4Gojq/yZiMgsRmp5/wbaBbwIpcUyCdg+A/L9dVleONN/M6aicbUgVmgReeQT53JK2/JsXGPOeB5evyv6onZ+icREtIkZulIiQPE/Vd34bDaevMLaSJukLj3Z0ou+1dEcDL5eSd0N12iOLrxjsrjxEVt9cqgUhMkIYClbK+tiejezFLsjjedXZ2R4N2NkSPElj/Wfwo2h9CqevxvcYPiNEJGdE6jBs8Ou/8CyUgffGAxmBBbrQtZaAxD22BonPmCi/gDyiPmMhmArpnKX508JS2AInEl2H7tx9SEQ0w6lkbx6nbouIHGPUTwxpUTD4UC25GA2Ol4ix/7yZCTjWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=or3t/yOE; dkim-atps=neutral; spf=pass (client-ip=43.155.80.173; helo=bg5.exmail.qq.com; envelope-from=chenlinxuan@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=or3t/yOE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=43.155.80.173; helo=bg5.exmail.qq.com; envelope-from=chenlinxuan@uniontech.com; receiver=lists.ozlabs.org)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYZ8q0r0Tz2ywS
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Jan 2025 18:23:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1737012128;
	bh=AdWzOTY6w7RvGayoavDKbI4N2wMWk2TvLEaUIO3pF3Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=or3t/yOExQ7hIYEnkiFHiAe4XQkWRW8QlUrAYhtAEGie4LVp4O2u7obON6vze5nBc
	 /6EpDfQJuG5KLjQQ8spXOwgPf6uo6gBGB4Pz3hUUJMUONNrAAXLEGD01txDUnN6MbQ
	 HPZKLEVVCi9JpOrR/sjmstifhvlWQ7rih71J2CL0=
X-QQ-mid: bizesmtpsz5t1737012113t1sesjb
X-QQ-Originating-IP: u42jBZHty9sdEqWRb61vcNXgVyNKCBqcsm2aLWkT2Vo=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 16 Jan 2025 15:20:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14316537599261247281
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>
Subject: [PATCH] erofs(shrinker): return SHRINK_EMPTY if no objects to free
Date: Thu, 16 Jan 2025 15:20:42 +0800
Message-ID: <433DB98624BCDF95+20250116072042.189710-1-chenlinxuan@uniontech.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MIXpHopat2IaojCmu/0MpuO+wRaGMSLEStnOjRPHZ3Gi1KEdghlrlsnt
	RqkSbwlwVYfFRltDlVFDpLOpyVmvVgzQ8MGk3qYvE0Yah7ijTR3CL25DxQ7UKQ0EwPI1wt7
	cCNocSIVsWtppgQb+fLAVWRupeEsiyj0aPtlDhVbb59ygJYFMXods6axdmYQsIZLwXNcAsL
	bc+o48NqcSHy5p4DB/xV2GCtAKy31RdVxLNOjhPFRe8iA6BxwdQ1WrwBhaSBHxZ9QLQDz8X
	vudUFK5ik0BaX4ia2v7LiYVwART4GMsmcBuZckDSbQF7gBWXd+3V+ofoHlfK5Iug6PGAprj
	6VwnWjOVOAxdP2SSXVWPnaLnLml9Vw7CmvtnwUvhut1Atek+LVHKSO14KYk3nuLtdR1zJJx
	o/mq4PbLKGmbqHQgyc+oFvfRvx14grJpC+01rWXGZ80aB9BDk8v7t9ZCofK0CNY34wxY+RR
	vxgmmTPKKyte/3enGd/bmDzyadOladbuc4KKjXgnrdIHSYCHkYyNu+FxajdiRK/rW95asON
	QjJSlFI7ahZNN/fnGYj0dJ+ggDm+Jl4ep+qLymIocwJutom3pohfUtMSNr2k+nAo1OTCqeG
	uSInlsI31nxsbb6Nw5mgXnxz1rutM/jCFza5nT8d+nAWeo7HeDBrnKWXdM/1eTmsp5MTcUs
	Zvntr5Xgi1xrsyPhmBG1NfrZEioY32NEp3cULLZqceqBStQyIyI7O5tUFnxyhdS9rFmZ72p
	DuhzmW0qKABan5jTWc2Qwq7JDVQ/hvQrgIeg0I0HxSOLdsj2s5TiuE5A6QErZcIDEZMQrts
	z7Utz3udTaZYMSLGw20P1IoqSfmQkS4hNCOueCMMm8fdLpFarVI2v7pQnsNotnc5vIP32KM
	LDQesvJzgFxD2NDpi0fkyItRdtvbLOoIMC+D+QaYGv2STZfZsTW9dCfnCIt/3Vs5vlQG5gf
	AenQ0iuvH6ss6x8Po1jL5X/O6KzK1yfe6h7pw4TKZRaiI53qbpEd888IxSGZrI/Ad2SM=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
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
Cc: linux-erofs@lists.ozlabs.org, Chen Linxuan <chenlinxuan@uniontech.com>, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Comments in file include/linux/shrinker.h says that
`count_objects` of `struct shrinker` should return SHRINK_EMPTY
when there are no objects to free.

> If there are no objects to free, it should return SHRINK_EMPTY,
> while 0 is returned in cases of the number of freeable items cannot
> be determined or shrinker should skip this cache for this time
> (e.g., their number is below shrinkable limit).

Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
 fs/erofs/zutil.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
index 0dd65cefce33..682863fa9e1c 100644
--- a/fs/erofs/zutil.c
+++ b/fs/erofs/zutil.c
@@ -243,7 +243,9 @@ void erofs_shrinker_unregister(struct super_block *sb)
 static unsigned long erofs_shrink_count(struct shrinker *shrink,
 					struct shrink_control *sc)
 {
-	return atomic_long_read(&erofs_global_shrink_cnt);
+	unsigned long count = atomic_long_read(&erofs_global_shrink_cnt);
+
+	return count ? count : SHRINK_EMPTY;
 }
 
 static unsigned long erofs_shrink_scan(struct shrinker *shrink,
-- 
2.43.0

