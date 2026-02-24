Return-Path: <linux-erofs+bounces-2399-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNHnI6DZnWk0SQQAu9opvQ
	(envelope-from <linux-erofs+bounces-2399-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 18:02:24 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E237718A3E2
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 18:02:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fL3t90Y57z3cZH;
	Wed, 25 Feb 2026 04:02:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::829" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771952529;
	cv=pass; b=AxbMKuJK5evbmREQpIcyn0qTSK8hHVkLewkccZSRacKU0AOIj7smvyLy1y3eFQ5mSTIhePdcqtZPDVk9bhaD3h9rdE1W6HLwhGd0thBQSF14ecxZpU5+g+bDNzvxY3NBASVbXzaKJAc4hvF3w5moAGHPrYDESL2cXx+dtZ2ZEkxT3AsIfrbttheeVX0Ba3S2zjqQCIHpcbta0Ia996mDKB8sAS5v13KhFhui59uxusyOUN3gZ4kR6AzaQSKLhb91EH2D44x3THx8fzAF23NCv3W6G2rildtRL13m7vwSy0nkR9/xuxqjxCDo7BCKmcCoGCRlb6NQl5ni3/Ko3Qy6SQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771952529; c=relaxed/relaxed;
	bh=4Gg4RV1H3ROtXnBW1YCCHo6i4I+MEGN0xjahTIuDqoo=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=BWQw0KTirNMtRC4IpFzKCFszdnQ1P7X+XFTR+45/9FG9/TBfnhWeFoURhU00Zs1SWlAombO++ZmBItMAImJ2oIOrdrZwS/gf9yfaBfSQVuce/s46Svp6IwPXd7F46eoIcBc8TwnzbJB2z/4XXcadC2iQ+JIrMg87luUupgN/3G9DRLIYt/soEBRlkZ4bNanHsXUg3yN4ToSl9y+0VW+xJ/gKAAa3SDlac2uLScH7VvrsQYtK4Wmw6v861rSX62Wn+gE5FLwtsWv5rbJFjZkrv3J6zm+3f0toaFniO665NbDZdz8X51Rs8IBPag4iFZ7Y0KZ6xFjMkN87LGvH40qdWQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; dkim=pass (2048-bit key; unprotected) header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b=Jlstoqsn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::829; helo=mail-qt1-x829.google.com; envelope-from=matthew.lear@raspberrypi.com; receiver=lists.ozlabs.org) smtp.mailfrom=raspberrypi.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b=Jlstoqsn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=raspberrypi.com (client-ip=2607:f8b0:4864:20::829; helo=mail-qt1-x829.google.com; envelope-from=matthew.lear@raspberrypi.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fL3t719vVz3cZG
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Feb 2026 04:02:06 +1100 (AEDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-50697d6a69cso31690041cf.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 24 Feb 2026 09:02:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771952524; cv=none;
        d=google.com; s=arc-20240605;
        b=Bo6PatjYtAugKU5X0EqO9zFpgp4U42qVLC6rlcKEiqZos5RqUfqhYuBbzmuyr7Mg/k
         ofLG39MHElNFJdCe3POLGm48F2ur7a73hDkX/Ny31kAm8MTp2XTz/RdDAnvdJPPhRv6d
         hO3SQTK8O5tgwKSFldPuZjVsb1gJFFXRGUOaudF6KHj1YwWvZ7//DEwxqpz1h3c6csCB
         wMS88ik1T5KhpdRisV8hy537oG8ykjGBXRvb4ly6UHs618ppAWTrbDKmYGn29tdyQajd
         tKeYsBASHAPQy9CPrgVpVJYIJZeNhhqCOokukzzXzTD7nJGqjoOCpws71NFyuvfeXbke
         5QxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=4Gg4RV1H3ROtXnBW1YCCHo6i4I+MEGN0xjahTIuDqoo=;
        fh=QUVm9qy9xw/vH5FkdNybmOglH9Yo1FLRstF7uaj7WSs=;
        b=CzY1bVqZcjE6BeicJ3D1uqF02x6hpZKNmUCPJv3SzqYhVUZC56lbYOIpS4+m6tm6U2
         4gADKDxTjk1cB1LRPfWo0sWqNLEO2oCoYFD/fDUyyChDrl3630rJObfoBiM6gKq4xhjy
         TUXh9SN2jM/FQkr39SueL/887hhuuYluotIvB68Z+hPukJEiQ3KeERnIQBDfH3kNPw6Y
         CTVLLibltDRHuwBMi95QAF7pP3tJbn6/Xhf8+E5L2BG2b4ZEgulqVled23zH21HsJQ4k
         na3wNGBKSy8g0diEf/J3D4LwOOO1pKoVrJg4hobjH7rMbzQNJ0BVrw5BgjrrjmPj4FJz
         utVA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1771952524; x=1772557324; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4Gg4RV1H3ROtXnBW1YCCHo6i4I+MEGN0xjahTIuDqoo=;
        b=Jlstoqsnt9k0NA2LUVDTtUke0KqLEJS/Ftwnw/xIOJuuHN2UygQMOfZ2sg1dMoiL0z
         8ov6QYZ8/g+I8p+yEyjq1t9stAx8FeFPRajMRT9sa6tdKidKy3Gn4deNgClPZRyzOGUG
         ArlOofb81FI23Yo3ROVPRWF2rZF9UDq6FemNkxnc5qa3ckgjx+ZB2bmCYj/s3Uky4OGZ
         tY8TWKnEjxmulbSOTjs0eDrrfp4GT2xPanJCy9NRQsl4OFE6OsK/syZOn/qPY+nLjk5l
         WFs6gcCC6XcJojLhH4OwYpNr78/T+lOMwr+GoiHBZy2BBR/LMZt+d+XIsJ3LIsHeSK7i
         webg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771952524; x=1772557324;
        h=cc:to:subject:message-id:date:mime-version:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Gg4RV1H3ROtXnBW1YCCHo6i4I+MEGN0xjahTIuDqoo=;
        b=J8j1KxU1OymwxjAw02DE57OdoR7sdjBwTxJnvcUVdtryrC/av+X+nm5xTIJgQ/rnMb
         6Vmywfn7GuW3VZdzjFHKOmEGg8UYuV2OUKNaVTiroqFbpIi07ry4Nsy2rOOOKBPqYzge
         5ebv+0rvOCF2akyLBUli1iljmVOub/IIqfilYz9E0DaLJCNHwSeciijN0hO6AU56NbhO
         jsOTKCYXFwHI9yE9eF6Y2lJzAE3MAh8CwTUXgit0G/5r5q4HNt4EPD/b7XiOuFNDXgS2
         6lqqd/v2+IlfxOIcpiOaaz8xxT696pbt3Il14pd1S4Gu0filH1I90GneS1qUFLN9eo/y
         df/w==
X-Gm-Message-State: AOJu0Yz9qnHlBhPg9lkGIpz4mMZ/D+5v8F6al+rmgtpkezneGobS0WPC
	ZafDBPok1swZsvnh9v7T2lft5MGOtoCK/tqa2/h5aA8L45iUYsgv212aT/VTmPjLuU1Qz733XfK
	ecMy+qEYtpsbRMSAqfygYaWI3e6Rqumh6phiNAPN0Wt6rk7hdmsZl
X-Gm-Gg: AZuq6aK9BJWnPuS1WSTvsQrJzsbDrrVc+V5g/9E9cwYqwIDSTqjFxBJ9Xk8+cWZm5rq
	Zvm0kMAU703/CIBeNUi6+7jk+1+uI1aLUnSwtzM1HNlcANLjis9fgEHF5amU8BcjpDnZi1VWZKu
	iLTduDuJNkwzXhYv8domOaIBCSr4o58akPr/Q6R4LUI93Odx6RKMJHYRGVBESBxmmi8yflJ4RM0
	nCGafAG+XtaWj9Gya4PP8TSwYOjYeBJmFhQjP82XotX6Em9db8RSbQww0Xs5+3HmDxmyL7pgVRq
	7P4mpCvs
X-Received: by 2002:a05:622a:1208:b0:501:4703:3b6a with SMTP id
 d75a77b69052e-5070bba1423mr164660781cf.9.1771952524089; Tue, 24 Feb 2026
 09:02:04 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Feb 2026 18:02:03 +0100
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Feb 2026 18:02:03 +0100
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
Date: Tue, 24 Feb 2026 18:02:03 +0100
X-Gm-Features: AaiRm52PhjL91INs14zgyftZC8_DCtqFkvmdkpkF2-EUUuTqVtl9JL3UlhfmxzA
Message-ID: <CAPrOGNB56AjZ8C8fRChucWHHhLHQoim7xPpz3eyFXwDCPJ02YA@mail.gmail.com>
Subject: [PATCH] erofs-utils: Raise maximum block size for aarch64
To: linux-erofs@lists.ozlabs.org
Cc: Matthew Lear <matthew.lear@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[raspberrypi.com,reject];
	R_DKIM_ALLOW(-0.20)[raspberrypi.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[configure.ac:query timed out,raspberrypi.com:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN_FAIL(0.00)[1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.1.f.9.b.1.2.0.0.4.9.4.0.4.2.asn6.rspamd.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2399-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[matthew.lear@raspberrypi.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[raspberrypi.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[configure.ac:url,mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: E237718A3E2
X-Rspamd-Action: no action

Ensure MAX_BLOCK_SIZE is at least 16384 on aarch64 so that native block
sizes can be used without the sub-page fallback.

Signed-off-by: Matthew Lear <matthew.lear@raspberrypi.com>
---
 configure.ac | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configure.ac b/configure.ac
index cf4de99..8a8e9b3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -322,6 +322,10 @@ AS_IF([test "x$MAX_BLOCK_SIZE" = "x"], [
                              [erofs_cv_max_block_size=`cat conftest.out`],
                              [erofs_cv_max_block_size=4096],
                              [erofs_cv_max_block_size=4096]))
+  dnl Ensure aarch64 supports at least 16K
+  AS_CASE([$build_cpu],
+    [aarch64*], [AS_IF([test "$erofs_cv_max_block_size" -lt 16384],
+                   [erofs_cv_max_block_size=16384])])
 ], [erofs_cv_max_block_size=$MAX_BLOCK_SIZE])

 # Configure multi-threading support
-- 
2.43.0

