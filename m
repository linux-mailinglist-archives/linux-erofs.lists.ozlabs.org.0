Return-Path: <linux-erofs+bounces-3196-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJDxLjy7z2kd0AYAu9opvQ
	(envelope-from <linux-erofs+bounces-3196-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 03 Apr 2026 15:06:04 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE463944DC
	for <lists+linux-erofs@lfdr.de>; Fri, 03 Apr 2026 15:06:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnJr76wjkz2yhG;
	Sat, 04 Apr 2026 00:05:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775221559;
	cv=none; b=WFX75KwdqU/DJJVsfiHA14JVQu+KV2qEesG2ydFiLcgtYDzJD9+cP6r9+00c7SLgkroyTED5B8JWohrIyLVX5q6TJ63NhNP7R7H3RSSR1vtEUC+UrD96MISpK68/ggjsevRbxCt4tvsYkZiZT2ZFyPgKvzra8JQ/wWdpxpd0Xd2ZBhK+0/v0Q0MlWIQSKZc05IeZqz30V08OMSfF0WXC2HOXlZQu/Sr+pZebLt4JYZm6u/A16Lgxl5P14CdxAWZDtTrUSBqDf338JCkX0eRYfulj0vVO4YAJGgfcd4Ty0XeGES78o1fA64ot3zWmV18T9aPg9SO+twx5I3icmPrTgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775221559; c=relaxed/relaxed;
	bh=C1bb1Us2tUbZxfP7XuG/F/PPueGguCFpdxtD60Nsi2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OiK53J0PDUZryLSdYJPyb5EZiaG/ZO6bWPFanKFFwq+31CIQi2CIct+1hxFXvC/XdNJLpq2GBgsimvElUuDx+t7+oagQYwUeiEma6Msmp+YcmIeder5SuzCekGt/yFjfxtGuuyKHtExhlugsDHsroGQL6ieri5SKzV6DGM4J6AYHtbnaZ3INeSyx2XNHiYeIrmi8A/v4U1alPxYXPL5iiEUGViMeP2cJGfTtnJN15SZP5RRFKc26AouGtjVegAa/FKhWF0Etlh3L40y3BSNhNY9ukhVpI1BOUeSMHTz6YV003Wiz2HqmiUeesnQ17DPqX4wPf20Mfo1IAQA4jf54SA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=osLsGbbG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=osLsGbbG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnJr51y8Kz2yWK
	for <linux-erofs@lists.ozlabs.org>; Sat, 04 Apr 2026 00:05:55 +1100 (AEDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-82748257f5fso1844625b3a.1
        for <linux-erofs@lists.ozlabs.org>; Fri, 03 Apr 2026 06:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775221553; x=1775826353; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1bb1Us2tUbZxfP7XuG/F/PPueGguCFpdxtD60Nsi2E=;
        b=osLsGbbGVNhoy/T+j5SNXtJes7i4hx2XoxqLhfthCfPFFIdffsPJ9oRB4iLDmvMHjh
         7zhjeiTB1V84g88Eza4xiaXvO+/q9VXTJq8WB+4pJ7YzlXToyN2hi1dfmDL1vgrJjr14
         i1/AklCpLin4dw1yReDxePWWr1O2uG4q6TQYFnB8gk72myXMWncIfjG0hwBmaDtX8wZ1
         0haUD32K0SbadcksNJdOm92GftBOVwnY8+D4FMKwG4sVqnann+72fpqWKNSpdOWKXSjo
         Mlfp6LPunPt0Ucvr+5ichql10a2KmeZJ/z5TZ7hltKCEQTCZ101k5DWXUyhQ/YCMV4Lk
         ZKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775221553; x=1775826353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C1bb1Us2tUbZxfP7XuG/F/PPueGguCFpdxtD60Nsi2E=;
        b=l6o/N70WJyba2NI8dq6VKdg4Y9Y9lOe0XEfdi61daFI2WmAGkXcA9/m4OomZVEexPw
         0tHDhJeayXNKcnp2e7ULHFkacVG5xxeqtrhjaCmuEEOpce9TfEnLxcJ5K2G7oXNoefcd
         E9xmUIIxZBuEK1JTMBy4MsmAXRrnurhT0BpP97M395mTMZV4xituGLmGv1qSA+jUi9Sl
         mjX+S5zlGtGqtJtTlRdA1it4eT7jzuWUlATLuF7dnJzwzaLRfyKJH1zprmmi/Eu3xLJM
         JUvHFOZoaKM8vYiYNw/IADmD1LUVhqGZ0ksuV8deXBU4GQ0L4MyRPxxYxeyPW6tE5CN0
         ILxA==
X-Gm-Message-State: AOJu0Yzn8xFrO/yHOVES6zAs9AKvvXrD0ejnmLuVqM0YIxW+D5H53u2Q
	fX5/iDL5ajj1kCg8oBQhxzCCqwZTcgqKA/tPvzrG+lMb8H55stE+2FNxxNESgQ==
X-Gm-Gg: AeBDieu+68zA+o9XDHTwBW4G77Tg/jHBStiLJkOy/Nz0LOBaqFXbmkiMcR4jYSg+8Un
	8hTWV2QZYGseuQpe51e4uFkRxir4wnEr9UafrVhXCzWe7gcL2zSZf0fRiK9O4i8gwVuxMxcxE+T
	AlmkFYCzyfuo8T5cf3yyoMZw+Dv56XHuvRAbfvL40rUxfC4goK8IACTMUGUfsL21E2Kn8TAlDr0
	FfaYr0bN92wgYMJaFyAWxNE/ZTpIYA/nPjEl4ho24/k3jiXWU1DCVKbidC6fBpaQOIuKGYbknmo
	MYCygRV/2SYi0P/tqH7VXklQ8vJuDeO3wn9N2bc34N6UsaZ9yY1z4Hwz71yHpe3TeGGv5jW2Iq+
	unl88RrNqyRsvwSORzBE81j76dmsEU4xImIlDRv7aWtGwRN1VTg8MRjV53+k6ba8AduNzWCUE2Y
	upluPIe69I0gQiYG71EhnHe8yLRkIUht9vE7MRYjJL/vR5aHQ=
X-Received: by 2002:a05:6a00:3926:b0:822:69b2:7ed0 with SMTP id d2e1a72fcca58-82d0db0bc32mr3046446b3a.6.1775221553118;
        Fri, 03 Apr 2026 06:05:53 -0700 (PDT)
Received: from DESKTOP-MOQC9AF.mioffice.cn ([43.224.245.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b5f1dbsm6064258b3a.27.2026.04.03.06.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 06:05:52 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: [PATCH erofs-utils v2 0/2] Fix 48-bit block addressing for extra devices
Date: Fri,  3 Apr 2026 21:05:44 +0800
Message-ID: <20260403130546.76579-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <12b129db-0206-44f3-a53c-9eec6fe3fda3@linux.alibaba.com>
References: <12b129db-0206-44f3-a53c-9eec6fe3fda3@linux.alibaba.com>
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
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3196-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:zhanxusheng@xiaomi.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xiaomi.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 6CE463944DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The 48-bit block addressing support extended the on-disk
erofs_deviceslot with blocks_hi and uniaddr_hi fields, but the read
and write paths for extra devices were not updated.

Additionally, erofs_read_superblock() has a swapped hi/lo combination
for the primary device blocks -- the same bug fixed in the kernel by
0b96d9bed324 ("erofs: fix block count report when 48-bit layout is
on").

Patch 1 fixes the primary device blocks read order.
Patch 2 adds read/write support for 48-bit extra device fields, and
syncs the erofs_deviceslot definition (blocks_hi: __le32 -> __le16)
with the kernel.

A corresponding kernel-side fix has been reviewed:
  ("erofs: handle 48-bit blocks/uniaddr for extra devices")

Changes since v1:
  - Use ternary expression for the read path to match the kernel
    implementation style, as suggested by Gao Xiang.
  - Cc linux-erofs mailing list.

Zhan Xusheng (2):
  erofs-utils: fix swapped hi/lo in 48-bit primary blocks read
  erofs-utils: handle 48-bit blocks/uniaddr for extra devices

 include/erofs_fs.h |  4 ++--
 lib/super.c        | 14 ++++++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

--
2.43.0


