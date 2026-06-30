Return-Path: <linux-erofs+bounces-3784-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /6UON30vQ2rITwoAu9opvQ
	(envelope-from <linux-erofs+bounces-3784-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jun 2026 04:52:45 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EEED26DFE70
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jun 2026 04:52:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b="CVPQD/K9";
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3784-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3784-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gq73q0Nb6z2yZZ;
	Tue, 30 Jun 2026 12:52:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782787958;
	cv=none; b=fRWgNMnwcv9gpELuD2Sr1CT0hiU1mPZ2brBheUQxr1GBGRFrymq9Us1D6/qQgmzNNmIXS2QWbLIKZV0BfvDUO47WCDg3DLbiO7J6isw+YQfACaj87ZDcP3B8cPrGXEPI6J2xSEfg3cMiyyUzLC/jGDsjhpZEjL77jP7f6hGV9XmDv6VjsAOCt45qH7ePz1IXHfOhe3uNBc9OcXnvrmY4j8JX3fp7NQKLNU63BwYYGXASaAYGCdqEgo/KgWKH4Q1HpgVTNil95fUoN86eGRbtO3ltJmf+L2u7/5LwUo6llf7/aC7fLXW/J5eBY3Sju+FqVuAAIdb3HVYTmCxbyvCwAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782787958; c=relaxed/relaxed;
	bh=lh8rv93r6CwDWuA5VL0CHj8CLLN1gg0VJYucv0IP9Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VRkm/L0+fje/7whtDdTwbODoe779qDAkAizlMzAKQrCTxJpYd/fw3O16B6upFNHRhPrQ3XP+KEWvdAA37Ul1X8zLsyXb69+AFJjqUVSfLaBvMAAmUqN5WBOuli1vBXeNd/N6t2ilE2VDCw/VceQMuG36msDtFVmAHoyqoFKv7HEv4wNUUEBuM6PpZhaU3jU2FYcdnESVWS4DVE6BoavD0aDLjo8lH8Osdn25q28YNyxOE6asw8yY7yr0+DSe19ziZFrPzmVgrtcfajt9rkrota3pzS6tVuOcjsO8U6q5Nu7uvwLFV6FqI/e/iV773xkHMlQEdsPXNg9jKVAjsg+tGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CVPQD/K9; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gq73n4rvPz2yZ6
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Jun 2026 12:52:37 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782787953; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=lh8rv93r6CwDWuA5VL0CHj8CLLN1gg0VJYucv0IP9Vc=;
	b=CVPQD/K9LyKEkkVau9goxHSlEFMZIb2BpCSgr/ZC2UHv8duXQt/w2hUmISEX4UsyEC//NhJiHoIrEt9aWvEFCnWYPkkID4zJlpLiNkfyhh8qbxYT2JmdN/3xBuauAoL7iQaggU68eCgYPf9IrqxVaa6zqh6VIBzauC9cPLYv9x0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0X5zS2pd_1782787951;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X5zS2pd_1782787951 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Jun 2026 10:52:32 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 4/7] erofs-utils: mount: fix `RESOURCE_LEAK`
Date: Tue, 30 Jun 2026 10:52:21 +0800
Message-ID: <20260630025224.3955763-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260630025224.3955763-1-hsiangkao@linux.alibaba.com>
References: <20260630025224.3955763-1-hsiangkao@linux.alibaba.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-3784-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EEED26DFE70

Coverity-id: 647264
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 mount/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mount/main.c b/mount/main.c
index 48418275b2d0..ffe718a0a90f 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -552,6 +552,7 @@ static int erofsmount_fuse(const char *source, const char *mountpoint,
 
 	/* execvp() doesn't work for external mount helpers here */
 	err = execl("/bin/sh", "/bin/sh", "-c", command, NULL);
+	free(command);
 	if (err < 0) {
 		perror("failed to execute /bin/sh");
 		return -errno;
-- 
2.43.5


