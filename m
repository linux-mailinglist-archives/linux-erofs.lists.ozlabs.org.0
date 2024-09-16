Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DA597A324
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 15:56:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726494972;
	bh=wrfeI6c5Fy2/wr4QW/RT84D3Z/gYFwXLPq/0MCJKzS4=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=e59fQ+z/8JneZ10Fnsj8cMAjma3XgHlvLfrYcuxsCdOKFbkz765nzoL5DjxL0Rpie
	 5/dPg584uamUADnDSYS3OACly8zO6Hh7J7RgKpgipHS0QRPl5lndZ3Hu+vuOAF6pG0
	 AagwJNuvtPmmv9lUFx092t37BiUKiHm5HZkApfGQCLEVwImOdDDcnBkyOynlDnv+5x
	 6VPTcAaQDy9aUcEmANTxPdk668TmieM32SSA8fZnJ2yOw3kWrNweJvoBLZTOepASwC
	 oTNsq2wPuQ+A+uG3R356Qd4dLK9N0ITw3mSTfrRVafc4y0gqPqh3MYo4FkCqEq96IG
	 //TaIyRYFWM7g==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6mfN3djqz307f
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 23:56:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726494964;
	cv=none; b=XhJH2xFy2S/iE4M17Hc9LvG8E4AGT52VFWpQefhvnN5eAT3oWD0vu9mUI7XBF9cR1UaEiOi7z928CNdKYZIoWEcxih+mxJ1bbBQSQwpcIvaZWHDfgfRDJRZOayhS0h4UXeYIimckzAdBMCMig5nJqFyf2dT4EcrQ5oc6IN6suWfC4HqZtLzgAfbvkyuHd8/DN0hQuk9a9xNRBGiMwXWa3yQBhaGbB6JsGmbGN+IiaVq0YkTjYVrKp4VONNrC7/HxAv8ZdVz9VeCFj4ZtxpdcyXNqwuz0TkW5JTP4pmq/L39dQZm0h/hz9leOuDq9nm8thb4CC1IJHKIpyr51o6gARg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726494964; c=relaxed/relaxed;
	bh=wrfeI6c5Fy2/wr4QW/RT84D3Z/gYFwXLPq/0MCJKzS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWJFjfCOGbOZRvQO45rmxxKH9G4dhmHFbdTeQrcStnqEoZE/oScJ2TTMHVX8FT/XLXpcyIxWtqS1EeEyhs2vN2d+JB9SD5unmsQUb/KwCUQNdoYldbehFC4U2bQ5Fv11N/59FnCxa7yzrusrms8HTOgtaXhOLvfSkAtMK2HrceLO7tgN6JYw8LK9yVANkBUzd34Sc5xO7aOZnJpD9gdc/XmKzMXdDRaoYcX4VdqsiBqedkV7bu9d6sKnFveR0cLQGt1yzrO0kQbzE3aI8jcQZWWGPwNbZOZHaycNyCnv5pmYKLlECYPswAzGjNw9aJhz2Td80U7WLkzDalCIxkOsYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=QPrZ5t4h; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=QPrZ5t4h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6mfD5Y0gz2yNB
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 23:56:04 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AFBD969960;
	Mon, 16 Sep 2024 09:55:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726494959; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=wrfeI6c5Fy2/wr4QW/RT84D3Z/gYFwXLPq/0MCJKzS4=;
	b=QPrZ5t4her/8AqCU4Iaw76WzB/tVPUXjSJhli+A3tTxISQP/t20LUrFmoq2j2c7foKM7W1
	yeMmsFJg84bfucAURCoKi5pL/ENBe6x2RWV8+Sj/IKKhZsAP6xHPMsxp7swp2XZ1njlF7z
	fsg+jQJjB0DCkPGguMjNbbURnPoFcB+0Ig0ZOX2H1y4vzAyMwwIOewohYrOhWU7bf5h5fq
	JVKLji3Jsz6hk0fJFjSDzpv7vCczn8KCoKk93/TZ03jb2TfK5N+eYwQoXN0t2BvBNojFhE
	liZpXCNMlx7kNFvP6nzDKXa8Mfbq/p55GtVXvRloNzfWZEp4KGYBoQZTr+ZkpQ==
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 01/24] erofs: lift up erofs_fill_inode to global
Date: Mon, 16 Sep 2024 21:55:18 +0800
Message-ID: <20240916135541.98096-2-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916135541.98096-1-toolmanp@tlmp.cc>
References: <20240916135541.98096-1-toolmanp@tlmp.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
From: Yiyang Wu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Yiyang Wu <toolmanp@tlmp.cc>
Cc: linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Lift up erofs_fill_inode as a global symbol so that
rust_helpers can use it for better compatibility.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/inode.c    | 2 +-
 fs/erofs/internal.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index db29190656eb..d2fd51fcebd2 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -196,7 +196,7 @@ static int erofs_read_inode(struct inode *inode)
 	return err;
 }
 
-static int erofs_fill_inode(struct inode *inode)
+int erofs_fill_inode(struct inode *inode)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
 	int err;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4efd578d7c62..8674a4cb9d39 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -416,6 +416,7 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map);
 void erofs_onlinefolio_init(struct folio *folio);
 void erofs_onlinefolio_split(struct folio *folio);
 void erofs_onlinefolio_end(struct folio *folio, int err);
+int erofs_fill_inode(struct inode *inode);
 struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid);
 int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		  struct kstat *stat, u32 request_mask,
-- 
2.46.0

