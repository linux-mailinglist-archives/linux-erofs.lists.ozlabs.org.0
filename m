Return-Path: <linux-erofs+bounces-3678-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ae8JI1/DNGrEgQYAu9opvQ
	(envelope-from <linux-erofs+bounces-3678-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jun 2026 06:19:43 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EE56A3C75
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jun 2026 06:19:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3678-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3678-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghPWG1zzgz3bps;
	Fri, 19 Jun 2026 14:19:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781842778;
	cv=none; b=AxXSL6lqy3BduupIE1izfvR71SV0CQ8kpUiT6SNtRkSC5EsHjSqfiuWOiGNlyJd1jraz9dstRo/taxWdCJP3gF0Xn1zjFSXbSZHGhoNnaTrfaLBmTjMsO4VvB9aZsxN9ILzt95WDm8ynjEZvl+I/ww9WXTOiiYHC3r4p9A33DuMlS79xgSRDGoN6BfAfazjKzDLrnkB13T/GfTJRWATAqiPmvDqbZw6RF54g+tN6JY6a1LdeKbg3OR4y26r4MqmKGAYft4Ho5EtgXbh09URzuftIUljAt3K+IyBSRA4AQFE2kbRk6E14pbrSiOhvGbVDwbruKovyPhH89NLvAOVfYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781842778; c=relaxed/relaxed;
	bh=eOTBuewEJAuqsPkyF+tcyxa2XVezxYhVgyFbOqsw7Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HmGv74ddqMtUkYy0sfHTAYuqSRyeH4C1YWqfCl1ukmk0PYMx3KC7hbR1+H+TEhBIVJRepCb+ayLH7Wm/rrWy0MO+p4ZprN7sUGFruiBjzPwq1gU4/JUn2QD0+m9ecl7b7B5Hg9A4B4NhuHqHPQ9o9+uBLTVXggGxWvo16IE7hHThJ4KYU7kMZVPH+5tyTizLHpduQIY14Qq7JDa9vzHrdIGPi+e0Bri9yRFoqkEy3YLlE/uG+CW+ug2WeWJOr5CUaS8XEYlhURY98ybXo1WMVbw3rgSQHNWuduM1cvFAkzGwIcOjzr93kBuQeXN/nFXRa9Jsfo5VmuCvemfiTyVaQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.62; helo=out28-62.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Received: from out28-62.mail.aliyun.com (out28-62.mail.aliyun.com [115.124.28.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghPWD1G7Cz3bpp
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Jun 2026 14:19:32 +1000 (AEST)
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.385346|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00282732-0.000360199-0.996812;FP=3272964558224594357|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032023038;MF=hudson@cyzhu.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.i0FVOeA_1781842762;
Received: from HUDSONZHU-MB0.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.i0FVOeA_1781842762 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 19 Jun 2026 12:19:25 +0800
From: Chengyu <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH 0/2] erofs-utils: support ublk recovery
Date: Fri, 19 Jun 2026 12:19:20 +0800
Message-ID: <20260619041922.64521-1-hudson@cyzhu.com>
X-Mailer: git-send-email 2.47.1
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
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.00 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3678-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[cyzhu.com];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	ALIAS_RESOLVED(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[hudson@cyzhu.com,linux-erofs@lists.ozlabs.org];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75EE56A3C75

From: Chengyu Zhu <hudsonzhu@tencent.com>

This series adds recovery support for the ublk backend and then cleans up
the mount-side naming that became misleading once the same context is shared
by NBD, ublk and fanotify paths.

Chengyu Zhu (2):
  ublk: support ublk recovery
  mount: rename erofsmount_nbd_ctx to erofsmount_ctx

 lib/backends/ublk.c |  23 ++++--
 mount/main.c        | 186 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 159 insertions(+), 50 deletions(-)

-- 
2.47.1


