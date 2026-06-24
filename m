Return-Path: <linux-erofs+bounces-3747-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /zsXKK7dO2qreQgAu9opvQ
	(envelope-from <linux-erofs+bounces-3747-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jun 2026 15:37:50 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 993766BEAEF
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jun 2026 15:37:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3747-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3747-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gljfw2K9Qz2yZ8;
	Wed, 24 Jun 2026 23:37:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782308264;
	cv=none; b=edaJP8PwwoDvkjg6l2gmV9Ge+K6tYqwl0v3zvnRmBroyVzSl6AKv/6c4ZzTAOBkOdZ/zLu7hKCz6aaPvXIUhJU6NvWG/WTptt9VFKpmQJnsHd9lCQXeg8w9Mu8XLI+phTP88Y5irSy5MKML/Qq2dn9Kdhof8dgxHctzZdieMZtjKKkuN3Px8lLYsy0fN285mgDWHft6SEiVI2aI+BF2b641SrRuDGN54dhnD/BfYxpsUJUew5Y2+uFHWBT9imOBcYZrjlHZtgDXLQ7ULeCv0kbcaLgf5vIRoTyWor6BrG82QT61E17X7gJN8DE+zMjNTHKBF9hDwTBVqdNW7XLi6gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782308264; c=relaxed/relaxed;
	bh=WD9K6pG4axWJHr2LOot4g2Qdvjm+Iwv2n8UVaHgC3PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNs9AtB1FnfBNMVGAaukf84rjOc7iZ4wyZltauRrFFw8tlwhIcyTWlV5W3fe//VScAZsoYsOUrsCileqOxOjk7Q6MKYiT6Rhtxm9VPzjLlL7oPbYTImHVZMGB3H3xdi8CsJYxemYyR+OzMobKoDuVYQkRlX1UEVKYyIWumbvmyO4WLT8F52gIUtRn/nLvODcQAmhI7UrR3kV5dvsQFq15grE89nWUZl/Brz1TOs3UHR5BknWqQ0eTtQNqv6d9jIMlWypbffCZg/XRFLd4ol701M2z1BO9m8IJvrdvTr727L77wn0A1egtVlul6kr0BY9G/ypKaUG/+yXxs36XqkGJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.45; helo=out28-45.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Received: from out28-45.mail.aliyun.com (out28-45.mail.aliyun.com [115.124.28.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gljft2Cv8z2yVv
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jun 2026 23:37:39 +1000 (AEST)
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.385346|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0027092-0.000363508-0.996927;FP=3272964558224594357|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045220102;MF=hudson@cyzhu.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.i4Wq2SY_1782308252;
Received: from HUDSONZHU-MB0.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.i4Wq2SY_1782308252 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 24 Jun 2026 21:37:33 +0800
From: Chengyu <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH 0/2] erofs-utils: support ublk recovery
Date: Wed, 24 Jun 2026 21:37:30 +0800
Message-ID: <20260624133732.18218-1-hudson@cyzhu.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260619041922.64521-1-hudson@cyzhu.com>
References: <20260619041922.64521-1-hudson@cyzhu.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[cyzhu.com];
	FROM_NEQ_ENVFROM(0.00)[hudson@cyzhu.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-3747-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 993766BEAEF

From: Chengyu Zhu <hudsonzhu@tencent.com>

This series adds recovery support for the ublk backend and then cleans up
the mount-side naming that became misleading once the same context is shared
by NBD, ublk and fanotify paths.

Chengyu Zhu (2):
  ublk: support ublk recovery
  mount: rename erofsmount_nbd_ctx to erofsmount_ctx

 lib/backends/ublk.c |  23 +++--
 mount/main.c        | 207 ++++++++++++++++++++++++++++++++------------
 2 files changed, 169 insertions(+), 61 deletions(-)

-- 
2.47.1


