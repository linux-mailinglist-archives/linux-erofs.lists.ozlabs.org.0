Return-Path: <linux-erofs+bounces-2750-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDUIF0MeuGlYZAEAu9opvQ
	(envelope-from <linux-erofs+bounces-2750-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 16:14:11 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A7D29C14A
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 16:14:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZJXF023zz2yZc;
	Tue, 17 Mar 2026 02:14:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773674044;
	cv=none; b=TfMxYMsmFpNyatfCG7WyjWjJL2j2UBv2AvbOaJ3Z4IaiDIlKKd+lsqKTiONdZD0tfOqh3QV8GaIooti+D6XyN3iscX/9GlIjNT2+855GjDJl8zh1N7R3TwdOp+znotYbtC0QF/QXlJViv8VnRL0qpfRtBUNyNOdGKLtOOfYC6yS7WPPFRUV0a1ceKrw2Odzx87dVmNcAYD5vUrN1bmZLoocIDtEo7Y2CSPlUjBvLAIC+/0S7lVMsbGab++Vgs7ZRnmIupAfraKeBalv13UA9cZ77gRdKCQwdllQ5wpfBBOp4QPKW9DEXYFKGAL3pIJhCyEydTFOTmQhDW/4YostaOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773674044; c=relaxed/relaxed;
	bh=jfP5fPA5+O1UpxCLg3BGvluDAEYUfToUjuJ4spb9KG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WDWox08x+zSrTAe12nJIryAdGk2fxx1uJ9lsfbA4Z0zIW/4Qw8gd1QblJZvas4I4zCAgheDiIGXQqNJaPfX6f9/0Kgf1OFKaOMZ7yHwVhGD0kY9tRB9T2a8Gon+rbiqWIBoN0WXfXyU4gKLmWopW7kP48tKZ+UDVeK7fosW2ia+VSerZIndNfs9kH7lMPeJMNCp1NKRYWOUGsjtkFTrspM0uKLGnLtAtONMAPnaT1Xg2WeuBUpvrhllBGn6EyIB6WAHbXo1uGr/kkfLErlQ6pyPw6zRVkUC9mXEMkOYh80s7tr+azNUobwZCs2kYqriwsUDMt3aVmqBdbAJbgT1LTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=N96twQil; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=N96twQil;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZJXC5NW5z2y7r
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 02:14:03 +1100 (AEDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-35b9fb3f57eso460105a91.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 08:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773674040; x=1774278840; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jfP5fPA5+O1UpxCLg3BGvluDAEYUfToUjuJ4spb9KG4=;
        b=N96twQilYk9ahWQrHwue4vKOhCOPAnOOhfqKNyyQLcKsvBD1clSt5LD2ewOtYikVVN
         UeoRukx2msMvxK2cv/ABvQW05rjlDzdjgWpyyl1CsB7Sd2zXqPz9X3rB+JNJA3Lksea7
         WPUqHOCzPyVpWULQEedREda0Vu25fnaILKU7lSmBwoMTNeiNPIHT5ix1Lj3bIv1eov6l
         RJVJ5c2f3wac2mxaiEqbmgiiUDMZJ/h36MnPJOjfprChpobQLi9X79MDMOmITK31KyGe
         O+iZP9fgo/vqyYPR6bmPPm1aSUWeobqeL1kf4FwEV9MCZwoNumkbG0aA+1CHwlK+VGjE
         iSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773674040; x=1774278840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfP5fPA5+O1UpxCLg3BGvluDAEYUfToUjuJ4spb9KG4=;
        b=FF2uB7TBYMJ4Sz2rzNKRBlBMiEMGHGMwnKgs8zEjtSEfxRP8yXE7KSvOfvR+dVmhoI
         NaXb3CAPq421NEN9bplo34t/WHlgu+vqpqnr9RVVRXs1jGAFIvOIwDzM9w5OgdgHGYuw
         wo8JyRTGj/XNDIHCcKnkZnHwkhIbae5rPkR/GTxDlk6nyvbH3AjuOhK+CcnaWn9uYRft
         XtnRxWW+Sm4rImkBa3RGtSYuKonhR4i6QInoOO1ZrnKaGak3e6y7KrbdxvZcWA9Hotwe
         ElfRGE/ppUseL0nBqMsqWx9V3Ud4EMjVYx8QEZkCUxz/2PR1DPEKMpj2fJudMEehR0nL
         vg0g==
X-Gm-Message-State: AOJu0YzOnJFRPdAt6t2bpZbyBwljsnguOXrFo/CwdyEMO2Qhi306wTXh
	Ik0TjOtqGbdVgO5VhLelUMHwTaVEOK6q6z4RzUBnkcBLn8rROv/lG4MsCQmyc7w7koA=
X-Gm-Gg: ATEYQzycDHtYYCvppYAbF8d4NR1G26MZgfYuIAi2bb7duD/WPLsyf2uPv28Sz1I0Ewx
	4eIq5MftT8iAvaaxcr4GQmbErRkKLfn6ldZaabQ7t7a6HO+q1Ae+aMwE+bBmDSjEMmLHO/wuAbx
	6tfjZhpeBobTYt2A7fhg9iH8YTyvdEnvlczNbrYrthCs6KTOyLSPMLGZ17h6cMJOKEjTqBSL5b/
	/6ZFOL/3X/pxf0pB+psR5NKVxV/orsBy+CibRrBA1ocLf0XpmjT2jePJrUPu1vxW899gWSW9csO
	zRqAldvi5uGvx9J7s43nqm3ye1LprdNZmqDPagNK96v+QOhqj1mvdPUWqnIM4EQemeGCie0g7im
	nCYRNdXKe+2IDCDdkgc02CuUo+wVD6nasOOEcrtKAyWJn+4rbz8hP6Rr6zPLDmQecAg8bnDDCA1
	Ax6tU4jWkndvb80D1SmL3CfdMF/qrYvHbjpiK48/PTu0N/IRG2kRw=
X-Received: by 2002:a17:90b:3d4b:b0:359:8812:7c07 with SMTP id 98e67ed59e1d1-35a21ed60eamr10867582a91.14.1773674040215;
        Mon, 16 Mar 2026 08:14:00 -0700 (PDT)
Received: from ubuntu-arm-nithurshen.SNU.IN ([45.114.151.61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a07f0a365sm16248072a91.13.2026.03.16.08.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 08:13:59 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: [PATCH] erofs-utils: lib: name worker threads erofs_compress
Date: Mon, 16 Mar 2026 20:43:52 +0530
Message-ID: <20260316151352.59423-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.51.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-2750-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,linux.alibaba.com,gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.996];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 20A7D29C14A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Set a specific thread name for the multi-threaded workqueue workers
to make debugging, profiling, and process monitoring significantly
easier.

Previously, worker threads inherited the name of the parent process
(e.g., mkfs.erofs), making it difficult to distinguish them from the
main thread in tools like \`top\`, \`htop\`, or \`ps\`.

This utilizes \`prctl(PR_SET_NAME)\` on Linux and \`pthread_setname_np\`
on macOS to explicitly label these threads as \"erofs_compress\" upon
initialization.

Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
---
 lib/workqueue.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/workqueue.c b/lib/workqueue.c
index 18ee0f9..860e403 100644
--- a/lib/workqueue.c
+++ b/lib/workqueue.c
@@ -2,6 +2,9 @@
 #include <pthread.h>
 #include <stdlib.h>
 #include "erofs/workqueue.h"
+#if defined(__linux__)
+#include <sys/prctl.h>
+#endif
 
 static void *worker_thread(void *arg)
 {
@@ -9,6 +12,12 @@ static void *worker_thread(void *arg)
 	struct erofs_work *work;
 	void *tlsp = NULL;
 
+#if defined(__linux__)
+	prctl(PR_SET_NAME, "erofs_compress");
+#elif defined(__APPLE__)
+	pthread_setname_np("erofs_compress");
+#endif
+
 	if (wq->on_start)
 		tlsp = (wq->on_start)(wq, NULL);
 
-- 
2.51.0


