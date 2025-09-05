Return-Path: <linux-erofs+bounces-976-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E38D3B44C62
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Sep 2025 05:40:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cJ2D85PxLz30RJ;
	Fri,  5 Sep 2025 13:40:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757043608;
	cv=none; b=SF008XMBZ5sJdS0qr/I9qk0gQas4k1hclcT/7M768r6jzoYLZlXoFA8cNwMhWZGOIhYnEcis9HfJn02rRrajBxvZKGp1n1lwNRSrbhYirB9y34d+mAxKmV8JBGg1S+97YOUz07mrqdN+jByVulHhwXxMUMXJchh9B3A9FQo39uxW9dfCK1zgXRxHVeSyuyrIBXddgh9RzrShX3un9vPevHQRwwxf5y7NdALO/sAPBnFoPoIIEQ67QgTf0/0rY4mdYk1eHk98LCpnrfK3J0n5Aufp5JFfbGUM6Lp6Jd+GBywwRsO0ewnamxHExBGqSIkCy6/P15Ggv5kAVVF4yqAnxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757043608; c=relaxed/relaxed;
	bh=XCOQiK9RJxGe0B9XgbtKm70Q7RSnFjUQ90X7CPywoRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UF/AFSVQf69X5R4XRXFbEfD4fIcu9tf8KvSCS1hwDSRLxLARnGjiNXcYxYZHo4nYd73sTACQh3oVIcg7oWb3iXOGcVuQ4ZoxurFvQG54uXvP6aC2BEvI2GaF6cHOwThYviSAkndTLUwkmWQyl1nQkk87oFQNZ/0EXIxRcYCWqK/k7JMLFU4zmuIsOY9fB1zP3s4NLNK6nr+oGKtxLRLau9XcjaltXRCTXZfrJgF7JDMPvyIHe2CSm3qGOr0R5jch6JccPWUqPcuu6n3JdDSvNt/mopm45jhrvfz4XcOVuyJSFd6HnAfRq6E+ov9VK8NAJFzaq6dSRLvVYnydzgEA5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=I1Q1P4nL; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=I1Q1P4nL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cJ2D66Dhrz301n
	for <linux-erofs@lists.ozlabs.org>; Fri,  5 Sep 2025 13:40:05 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757043601; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=XCOQiK9RJxGe0B9XgbtKm70Q7RSnFjUQ90X7CPywoRs=;
	b=I1Q1P4nL5CFAakPtd36O74i1PVF3VDbskgGykjSTrXP84/zuHZAZBhsEVcuUOQZxe6iqymrkxPLYbeZXfHtwH3iuqVoC0ShG9a+esf59o9aFFPjJTfvLJ4/IsruubVmqzAI3B4o3gEyAkPSYBALdkK2ovStpBOf4Fk+W4Jt+kbE=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WnJ3SxM_1757043596 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 05 Sep 2025 11:39:59 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chengyu Zhu <hudson@cyzhu.com>
Subject: [PATCH] erofs-utils: lib: avoid trailing '\n' in erofs_nbd_get_identifier()
Date: Fri,  5 Sep 2025 11:39:55 +0800
Message-ID: <20250905033955.1351125-1-hsiangkao@linux.alibaba.com>
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

The trailing '\n' shouldn't be part of backend.

Fixes: 5d3efc9babf3 ("erofs-utils: mount: enable autoclear for NBD devices")
Cc: Chengyu Zhu <hudson@cyzhu.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/backends/nbd.c | 21 +++++++++++++++------
 mount/main.c       | 20 +++++---------------
 2 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/lib/backends/nbd.c b/lib/backends/nbd.c
index b9535dc..2e54814 100644
--- a/lib/backends/nbd.c
+++ b/lib/backends/nbd.c
@@ -183,15 +183,24 @@ char *erofs_nbd_get_identifier(int nbdnum)
 
 	(void)snprintf(s, sizeof(s), "/sys/block/nbd%d/backend", nbdnum);
 	f = fopen(s, "r");
-	if (!f)
+	if (!f) {
+		if (errno == ENOENT)
+			return NULL;
 		return ERR_PTR(-errno);
-
-	if (getline(&line, &n, f) < 0)
+	}
+	err = getline(&line, &n, f);
+	if (err < 0)
 		err = -errno;
-	else
-		err = 0;
 	fclose(f);
-	return err ? ERR_PTR(err) : line;
+	if (err < 0)
+		return ERR_PTR(err);
+	if (!err) {
+		free(line);
+		return NULL;
+	}
+	if (line[err - 1] == '\n')
+		line[err - 1] = '\0';
+	return line;
 }
 
 int erofs_nbd_get_index_from_minor(int minor)
diff --git a/mount/main.c b/mount/main.c
index 149bb53..2826dac 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -356,10 +356,7 @@ static int erofsmount_nbd_fix_backend_linkage(int num, char **recp)
 	int err;
 
 	newrecp = erofs_nbd_get_identifier(num);
-	if (!IS_ERR(newrecp)) {
-		err = strlen(newrecp);
-		if (newrecp[err - 1] == '\n')
-			newrecp[err - 1] = '\0';
+	if (!IS_ERR(newrecp) && newrecp) {
 		err = strcmp(newrecp, *recp) ? -EFAULT : 0;
 		free(newrecp);
 		return err;
@@ -461,16 +458,11 @@ static int erofsmount_reattach(const char *target)
 	if (nbdnum < 0)
 		return nbdnum;
 	identifier = erofs_nbd_get_identifier(nbdnum);
-	if (IS_ERR(identifier))
+	if (IS_ERR(identifier)) {
+		identifier = NULL;
+	} else if (identifier && *identifier == '\0') {
+		free(identifier);
 		identifier = NULL;
-	else if (identifier) {
-		n = strlen(identifier);
-		if (__erofs_unlikely(!n)) {
-			free(identifier);
-			identifier = NULL;
-		} else if (identifier[n - 1] == '\n') {
-			identifier[n - 1] = '\0';
-		}
 	}
 
 	if (!identifier &&
@@ -596,8 +588,6 @@ static int erofsmount_nbd(const char *source, const char *mountpoint,
 
 		if (!err && is_netlink) {
 			id = erofs_nbd_get_identifier(num);
-			if (id == ERR_PTR(-ENOENT))
-				id = NULL;
 
 			err = IS_ERR(id) ? PTR_ERR(id) :
 				erofs_nbd_nl_reconfigure(num, id, true);
-- 
2.43.5


