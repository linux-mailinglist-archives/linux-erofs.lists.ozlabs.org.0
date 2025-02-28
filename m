Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B90ECA49094
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Feb 2025 05:54:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z3wqR35ppz3c5s
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Feb 2025 15:54:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740718482;
	cv=none; b=RcXaZCLZ3Af3yz6BNsR8YZuGB3R283IeLNsu750Q4oecWylDBn5/dG6RCoXLB2bZFbSx3D+kO/M7j/XRqmvjpGnA/Jghw7usYOmwGmFlX9P8mKh6UTG4OEBTUjV/Y8lrbk4VfPq/oDNJGGnDokUj0WBHMcAz/Kaqgir4nl9oM9sgkxH2t2Hs/gvM5AtrIPXJGP2w8n2PNHzVxUj8lUViyABPrNXgkpBW6jfq/FcQ7sYXp8e9JSOMf9G+tdhwi9EC6FXsv/Ll/+JtAWLRoqhn3UAhRarc1w7mDYEfTU23UFoM8pZ3fncbPf4dLkafsDpyVlzGfkK74LrK6wisEp/CRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740718482; c=relaxed/relaxed;
	bh=fQp2Qr5jU1TBCSrDGzVTxc+QxNj4JULfFi0mVOvpVAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9hO9dSYO5YQ2v/m0+duKHLUo0NE9U8IWSdoDRhf0M2C+3DOcSmQXZK65Hk9e4LKkC9cnhoY0NLoF5KXVSHt1x++35wkIOR96nd058BiETbxt4ko9MdmCq1u0CZLpkJqeqTIkSUkG9a96Qm1e5C8Qv09JBz8hkDgAQV+NlnKL0/NjW64F6djBZAaEAHpAsdRAIifKH5do3jmYQ0LepbSMPMGC/vh55nncByeiOP9F5K20fP307V0SVbKoVPdUWBaysID8A6+izASFkuMyWN76dAyD+eEvqWp8pikANk16tRykH4p9+wmQwBMZrN4EsMvs4jTHTyceNP/AA3pCtXOgg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DECm/o/J; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DECm/o/J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z3wqN2J20z3bsR
	for <linux-erofs@lists.ozlabs.org>; Fri, 28 Feb 2025 15:54:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740718474; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=fQp2Qr5jU1TBCSrDGzVTxc+QxNj4JULfFi0mVOvpVAo=;
	b=DECm/o/JTxGBLDiRtEH4UHiOCvORzhq2Z02mHChuUdYcIeQkrm0Nnz25KQ17DScrf7WTzH7Y+VJJLEOjzJ70+TMgjXGxXybVd5c54gOGRJUPb8oGt+fCu+rhH7a1a9+D2yxg3NGjMn5kdA0NgG4BqF5OAfgqmeG2cQj0SEXFC9Y=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WQOMhWp_1740718467 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 28 Feb 2025 12:54:32 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: tar: handle empty filenames correctly
Date: Fri, 28 Feb 2025 12:54:26 +0800
Message-ID: <20250228045426.81099-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250227171557.3368310-1-hsiangkao@linux.alibaba.com>
References: <20250227171557.3368310-1-hsiangkao@linux.alibaba.com>
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

Tar entries with empty filenames are unusual but shouldn't
cause a crash.  Handle this by following `tar` behavior:
substitute `.` for the empty filenames.

Reproducible image (base64-encoded gzipped blob):
H4sICL2XwGcAA3Rlc3RfcmVhZF9mb3JtYXRfdGFyX2VtcHR5X2ZpbGVuYW1lLnRhcgBjY
KA9MDAwMDc3VQDShuamBiAaBGA0hGNoaGBgZGJsaAZUaADiGDIomNLBbQylxSWJRUCnlG
Tm4lVXnpGamoNHHtVTClR14ygYBaNgFNAAAAAE6urMAAYAAA==

Fixes: 95d315fd7958 ("erofs-utils: introduce tarerofs")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v1:
 - add print message for this case;
 - add a reproduciable blob in the commit message.

 lib/tar.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/tar.c b/lib/tar.c
index 2ea3858..941fad2 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -826,8 +826,14 @@ out_eot:
 		memcpy(path + j, th->name, sizeof(th->name));
 		path[j + sizeof(th->name)] = '\0';
 		j = strlen(path);
-		while (path[j - 1] == '/')
-			path[--j] = '\0';
+		if (__erofs_unlikely(!j)) {
+			erofs_info("substituting '.' for empty filename");
+			path[0] = '.';
+			path[1] = '\0';
+		} else {
+			while (path[j - 1] == '/')
+				path[--j] = '\0';
+		}
 	}
 
 	dataoff = tar->offset;
-- 
2.43.5

