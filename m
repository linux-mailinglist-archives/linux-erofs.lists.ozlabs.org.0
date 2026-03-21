Return-Path: <linux-erofs+bounces-2912-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDtbDka5vmksYgMAu9opvQ
	(envelope-from <linux-erofs+bounces-2912-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 16:29:10 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 425812E6176
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 16:29:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdNdF4y3Fz2yFl;
	Sun, 22 Mar 2026 02:29:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774106945;
	cv=none; b=dYQjOoCW7+k0BH4P7jyYJefXTMNyyR/Vfqm6Wgf8tXeZ9wI2OmgyTwJwenFRXByXV44e0/LA1dpUeRh0PcYd4votdRLu5frfF7yV1KVJUNgKmdg4eSWXT7GSZkksh8qHHTq6tuDAioK+HblFrJuqcQm+znYd/XImGufOllGSHQN8vzD2CP3y8gK7NswNfLXdM6IqhSTmnrA2ds2mXURcabm6i+uP/xIJ9SwYOAyuiOCtja9AIuxbPYTx9elSXVRsKrbUQ6o/PhX0f05h+47YHIfhiB1EJpbjQI7XVMwpcNcDpYasUVD9a590h+MjazzNmVgsim01uYWpeE+GOydz4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774106945; c=relaxed/relaxed;
	bh=fWukqVlhdgfKZBZs1uFeootcPX3ubjh7eMmyKCU/7Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NorWgN+kmozUeivm4Z/Pgde3bJkEM0GskUMvK8cLcjiJw7TyT4UJg3J0/1vrG0CBYS09ShB0bZUaBq/MXqfiwcFsx6qKLyH4/tDCiVPV0HB13YHvlPk0ekkHrq01NkzQLXKGUIQ/dV0f0GmVct+w0rwfT6aaJTCQTz8P1DOLNYBdGrkVwzFho84jHWqtpcbtz97X3c2yF8K/nKXHktearvfm9xhumVoYpC7f0ktI69/6gc2szFTQ20ACleCqqtpHpGiWlwoLRJMcin06s5D35/+38SLCARqgfpV5B3YvHEde93ZIbUdky0uQelpWBt6b5MAcIRRiXjhoY92NenLsww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=XhzqGe//; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=adityakammati.workspace@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=XhzqGe//;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=adityakammati.workspace@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdNdC4Vjbz2yC9
	for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 02:29:02 +1100 (AEDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-35a094cc3e9so1920077a91.3
        for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 08:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774106939; x=1774711739; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fWukqVlhdgfKZBZs1uFeootcPX3ubjh7eMmyKCU/7Eg=;
        b=XhzqGe//nswlX+r3llxGy1WBkcQdYuXRI/VdpbH9wdFsylqnb9dlH4Hqddf2Ig0aGN
         1Utv5QAi0AkhI/lJlRwdbUK0HyWqkLG48H2QXHiAEjDnZiTdWexoXsJJBVjsPhX78wZE
         levBrP2ZAREAUe3jKtzLkCztGWLzr4uYzLfKgupjPAZkA/BL5palg105obTiKvW/qvJg
         mefrS/4eJYbiiJE29bJyHSvcftZH47oMXZQsQBMgbneGQlRpQd4y4zoieI2NC/2YMaNt
         2OIbZ+BibiB3ZR263ybglFecMVZ6AQ5X+m/nyUuYyFV3HZoTE52NmaAwcURmTTT0lHi0
         3VfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774106939; x=1774711739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWukqVlhdgfKZBZs1uFeootcPX3ubjh7eMmyKCU/7Eg=;
        b=G7yNFVyh1o6WqT/657JOLTEnzFRyUOdddO9Jv5JFUs71Zra1zVOmcsE55oUYx9yiJU
         SuO/I41EPNK9rZGZqsrTp16PJCQDqu//P69eo1VquKpJfKwqjsYf6bLkQ0LcRr7+b/ld
         Zfz3M1PcN/hdfmrmfgvttjq2lA1y4a6AJSFyz+OCm/qDHN+iC64YyNxHv/PS0APjrDqU
         3+mjx3txcryASQhKf5SuSGzQlib1//NDaxPSyvSt90QNm8n9/n2ak5V7EysB0hyM4n9H
         1+7CiBFZGZOSTOVF80CK0jo1G8NZTRAhqALv9mk1KqU+LEC7+J6sGmEe8/P3adGFOA1u
         ubsA==
X-Gm-Message-State: AOJu0YxF/Dr6LT1TRcYGcE73w8SVX4pq5wH5D73sH8JWY9pU9FPn+ZYh
	1c1L8NO3DZw/E32pGYG1kJ5UFtFXr884WQT4tKxi/h2No+mIz9GSCHCO2G8RfuU46tA=
X-Gm-Gg: ATEYQzyTl1CQvpuDtjty1cVF0Jvea0RfdZ0vSG9469b+XirPDeyyjJg0BvG6vLrU6sA
	Z/4RGQGiKh/IhXKLxCN54G7ZFeXcrzCgTPz2rEtHWnA4BTweGeXUnM5AmukbVhA//kbTWs5mXVo
	SBXwUSg4iSOnydNRsd0Qb/5LItaa/e9UVZb8rDX2CDHJlkw8J0knitW3BGlRnXFEHnBbID/sTCU
	OnW+loMtTcJbLQBkVl5G50KWnVsgiVwGEAdY/hzavJdxZWE3vBP/QR/TMr6As6ZYUAVBpFKuyXD
	NEFrSPElQAq7Ka1n9HMciDTMqldKMeexxqadkMeXIexH4YYk2a8QYkimZPdTe8gMdFccHEZlzJV
	7JQ7OIbuHjJ0pveUggpD8PcVv7FTIORuCkYODRUUTDZGAy/CQZaiLJQEf1LCtzwYT1rX5Ah/a7B
	HUydGat94H3mnYXYFJ+q9DyD7gogCPtxddIwvqmOtnVZnUCe/hwdKVwDamjTYAaSCtYvblc/I1I
	W5YQ0AzlrAe7YYNAYdLkFgC
X-Received: by 2002:a17:90a:f94f:b0:35b:e554:c504 with SMTP id 98e67ed59e1d1-35be554c523mr703786a91.6.1774106939047;
        Sat, 21 Mar 2026 08:28:59 -0700 (PDT)
Received: from localhost.localdomain ([104.28.157.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc6017492sm8395364a91.5.2026.03.21.08.28.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Mar 2026 08:28:58 -0700 (PDT)
From: adigitX <adityakammati.workspace@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: adigitX <adityakammati.workspace@gmail.com>
Subject: [RFC PATCH 0/5] erofs-utils: add manifest input support
Date: Sat, 21 Mar 2026 20:58:27 +0530
Message-ID: <20260321152832.29735-1-adityakammati.workspace@gmail.com>
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
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2912-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[adityakammatiworkspace@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 425812E6176
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This RFC series adds manifest-driven image construction support to
mkfs.erofs.

The series is split into plumbing, loader interface, composefs support,
proto support, and a final mkfs follow-up so each step is easier to
review.

Current scope:

- add a manifest source mode to mkfs.erofs
- add a manifest loader interface in lib/
- implement a composefs-based manifest subset
- implement a proto manifest subset
- enable diskbuf staging for manifest-backed inputs

The current implementation is intentionally minimal.  In particular,
composefs xattrs, inline content, and digests are not implemented yet.

This series is based on:

  b67812ce4eb5 ("erofs-utils: fix thread join loop in erofs_destroy_workqueue")

Build and validation:

- built locally with make -j2
- final tree passes ./tests/manifest.sh

Comments on the series split, manifest format handling, and any preferred
follow-up direction would be appreciated.

Thanks,
Aditya

adigitX (5):
  erofs-utils: mkfs: add manifest source mode plumbing
  erofs-utils: lib: add manifest loader interface
  erofs-utils: lib: implement composefs manifest subset
  erofs-utils: lib: implement proto manifest subset
  erofs-utils: mkfs: enable diskbuf staging for manifest inputs

 include/erofs/manifest.h |   26 +
 lib/Makefile.am          |    3 +-
 lib/manifest.c           | 1061 ++++++++++++++++++++++++++++++++++++++
 mkfs/main.c              |   67 ++-
 4 files changed, 1151 insertions(+), 6 deletions(-)
 create mode 100644 include/erofs/manifest.h
 create mode 100644 lib/manifest.c

-- 
2.51.0

