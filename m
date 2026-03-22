Return-Path: <linux-erofs+bounces-2924-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Uj1wJomFv2lC5wMAu9opvQ
	(envelope-from <linux-erofs+bounces-2924-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Mar 2026 07:00:41 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 313762E8556
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Mar 2026 07:00:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdlys38tsz2ySb;
	Sun, 22 Mar 2026 17:00:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774159237;
	cv=none; b=lrTYRR8qd7Ubr3v5UhCYsm6ATJQME5YYv/rVvXjsOpj9DmULCOAaCb8J0ddDqqhMGL7GXQX1jw0Ra8WbG6/SPhRJzTJtQ/O0d0fwvHGBJvcN47vk4zVmCjZp1lG2FQMD3TmsIw33UKAEYB0Z3NFSLyMT6xa//f5UZgpcfB9Qm3G5Ic/fVThmbabCv3dQWDej4iqWFYt8OzkOoHSo0Wqoicrh5TjodQ9KPjod8Tvc6fHILoMZtcc9CdfIAwD7odxL0GWwM1njv7OCRmGPIGw2p87nhlGoDKQ1GXmHIt7POhq7vIwoEKwRw6PjfOrAWclMOQsA+hUyIAxK9zAEdKYHcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774159237; c=relaxed/relaxed;
	bh=iaUNDmJO8C+O2ztLLrAumQtevZY9H6OG2tdHce6OP+M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bTaAGxpA9OHybwCWuQXleJvnj4h4PUw299I6HUrPE6n9KZ3IraQ7tJzB8Hl8RziTfleZrVuyRU41XeYXcy6MTwvg81nfkn1OQw9i34tndBZqpl17VePTT8S3diGBKv73vInGGIkZe7pY00++Vkdra55lCE2GUjo3PXPr34mGAUqvT5MGXK7MWhfF2pSBhvLdM2B8GtFM9+lLIKvj7cvwozeefW4JKQNDGeghWucj0cxfwRZ+ZLkVFYY6ERH8er6EBcvq/D5Hlmu26FOmjkv9Fh5w//Ka4vT/0g+vf0G2IBev0Tjl3WXoKeD+8rqN/fVdnSNEGQ8KpenuiM8NoQ6D7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bs2/vxV8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bs2/vxV8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdlyq6Px8z2xlr
	for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 17:00:34 +1100 (AEDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2aecab39ad2so3697425ad.2
        for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 23:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774159232; x=1774764032; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iaUNDmJO8C+O2ztLLrAumQtevZY9H6OG2tdHce6OP+M=;
        b=bs2/vxV8iNUqURfTqVLJsv0wyhdsTruqJxsRG9r3Q+V0q2rN33IPGgZ34lN1HJXOD+
         x9CZkjKJ6D/5TSD3Bv6gzQtMuatITzj3iIUbhQtpS0fTttT45yndj6jEWcRPfvwCqanK
         SdLwg1DTJUYdXEe8BN/gSeasCH5m6lqGdo7S6hZARD6gA7FxbEeh+ZceMt50wheRG7hW
         ngR49/JlhLZneDMSMBaqsAPd0YmIfAQ+FfIX1A/OZXD9zbVvi80LkKidoGOjngFIB46s
         S5YlxQ8dupwIDS71yXV6TFb5e8iX0Hph4gvjPLF9CgTGnS9HAry5oZuxRe+CTDYllYqy
         4pMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774159232; x=1774764032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iaUNDmJO8C+O2ztLLrAumQtevZY9H6OG2tdHce6OP+M=;
        b=gBa1xZDj75uIkdj2uNnHTcPd+sQPYfbw5tJjInvckODqnbOi9kh0DabLF8Rnr6JITr
         9MOqXGXR8G0dicVYNqMvut0zU6GISbv5uNaNYRsB8DfQl9oDCL1lyrRn/IwAlHWior2M
         lRx0tY4L8rgg8zG6ufoTmAp+3OKJeVvkoYWr08MZ9ZgWdIkjpm13A6S09lL7nQrBUOaK
         keeiLFVMtWyT2Hxq1b0cKXV/L+f3JS5ANIBI0Txb5ZCqh0COvIXRUZ9MBHoVqOkV7seW
         V/R03vU0pIRZ5+gVWifEyARi9WibasI3KaMfe/3ez5871xk/Uv/YjlYZuL8z1y/xInQT
         4YzQ==
X-Gm-Message-State: AOJu0YwAQyqUjTSYN90rmWaNNBrXlu7ZUAQaOUZnwncmBR5M+gwRH6KL
	aVftOTql/OY+1Zq3MNQltBLTwCoplMvCn78puktTyO9xwXtgQosS0WdHOlyru/iy
X-Gm-Gg: ATEYQzzOpZ6N4N0wArtYgrpkEQwtPY/2buXbc2tkpQjPiiIreQxwLKkv/GM3keiGg1Y
	rAd8QxsL2WODjFSwN7o/iCr/BURRCilKDgLGmc5EoSjoD2JEY3J7NEPmqyITEcs4gX2vXqFc95i
	PZ37EHKIoLyQ7ecA9EZKIN9ruxbgDJFOg39s8E5oCv4sXct1K5+Qiqacj182kYrbeLpWHcVzlh8
	xxywcLi4XFNMgM2U9iarHFFmjQqPwZowesi0n99tTUgvGk40mbM9LZvOvs78ZuquSTJXQZK614M
	ERe/VfBnih1SreZB0/ULdSv4gh8psWwTAsTquv40Y4HLuPn7oLxc7X0FLzikdvOjjttra9dqwNW
	oO+kzzK7r1/Ak5GdbUGKxzN1iMDv53o/ZPO4LnF4kk/34Lt7H0oHnD0I/OL7bLBpeHbyO+3/66s
	W9IXSLCS+Ta3kzGbbrmPBQ8N6qeojFA+uep+5fITFyUz/IT0QbGjtSwno/UtcnjCg0EBA3dmfaC
	rjm8XJwbU0ZSpaUY+e64YnTSlGhM3gc5bcuXA==
X-Received: by 2002:a17:902:cec4:b0:2b0:5cee:c40d with SMTP id d9443c01a7336-2b08275e889mr57347405ad.3.1774159231912;
        Sat, 21 Mar 2026 23:00:31 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([117.203.246.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08340c2edsm80766245ad.0.2026.03.21.23.00.30
        for <linux-erofs@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 23:00:31 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC] fsck.erofs: design discussion for multi-threaded extraction
Date: Sun, 22 Mar 2026 05:57:52 +0000
Message-ID: <20260322060028.15146-1-singhutkal015@gmail.com>
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
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-2924-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 313762E8556
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Gao Xiang and EROFS community,

I have been contributing to erofs-utils since early March [1]. I would like to discuss a design for multi-threaded extraction in fsck.erofs and get feedback before writing more code.

Current state:
  - fsck.erofs is strictly single-threaded; erofs_verify_inode_data()
    serializes all decompression inside erofsfsck_check_inode()
  - lib/workqueue.c already provides erofs_alloc_workqueue(),
    erofs_queue_work(), and erofs_destroy_workqueue(), used by mkfs.erofs
    for multi-threaded compression (cfg.c_mt_workers, --workers=#)
  - Fragment cache was introduced in 1.8.5 (lib/fragments.c)

Proposed design:

  Since EROFS pclusters are independent, decompression can be
  parallelized while file creation and metadata application (chown,
  chmod, utimensat, xattrs) stay serialized in the main thread.

  Pipeline sketch:
    Main thread: inode walk -> erofs_queue_work() -> collect result
                 -> write output + apply metadata
    Worker N:    erofs_verify_inode_data() for one file

  I plan to reuse the existing erofs_workqueue infrastructure and
  follow the --workers=# convention already used in mkfs.erofs.

Design questions I would appreciate guidance on:

  Q1. Is the existing erofs_workqueue sufficient for fsck, or should
      max_jobs be bounded more tightly to control memory pressure for
      large images?

  Q2. For fragment-deduplicated files (fragment cache from 1.8.5),
      should workers share a mutex around fragment reads, or should
      fragment reads remain in the main thread?

  Q3. Is per-file the right parallelism granularity, or would
      per-pcluster be better for large single compressed files?

  Q4. Should fsck follow --workers=# (matching mkfs) or use -T#?

[1] https://lore.kernel.org/linux-erofs/CAGSu4WPCYtq-+hVc-tg_A4u3a3zxnizx7ui7QSO0R8V1DirJSg@mail.gmail.com/

Thanks,
Utkal Singh

