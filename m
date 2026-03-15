Return-Path: <linux-erofs+bounces-2709-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEjEJzvetmlOJwEAu9opvQ
	(envelope-from <linux-erofs+bounces-2709-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Mar 2026 17:28:43 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 521102916EF
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Mar 2026 17:28:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fYkDl0VgNz2yF1;
	Mon, 16 Mar 2026 03:28:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773592119;
	cv=none; b=ACS88tYZGhgm5xgrsh5jw/eUC+mBli/OQA58GLfB4oBaDc91EqUEt/+tOFTxz/0NlP+rpprRJdP3skNB9+BwPSaz5cRWIEiNISVZrKNV+3yPrvGfRvJBjTd237vhwi0I1kGQ2M5veivZkd87XqbBj+8GPLu5Mnn4Vi/4PW6KIklCJt2ejFIh4dqwIaUT+6HjLZYdPVV1W4cGhz8H6GR61DP4DpMOt8bDvvnAVlsuS6iPS/LPogAM96VC3/KMCMrh3ockcKK8mEo+Q/8cszRU5n4+o66u1/8XnZxmZiitrY/G1jm2AWs0UKyZ5xZQJCRpZ6kXyrlQeWjzBKAlvAnSYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773592119; c=relaxed/relaxed;
	bh=Xtw98uB7v1zHKoslDSeoSegCcIr7J7RAVQq22gnxnlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zi/HKcni2pjZ3L/y1jFO7JSZcgMFD855jC1cZk1aDES78/yo9UzyNOSF28UUGqpqbG22nOGVQjv1yVqO6mEgdPxtunUylxhnPjjM4Q29woYaaM4Ba7gvHHbLoe94Zj+3d3MUYw5rHLO4vFbbnkMXDWvjWr0dltiV2et36eCNacevCkVNqA8mwCe2FhcgEO4TYdZ7KGmfb97PBzoeCTBoywCfah7iJQgCtgyx9273h1GOhiHV/evFur3mdqpIMRY4iZyOavMQ8ixFNYtlmhXCRNFkpIjFjxUEHki83U2DItFqPHOQ7en//QBWXRcE0aJN1Uvf9harwapm40Zn3wmG7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=i2gRWKGY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=i2gRWKGY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fYkDk18Qgz2xnl
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 03:28:37 +1100 (AEDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2aecf52fa69so2474475ad.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 15 Mar 2026 09:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773592114; x=1774196914; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xtw98uB7v1zHKoslDSeoSegCcIr7J7RAVQq22gnxnlw=;
        b=i2gRWKGY2IZR4I1WVnjqTayQoqEse2DTuRRotZMpiEtNI8oFQgZKUpvk1GMcTRvFbO
         z1qh9OPeO9piku5EOCfTK9bjsnC5tEKNdeXaR4JZ7gsvKMRv2EbtYtuAQyeR6TJu1HRC
         lUQbImKLBW6kcf/SHKb9RpwFZGZhnHTdeACgRYuC1WN3er3w6oqmcvN9bMiiOxyRrF1s
         R65kkvcLzYqkV/ASab/wZnmY9/kkYXmQ3mrBs+kcq5TPm31ZJ8oyDYfGI8OgG9RxHdyS
         Lun+kCPK0Hj/1odbEwGEjUAjhw6HNGWwBtr6edG1d7FqGiDQA7ZMMIIi+AD4tz/hZpXr
         mBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773592114; x=1774196914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xtw98uB7v1zHKoslDSeoSegCcIr7J7RAVQq22gnxnlw=;
        b=mfuxKvQHD5r7GE40TupQXLsQMhuBSPFGGneJveXM3duKjZuXe50t5X+JHj4d5xD3Qp
         wSBmLcSqF+LvTDuAYikPH7o24Li7dcBfq1SYdbRdqu1CQBjmYOy4xrL20bDRDHk6SwoZ
         1LP2ROg7WbbFiVEbu76IvHikMIeDe+RtgpPhMXNV76Qis3/W5N/4HuAObmY3Sbhck2kt
         CVKNDOxafeybzk0QkeD3/dxBD5xxKtBG+HiHJbKa4vC86TZWNvlmirYgzoKDhq7g4OQm
         Mk7ycPoSsVLirXlDbBHT4hW9AE3RTzdcILozwGab4FwLLheY7+O145ry+wSBstrnWPaN
         FajQ==
X-Gm-Message-State: AOJu0YxBm/KTqftjH+UfoOH/eLLWjL/wBD4ELz4zAL4s3XadoIcDccbC
	yX4EQL7eBfGBfF+NS5424G0TpS5ROigRbb6uSsbaAW2TNaULvScE2JGH52bozWku
X-Gm-Gg: ATEYQzxPL6QeKYsufsd4E0B86Izb8VLa72UffyR4ue5ZZ5IprzjYoplYEtzc7O/HDZW
	1Pjt4Wbk5QmvoA+/3VHqNF+0HIza+GQ2h468esyNOn/ow2V1203TDoYEo3mzkr6ke4kp5gd6sgt
	+esHXue+0ytwmmf4QFfZEPACX/zfJYMFljc8so+ORnGpPqBAJMmEeuhCv8mQejcjzPd5esl3SUY
	cGQai/AD+EvBgtWPxU9xTOH4ig1ON+BI/ydLFTumXvmShRcl4SGBcRVLTxlH6ZoHg5k4fpN1NkA
	a4oYRutp4x7gXkIKJMM5kEF9gbEeND/kYyqe8pHJ/XhuFBd4uaQOgy+pN1/SBFnTkZAuRoN4L9r
	4DAE9rQKAVHYWug/pJpW94TXxXLuw42Rof9vM382f5xDbVfgcVdevurZSLZuQZwNIov1KiS6Mwp
	CVPU4YW6LAJRgkoiwL6QROnlpKljvQsx81WxfjVoEenfdT9soyk3had+C1jJRBI15tx4sYjnYKb
	mvOG0zwMS9o3Vh27Me4uk6qLkpcpQN0P2w4qA==
X-Received: by 2002:a17:902:f546:b0:2ae:4f95:df56 with SMTP id d9443c01a7336-2aecaa3eb84mr68397745ad.3.1773592114536;
        Sun, 15 Mar 2026 09:28:34 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([117.203.246.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece7ee1e3sm86663085ad.44.2026.03.15.09.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 09:28:34 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	Utkal Singh <singhutkal015@gmail.com>
Subject: [PATCH] erofs-utils: lib/tar: skip PAX entries with empty path
Date: Sun, 15 Mar 2026 16:28:30 +0000
Message-ID: <20260315162830.24556-1-singhutkal015@gmail.com>
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
X-Spam-Flag: YES
X-Spam-Status: Yes, score=3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Report: 
	* -0.0 SPF_PASS SPF: sender matches SPF record
	*  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*      valid
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from author's
	*       domain
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
	*  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends in
	*      digit
	*      [singhutkal015(at)gmail.com]
	*  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail provider
	*      [singhutkal015(at)gmail.com]
	* -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at https://www.dnswl.org/, no
	*      trust
	*      [2607:f8b0:4864:20:0:0:0:632 listed in]
	[list.dnswl.org]
	*  3.6 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
	*      [117.203.246.41 listed in zen.spamhaus.org]
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [4.30 / 15.00];
	SPAM_FLAG(5.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2709-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	NEURAL_HAM(-0.00)[-0.778];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 521102916EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a PAX extended header contains 'path=' with an empty value,
the computed length becomes zero. The subsequent trailing-slash
removal loop accesses eh->path[j - 1] where j is zero, resulting
in an out-of-bounds read and undefined behavior.

Skip such entries to avoid unsafe pointer arithmetic and invalid
filename handling.

Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
 lib/tar.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/tar.c b/lib/tar.c
index 26461f8..be86984 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -510,6 +510,8 @@ int tarerofs_parse_pax_header(struct erofs_iostream *ios,
 
 			if (!strncmp(kv, "path=", sizeof("path=") - 1)) {
 				int j = p - 1 - value;
+				if (!j)
+					continue;
 				free(eh->path);
 				eh->path = strdup(value);
 				while (eh->path[j - 1] == '/')
-- 
2.43.0


