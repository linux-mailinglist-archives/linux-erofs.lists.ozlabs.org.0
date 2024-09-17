Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C083E97AD9D
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 11:11:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X7GHc073Jz2yMX
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 19:11:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726564296;
	cv=none; b=JBedUsNW3rYoa2rRiqQDq8sjV5Q6TnbRc5voGZ3xAZtzkdiRBpZ1i3SP6kLexGecMgF9aWWWziow7jcN5KYBInhg/E396xxExpR4Dar7eyME0Gs7vaFaFzJSamenvHnBeUfo/ZcOaagwAjFXJ/1OjiK1ceRfslr2EVqUFm+sF4euMW+tYcO68JPgyvCS3DGfbxcrDtOMWSc0FiAFN/yJ59EopFM3y2AW78Cmjm5uGucigNpLePlGRbjm67eKZGvczIqYytW2TYqS3+2sqY4Y5k1iEnipsEfkVpdXU+7Rt+spfo9cBwzk2/UVoWLmeVqa9w/yOMRP/uvWvspQU6NoYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726564296; c=relaxed/relaxed;
	bh=SEzck7YOSX8WqBU2tcTUGpNhGTX3M6KFp65KUNgtKqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XGGwOl4tscC4T+hzvljYS6GO6zPc+P1399fI8fveQJ2vzRCcmAZ9dGlbJf1SPHIva7iF9NuWLV/yq29g1nYMAN++ai4RrCt8k6qyi+P7N0sUUO/cKAuOmeKyptpsSvrjYBXZrVJv18te8B2mlTpE+8AqcqVMgWKiQmxImEz+C/5PGYgdJ6/0pGZ2QLNgecUgU2+WiVn5EWiFavPwDKObq08l9d7DQgCj6Ff5fGJJjknmBRfQr+H3JU8Uoj3afOyg3Vp+SFiYhYsxcDTEaoTewuI94ivybcKmbK/9AClXiJqsn1WnAIjkq934mrHo65lH2ci9GIiYg6ck98GNXyMi8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Kd4FSzFm; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Kd4FSzFm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X7GHV6lzZz2xQK
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Sep 2024 19:11:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726564287; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=SEzck7YOSX8WqBU2tcTUGpNhGTX3M6KFp65KUNgtKqA=;
	b=Kd4FSzFme3kb8kA4QHd8LtdYSyZtFh/2re5cY5iR9581lEH5Sh5f+ZOz+PybUNfI4WBYI+KnVjFiTvwdyQvMOziCTd5+ZIkl7uV5SxdLeXxt23j6DMbiQzE4EM1b8Ot6ibp5K+6m1hLVre8X+ikki1ooLtsRkCtx77WgePuApi4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFATJ1v_1726564277)
          by smtp.aliyun-inc.com;
          Tue, 17 Sep 2024 17:11:26 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: fix off-by-one issue with invalid device ID
Date: Tue, 17 Sep 2024 17:11:15 +0800
Message-ID: <20240917091115.3920734-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The device ID should be no less than `1 + number of blobs`. In other
words, it should be greater than `number of blobs`.

Fixes: 89dfe997c2ee ("erofs-utils: lib: fix global-buffer-overflow due to invalid device")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/io.c b/lib/io.c
index b101c07..dacf8dc 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -342,7 +342,7 @@ ssize_t erofs_dev_read(struct erofs_sb_info *sbi, int device_id,
 	ssize_t read;
 
 	if (device_id) {
-		if (device_id >= sbi->nblobs) {
+		if (device_id > sbi->nblobs) {
 			erofs_err("invalid device id %d", device_id);
 			return -EIO;
 		}
-- 
2.43.5

