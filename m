Return-Path: <linux-erofs+bounces-145-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A8BA7CB99
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Apr 2025 20:57:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZVPq61Swdz2yqF;
	Sun,  6 Apr 2025 04:57:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743879441;
	cv=none; b=CODhmjapzc54hIf8dW84/+lwPbJbJnLCzoT31FQ5bECQTsmdQOqXCqgeEloHcDIaWPk44Vf/LG7ifSOy0YF87xZTHp3nUboVHP2JAs/hh3ifl8YD585v8FVH70IiA20dMBUf7e37buNKHfdQqxuzvZiquo+e45JRXkhtHdRNLB9BvJFEQQVSSBcp7AK749TYaS7PjCi4TPMeWzOR1xXa5/aMfc/xU/OCI/rKL7lDnZ5NYY9QXqjSOxjwGZSKGjM5gvHdWb46k3I8p1djXi5+Z9vqstzYs3dLgSk/w1OyFxwDehK4NSp8DA4lgrtp//hDpjX12+illw0ySTz/2zRvkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743879441; c=relaxed/relaxed;
	bh=rXWcuOcKhl6BMhcOjflvAwyOvqqH5OhrI4k7T7YSj0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tf5nnY2bLn3VnyselfrDj4ZjYmuZLT5CWQUrtJWkaSZBWjgSTXRK18kscjRjgnQ0nHF/xeZUTadIqtTunniO4aJjCwAVVFhNdfR9kb+pAx5MK5J1Mf0HG4y/4stZOTnJ3BABtqyp3c0rHFBKbz8Qnq5aUnv33lrU3/Fz7ZmPpn6f/1ozfsGGhZQRoJkYWT4omr5nRJVt4xIb+kpfQmZ90ndjDDrjecRMnV4cBIU1F8s31PSGGyMRD03Y0sHmUasJcgHigZd4xpm6eAq90JFLlxcsGaBmEp91uAx9RhDHUDdiGxrh6j67DQmON/WTBErkgXH/nh/K3yeju3DNZDgs3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pgZZNziy; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pgZZNziy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZVPq41452z2xRs
	for <linux-erofs@lists.ozlabs.org>; Sun,  6 Apr 2025 04:57:18 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1743879435; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=rXWcuOcKhl6BMhcOjflvAwyOvqqH5OhrI4k7T7YSj0s=;
	b=pgZZNziylpwUGgjRnsdhoOCe8n5RJn5K3J+VL/hjZzC8WeBP+vJ0WQGUrSWZ290NPWSTeh7mFjkLkEPMmporgfKQurjcbNFihvBeYJRPksDT3uRcHjUYxQNkqBqTsrb0SWX2hi8psYDQnakQ1yABCRsQwdYgizKXF9N6E09gJTU=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WVLL3Ng_1743879432 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 06 Apr 2025 02:57:13 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/4] erofs-utils: lib: drop unused `ret` assignment
Date: Sun,  6 Apr 2025 02:57:05 +0800
Message-ID: <20250405185707.3202298-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250405185707.3202298-1-hsiangkao@linux.alibaba.com>
References: <20250405185707.3202298-1-hsiangkao@linux.alibaba.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Coverity-id: 548921
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/compress.c b/lib/compress.c
index 4b966d8..bff0e0b 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1202,7 +1202,7 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
 	}
 
 	if (ptotal) {
-		ret = erofs_bh_balloon(bh, ptotal);
+		(void)erofs_bh_balloon(bh, ptotal);
 	} else {
 		if (!cfg.c_fragments && !cfg.c_dedupe)
 			DBG_BUGON(!inode->idata_size);
-- 
2.43.5


