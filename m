Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C76D399E42D
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2024 12:38:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XSVvP4LHjz3bpN
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2024 21:38:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728988736;
	cv=none; b=QSqNXjzMdPS4J91m2isb1esYZKW7d1uCAaykq7hMU0gkhqwC1oocHF6BM3JVl6jNFp7rbMmOWvVADSQXC/HLlkjslzU3yRbPwP54EHFrTSI0sUT8A3p99yv/nV/zgjo/ngfRhPD6EAJuL4BOHBOZBm/d274lbTlaOyZ25a7vvDT1NJLtMZclTY/2Ht+geNCHPdl6d4DXZVB+ojdlXCNt4tYgboy8359Sn0JZXWIS3ujB7m76IcR+KGXi+TbXVr3wgS44j7qVMMU2dZQRkqVkoBwSrfMU9qJx/t5cGBP83PQNYPzsc1zj7M3frQWSPqaCYV5jjaiiWSJap3dIp/sL6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728988736; c=relaxed/relaxed;
	bh=zbwwe56n6BEAFKi92J7UJBALAvIEtYC5JMMy8xDigbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=li4iVmuEJsdWfjG03oEcOX2Z8L0njhC8lEzmVLLbLzlamxBtP7/zoFW8tuWiV8ICD3xdiNZRaRKVtz4s82P1yDHaJ8L7rgtYn/FyaioOUofBis4fOB3W5qg6phhFEZgzGXxAVsRwVI9EyrX8OfWLsTaIe14RdNHIpxqIUPVQA/JDCCMTl7TleelSKU2bl1YjCBSfgQ4b3YiRONRazoXC+aLTAebJIyTMXaDMLIkhw/9jtKeKcSQT2cyaR0Sdbmhl9UsC1noGzBZcojQmFsd+dIMNMCWI6fTUKHZ80IG8gYHAbzMi3xNBWx+MHUPchLRBsS0pDZiX6vpuMdMqfPddRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YafX1C9+; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YafX1C9+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XSVvL43wSz3bkf
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Oct 2024 21:38:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728988729; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zbwwe56n6BEAFKi92J7UJBALAvIEtYC5JMMy8xDigbg=;
	b=YafX1C9+XhobTSJQ7HtH4LHrtABGUpYZwX7+gYQjuWOV3WLFM2QNSrg2uBPq3a5V7qg2ctnwohB85mthig89nNHkiEs0up8GZzSghY011VFwfpYflG37SONw9kkMV/A0yJ6yeKB3h5cuZtiafx/mNPc4/2eyTO9LzBD0Yg3MSRs=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WHDQB3x_1728988727 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 18:38:47 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v4] erofs: fix blksize < PAGE_SIZE for file-backed mounts
Date: Tue, 15 Oct 2024 18:38:36 +0800
Message-ID: <20241015103836.3757438-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Adjust sb->s_blocksize{,_bits} directly for file-backed
mounts when the fs block size is smaller than PAGE_SIZE.

Previously, EROFS used sb_set_blocksize(), which caused
a panic if bdev-backed mounts is not used.

Fixes: fb176750266a ("erofs: add file-backed mount support")
Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v4: Remove unnecessary parentheses.
v3: https://lore.kernel.org/all/20241015070750.3489603-1-hongzhen@linux.alibaba.com/
v2: https://lore.kernel.org/linux-erofs/20241015064007.3449582-1-hongzhen@linux.alibaba.com/
v1: https://lore.kernel.org/linux-erofs/20241015033601.3206952-1-hongzhen@linux.alibaba.com/
---
 fs/erofs/super.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 320d586c3896..14031141bde8 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -631,7 +631,11 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 			errorfc(fc, "unsupported blksize for fscache mode");
 			return -EINVAL;
 		}
-		if (!sb_set_blocksize(sb, 1 << sbi->blkszbits)) {
+
+		if (erofs_is_fileio_mode(sbi)) {
+			sb->s_blocksize = 1 << sbi->blkszbits;
+			sb->s_blocksize_bits = sbi->blkszbits;
+		} else if (!sb_set_blocksize(sb, 1 << sbi->blkszbits)) {
 			errorfc(fc, "failed to set erofs blksize");
 			return -EINVAL;
 		}
-- 
2.43.5

