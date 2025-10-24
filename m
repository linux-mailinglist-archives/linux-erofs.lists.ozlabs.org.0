Return-Path: <linux-erofs+bounces-1283-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A13B6C042A4
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Oct 2025 04:51:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ct6qR0DdDz301K;
	Fri, 24 Oct 2025 13:51:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761274290;
	cv=none; b=GwDwVjfkzIDxqjE8Of6jf1xJIZ4CwfLHaa+3iSpK1oGHknPKF9yHC19Tzi7mianzpiA6KvTv6Gmh7KzwZPpGV/C7FOTf83ZoQdB3cOguHCgxKeN61Z3GQskXip/1sE1PTlsoAq6PsbqLEtFcDjZFB7s8IlBGK3GCSzJgzftrp25PJaIYv+2s9CiF4hflS2uMryeeBmzL8L2BXgBmQ356ZxKRXULYIWd8rJYPRiyExjpJnGkXSMV3B3yLiW4G973rqwvuk3UofJe7YH6VtbnQlgss/6Bk9fJSO3FmgDRa5zcY9jWzkN5r/qUBUXgi7IhSFXzivJou/nGMmHl6sfFImA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761274290; c=relaxed/relaxed;
	bh=m7u4naaZ1qKpjmD+CMxXaUPgz/XIO2c96G5SpUjOYN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EWCmxdbIH9C2NbcYM4DcGl1PPx6nwLh/8bh5A3KTMM8J9uSPApsaonh5WaTZs+j0Or8d1HF1yiAau1K4tA7kdg/1mR3K0McIcziUURJW9QTEwd2mDaMpXgWnyqNnNbHaN4sJ5z6+pXRc9ebOW815T1tVe2uWtTqi+PPP4yAcJFcQwknyA6M8lucsV70k0EqNy5Dl4CC7nss8FOz0u660mBH9G8ImC17OshVH9rhaclhOpw8/n3gZs5qW3sfDCHetRET6Rgg5/yxuZo/EISaMIhAvwWWXQLHdR2fc8/b6iAardrrGUVyadZm5OnKe3Don23Yl0i8C8K0e/u7po97UVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=swwAjDZv; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=swwAjDZv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ct6qN5glFz2yl2
	for <linux-erofs@lists.ozlabs.org>; Fri, 24 Oct 2025 13:51:27 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761274283; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=m7u4naaZ1qKpjmD+CMxXaUPgz/XIO2c96G5SpUjOYN4=;
	b=swwAjDZviS24VOYdcIco677KzYQwsnIUlO8AjaAJVHpauuDoVrqAL8s3artpjqu/u9PapHj0hbjiEKizcjdSZwgOMP6ef01UfiDselsqIlwoXw1qqdvZfPayCInXKhpAJdncMKldtBJb2l65aynnuZDRukW5BxEffzOUnfYYLWw=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WqshyFa_1761274276 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Oct 2025 10:51:21 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH] erofs-utils: lib: gzran: fix corruption due to incorrect dictionary recovery
Date: Fri, 24 Oct 2025 10:51:15 +0800
Message-ID: <20251024025115.2818034-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

The dictionary was incorrectly copied by only one byte, leading to
corruption during gzran read.

Fix the memcpy size argument to copy the entire dictionary buffer
instead of a single byte.

Reported-by: Chengyu Zhu <hudsonzhu@tencent.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/gzran.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/gzran.c b/lib/gzran.c
index 47d660d..527a366 100644
--- a/lib/gzran.c
+++ b/lib/gzran.c
@@ -362,7 +362,7 @@ struct erofs_vfile *erofs_gzran_zinfo_open(struct erofs_vfile *vin,
 	for (; i < ios->entries; ++i, ++c) {
 		ios->cp[i].in_bitpos = (le64_to_cpu(c->in) << 3) | c->bits;
 		ios->cp[i].outpos = le64_to_cpu(c->out);
-		memcpy(ios->cp[i].window, c->window, sizeof(*c->window));
+		memcpy(ios->cp[i].window, c->window, sizeof(c->window));
 	}
 	ios->vin = vin;
 	vf->ops = &erofs_gzran_ios_vfops;
-- 
2.39.5


