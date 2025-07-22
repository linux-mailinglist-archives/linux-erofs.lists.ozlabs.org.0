Return-Path: <linux-erofs+bounces-699-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F16B0D67D
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Jul 2025 12:00:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bmXp35dmtz2yb9;
	Tue, 22 Jul 2025 20:00:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753178443;
	cv=none; b=nw208Hc9RybmxJfIcq3+jlBuG0ZAUAORmR71+3TujV7u63fg8Vnx+dpgQZBHbRwOmrhtVOhhfKkQP8BYoTV4lODjWiONVEnReubh9r+obXAe776UC6Q+htHivIBrfRINK6bDa+MdcmeCsemzfN6kCUdmgr+PDx+HzwTREWi4UHDGUaeW8bltAkce1zJ2xhkZrCXxVmA1vKuhAJ0uM5NH8KTawvU6tgcgkJ+0vddg10rF329D3Ig5FW3v9SSSdaMW/PojNB+U28r3ZpbKFuByrJ3pJG7YRQTXyGPcg4u0TgLXB3UmZDTOrdZVDBcQiU42TAXtnnm5VJBb+DUDSxmMUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753178443; c=relaxed/relaxed;
	bh=lPjat0Bi98OfxfxyAaI3NTYf7rjxuzInugrh9ayiTI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DHUWMx8azNpQcWn8Um5MOhiAXIt3HrBmdpQ0MBNRe9qYSJhrSysnrvhRYAncEgpIkSwkgcR5jvZNkRSien7RofOokmQDswm+MYpifsmRT+RTkkPnoHIlkcwrqFpU0a4kgYLFoDeuZRX92eLvYMVLYH4mZtElSZfvHvEHTZcXM4fvE/yBK3XrEIC442vZkuUEKhwmsEhR1v6sNspSFU8xe3QMUGq3p83s2PrTJ31x0GbWvpZvA+oUPiR5g+hOb/Sst4F9KZqBoEdmPpmjiOv+RqxlU0i5U3HFEpuJctUfSabMLDkZk3l857Pw3VLttD/psuReROwP42q9ZWnm0d99RA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=P7SGnOLD; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=P7SGnOLD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bmXp15Pn2z2yF0
	for <linux-erofs@lists.ozlabs.org>; Tue, 22 Jul 2025 20:00:40 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753178436; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=lPjat0Bi98OfxfxyAaI3NTYf7rjxuzInugrh9ayiTI0=;
	b=P7SGnOLDtSMV4xITvch1QdlUcHKNqzL45lHFdU6lWPOn+f6Wg4tKoIqRe4BjO8pPpZUf8WEwW7+kyBHFFXfHym+29yVA0Jf3vaeRqNAZ54UBXOR4hC3tYv4WfDc/CV0NrywqoyHW3gDVfdYkQAbJ8zIMDak+yqZ1zfye59C9eWc=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjVvTmr_1753178430 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Jul 2025 18:00:35 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Stefan Kerkmann <s.kerkmann@pengutronix.de>
Cc: linux-erofs@lists.ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 6.1.y 0/5] erofs: backport for `erofs: address D-cache aliasing`
Date: Tue, 22 Jul 2025 18:00:24 +0800
Message-ID: <20250722100029.3052177-1-hsiangkao@linux.alibaba.com>
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

6.6.y fix: https://lore.kernel.org/r/20250722094449.2950654-1-hsiangkao@linux.alibaba.com

Hi Jan & Stefan,
Please help confirm this 6.1 fix backport if possible too.

Thanks,
Gao Xiang

Gao Xiang (5):
  erofs: get rid of debug_one_dentry()
  erofs: sunset erofs_dbg()
  erofs: drop z_erofs_page_mark_eio()
  erofs: simplify z_erofs_transform_plain()
  erofs: address D-cache aliasing

 fs/erofs/decompressor.c | 23 +++++++----------
 fs/erofs/dir.c          | 17 -------------
 fs/erofs/inode.c        |  3 ---
 fs/erofs/internal.h     |  2 --
 fs/erofs/namei.c        |  9 +++----
 fs/erofs/zdata.c        | 56 +++++++++++++++++------------------------
 fs/erofs/zmap.c         |  3 ---
 7 files changed, 35 insertions(+), 78 deletions(-)

-- 
2.43.5


