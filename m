Return-Path: <linux-erofs+bounces-2797-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NmZAR5IuWmK+QEAu9opvQ
	(envelope-from <linux-erofs+bounces-2797-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 13:25:02 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BEA2A9CC0
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 13:25:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZrkc2bJkz2yh4;
	Tue, 17 Mar 2026 23:24:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::32f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773750296;
	cv=pass; b=lcN6ibd5Kn9xkxlOfCUnlFUhnrGjIV351FkF0UsVHi3VIg0hYpRqVgzLVdOWgfpIPjaPmwSPJkG7mj58Yl+naG5M/MhLEaTL4JrsX8Lhs+/pNrCCE1mfW0E2P2iHQS/LCMGxVUUBMxIoszeFXD5LM+ZYpQI27ZKNpoETyXw6vQZdQwTqG0+tZQuZqZnDCFYwJobkGgyQf7r0CjgSpcyo7gfFqWd2kXgXXvldmD2OshCzmehH+gYCrxJGNIsP4MISp6AgnmBjABsoVRzaWUIAkyWgHKVUJerHtqfM2Itqs20mB4WPquH4cp6wTEAcozt1IHQHtTAaIkh7gHZIXLIuRg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773750296; c=relaxed/relaxed;
	bh=uRvHjkawGfPp0mf651zcGbhTeeR/1KRH9/pytqPEg5Y=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=Uo8fHfWOeM2QszBEpCTPqm69coeOs0YHIpPlO3hr3Gr7fff7pcGMpTcOKs6uXzSn7wGypsebL+EOQ0YPcA9V7s7rpweOpX3fVxXnw8/T4wiNNApFgqsCSdDq6Xpo9BIqhIHlLaz3IrtvrL2TlyAbfDG5ok3rTh1n/jfMy42tTeQDu/b54fX7mtcWztbALtJVCL4BzegfUC0Gl2ixFUJSZD/q+SjEHEJ4oPxoJ1kNUqPkpkYx5ezmnG3vhtPfCIFrLHKVzoIwVujXAWrAZ+iyiaFqNh42KDkcXAoxR0w/4w+2JCd5JI2cv3Psy2PF3SOMNL6CfnIQaQgWZMRrXN9h4A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; dkim=pass (2048-bit key; unprotected) header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b=e3iEoY/i; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com; envelope-from=matthew.lear@raspberrypi.com; receiver=lists.ozlabs.org) smtp.mailfrom=raspberrypi.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b=e3iEoY/i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=raspberrypi.com (client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com; envelope-from=matthew.lear@raspberrypi.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZrkY4kcDz2yfP
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 23:24:52 +1100 (AEDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-7d7412cfb9eso5185743a34.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 05:24:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773750289; cv=none;
        d=google.com; s=arc-20240605;
        b=RALeP0zstOu+ojcDM3mkeyDCYHaju9K6NM++OQdvdP/g23vbjd8WK+nTKBk9K7/h7m
         r/K/ps3LbPQ7rOu0ecsbfsBWL54rMPvkvESTRKM2EOE284zJZyGJluJQ/VLVfbVRXNLt
         xJI8f7nAJe5URHevB+h9I3bxIlEyFv1MYelGvOSbMTp+ryOdd2XsynGBeZAyGGkpw0Wm
         /nYNHLmnslxxLw8Gi2QvIrMpa37fejy34v3L2UxdCxnAR9Wh0V5yhp1pfuJSv3eHt8BO
         OcLo73SY7MLEftyRl2DnVWUWW1yrcGWCHz7babHaQowEfTT5da7XW17JhT6FKj80TfIX
         d9tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=uRvHjkawGfPp0mf651zcGbhTeeR/1KRH9/pytqPEg5Y=;
        fh=QUVm9qy9xw/vH5FkdNybmOglH9Yo1FLRstF7uaj7WSs=;
        b=ilFXN/E8BN8mKsplJda/0Zo3F9Jm9bocgTDLRMWNgc0nrhtbG/j0MQ6ixgLM60dwgO
         kT8mZmGNFPqrskvYxwJ8VeX93OXdpWFebvrf5p3Gzlgs+Yga2P5PCTZCdvosLAymWNS+
         /DWxyuRo1LydkRMo3xlmcKxYcjIEyjvufpJ4kKHQ/9ONuf0woaflSLpigM/tN3qFAtoL
         C8+djo4NZd6wWvxV+B1+0BM3Ryew/VAiFXfV7yqId1fiaEWz7KS6ZtjwcJiHYLh1IThw
         LfbvcwG/ECFWyfICamyLvIqYfdwivx2xJs8yLD01WBwXGMGQOsuaYYQfYJOxwwrqUOHO
         iWIw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1773750289; x=1774355089; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uRvHjkawGfPp0mf651zcGbhTeeR/1KRH9/pytqPEg5Y=;
        b=e3iEoY/i3DgY5I22Mx8N+LJh72ITFx4yq/3xmv/Nw2v/MpCYrX+OcYjhZ+6mwV8p2p
         aveGg9ScdKr2u9fs2dkqul1qgdHP37YgXjb9tC5nuwsgF3Mg6W/jf4RSpTDZlCZKpNL3
         drok6882aCRrQAUU5CC0YgmCqfQdl3CNJNIhAOQ0c56dY9SQc4TsBjmy+1f6LQyKaNiz
         B4Ld/kSimlcw82eH6mBRuyI7Jg0ePph1/ZbBN3koFEtUhmv2Ei4TTSPWGzmb/inMZHRX
         MDlkJ37Vbs2t/DZN5pGm/kfZkiov5P2NOrUva0nJEATxJIPLyOQvdY72uraPt9JpR5Uw
         aujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773750289; x=1774355089;
        h=cc:to:subject:message-id:date:mime-version:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uRvHjkawGfPp0mf651zcGbhTeeR/1KRH9/pytqPEg5Y=;
        b=eXuZm/Unixjc3JvSMPiqXePJ88bomz1aWeuDspD4stJjufeq/SR8MRGFrHfcciNbcB
         lBYLD9ZxWmhpeEW8ny23gL8cpXJP5weErfFmmCKKI/IAAako3swl69zogbuEJLgMmCxo
         6Sx1/tAC7L4JBad3S7R76CwFT2CnHpB3z6+Re+5KAw9enYcftREasNFqv/zPjRiCTW8H
         mQqLHGh1MDl9KwZ9nwE+mLIHp139MP9GaiwXgDLiC/AdgQF7kPTJDtdQdc0mZo1iOEpQ
         jC/iBFIELUH+rnByb/8tlnfUXiYXwleP65hCV0wnBOwnbdQm4C+2NcmQmhpvs8oeh/sh
         SuWw==
X-Gm-Message-State: AOJu0YwvGp6H5cPcP4YrgC7uOZLIzzsdPVzseMtJ+cG8Aj9KbClQlKA/
	K0TPX51f3Vt7yV7CMBK3RUaP9md3mtEg4nbsIvxVL2wQEFSlHN7IhFV+rjE6sMMlt8BMQ/jQN/U
	QA5LdB/zaW2hqTtO+65Go4obWgPbnY5aumnyaBPKRyhzW9wtEStqN
X-Gm-Gg: ATEYQzxWn36oh16mHtw/jsH8+WgPu4jF9SiyAxLmztpSml0mN1RQVWC8FTFTeg0xfEP
	jnchRwmnDyc9Jk4KyTlsyH1vvpbzv2RH6REKspeDXKakwPiln8nOgQsMk4TirMrKcjQtQhXjOPU
	6b6PM1fWmKvsBuCHEW8N6WYXgWDZxw+b1/kMo8R24gyUqfo/Qz/Fhy/RU9MlnO4g+d2oVD6mPWz
	5pZMRGlysj0e5EOnL9cs2VetZyHTf12zT5MNKOF8qDLUgszsGI5jKoj4fDsIiSZQJ4kBpi5CdER
	NwkRGVV2
X-Received: by 2002:a05:6830:3914:b0:7c7:61e0:a4ee with SMTP id
 46e09a7af769-7d7824db31amr11558981a34.11.1773750289346; Tue, 17 Mar 2026
 05:24:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Mar 2026 05:24:48 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Mar 2026 05:24:48 -0700
From: Matthew Lear <matthew.lear@raspberrypi.com>
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
Date: Tue, 17 Mar 2026 05:24:48 -0700
X-Gm-Features: AaiRm50k_whnj84ujUD0vx7NzX4JioGFGEGgfGSiW1FWSJWQdNgZTXm6ccUq5a4
Message-ID: <CAPrOGNBjaSxMRnwpcear77Tk_6LnAhREA6aw-P1pAz4oMkdenA@mail.gmail.com>
Subject: [PATCH] erofs-utils: lib: guard gzran zlib.h inclusion
To: linux-erofs@lists.ozlabs.org
Cc: Matthew Lear <matthew.lear@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[raspberrypi.com,reject];
	R_DKIM_ALLOW(-0.20)[raspberrypi.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.lear@raspberrypi.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2797-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[raspberrypi.com:+]
X-Rspamd-Queue-Id: C9BEA2A9CC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

gzran.c unconditionally includes zlib.h which doesn't compile on
systems without zlib.

Signed-off-by: Matthew Lear <matthew.lear@raspberrypi.com>
---
 lib/gzran.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/gzran.c b/lib/gzran.c
index dffb20a..bf99796 100644
--- a/lib/gzran.c
+++ b/lib/gzran.c
@@ -6,9 +6,9 @@
 #include "erofs/err.h"
 #include "liberofs_gzran.h"
 #include <stdlib.h>
-#include <zlib.h>

 #ifdef HAVE_ZLIB
+#include <zlib.h>
 struct erofs_gzran_cutpoint {
 	u8	window[EROFS_GZRAN_WINSIZE];	/* preceding 32K of uncompressed data */
 	u64	outpos;			/* corresponding offset in uncompressed data */
-- 
2.43.0

