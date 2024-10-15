Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 711D399DE95
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2024 08:40:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XSPcB3DWLz3cGb
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2024 17:40:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728974425;
	cv=none; b=Ogy0teGl+3BmB9pJXHu/B9zv4bC747/7CbT0/w5modTe+L9chF/Nb9qk+krgauEovpRoLEuCQseGCIKFBleRtFiOj6VHqeRVGlQhBCbNNXqVZb9somkSS6CXkcdFVF0o9i1mIqLphtD/9WY5zkty2i//+cdctOspc+J8Pa7pQk/L6hN4zGhxq86pCz/ZpKlU6lGXtZgQ0SPtDNEtR6jIWN7XGfWj+VMuccn6UZoIwL6qwIka82u3rMomHmw3LjNqSo4priulH9kNqyGJK4rEZ6weZejAtdpw/KrD666t6xWjK4TdZVSDHdDygi25M38elnPZgwlCgwv9BiYZan6eWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728974425; c=relaxed/relaxed;
	bh=yt+/eMQI2XRlFy5hEDqAggoK8kdAzzr6SJ9l3ypys2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kR50C6t1D4mSB/QAeX8hPh4EeozdZO7fChH0CP8nHTv61zxsNqcw1jqFksMbgO3eP+VxMfQ7k/qlU2Hhmj4zSPdH5lca93T9xS3YcVio7ifZBOErqaJcFvvskJ8ezfPM/NVawaYs/VYBeTX4zCTNKJe6OAx46+B9DM67MqBYzLwYd7/ouP3tzk0ls5vLysmR/eUj539UfeM8uSe5qy7JIHtWaM0sMy0WB2nQ6QuydEO9/VvuUv7qYkIKK1mx8TyBJP1WrAHxp4NIDrJxO3Xtj9vKfNgr7fpDnJEL+fneMpeN7DfE0cgtygtBZgpeHC3cYhJops1bgU6rhuyA0XWznQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OW1MstPx; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OW1MstPx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XSPc3559dz3c4D
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Oct 2024 17:40:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728974410; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=yt+/eMQI2XRlFy5hEDqAggoK8kdAzzr6SJ9l3ypys2Q=;
	b=OW1MstPxStCIxFVxKuhmpgZOgP3cOVSZD22Gq/KUWsJB1yRkzFbLGU6sfgf6quyiacfzdnb2nlyOYg8v+NeIINZARLAXBqHrwNbAJEqRTVrvLvNXydIT3QAh2K2UcS+EgwYPNRufb1zTlmgLEHH1CNZcRdYM4049IBxHP5orxYk=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WHCJkYo_1728974408 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 14:40:09 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs: fix blksize < PAGE_SIZE in fileio mode
Date: Tue, 15 Oct 2024 14:40:07 +0800
Message-ID: <20241015064007.3449582-1-hongzhen@linux.alibaba.com>
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

In fileio mode, when blcksize is not equal to PAGE_SIZE,
erofs will attempt to set the block size of sb->s_bdev,
which will trigger a panic. This patch fixes this.

Fixes: fb176750266a ("erofs: add file-backed mount support")

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v2: Add support for blocksize < PAGE_SIZE in file-backed mount mode.
v1: https://lore.kernel.org/linux-erofs/20241015033601.3206952-1-hongzhen@linux.alibaba.com/
---
 fs/erofs/super.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 320d586c3896..abe2d85512dd 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -631,9 +631,15 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 			errorfc(fc, "unsupported blksize for fscache mode");
 			return -EINVAL;
 		}
-		if (!sb_set_blocksize(sb, 1 << sbi->blkszbits)) {
-			errorfc(fc, "failed to set erofs blksize");
-			return -EINVAL;
+
+		if (erofs_is_fileio_mode(sbi)) {
+			sb->s_blocksize = (1 << sbi->blkszbits);
+			sb->s_blocksize_bits = sbi->blkszbits;
+		} else {
+			if (!sb_set_blocksize(sb, 1 << sbi->blkszbits)) {
+				errorfc(fc, "failed to set erofs blksize");
+				return -EINVAL;
+			}
 		}
 	}
 
-- 
2.43.5

