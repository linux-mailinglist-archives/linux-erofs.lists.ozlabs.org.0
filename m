Return-Path: <linux-erofs+bounces-2764-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNiKFSZ2uGn5dgEAu9opvQ
	(envelope-from <linux-erofs+bounces-2764-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 22:29:10 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 975B02A0F4C
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 22:29:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZSrw6p0Bz2xb3;
	Tue, 17 Mar 2026 08:29:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773696544;
	cv=none; b=e0pQoIcALg1FhKcMENA94rHAEKFFFEdVpN6o4FUxlHbB4zETCksYygP3wTkTwhgXq/4H6j+YbhEAmuGlNVQv5uGZ/o1XRKTGIAvGlI7FJY9qM5IpUc1NKWHK+S41R6BSjVZDBD9NQpXmgL44A1hrCyvevxTcF6Yw3Pz4JItw3iOaBAd2gSNnpF3J9H+2MICECV+p1vxetUHpVcKu715Bw+WbNyE03cZS0NmaPUYOzpOWQ5+RJKIH4MN2sSyaanJIiJ7tSDshKkSpTaEtT/oVqeEjzyyUWkxhhFGy2gtwHB00+aeIVXxhiyPcpG4sP9dhw3P0eGd/0UAqkN3JDijDtA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773696544; c=relaxed/relaxed;
	bh=gYePWMQaAuXLveIsTODTmAZevnVAiAnr16/u4MHtRIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k3++Djcgoln/emCYareFi9MbkQAtRCI5sxWHn2E+AMA2zOF0u2sszw+LrZ4u8Dw1ILWUxFlDCvN803+mr6ikZ+qaWqSAZTwFKJ7960d1dLPhWUE3ZmUxv/+qwXOMJGwMY55uhMByKKlunock+Qg2bdXAEp3KwJF9Zx942xQ+2hqEXLq+M3ckHJLOfvv/UAWMQFpHBX7oYeS2cBYSgrqIfgApPa95kP1W8eqcyNAbf+wFXO3juUj8wTQo8uSqH6q0z5U3JUp+ftCKPHBlCuJsTvXiuoGhhfNRlizghUPY3Mh2iaSF5Z9r9txzfEqyLbgqlFKKqNI4SrMBR+l2kCiFbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=el5pkLks; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=el5pkLks;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZSrw0PZhz2xVT
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 08:29:03 +1100 (AEDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-82980ceb244so399862b3a.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 14:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773696541; x=1774301341; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gYePWMQaAuXLveIsTODTmAZevnVAiAnr16/u4MHtRIg=;
        b=el5pkLksW2rkmbvfrgptU+ZpImR/X8dOU4ZAfT+/ld/LP+F6/rvmXHPxJrhB3+OPax
         UY5kqU+gKQGk36azT8tJm0FGOli/QVIwvAp6XF8MAYL2iIH+992oUe0ViAoc4WEwNJev
         6MeStIQx9/a3xcKYb2clCtr1eyGE9q33Dqtty0SF7fV4Sy35sQj1uIvaIzovgusYLEtC
         RO+2zyZhjliPm1zhS/+9mLdfKXv2TfDhfH/Ib+D2bXN8Q4AZ87OGgINcdHu6gVPT/Qgl
         7EuqvoFX1ui7DjySz6x/qgaN65phEAyDmW5nbG/o9aaa19jZ1kd4W9aw6KNjrYMTsPN6
         etpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773696541; x=1774301341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYePWMQaAuXLveIsTODTmAZevnVAiAnr16/u4MHtRIg=;
        b=CNosfJLcqK0Jhv4NvQ+LEJt27NT5dpcKc+aT3fpLTAvpA9vur2SL6XW4VVaYkqy841
         zS/VCgsg7d8X8RV4Hh2rtw46atIvmm5wzybfH+vVcPJF+SA2gweJ8cXqnXPJX/Y8M5wC
         IhVL4YYLHSoMuADbQ2cYtwF1W1qSWUDcW32xaZV2dyfeqwwRKBaIHFj4umCRYiH9LZC/
         Xk5iK/7uLtOxLUvhjQ9THkCEspvYMq7+ewvPef1U/FkHZ6AtYW01YgpwXzvB1uINtU67
         MO9tUToF01Y+k3ozv51kIL+/d2R6Rim0RfdDrh0YRfS0Ake0uLNc1/CptHmgy003fSg7
         Fodw==
X-Gm-Message-State: AOJu0Yy171/veLjXqrvGZlMmAm4a0S7vAyN1FjpVfppchvdz+mw8fbHd
	WtY7NLa2mguNBD41yRZ72kH6pkidoHzjxSQQp3RZyOjYr4caU0dG+tYTSp0FyUi2
X-Gm-Gg: ATEYQzwBg4paHSaodw7M/FOijc/Un4Se5OajfzAwzMS4s7R8UmZD3WR53GsqHSfJrEx
	vLlX7s62r7PQw16xOklS/Monkt4rN53QanZ/3cMM4EKrkGcc95cURR5eRgawz8/iKb1gSLhxhti
	0iAGwHs9PG/b2uQ3Xk4WBpRtpq/xPOennEsurFuKfBDaThZjOSuaaL6sgzSRJewSY9S1hXHDD7b
	sh83CILQDlS2HlW0wf2iRRhL3vquzZr4v7dgndiUIYdLJ3lGOxpwUz2tnmgU72kHeJshlQ8M7bp
	NffDr9ak6TC7+C17zNCPV8zdvm1mVC8AGfYrDJDWlWoWFhjk45AT+iojZ5NDzNeJoJ1qt0BjQD6
	uQiBip8xfM4oUq8hlHZgTSZqLwDnhhX59TFoGlPUNkTOhbvvfEl/zGdipIJN/l+wMIn5qHz9B0+
	YBhDLkVYKmxow0sjgfQlZejHO8tv/Jj07IUyCqoFzsAg04gN3NoAovq5EbKY0BIeY1SZdiqBX3Y
	XrDmEsHEYLh212IjXzdbsrK7RVrQU+E+xKX
X-Received: by 2002:a05:6a00:ae09:b0:82a:1589:311b with SMTP id d2e1a72fcca58-82a196bb525mr6927475b3a.1.1773696540806;
        Mon, 16 Mar 2026 14:29:00 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([14.139.242.98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0734039asm17051846b3a.41.2026.03.16.14.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:29:00 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	yifan.yfzhao@foxmail.com,
	singhutkal015@gmail.com
Subject: [PATCH v1 0/2] erofs-utils: lib: fix ZSTD decompression safety issues
Date: Mon, 16 Mar 2026 21:28:45 +0000
Message-ID: <20260316212847.57030-1-singhutkal015@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
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
	*      [2607:f8b0:4864:20:0:0:0:42f listed in]
	[list.dnswl.org]
	*  3.6 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
	*      [14.139.242.98 listed in zen.spamhaus.org]
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [3.80 / 15.00];
	SPAM_FLAG(5.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,foxmail.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2764-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.768];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 975B02A0F4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes two issues in z_erofs_decompress_zstd() that can
be triggered by crafted EROFS filesystem images during extraction
(fsck.erofs) or FUSE mounting (erofsfuse).

Patch 1/2 adds validation for the ZSTD frame content size read from
on-disk compressed data. The frame content size (from the ZSTD frame
header) and the decoded length (from the extent map via
z_erofs_map_blocks_iter()) are independent metadata sources. A crafted
image can set them to inconsistent values, causing the output memcpy
to read beyond the decompressed buffer. The legacy
ZSTD_getDecompressedSize() fallback path is also fixed to reject
zero-sized frames.

Patch 2/2 fixes a missing error return when ZSTD decompression
produces a different number of bytes than expected. Without this,
the positive return value passes the caller's error check and
silently returns corrupted data.

Utkal Singh (2):
  erofs-utils: lib: validate ZSTD frame content size in decompression
  erofs-utils: lib: return error on ZSTD decompression length mismatch

 lib/decompress.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.43.0


