Return-Path: <linux-erofs+bounces-2930-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AIDAxWqv2mI7QMAu9opvQ
	(envelope-from <linux-erofs+bounces-2930-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Mar 2026 09:36:37 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6157E2E8A17
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Mar 2026 09:36:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdqQm4vsTz2ySb;
	Sun, 22 Mar 2026 19:36:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774168592;
	cv=none; b=e/32M6p39avkkSxyQOWh2HaV3LRXAn2DdYecKp4aoUIkJd+SgcYrYv+fepF3iLhOeIceSJw7uaKP1SIjDaQuHfue/QijOdZB0polrwIMtzg0x9hTtQLeNN3G3xP6dcAGUu8R3BjwxKbHHR5jISzqiHMXYq0moM4Z1kz2znt6HrbiA+0O7J0p/79ZIQVI/+CECQVI3Qu5Q9emkPK1SM6SDzA58xebCIkNcoT5L1uv40p8ZbglsXIt2jKMdQH9d2/MlXvYoohhMiWWUJKzo9sGW5/l22pD6bhbMOLJYnhWP3hMCspGyjMhiincOlcBLxXqQakeoRvxzZ8/sbda0mOozw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774168592; c=relaxed/relaxed;
	bh=JCv71QfquVCHRBr9bD9jl3lICERcRHcLvNGEhRcjOTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7dbJB/L7nR2dplcM48bsstdBrPicVhamlz7C2WP4gK+Ho3UtIN/RFzBliagJY9kmBa0rZKi6gfdjQmSJ7Jp8VB1XyP9irROAaBVHBU4LEsqZKIAJWjJ+feX9qTXSOiWb9iMQmizvQQ9chAxS8H0eD6aRjnySF3Q9EVA/fwC688WZFc38v0he8DUf2QJCNSFdSFEHro292VR1Syhy7LlSNViD4cmHdUS2ewYbaE+SeqO2iz1t7mnF6eD47d2gxxFfPbixRU9cGx3UPCmiFisGJeuGpZ4WzaBd5tvgOoyJEDNqURT6R1sj7PF9Z2bsc1yBCL8W+gWEO4TiCpLF2PGIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MZviaPmi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MZviaPmi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdqQl013Nz2xlr
	for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 19:36:29 +1100 (AEDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2b04fc8851cso34358745ad.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 01:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774168586; x=1774773386; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCv71QfquVCHRBr9bD9jl3lICERcRHcLvNGEhRcjOTs=;
        b=MZviaPmiZjBd1bva+ueSPH8Z+wwX0wCDpJzmX4fDAfHzeRocJmOoZNWplc/FEjjmUL
         DKQVUfJ/IiEs8CyWn9kw3X6EXU6MKUWeYfTkzzDpOE3poOWBymSKcTi+USiMhStgiW2H
         xQhqg22vgm9BQWpjryaG1R8GtWgMki/stEAXCw+sr/Dz1k1+coV+51npk4ASLSQ+tCSn
         WhGzjXMDq4FawSwAob2gPUMFKn/Warq1rpI5op00n9F+F2lyiB13t78jUDtcwT+cl4T3
         ABq2BTo+8sc3i3AtJd+w88JfPiewcie9XxfRAAnyRpxSawJMnOagTOdDI3AnaXvF0GhQ
         a3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774168586; x=1774773386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JCv71QfquVCHRBr9bD9jl3lICERcRHcLvNGEhRcjOTs=;
        b=b4Zfdw6+0VFflycFNDnBke9o5W1nenImBssUrumhAILEHh9jDxIsEZSsJFpqJQUC0M
         bSWZTJkCnCq13uDzfWuVxXWam2oxAZ2fFIa5zpXZnG6aZNbHPfWphN0FFp7hELpnhXAi
         +Y8BxaIsBdDbGXWkKwjxEHBLanKm+R7al8iCOIP2SQjxNnsuQJ78ZT49FBDc5emRo97U
         Xz2la2iumBJrmAgrBc/Vgydg4/6SyHKpIfXT68pB72FgmcunThLnLUQPbbaQCbMitIzU
         rt4KMrcM1briaWsx6oc+xdjr7QaqE1qmaDRVFTnP+W3gwgoZdlWvETJkPOGJEe7tb+k+
         g6Qg==
X-Forwarded-Encrypted: i=1; AJvYcCX5CIMsh0flUYepC+8K0Oqs74RqwZzfKVxJBOAsjHW0BZkb43PFFdc8BVZOdQGzTKg8K0q/KJjpIjWDPg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxhte64FHreHg85n+g2RvLQ5yLHjsqcj7bdhGD2d4NhSrgCu45u
	yknTIL6bVsQx2q7zzmVdlEOHGY0jxJpC42cxPGQJKMw3GifVRjoTamLpS+cFhvOa
X-Gm-Gg: ATEYQzy+TyxHw86TTdNBsPF+lYIhRKjJPhZxXmypiSw4elB4i8k9MYdCrtwkdKsVZ+f
	02fsv5eIYAPqruw4L+AmkdtI8KsWlmtlsTTAxiplnGhs/oIXcT/4EvYomgazv5Bt+a4mxb3WA/y
	qlJXcpgPhjWSYbiSckoPSgvJXDt7ZbiuGU4RnM6a3fK7D9svyOjiz1i83/hHiskQJN9AFxMppMV
	pmMxVT3QRF+mVbm/YrpySg1wShUrJ1F09MytGFGwb8dHicU/43G8wygdFYk1h24OCCSDx8pjJ3m
	qVWujUT6dvsCVWQg1e98d6wtCiWsCPmODwTHVek+7TiTmXrpLfvvCtX+AlKrZ7jONvnLcDiCe6P
	coo8nGC2xJcKIJoO/j2IyMSWaFGkbT+mZn2ubmU67t1iAkqkPxq7rsv9vgWOtuZq94nj+8yFDOT
	gix+eVLh1TQwRwFpXLFcl6nakKX5VNPEgI7vV25brIvIjdgOH/wo4U4Bwi
X-Received: by 2002:a17:902:d541:b0:2b0:5cb3:e4bc with SMTP id d9443c01a7336-2b0826f6b0dmr81665845ad.16.1774168586281;
        Sun, 22 Mar 2026 01:36:26 -0700 (PDT)
Received: from localhost.localdomain ([45.114.151.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083656df5sm93861245ad.44.2026.03.22.01.36.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Mar 2026 01:36:26 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: singhutkal015@gmail.com
Cc: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org,
	xiang@kernel.org
Subject: Re: [PATCH] fsck: add --workers option to configure worker threads
Date: Sun, 22 Mar 2026 14:06:20 +0530
Message-ID: <20260322083620.19933-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260322064706.27001-1-singhutkal015@gmail.com>
References: <20260322064706.27001-1-singhutkal015@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2930-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:singhutkal015@gmail.com,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6157E2E8A17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Utkal,

I've run some tests on your patch.

I compiled fsck.erofs locally, generated a test EROFS image, and passed
various valid and invalid inputs to the new --workers flag (positive
integers, hex, trailing garbage, overflow, and negative numbers).

The happy path works perfectly. The *endptr check correctly catches
trailing garbage, and standard overflows are handled well.

I would suggest changes:
There's a hidden edge case with negative numbers (like --workers=-1)
on 32-bit systems. Because strtoul() is used, a negative number wraps
around to ULONG_MAX. On 64-bit machines, this is safely caught by your
v > UINT_MAX check. However, on 32-bit machines, ULONG_MAX equals
UINT_MAX, meaning -1 will bypass the check and attempt to spawn
4.2 billion threads.

Also, when -EINVAL is returned, fsck silently prints the generic help
menu without explaining what went wrong.

Therefore, in case you decide to send a v2 patch,
1. Switch to strtol() instead of strtoul() so you can explicitly catch
   negative numbers or zero (e.g., `if (*endptr || v <= 0 || ...)`).
2. Add an explicit error message (e.g., using erofs_err) before
   returning -EINVAL so the user knows their input was invalid.

These are just my opinion, but follow what the lead maintainers say.

Best,
Nithurshen

