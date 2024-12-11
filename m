Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 392E29EC908
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Dec 2024 10:27:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y7Vcc4l7Mz30Qb
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Dec 2024 20:27:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733909246;
	cv=none; b=C2xNJ5bDHrM/F/22teXUhrc/FhuJyyUJN6pxXVreyIqLrNE/VaHEtDftpNIMu0LMjjjzZM8vFTyH87ZUco3B+C0DHZYWFA1t3UHhcBJSsUapWRXetGJ4XmUJGlU0gOovQ43/YPXnFTY0Q7zJlEjZVd5XevQaXvMVpJ7+GwSzZJ6+q4uJpfX9YCr7hSZzdRcbVWJ3pMvZgI9UJE7yu/ivs05uaEe109UvhYA89ljcjR/05e9SlhuPw6u/S4WaCEMlsaxBGULutybeBPSiGv8vSwNxVhUlVPF0jbulM2gCKgOoG3VlE20NkX5rR62YU5Hw9ItITgM0O1CpuJiIrLZOew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733909246; c=relaxed/relaxed;
	bh=N2RbVpnB8vIe4TImxXWeaggFf2DtrOlUggoajhlh7ds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y/3UWMy7SRtRtl46EmwewJX1swLFhSDX0T2HvcFcmqbtZMYn009I7KI7zoseBzZTjJyHk8N9H8A0Q7sM9s69bDmfPOWY0RnsOpZkusgpuN1mSOQOFaWjYGMkTtWVgM9MndfOKEEGWLrkjkY2jOUrVvhS7fY/jkz2EmcYy2lECk+76Zjxnh6Ek6rpDQ6R9g6Xv+BQmOwXM+M7Vdt0X/oca80ITpJUtZfRWSnEL1vZajZ5wCA9UvNmiiCcYxdghsEymiasm6/FcJWctHCU3rtf3Xj1X2ylffD5lxcp6gAZ/0+F1DGBlRin7BP6ODDaICpUEl1tkmhlv5UHvdoXcNivSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xUsT10jQ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xUsT10jQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y7VcV4ds2z2yRc
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Dec 2024 20:27:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733909231; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=N2RbVpnB8vIe4TImxXWeaggFf2DtrOlUggoajhlh7ds=;
	b=xUsT10jQDKMY6LBBzZ70zQsh+BD58jaeCV8D40E/J96Mj4HRqNbnKR+VR5qS0/XYX3EV3i9SbyzElq3R4AVP/u1GFeLuzhRZwIHHnMW58kgHh7kXrpEIEsLDlwn8rCJ2ufwVTvkhcgAXtmzm6kvBVtAgcin3WdCWmh0r+jF9R/k=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLHwkYQ_1733909225 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Dec 2024 17:27:09 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: add `-U <clear|random>` support
Date: Wed, 11 Dec 2024 17:27:04 +0800
Message-ID: <20241211092704.4008111-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

To match `mke2fs`.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 man/mkfs.erofs.1 | 11 +++++++++++
 mkfs/main.c      |  7 ++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index e7da588..ee84163 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -110,6 +110,17 @@ Set the universally unique identifier (UUID) of the filesystem to
 .IR UUID .
 The format of the UUID is a series of hex digits separated by hyphens,
 like this: "c1b9d5a2-f162-11cf-9ece-0020afc76f16".
+The
+.I UUID
+parameter may also be one of the following:
+.RS 1.2i
+.TP
+.I clear
+clear the file system UUID
+.TP
+.I random
+generate a new randomly-generated UUID
+.RE
 .TP
 .B \-\-all-root
 Make all files owned by root.
diff --git a/mkfs/main.c b/mkfs/main.c
index c92f408..6a5dc66 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -620,7 +620,12 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			has_timestamp = true;
 			break;
 		case 'U':
-			if (erofs_uuid_parse(optarg, fixeduuid)) {
+			if (!strcmp(optarg, "clear")) {
+				memset(fixeduuid, 0, 16);
+			} else if (!strcmp(optarg, "random")) {
+				valid_fixeduuid = false;
+				break;
+			} else if (erofs_uuid_parse(optarg, fixeduuid)) {
 				erofs_err("invalid UUID %s", optarg);
 				return -EINVAL;
 			}
-- 
2.43.5

