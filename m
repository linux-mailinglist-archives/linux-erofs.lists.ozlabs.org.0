Return-Path: <linux-erofs+bounces-2822-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIrYDTtAumnMTQIAu9opvQ
	(envelope-from <linux-erofs+bounces-2822-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 07:03:39 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A802B626E
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 07:03:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbJD54159z2xYk;
	Wed, 18 Mar 2026 17:03:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773813813;
	cv=none; b=DTEfYoNibq6Ih+cvgJfeDcD6Et2yKQtG9e3MMSmoDO2IMbs9O8cRwu8tOHhakE2jaHTMw94oGlBZ2k/C5TowVk6NZYimMlbTYZ5FYEspFdbK2R169tQhLmZoXq5AGMZlIEj8Xn7nXg9UvZfUMZhtD1ULljSSaw8a4TrgJAU5GFIJ0m8FhKWywOfZxMLVeAZ1R8I/4MQEZ/304veRO/WLOUobruX9NSr0he8qIgkOnsVbLC3+Bn3mI498EB0uqQ12ZeERMRBOGNtSNeYUzv31UxghBdwm1oFR+ZQQHr0FobhF0/5hmH7HGNgxxgRV0ij8YvDMRAf4FSj5dRCp4Zbq5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773813813; c=relaxed/relaxed;
	bh=uq4VpG2bQN2A9BU1ZDJRq4AcwF1lb0nfwCc7M/tf3oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSFvw7x/zaoBtPFLNH4fWpRpKMq4wGYotpuyE+EhTSJtWSDg8dez51wUGlxGSBhgLAB8uNpcdisfOJszDJhDcfr5uIdrVk9eFVK/PujRT46afgbP7MElCBUjp1mvF73T/UKgOA1mMHvVoVPFMVJz5/02G/T0i+nr0IAxsXwm5OYUAXc2/0RbOTYlyRms/binBEar5+kqdQsgqzLCLYa4eUS+61t6RtSBBZ7UlFHi1qcyUVTqVHx8xmf2umNFcBkHVHmICZY45/KiWwLBNduyw0IFyy1CMri+bOnVBmyBnL6sjXLvMKvwDiP+Ne3Zq+NS1u9thCPth6Dh+7UBg+Hquw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=PtL6voti; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=PtL6voti;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbJD40r0pz2xQB
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 17:03:31 +1100 (AEDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-82987437624so365760b3a.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 23:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773813808; x=1774418608; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uq4VpG2bQN2A9BU1ZDJRq4AcwF1lb0nfwCc7M/tf3oM=;
        b=PtL6votizTKi7AooIB0TBnRI3luxsvmNnu8p36sZ6GaU6eC7sZ1tszzU2kPfNidByO
         7L7GB1x8Jxhqo3qtcFMOd0b6kTlM/3RZZA6aRoBEmci3VhKB+6Q+M7gNL7GwPAfvfZz4
         45/crmq4e68RZjO8zUZBiUci76/GO4jH24rxRoR+c3hpfAGT/yMB10P/VEmEdj5WiBkO
         kyYzUiVUPkSO5P2YNLglFn/b/yPg2dk6Fo9QWxFmp8hiGHvoUHIn6lckNEMgGHe4LYMC
         VJAO3ju9qvZ/DXXEoW3eyU4o+7NGqo7vBGJzLClEqHwpFVA1gB4OcNA++6Ycv2Ie+OPT
         LxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773813808; x=1774418608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uq4VpG2bQN2A9BU1ZDJRq4AcwF1lb0nfwCc7M/tf3oM=;
        b=d3gFeGKnAPz13k1S85vjnDt3cn4tLhTuHsA1JG5U39SXW+O7rtDdnFv7QPV3JF1VZ7
         mrboyNAhF+rubjOIiKPK6zzu6yqnlvaHvEf/encaTurX54mWdB7DkwqeZiKHOJVxEQ+R
         kpa0jWV6jA18fYF57tmUzLUIXl/FO2xRWtfBI6pvyN2QC+vjaO5QA0Ji1HDUVcKSVNKh
         7dyv38moahlqDW88ebE3eXpJIHUYxl3py5c2QNP7+VRBsT1PJEY6KC/9MrlN415AXfsA
         z0G7BtpLwkjJewa3B+WThzYGOuawYj4y8R9b+PG1BXOCKRq80oBSw2dRwFB0BsanPm1J
         lS/w==
X-Gm-Message-State: AOJu0YxhzIqSW1Ml29txMnRRCtHw4qnBEbxXfoaHwmmlZpfVUCFHDRqd
	MDIJVu7u71n8Tiu43Ym7s6pbZWSmu4dDN6PB9zwFy/jeBy5144h67sr9wAS9D7hf
X-Gm-Gg: ATEYQzzuFroNs27FAJu0yUImvIEMIfkIQGhhdmZoUCEQSCk+O5GRP/DPJVdfTl1AeY/
	IjBVh4DUwz1ZtfcJ/6K4m3LQO5IzZuvKz5yJufswpS1X4T+2qyFZv2K7t2zheiccO6j/x22g52X
	DNz4kh6TtDPTt5JkN8x16DQv6cEE1r0yj007kZkwL6Smv1aGxTfxSLRu601+J1VZVshenKANdJa
	8fR5kaB0sfpVuoNHwRoDbRHPTmj12Jk9cHHt7KmB+jx+67WqFcbIRzvkfA2bqOI4DkZqKwBSYux
	JCGMWn8doAhopwo/7QlsORqLaTMwFl19wuTn23iffE/Jj+FcB42BYcBOwnL7Y8QcaYMjbz3QkKY
	yP7A9a4+iOcpwDf2eZAzRp6CFmCo106sKT+NbmBJ1KlF28avVrybvX6tWl/a3Jr0Se/+TVYr2yr
	QlXmtpXvut1KeK6CYFwfh3pd32u13737IE96PSaP3Y8QD/nIDo89VDKH6W
X-Received: by 2002:a05:6a00:a90d:b0:827:26b6:c11f with SMTP id d2e1a72fcca58-82a562697bemr5401868b3a.31.1773813808475;
        Tue, 17 Mar 2026 23:03:28 -0700 (PDT)
Received: from localhost.localdomain ([45.114.151.92])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbb2f34sm1345978b3a.30.2026.03.17.23.03.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Mar 2026 23:03:28 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	zhaoyifan28@huawei.com,
	stopire@gmail.com,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: [PATCH v3] erofs-utils: fix thread join loop in erofs_destroy_workqueue
Date: Wed, 18 Mar 2026 11:33:19 +0530
Message-ID: <20260318060319.13191-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260317043307.27575-1-nithurshen.dev@gmail.com>
References: <20260317043307.27575-1-nithurshen.dev@gmail.com>
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-2822-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linux.alibaba.com,huawei.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 48A802B626E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, `erofs_destroy_workqueue` returns immediately if a single
`pthread_join` fails. However, it does not log the failure, making it
difficult to debug if a worker thread gets stuck.

Add an error log when `pthread_join` fails. Retain the early return
behavior to safely abort the teardown process, ensuring we do not
free the synchronization primitives and worker array while threads
are potentially still alive (avoiding a use after free).

Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
---
 lib/workqueue.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/workqueue.c b/lib/workqueue.c
index 18ee0f9..4a1a957 100644
--- a/lib/workqueue.c
+++ b/lib/workqueue.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
 #include <pthread.h>
 #include <stdlib.h>
+#include "erofs/print.h"
 #include "erofs/workqueue.h"
 
 static void *worker_thread(void *arg)
@@ -53,10 +54,14 @@ int erofs_destroy_workqueue(struct erofs_workqueue *wq)
 	while (wq->nworker) {
 		int ret = -pthread_join(wq->workers[wq->nworker - 1], NULL);
 
-		if (ret)
+		if (ret) {
+			erofs_err("failed to join worker thread %u: %d",
+				  wq->nworker - 1, ret);
 			return ret;
+		}
 		--wq->nworker;
 	}
+
 	free(wq->workers);
 	pthread_mutex_destroy(&wq->lock);
 	pthread_cond_destroy(&wq->cond_empty);
-- 
2.43.0


