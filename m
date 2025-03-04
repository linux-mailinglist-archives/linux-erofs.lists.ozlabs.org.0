Return-Path: <linux-erofs+bounces-4-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DCCA4DC1A
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Mar 2025 12:12:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6Y1p5lDNz3bld;
	Tue,  4 Mar 2025 22:12:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.16.41.108
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741086390;
	cv=none; b=bNZLppLi9jhO9SwEkw5DU/+WIOrCVOYSia8jn1KF0g7o5TPdkW9151+72LKZv7QxOEt5HV4WIB9z+YCM8L06Y29chpUCznkQmNRJ4U//YRzG+qqoGlSoyIkxKmm0QVlpPpAf03FWhQ2M0rJYXMdqsFFhw2IgzG9T47Awbzsg1BKqIs794u0agz1D707cwlnuDCtYfCY8eZdEmwmeogi5Gz91H5l9asy1T2MhxZ4AUOqtxgqScFdvbCmRCqb7Q4VPo7/APmFMvj5p2103fFoIs6bTuXHorYYOZguu9SDPtsr59wTPsqFeyO4BycvHZj2g72JDO0dUpGqjhnCx4WP3oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741086390; c=relaxed/relaxed;
	bh=aidFCCwoyLLJB8y70ZLRHcH/5O3h84FAjWtPCnyu0PE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xw09LboeZ2z6RpYlL3mvhp0Oxw8Jwk645FROsZGOPET2jwRyn0OyqjutMfgOkkMwVJ2V85f+GBHRc3Trrin9XRX3vLcKu3YZRZ8KnLuVHiZugv2OvH4BCxfNthuh3UeYX6EAWWy2bj+t7nbVUx86txdehlSRg/6bKFVh0znDYHM82M6pqF4+LwwPX/I3k+Or8G1KK7ExtrnXqqtjp56rHFntDG8JC56gbSz17EldMbj3LcjhGzFYdQ61hm+XlE1ECvqlqmFR8IXQuVheOZdGve1YMU6oh7cOfDhUa+NCsjO08QBavvSadUfFogJFu8O8uzMsjk3dijuj1MYq4bNpSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass (client-ip=195.16.41.108; helo=mail-gw02.astralinux.ru; envelope-from=apanov@astralinux.ru; receiver=lists.ozlabs.org) smtp.mailfrom=astralinux.ru
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=astralinux.ru (client-ip=195.16.41.108; helo=mail-gw02.astralinux.ru; envelope-from=apanov@astralinux.ru; receiver=lists.ozlabs.org)
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [195.16.41.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6XtY0ZDdz2yVV
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Mar 2025 22:06:26 +1100 (AEDT)
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id A26821F9EE;
	Tue,  4 Mar 2025 14:06:20 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail04.astralinux.ru [10.177.185.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Tue,  4 Mar 2025 14:06:17 +0300 (MSK)
Received: from rbta-msk-lt-156703.astralinux.ru (unknown [10.177.20.114])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4Z6XtH1zdrzkX0x;
	Tue,  4 Mar 2025 14:06:14 +0300 (MSK)
From: Alexey Panov <apanov@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Panov <apanov@astralinux.ru>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 6.1 0/2] erofs: handle overlapped pclusters out of crafted images properly
Date: Tue,  4 Mar 2025 14:05:56 +0300
Message-Id: <20250304110558.8315-1-apanov@astralinux.ru>
X-Mailer: git-send-email 2.30.2
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2025/03/04 09:15:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: apanov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_uf_ne_domains}, {Tracking_internal2}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;astralinux.ru:7.1.1;new-mail.astralinux.ru:7.1.1;lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;nvd.nist.gov:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 191452 [Mar 04 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2025/03/04 09:41:00 #27591543
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/03/04 09:15:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

Commit 9e2f9d34dd12 ("erofs: handle overlapped pclusters out of crafted
images properly") fixes CVE-2024-47736 [1] but brings another problem [2].
So commit 1a2180f6859c ("erofs: fix PSI memstall accounting") should be
backported too.

The backport follows linux 6.6.y conflict resolution changes of
struct folio -> struct page from 1bf7e414cac3 ("erofs: handle overlapped
pclusters out of crafted images properly").

---
v2: Corrected patch comment about a minor fix. I mistakenly assessed
the significance of the changes relative to the backport from 6.6.y.

[1] https://nvd.nist.gov/vuln/detail/CVE-2024-47736
[2] https://lore.kernel.org/all/CAKPOu+8tvSowiJADW2RuKyofL_CSkm_SuyZA7ME5vMLWmL6pqw@mail.gmail.com/

Gao Xiang (2):
  erofs: handle overlapped pclusters out of crafted images properly
  erofs: fix PSI memstall accounting

 fs/erofs/zdata.c | 66 +++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 32 deletions(-)

-- 
2.39.5


