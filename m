Return-Path: <linux-erofs+bounces-2413-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOhBNsoxn2lXZQQAu9opvQ
	(envelope-from <linux-erofs+bounces-2413-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Feb 2026 18:30:50 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3792C19B92E
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Feb 2026 18:30:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLhSk45Vwz3f8x;
	Thu, 26 Feb 2026 04:30:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772040646;
	cv=none; b=iULuo7hy36xJy4+HfgMyMvY+QXkWF7Uc6QWg4mHdwaOleydqZxlq+kAQaUmur9/oPlw/7TG28bVqauBObsroLkIsdl5pi7uWVdogxewEuKz/n9CGeTnGNFpp1b7bmhj9KdWRTer4NkGadAEZs+Im05K4GyYk5xKWSkGz3DjxRz1x1qqoq3VHHvstx66pvbpZt7AMmxOPZDSkU33koSNsiDrO1loTvE0uyb3ve006kH804H1XKsB4qQEJeY8rSU+QOdeRyNIDzO1McWQjKBGpVf/zVui6CKNqAm8uwysXs61ja+sCfE/Krb1Jh5JyHr/5w9jt3Rb5UnsPy4Dbs1faBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772040646; c=relaxed/relaxed;
	bh=JTuo4xmaTva3i/pqjivKT/yO0J+x8Da++N9RoMOsTfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dLpGbe1L1hhrnBWdSjaRJnGmNFgkasO+s6PKJOoNvPHwYAybk9XMEm//Q3m92InX6qWn3bLETuPuDkZY7zsVI9kNZz3w98onQaSTcZDX/6VXxRGCCgzMbSYt5vb/I5viIsNV7KX4wUHtmDgB1BByoS+SPV99vFW4Us36V5iaf7lKhKGCCvf+6bZrhg0Lwk/U8ZCcOIoO00G8DwDcDdCi0RvwMDR6OxeCzDOli3PoJfUAqYxXDRK77/BJz0KAbLOfRmVDp0ox+gB5+GpgNpp2jAG/pIsdy7RVE3qPZ/YlMkO4t8/74dprSCH6igGxhBa++c6O1arVKWHd28ONevu4Iw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CiP7ZSvO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com; envelope-from=yester1324@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CiP7ZSvO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com; envelope-from=yester1324@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122f.google.com (mail-dl1-x122f.google.com [IPv6:2607:f8b0:4864:20::122f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLhSh6Qtvz3f8t
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Feb 2026 04:30:43 +1100 (AEDT)
Received: by mail-dl1-x122f.google.com with SMTP id a92af1059eb24-12732165d1eso7612657c88.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 25 Feb 2026 09:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772040641; x=1772645441; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JTuo4xmaTva3i/pqjivKT/yO0J+x8Da++N9RoMOsTfo=;
        b=CiP7ZSvOG9YX866ylcT+muoysan/1tiZQ5OZuxIQqPhxNvPD93+BYyo7XFVrk34uqF
         DALEnT9r9Danw271tMuCryJPEzqOnDJEdiIjnJo8lxythqkfKvWE2FV7eHFvRqxHLah8
         bXTb+oastbbbqSFROsdPuIAMkVhUbjvUVz5rr81TJo0nOYDi2dDYQD51W3fTH17m38BE
         5nPTruemysvZty07nrxX6fKeR5fWM6J7JyLhyz1ez/K0BE2Pi10wQVT+L9lR3arCTXCb
         Jddkiocs0iLmRZx/rjPg1qX+B7HlZHyis7PnP5aIL5cU16vxgJ02uVovdjXWe6U6GHjx
         IQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772040641; x=1772645441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTuo4xmaTva3i/pqjivKT/yO0J+x8Da++N9RoMOsTfo=;
        b=NgE6rhBMTiosu2r0J1Y+GpfT4F8wzFLgATUUn9pwzzHNmpI0UUqIQHq8VOT7YzJjJx
         pnXvDtt2Orn1U7P9q6ZyUgBF7UNwAMYj7jHbhlunn3ZxVU6HoSMhWVCDgac/Vi2SoNVo
         yBBnu6T6J6RbBb5IbFcfCREC1UbiHdi1uoAOgV2Z25LfnNrQEQPPbLf7X6dwCXCDyfy1
         t/ggBozaqpReMsVSHdApc74uM2q91JLZfscn5gAoskp+Y6GhiTgDDYpFy9ZLD7gYSqr5
         MjerUP09e8AaVgqK9vshqrzhFO9RRzSd5Ohej7YA2ufCPHmmYnP3Huufk5r3z1lE5apz
         pMGw==
X-Gm-Message-State: AOJu0YwkjDz1VJyN9OR925qVqFaYb85vi4Ysma5bodcaayIwgWK4R8Ab
	eYRFhV3y5Ul9xgabcxsUMksuDzbGsYjMq6rq4Tc6/J5SLHiz5ZtbQh7cwb2tzD2i
X-Gm-Gg: ATEYQzxB+s7r1RV0l+usITzZ+IPk4PqmkSPrlF4YQDHLuwqSnr/owq9KC7eFqNAAeP5
	NVnoVpVRRxA5amAMGbiZjdaPANHBvfsigdMqiIfXO3HHROfQSKNoZOoay1tNW7celiK0yRiHFuR
	MabTCZjTwPW4kik5DY12yJzAiGRO7Ulnwadhr097wH/z/bX0/HxruHlhlXQm2cHxi4JwLcPnvJZ
	Ho+4JqipV+0IByZYosjBe6FuVVJAMRrhZkXqnuWucM64WSkj1XU5Y4yn559Lr8YGPMArDBL+uQf
	ALrkkCACW4eXaoNdFcbaGHDo9GhnxfzjWi0ygy4qtOPuhMLdEqlGw7Fc/x9LSXfMQjVXZeaXhYk
	sQvE65UAx02uUxAqZ/k1twNZRbOO5fNNL2mhdYX9tKNCnXwivOKro+jK9vrNV0N1DNwk0c0R48C
	mKJyVM6xTqLwgws1PC2wZPCaBWoIjk2U5QP1g3
X-Received: by 2002:a05:7022:50c:b0:119:e56b:98a7 with SMTP id a92af1059eb24-1276acfb898mr8038037c88.14.1772040640885;
        Wed, 25 Feb 2026 09:30:40 -0800 (PST)
Received: from cptpc.hsd1.ca.comcast.net ([2601:207:380:51c0::6d12])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dc167d3sm10674829eec.24.2026.02.25.09.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 09:30:40 -0800 (PST)
From: Ashley Lee <yester1324@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	yester1324@gmail.com
Subject: [PATCH v2] erofs-utils: lib: converted division to shift in z_erofs_load_compact_lcluster
Date: Wed, 25 Feb 2026 09:30:30 -0800
Message-ID: <20260225173036.194311-1-yester1324@gmail.com>
X-Mailer: git-send-email 2.53.0
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
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.20 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2413-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yester1324@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 3792C19B92E
X-Rspamd-Action: no action

perf on fsck.erofs in gcc reports that z_erofs_load_compact_lcluster
was spending 20% of its time doing the div instruction. While the 
function itself is ~40% of user runtime. In the source code, it seems 
that dividing by vcnt doesn't optimize to a shift despite the two 
possible states being powers of 2.

Changing the division into a ilog2() function call encourages the 
compiler to recognize it as a power of 2. Thus performing a shift. 

Running a benchmark on lzma compressed freebsd code on x86, shows 
there is a ~4% increase in performance in gcc. While clang shows 
virtually no regression in performance. The tradeoff is slightly 
obfuscated source code.

The following command was run locally on x86. 

$ hyperfine -w 5 -m 30 "./fsck.erofs ./bsd.erofs.lzma"

patch on gcc 15.2.1 
Time (mean ± σ):     354.8 ms ±   6.0 ms    \
  [User: 227.8 ms, System: 126.1 ms]
Range (min … max):   345.8 ms … 366.2 ms    30 runs

dev on gcc 15.2.1 
Time (mean ± σ):     370.7 ms ±   6.7 ms    \
  [User: 246.5 ms, System: 123.4 ms]
Range (min … max):   362.7 ms … 390.7 ms    30 runs

patch on clang 21.1.8 
Time (mean ± σ):     371.9 ms ±   2.4 ms    \
  [User: 247.2 ms, System: 123.9 ms]
Range (min … max):   369.1 ms … 380.0 ms    30 runs

dev on clang 21.1.8
Time (mean ± σ):     371.0 ms ±   1.9 ms    \
  [User: 245.5 ms, System: 124.5 ms]
Range (min … max):   368.4 ms … 377.7 ms    30 runs

Signed-off-by: Ashley Lee <yester1324@gmail.com>
---
v2: changed vdiv to ilog2 call

 lib/zmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/zmap.c b/lib/zmap.c
index baec278..3ac7fe9 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -160,7 +160,7 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
 	m->nextpackoff = round_down(pos, vcnt << amortizedshift) +
 			 (vcnt << amortizedshift);
 	lobits = max(lclusterbits, ilog2(Z_EROFS_LI_D0_CBLKCNT) + 1U);
-	encodebits = ((vcnt << amortizedshift) - sizeof(__le32)) * 8 / vcnt;
+	encodebits = (((vcnt << amortizedshift) - sizeof(__le32)) * 8) >> ilog2(vcnt);
 	bytes = pos & ((vcnt << amortizedshift) - 1);
 	in -= bytes;
 	i = bytes >> amortizedshift;
-- 
2.53.0


