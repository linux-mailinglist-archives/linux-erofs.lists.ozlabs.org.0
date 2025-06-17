Return-Path: <linux-erofs+bounces-436-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BC0ADC6D1
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Jun 2025 11:42:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bM22x3pBBz30T9;
	Tue, 17 Jun 2025 19:42:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750153337;
	cv=none; b=V4eM6w6pVzffNbt/fSDaS/dyxsev3bTNlGvxomvdWWZETgWo4WmsAO8M35Q2l7RoJ8m9/IpcreNmVmpWsFLFNtRUjnt51rdpw1p9rKOg7zG3q6V5TuxjrfP8yDYVXzVhyB1bk+q75yY4RA6Hz0WtPM+KIIVpXGCS+680BMhFCUZqx2sWRA+yZNlsh32pgg8fdoLn6wAER+WTKzbJCmjJZLuuSGxm2R6+3tqyJ+7uul2P101Ab1W1tu8hKsc0U9XKbPpdswPmE6lo4c/DFkM5nqF80R3pNXzYoLka12oaek0aR5U+GR4XL/58UNJAyavMGwd1IGDkKwSDMHYYa39bwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750153337; c=relaxed/relaxed;
	bh=btgETz8gblwBZr1BVSyxp5VIZgp8dPEXK6kl9hpz2XE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bv0bzvhhILrAkTnNt/Py5XSTUDGLybxXXi/ctUsoxgx5JXKyHFJXM6h5B4uvJupPEAav8XGTt4g++zby4lrzDD38hi3YO/znMg8FMTmoxH1BGF1ZMRfC5uZeQvl0UkZSFToINaw/VzPBs2VYXGFsTRxaVkpteY6x7C44d2gXJKYitdljUTNZk0XA8mRUkRR6faStuHEJXqpYwEHnMtGsx1NgYJ2lywc1sZGXED0fd9mgtHGvmpQLWeQbTHsIlefE1hKvJ+DZXkUe1W4Nz/sRYu6JX4dk2tdl0iVOzr1PsACGwRRqUHYrNEmkiVo0J1vofMZ7ia2kD66ZVBkUw0TuYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tL14vyg7; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tL14vyg7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bM22v3kxSz30T8
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Jun 2025 19:42:14 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750153330; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=btgETz8gblwBZr1BVSyxp5VIZgp8dPEXK6kl9hpz2XE=;
	b=tL14vyg7wJG9bY99NsimQB1QZ3BY8tO8+w6GMWkFwNL+viudy9HelxSP6+FH9p8rESoY91yInyLokb57iklftMS5nc+her02Puc1c64OCcCNNDB7IJA+K2/SnV6hZWESPE4sAfGnabDjJXhz90xJNK+tyfU6ZWyhezL2mMuxbC4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0We8vjyz_1750153324 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Jun 2025 17:42:08 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: lib: fix two integer handling issues
Date: Tue, 17 Jun 2025 17:42:04 +0800
Message-ID: <20250617094204.3562711-1-hsiangkao@linux.alibaba.com>
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

Coverity-id: 554931
Coverity-id: 555116
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/super.c | 5 +++++
 lib/vmdk.c  | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/super.c b/lib/super.c
index beab74e..a300a5f 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -327,6 +327,11 @@ int erofs_write_device_table(struct erofs_sb_info *sbi)
 		return -EINVAL;
 
 	pos = erofs_btell(bh, false);
+	if (pos == NULL_ADDR_UL) {
+		DBG_BUGON(1);
+		return -EINVAL;
+	}
+
 	i = 0;
 	do {
 		struct erofs_deviceslot dis = {
diff --git a/lib/vmdk.c b/lib/vmdk.c
index 06d4a49..8080c51 100644
--- a/lib/vmdk.c
+++ b/lib/vmdk.c
@@ -60,7 +60,7 @@ int erofs_dump_vmdk_desc(FILE *f, struct erofs_sb_info *sbi)
 		const char *name = sbi->devs[i].src_path ?:
 				(const char *)sbi->devs[i].tag;
 
-		sectors = sbi->devs[i].blocks << (sbi->blkszbits - 9);
+		sectors = (u64)sbi->devs[i].blocks << (sbi->blkszbits - 9);
 		ret = erofs_vmdk_desc_add_extent(f, sectors, name, 0);
 		if (ret)
 			return ret;
-- 
2.43.5


