Return-Path: <linux-erofs+bounces-3150-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFe8Ccm6zGmcWAYAu9opvQ
	(envelope-from <linux-erofs+bounces-3150-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 01 Apr 2026 08:27:21 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 38258375299
	for <lists+linux-erofs@lfdr.de>; Wed, 01 Apr 2026 08:27:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flw515NtQz2ySY;
	Wed, 01 Apr 2026 17:27:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::535"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775024837;
	cv=none; b=fZTzJFLWZEiVYnZ+6KhUrOXdgGMKWQfkYtDygxRrPN16g2ivVDWdeEP4zvwBch4c2UCHHo+zHrrMywbVVplf5A7BqAjzLlaRnEdyHtmczb5nULaDqp44CfZ4SV3dRQDlObKQNphmzSP6XXOWYw+NXuyYN2pzAk8JxJA9ArrwryqeeInqHQuROWx62LY0D5Y1tubsVfKeUHT0Yxh8/T7sfIBzFvMtfRV9AD4+nHy3vIHOR/mKdFHp1iyElpG2CBHRr3vkEmM4jmgpFlKuG7/RO1CRAFxyl69OvFYi5RC7opGwAhtYxDWJHp+w3U4m61em0W8oVQ/7BqPBB6/LajpIbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775024837; c=relaxed/relaxed;
	bh=6alSsOhcW8XHj+k5bFyh7oiPedcrP7NlFfaX2qU2ef8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JcEu+iZfezLjLtPupPUuOvyP14tjb2PAj/96znwKHi2I/Arar6zN/oCd6Gmvx5ueuimyHRJJHONg5Dw6p5B3vFCl6wWWDqdJM/ZYoStMOcAYArHxdZg/Zl15/U4wOXFcRhHxjR0KDyvmoW6fPtAeZRB/63hSQgjFsTu3P8B2zDbuDrianJAEBp6UeFsloqejTxI+cUNuJVFpmSXQA3v+KTJbOGpEpDT6dmP155b9yMFFPap2hNeYCUVY4F8rrCizCWAo9/0GcF8bwetEUXBqebfGgnw3p4wNUCo4K87+MmgVgYYFSOVJu3w3iMVgYpkEZkXZ67JVecY9DLezViXetQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TO5v2Yfr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TO5v2Yfr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flw504vJxz2xb3
	for <linux-erofs@lists.ozlabs.org>; Wed, 01 Apr 2026 17:27:15 +1100 (AEDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-c76afacbb0bso118115a12.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 31 Mar 2026 23:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775024833; x=1775629633; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6alSsOhcW8XHj+k5bFyh7oiPedcrP7NlFfaX2qU2ef8=;
        b=TO5v2YfrNc4JamtIyrM/FDu1Rq8eICCbWoijBRFEGdBC6hogG+QnoqcqOdz/Q7u9ib
         njzo7EPmZCHHZmSf/WotvObWvyQwK/g2LTnsCHHo5TWRGMiPGsdgUCWlLnQYRJbVKVWk
         33f0NmZf+ONmA7G+S3yvDh6a+H4VWZjNmtCkwZcvWA9MY9k4rX6JPSyH3c2sSvHHvkIX
         X3rWVO1mslGqQqBdmGw958e2DA2yJqI42MOG+qBr+1B1CXc1dGYVZKweCuteX2wBwZUQ
         fZqYyZ7lN6SbH9Kml9XDOPrRpyUiYyJsSGm9p+/ThsgAe+JAo+3KOAdV8yI9Uyudq25M
         k16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775024833; x=1775629633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6alSsOhcW8XHj+k5bFyh7oiPedcrP7NlFfaX2qU2ef8=;
        b=KJ1Irpim09ZfsvD4+rmDz2hlq2OXwzCFFpwMFrkI/W46yawYoU9/SqS2zh29f/xy6D
         rEt3KGWcgXjAYfMCn1yEIyQmdDFcTqXOJFFa6PdlFLwsF//6yb4oKEpB8pSQTTyPPPVI
         rGt0fZKeA5prP4+yWO+Cx/ec2+Y6HHPki1ryQGAis2nPAqmqA+D1esMN/5P38nn+2eIi
         ZWBVckP2aPGTIsJbfcjqMp6UtW5mvsRk8czQL3ePDHsWxX9JJrAaOUmH/cIPxQomkgXV
         2FWZhE//HVrklVeMoiTF77/l98NWLnYdcVKDLqhuJTg3f9z3Vswg91CT3ztUBL5iXzUu
         5T5Q==
X-Gm-Message-State: AOJu0YzphoRFZ7Mxte6nz9/rHf3WA1R/Ss41HVlVmbgJbKSJIqSd1oae
	z1+YjAO/DL2GPBIYcDDDez+l5p+Dup2tr79/qQIGaXiiy2NzSWJ85WLRXD7+9i3E
X-Gm-Gg: ATEYQzxeoIhcSyrKvPx6kzwCoeDqANB9zX7TdUzGbX0d2jkgS3s+hyTFsGJ6glOvWzU
	tLvD8MOXnC9xV8olrblK4pSEFQOJFZYgWzyho/Huk46Es/aR50mzWUE7YtYqClRtqslN/ZPfXEA
	xR3BMP+do4o46c4DJgSpdVlQzzk/CrO4dIbjHZsUiNWenTFYlEymKi7hpeRPnEXD9zDGcIYH7nV
	xjiioN/+bqhHjxAWZTndSmlWNtTI2lobciWteeFxQs2obh0/gPfsFwJvBRP3XUoo/KSoL1M1oa1
	HLeO1yQyPiRJo43tNLwOdEmfxsTpjqAa87N3A2LA7TsbxiK44EMxJrK4JrxO5wAshvOpfO4nJpT
	+dMGBJCtC4yyqEhD+MQAmzTx8ncm1UKJT0UAOrNvkIKs+2un+xSgBlxMMBITo7/GqYtfrpqrdz8
	/5cFZNQ8e8FwR1xfB8Z6uaXz+kUPaNi8Yur504o3dXb5zwdD4wCS5a+LhMQnsql42uqaQrbptCu
	ISfuW4IElEWjXKEjeB89yNuCC1rRSO71v2aFg==
X-Received: by 2002:a17:90b:28ce:b0:35b:9a87:bac3 with SMTP id 98e67ed59e1d1-35dc6f343dfmr1362622a91.3.1775024833313;
        Tue, 31 Mar 2026 23:27:13 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([117.203.246.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe608062sm3537582a91.2.2026.03.31.23.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 23:27:12 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	Utkal Singh <singhutkal015@gmail.com>
Subject: [PATCH] erofs-utils: fix pthread resource leak in erofs_alloc_workqueue()
Date: Wed,  1 Apr 2026 06:23:55 +0000
Message-ID: <20260401062356.5320-1-singhutkal015@gmail.com>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-3150-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.alibaba.com,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 38258375299
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When malloc() fails to allocate wq->workers, erofs_alloc_workqueue()
returns -ENOMEM without cleaning up previously initialized mutex and
condition variables. Destroy them before returning to avoid a resource leak.

Fixes: 13f7268 ("erofs-utils: introduce multi-threading framework")

Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
 lib/workqueue.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/workqueue.c b/lib/workqueue.c
index 4a1a957..1f3fa7c 100644
--- a/lib/workqueue.c
+++ b/lib/workqueue.c
@@ -90,8 +90,12 @@ int erofs_alloc_workqueue(struct erofs_workqueue *wq, unsigned int nworker,
 	pthread_cond_init(&wq->cond_full, NULL);
 
 	wq->workers = malloc(nworker * sizeof(pthread_t));
-	if (!wq->workers)
+	if (!wq->workers) {
+		pthread_mutex_destroy(&wq->lock);
+		pthread_cond_destroy(&wq->cond_empty);
+		pthread_cond_destroy(&wq->cond_full);
 		return -ENOMEM;
+	}
 
 	for (i = 0; i < nworker; i++) {
 		ret = -pthread_create(&wq->workers[i], NULL, worker_thread, wq);
-- 
2.43.0


