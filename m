Return-Path: <linux-erofs+bounces-3160-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIDDI8N0zWnYdgYAu9opvQ
	(envelope-from <linux-erofs+bounces-3160-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 01 Apr 2026 21:40:51 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A9F37FE2B
	for <lists+linux-erofs@lfdr.de>; Wed, 01 Apr 2026 21:40:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmFhZ5YHJz2yjV;
	Thu, 02 Apr 2026 06:40:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775072446;
	cv=none; b=U31TapsY3UUxPla6g5mQraHWThQeBrGsJ7bMYpAUGR77W/fJf4I/W/Osjo3xYRqK5fftueMYZunlYSaaXDHlaLIlSlgFx7lpekv7cO6vIWP5tZ3AxWIX7TeSot63NO9Bb90X29qydWiJdu14CSvHYZv6USl5klEbdfYXNVFaN0wbWSRUee5rkV3iU+v8yCXuTWgrd/VIn2zUOlp0lkVzDS4Tq+DilUTV6ko8qVlLKDYwkzHBxxcui0OrQFxEwInlhIhcK8PXRSy21VdAh+aNRxwrGpL80F4uOHyCRvu1rjXN1TicfF6+dzMWnFwFEFN5sE0vLCZODk0ItmBfUM9Fhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775072446; c=relaxed/relaxed;
	bh=pYFl+HfKYxl9ZmvEucZhOARwC4mxr/jXrScCeO2yBXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kE/pdL+xlllphKCpnYJn8967W6gxh7JMX84cPggbzlWhPgH4g5xdMC2VSk4eETR37UeKKOC5+IT4zSlBLfChcTEUVJO35ZSnnHnI8FimfymMw91mymC5G3jao9OhT1JzSD2dsKdyX91ol2GkzljKQEr1DaMjL6FcptgJNWTsYpU+SeoKkuJeicifh2VyHDAysEEdVXfnzvUSQK+foBlr1UZhYCnciSVKSzROsqVEhaD5f/IG+c2KxuYMgYJpYt7OX20YsUjLqRCXSmh6X2f7hVTcJJM7aum+nRvYJklsp7IhLWHR6O+XJme0tZqqnHoOVMfN0oLsbnkls6sWGwGLMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iiWE45Vq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=deepakpathik2005@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iiWE45Vq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=deepakpathik2005@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmFhZ1YSjz2yj3
	for <linux-erofs@lists.ozlabs.org>; Thu, 02 Apr 2026 06:40:46 +1100 (AEDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so59870a91.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 01 Apr 2026 12:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775072444; x=1775677244; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pYFl+HfKYxl9ZmvEucZhOARwC4mxr/jXrScCeO2yBXk=;
        b=iiWE45VqVXgA4qx2lSUIosJjjMMDe4qvQ/cZmjJwL728F6z1UKnKsSV1MmFO4Ph8s4
         5gA6Co5SrZa3rWofbV3ovYoZib2JYKUIzmLvlELhqFwmWCncTKYVEZcrmBwmH5iz65Eb
         eyX/BKs7Et6d1rIzZqp12+DBamDxr2MUQjbfsORmZ8h/uDZVysQEsDS7j0CkIpLT2HwY
         hJWZivwcQrK0z5hMZglLQdr+6D/j2+uChw7m4kNWqpHNDqxiQ67s0nTcTkrAwF6vPLUv
         +U7Y+oZa7kqyvRLFChDoesd5y0AEk0+epyLutMi+PZcF2yIflNUbUk0YbV91FC0XZGj6
         E/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775072444; x=1775677244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYFl+HfKYxl9ZmvEucZhOARwC4mxr/jXrScCeO2yBXk=;
        b=rtCAe0HcA35olJecFWcSBZu8e99UTmU0anb1HJbNbQ14+QZJ9xTAiOEfHUHUT+DmP6
         thc+vlB/G1BQx6Khf3ZremSOjg9A5E2UCOR23rEHn0cNpo4YtL6g3H1ewxdXWps3bR6h
         cw94L5ZReyCpm7OZi3GvtQCTGUuCUSClcFwSM6yEypzbcOOHnKPPDybwq+EgAoRspWM7
         WFdPEDj0Jiv9HxasMpOT3DiuqQreJ+SOBqN85uHTo2E5q2TA9icR/z+yrpi7aRmwXPPn
         W7EHapg5HM2evDb8qV1MJpK3EiVUxobOtdwTUbCoGd+cAQkP4rYQFe+AqWmnrC2L+N4G
         D3AA==
X-Gm-Message-State: AOJu0Yw/g/fbOp7ApwrNMlmXKjmahrQ0cJFtNJ5iO8FSR3nY2/Z0ffSp
	64zwFGUOjW5ajMvoYUJ0UdVHRO5EROu9iY+2BkU49gl0KVJitEBUvA2FsPEmPFc6
X-Gm-Gg: ATEYQzx/ZBD648JrDbikox8W8GFG9nco+UYWeu9cT1kdGJYgx9CQXFDLxKZeZVl54z+
	T0XUU9NSHdzmM8b29auQHPGx39GTCGtnMautYz1HRO5WH1rgGr19BthIZW4Zv73j8Sw9G/6PEGb
	Ijvbx/gcI1K8V9+VX1vh9TjGWvZVzKHsTh4nn8rnjTr2k7aFZcyn3IstDy95vlTSXbuPU2/ATxQ
	W+qJpbOt/sVeczPFrQsGQAIzKBmqr9PR0nqax8Uq6/TaKhYD5b8DLn4nQSdeNFymlv8Kcl/JDv5
	6/rvOMNMWg4SVd8nZw8EjjualiJiPJD+Gkw2s19JuAWnwn3wem4IODGp/aH0Vy58vT0yzRoQdo1
	hkz7ECeUXsffpxPuZdzLsxHCedL6k3nTuleBsBIHTQJDbMiqXUNN8w2AxrFdfOs7ni09V2KwqVK
	ksoYjfCQfnxCoRIwIvhpFj3W8N9js+s+lgEmi21AoK9OHNrs4=
X-Received: by 2002:a17:90b:510b:b0:35d:ab26:5786 with SMTP id 98e67ed59e1d1-35dd40bd4ebmr464528a91.19.1775072444130;
        Wed, 01 Apr 2026 12:40:44 -0700 (PDT)
Received: from final.email ([103.97.165.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe5e4ba7sm5601181a91.4.2026.04.01.12.40.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Apr 2026 12:40:43 -0700 (PDT)
From: Deepak Pathik <deepakpathik2005@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com, xiang@kernel.org, deepakpathik2005@gmail.com
Subject: [PATCH] erofs-utils: lib: fix fd leak in erofs_metamgr_init()
Date: Thu,  2 Apr 2026 01:10:00 +0530
Message-ID: <20260401194000.1-deepakpathik2005@gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.20 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3160-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deepakpathik2005@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 92A9F37FE2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In erofs_metamgr_init(), erofs_tmpfile() returns a file
descriptor stored in m2gr->vf.fd. If the subsequent
erofs_buffer_init() call fails, the function returns -ENOMEM
without closing this file descriptor.

The caller erofs_metadata_init() handles this failure at
err_free, which only frees the m2gr struct. The fd is
therefore leaked with no remaining reference to close it.

The success path correctly cleans up via erofs_metamgr_exit(),
which calls erofs_io_close(&m2gr->vf). Mirror that behaviour
on the error path by closing the fd before returning.

Signed-off-by: Deepak Pathik <deepakpathik2005@gmail.com>
---
 lib/metabox.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/metabox.c b/lib/metabox.c
index 12706aa..d55e787 100644
--- a/lib/metabox.c
+++ b/lib/metabox.c
@@ -32,8 +32,10 @@ static int erofs_metamgr_init(struct erofs_sb_info *sbi,
 
 m2gr->vf = (struct erofs_vfile){ .fd = ret };
 	m2gr->bmgr = erofs_buffer_init(sbi, 0, &m2gr->vf);
- if (!m2gr->bmgr)
+if (!m2gr->bmgr) {
+close(m2gr->vf.fd);
 		return -ENOMEM;
+}
 	return 0;
 }
-- 
2.50.1



