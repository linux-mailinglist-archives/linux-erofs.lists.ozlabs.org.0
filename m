Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7137F4A4EAF
	for <lists+linux-erofs@lfdr.de>; Mon, 31 Jan 2022 19:43:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JncQq1PlRz3bSk
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Feb 2022 05:43:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1643654627;
	bh=5myrbfvu3cmmdcPGFCLfdbNYlG0krFEoOktQ+bLOeK4=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=Hr1Q+sToTns2kGb26/05wqZfVDLRhxFCYoggd787i9N+iF/GcM8A87zb3wZY4sz/4
	 4mZDZrTpkLclCKbFow/wRE+r6d+sdjvGNtJvIUg2kjaR7gALenDM4donblUaBV6bgB
	 HYttUUYmRhpLLQGoEC5I+eOd6SYhNSdxdCDeJTkVtOCLzALkVPNq7U0KurvKLtwuns
	 z3a0Oygs2d3NNtxbapn3ZOgK1tCowvpRXsEoS3ygtKrv2NRSzS/2PKJs5SeHvK6eIR
	 XDmzaQJhyR4f4WT6vo7JKcb7ejv/TZzJqd0tdSlzanxoEVMiEMLC/fCd3L2ZlOaBXa
	 pJvfXHHJHkVoA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--zhangkelvin.bounces.google.com
 (client-ip=2607:f8b0:4864:20::b4a; helo=mail-yb1-xb4a.google.com;
 envelope-from=31s34yqskcygdlerkoipzmrksskpi.gsqpmryb-ivsjwpmwxw.sdpefw.svk@flex--zhangkelvin.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=nNa5UNks; dkim-atps=neutral
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JncQh0J26z30Nb
 for <linux-erofs@lists.ozlabs.org>; Tue,  1 Feb 2022 05:43:38 +1100 (AEDT)
Received: by mail-yb1-xb4a.google.com with SMTP id
 t8-20020a259ac8000000b00619a3b5977fso10436460ybo.5
 for <linux-erofs@lists.ozlabs.org>; Mon, 31 Jan 2022 10:43:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=5myrbfvu3cmmdcPGFCLfdbNYlG0krFEoOktQ+bLOeK4=;
 b=WS6ZzMrCXsEaS5SzC8EKZ1WDWb1JOJciiaMMGbPlwTNdIKUYpcIMWciOYa/7AXdYgf
 W3ZGrBjup5QEaUgQghjsQFGwg3/tP5BjyaA5a8bn6kk2Sq+eOnNsP0vK3zv5mPmVYMXc
 QkRZYx0Snt1hhT20Aqiv4T1cyyjon3B8Gs52dQ/oQvqQ4lpdvP9luTP2V21SDbGQmPu/
 3UOe5xWs2JqrU0HoX++fHva2ee242Usiapqe5KIfx2acfxsOnkmx63uSjF/9PZX5z94b
 OZf+Yu6o3KW1BdqMqu9xXdVQPEXl3NShbmdMGcTvRVNFktmANaA6uTy1ekkU/AjsMUgH
 o4eg==
X-Gm-Message-State: AOAM532Rs0kM0Ocmxtmz9l2QxtxLkOKeJl4TnSJaj6F/W8JPi6q/wo7u
 ghIkfvkGOdSkLWdqM4rzeBKjfKsH/DjSfEcnkN1Vry22ZW9ksxSqfC/LY5+htt2wP+HF/oqILt6
 hybkZquT9ZUYYiFUG5m/Q6Qvk2U6t1Q39svPL8sMb3mKO/NyT8k5ZIUZTf1Eg6HpX+NENyJ2EV7
 ThXpDt5q0=
X-Google-Smtp-Source: ABdhPJyBHgmM/xvOivBmbaUqb69XRyV3j/GqDEVNxIxjxdX5TVO6PeadM2/2lROcnnfXF/tIkBszGHXZnSNAbO3WqQ==
X-Received: from zhangkelvin-big.c.googlers.com
 ([fda3:e722:ac3:cc00:14:4d90:c0a8:1f4a])
 (user=zhangkelvin job=sendgmr) by 2002:a25:c709:: with SMTP id
 w9mr31413698ybe.296.1643654613132; Mon, 31 Jan 2022 10:43:33 -0800 (PST)
Date: Mon, 31 Jan 2022 10:43:27 -0800
Message-Id: <20220131184327.30176-1-zhangkelvin@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH v1] erofs-utils: don't hard code constants
To: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
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
From: Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Kelvin Zhang <zhangkelvin@google.com>
Cc: Kelvin Zhang <zhangkelvin@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Use sizeof(z_erofs_vle_decompressed_index) to compute legacy index count

Test: th
Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
---
 lib/compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/compress.c b/lib/compress.c
index 98be7a2..c520a1e 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -359,7 +359,7 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 							   inode->xattr_isize) +
 				  sizeof(struct z_erofs_map_header);
 	const unsigned int totalidx = (legacymetasize -
-				       Z_EROFS_LEGACY_MAP_HEADER_SIZE) / 8;
+				       Z_EROFS_LEGACY_MAP_HEADER_SIZE) / sizeof(struct z_erofs_vle_decompressed_index);
 	const unsigned int logical_clusterbits = inode->z_logical_clusterbits;
 	u8 *out, *in;
 	struct z_erofs_compressindex_vec cv[16];
-- 
2.35.0.rc2.247.g8bbb082509-goog

