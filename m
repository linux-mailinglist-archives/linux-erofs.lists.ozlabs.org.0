Return-Path: <linux-erofs+bounces-3821-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZrzUNfVGS2oyOgEAu9opvQ
	(envelope-from <linux-erofs+bounces-3821-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 06 Jul 2026 08:11:01 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB01770CCC7
	for <lists+linux-erofs@lfdr.de>; Mon, 06 Jul 2026 08:11:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=WKmdhEL0;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3821-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3821-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtv9t2FQdz3bp7;
	Mon, 06 Jul 2026 16:10:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783318258;
	cv=none; b=JX1oUSEUJMPwvzeUMLChQb+Rhrs/QNRrTIvRTCzQ+Smv1vfL0ixWRv9bt9rxltJU/nviH2p0w7tVFNZdREvMxn5a0Be4duM8tYcGTAqHKggxsMmSaT/jL3L5eeaOcEkQ00HBlGErQhDUPIwk788sQqIaxg/zJcW+/mNBNNgTDZNWC7iOUskY/7KT+QyI+LH+g8gEHDSWIrUA2J8FhDM5MIcbTx8uUKbWm1rH4UAXR9O6TFffxayIfWoiHF7xZqaP1WA1iuHLJkXAXGEZT1nRQ0+ucqz6HCwFFOc0QYPXeqPqbcvtxedHX3GkgxKQIzfQuM+e5+EkIckyMvwrISGw5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783318258; c=relaxed/relaxed;
	bh=fvJEvhNPNK/ZYEv3wDsDhZhcFXRYDrLPOYRoEXsW8tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OLoH/Hn23bpAPCRNhornsT5JpWTGty0RnhriW3iJQpUBa0q9eiIqjSZa71CCfvf0//BEjuWkKV/Y4PWUnwp0T28Hto4Zhjadv9U5mAk7F8CLq3e2rjzPj2TMWswYRV7dIFjx82ZmMdb6hQ2JcaJt0DrHCXmgvxDBmYZ0cHzHeOlO+z0yH65OMNYsXvS0f1aEGCzoM7G83MJzcX3z/FDxvUjUC4yE8l1vVk4tr9AUT6p2RzaFpYZyb8nzTFNOB/8fDkz9F5sLVjU1upEWO/APg+v9NCmqe4IZmONTJe9qkSlxux7xdfiDNpUuD36FpJfe29LtrfYcwp46QtBnPg83Ng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WKmdhEL0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtv9s3nbQz2yfS
	for <linux-erofs@lists.ozlabs.org>; Mon, 06 Jul 2026 16:10:56 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-3811f512167so2291906a91.3
        for <linux-erofs@lists.ozlabs.org>; Sun, 05 Jul 2026 23:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783318254; x=1783923054; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvJEvhNPNK/ZYEv3wDsDhZhcFXRYDrLPOYRoEXsW8tY=;
        b=WKmdhEL0AUkk/HYIa9avUEId8DlTCE1Jf7rNa9K9lsYMgoj7ixIeKCFwtb0h2exKwP
         XlyffTs6msJW/Qi3auzYcI9c0LqHfn9cRizh+U6/n6vXam+Dyeu2SgbFDs1SYh+svOux
         1lOQtMzo3CLGUCDzhWgOPS6VcqfEeg653Z5nE9bJH/F4R8/IegFAgMm4Ufos6C5INr2B
         12bWaOTG1gBfbN5Tfwq81cIPeETlsmUFhd2xPz3tXwGnW1ZaIWYW9WprbwIhKASOOW3Y
         zTRYfGwqDtQYC7TwCgIQauk50qOaAemmcV/NFM1cHfIJiC0M+sV7aR8Xt354DhZEFyGQ
         MYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783318254; x=1783923054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fvJEvhNPNK/ZYEv3wDsDhZhcFXRYDrLPOYRoEXsW8tY=;
        b=emOhQ/ln0bAyOoVrS4swY+7QSn06QtqmZW3lO8BrnqhUJ+rdktvSoYu2uyRKC/Lq9V
         riVCqKl5ooAN3U5zXOXLi4beormcjfz95vMP4KCuq/OWTBVUGVyAsh909sVRA72fHHjU
         Bmd4GeCgWS2yvDrw+Q+x0szv0/oiZ/2t3jBUYanaHMfzBbdk/1+cmVIRfZpdoJtBVt5f
         Ff0QxIth9HDkDMsivJ9Ycl5Nz7lAdWKyyT62+kHv8JTNqILF3jsTmuRpXWFYXll4E/EP
         rP9Dc/Hidq+CKa/a/nguOEhhn/BFNGi0h3yCpSC7OTkExNZ3/dvaBLJZRkPRwvF4x/v5
         Q4IA==
X-Forwarded-Encrypted: i=1; AHgh+RrTkpeCPyB9+PL8JCnUlKzPWatd8Q1E/PCePw/OzeR74ykjuMf66a+EMOXgHWA/daZfjh+jpM1kIwngrQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw35yPZD36nf4hdvDi/zGnLmQ9AHw/Aze2Qli9MP3cEVJrDxVqT
	HAU/00j+p3sLVqBjEeQvxVqGIb2xV3DFK9qxRKrJ6QhgfTUxhRjjEkiR
X-Gm-Gg: AfdE7cmyNUrDdvNwMIO3O1dROOj0t1RpEAQQkFTmYE+48LlBcL7m4wr6NNuGec9H/I8
	Bb8vpsi3l1uwcmlsPx7LnqwYbOS/MQuJMuZAAXh9rlgb9XZL98CtBW2z/kSCAY8lY1DrRHIILpW
	Sod8og9YOH/3EPZMa0Jvid8eMs5e3lac1orZwEGjdJuLHkk3FVaUMfmyUKf4uTUIRv3/Ssdsp0z
	i9sQbZC11+vMto3vgZSuvxaQjnbjK34wL78bvc5f8ez8OLtaw3MomoJ7uAlRs/r6+U+Ogx5jnQa
	eTiYPkjBcpn7TQblrqxh2IW76k4nsuZZEE5U4eul4ZF5DKpmehwOBBoGTgKCJv32kCHWdNGt9uA
	O+9oIN6XT/GdFWHmUJwtuX6KWhWyEXzvGFzW+MbF6hlVkOyRki4lXOBBMq9T0S6d70+Uexj7For
	Urmp9BLE0HSzV8ugTkXlnu2k/6nr0K40Uxi/34Azc9aHLy4w==
X-Received: by 2002:a17:90b:4c4c:b0:381:b1ad:c9e4 with SMTP id 98e67ed59e1d1-3829f4e8866mr8651885a91.26.1783318254322;
        Sun, 05 Jul 2026 23:10:54 -0700 (PDT)
Received: from localhost.localdomain ([157.15.11.68])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f1595e912sm55055475eec.31.2026.07.05.23.10.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 05 Jul 2026 23:10:54 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: nithurshen.dev@gmail.com
Cc: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org,
	xiang@kernel.org
Subject: [PATCH 1/2 v3] fsck.erofs: add multi-threaded decompression
Date: Mon,  6 Jul 2026 11:40:48 +0530
Message-ID: <20260706061048.16349-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260706060525.14018-1-nithurshen.dev@gmail.com>
References: <20260706060525.14018-1-nithurshen.dev@gmail.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3821-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:from_smtp,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB01770CCC7

Hi Xiang,

Please find the updated multi-threaded decompression implementation for
fsck.erofs. This version introduces an algorithm-aware asynchronous
worker pool, dynamically sized based on system CPUs, to significantly
accelerate the extraction of computationally expensive images.

Benchmarks were performed on an ARM64 environment, extracting the 8.2 GB
Linux repository downloaded from Github.

Extraction Time (Seconds):

| Algorithm | 4k | 8k | 16k | 32k | 64k |
| --- | --- | --- | --- | --- | --- |
| lz4hc(MT) | 9.36 | 8.31 | 8.27 | 8.54 | 6.94 |
| lz4hc(ST) | 4.40 | 5.77 | 3.65 | 5.45 | 3.36 |
| zstd(MT) | 9.26 | 8.68 | 8.89 | 8.11 | 7.94 |
| zstd(ST) | 5.23 | 4.52 | 4.62 | 4.11 | 4.02 |
| lzma(MT) | 23.72 | 24.79 | 25.90 | 26.92 | 27.77 |
| lzma(ST) | 56.37 | 65.06 | 71.07 | 74.69 | 81.63 |

Performance Analysis:
The implementation provides a significant speedup for LZMA (up to 2.9x)
as the heavy decompression workload effectively amortizes the thread
synchronization overhead.

However, for fast algorithms like LZ4 and ZSTD, the current MT overhead
(futex contention and scheduling) leads to slower performance compared
to the synchronous baseline.

I have tried various batch sizes for fast algorithms, but the time did
not improve. (I tried from 32 to 256 batch sizes)

Can we fall back to synchronous extraction here?

Verification:

* Deadlocks/Race Conditions: Verified via GDB backtrace analysis and
stress testing.
* Memory Leaks: Verified via rigorous buffer ownership tracking and
ensuring all task resources are cleaned up upon worker completion.
* Integrity: All configurations passed bit-for-bit integrity checks
between the extracted and original directory for all algorithms and
chunk sizes.

All concurrency primitives and memory paths have been verified to the
best of my knowledge.

Thanks,
Nithurshen

